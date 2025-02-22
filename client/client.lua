local VORPcore = exports.vorp_core:GetCore()
local BccUtils = exports['bcc-utils'].initiate()
local FeatherMenu =  exports['feather-menu'].initiate()
local progressbar = exports.vorp_progressbar:initiate()

local CreatedBoardBlips = {}
local CreatedBoardNpcs = {}

local MainMenuOpened = false
local OilMenuOpened = false
local MissionActive = false
local MissionsDone = 0
local Cooldown = false
local MaxMissionsDone = false
local Timer = 0

Citizen.CreateThread(function()
    local BoardPromptGoup = BccUtils.Prompts:SetupPromptGroup()
    local OpenBoardPrompt = BoardPromptGoup:RegisterPrompt(_U('OpenBoardPrompt'), Config.OpenNormalMission, 1, 1, true, 'hold', {timedeventhash = 'MEDIUM_TIMED_EVENT'})
    local OpenOilBoardPrompt = BoardPromptGoup:RegisterPrompt(_U('OpenOilBoardPrompt'), Config.OpenOilMissions, 1, 1, true, 'hold', {timedeventhash = 'MEDIUM_TIMED_EVENT'})
    for h,v in pairs(Config.MissionBoards) do
        if v.CreateBlip then
            local bblip = BccUtils.Blips:SetBlip(_U('BoardBlips'), v.BlipSprite, 2.0, v.Coords.x,v.Coords.y,v.Coords.z)
            CreatedBoardBlips[#CreatedBoardBlips + 1] = bblip
        end
        if v.CreateNPC then
            local bped = BccUtils.Ped:Create('A_M_O_SDUpperClass_01', v.Coords.x,v.Coords.y,v.Coords.z, 0, 'world', false)
            CreatedBoardNpcs[#CreatedBoardNpcs + 1] = bped
            bped:Freeze()
            bped:SetHeading(v.NPCHeading)
            bped:Invincible()
            SetBlockingOfNonTemporaryEvents(bped:GetPed(), true)
        end
    end
    while true do
        Citizen.Wait(2)
        for h,v in pairs(Config.MissionBoards) do
        local playerCoords = GetEntityCoords(PlayerPedId())
        local dist = #(playerCoords - v.Coords)
        if dist < 2 then
            BoardPromptGoup:ShowGroup(_U('OpenBoardPromptName'))

            if OpenBoardPrompt:HasCompleted() then
                local CurrentCartSpawn = v.CartSpawn
                TriggerEvent('mms-cartmissions:client:openboard',CurrentCartSpawn)
            end

            if OpenOilBoardPrompt:HasCompleted() then
                local CurrentCartSpawn = v.CartSpawn
                TriggerEvent('mms-cartmissions:client:openoilboard',CurrentCartSpawn)
            end
        end
    end
    end
end)

---------------------------------------------------------------------------------------------------------
--------------------------------------------- Main Menu -------------------------------------------------
---------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function ()
    CartmissionBoard = FeatherMenu:RegisterMenu('Cartmissions', {
        top = '10%',
        left = '20%',
        ['720width'] = '500px',
        ['1080width'] = '700px',
        ['2kwidth'] = '700px',
        ['4kwidth'] = '800px',
        style = {
            ['border'] = '5px solid orange',
            -- ['background-image'] = 'none',
            ['background-color'] = '#FF8C00'
        },
        contentslot = {
            style = {
                ['height'] = '550px',
                ['min-height'] = '250px'
            }
        },
        draggable = true,
    --canclose = false
}, {
    opened = function()
        --print("MENU OPENED!")
    end,
    closed = function()
        --print("MENU CLOSED!")
    end,
    topage = function(data)
        --print("PAGE CHANGED ", data.pageid)
    end
})

end)

RegisterNetEvent('mms-cartmissions:client:openboard')
AddEventHandler('mms-cartmissions:client:openboard',function(CurrentCartSpawn)
    if not MainMenuOpened then
        MainMenuOpened = true
    elseif MainMenuOpened then
        CartmissionBoardPage1:UnRegister()
    end
    CartmissionBoardPage1 = CartmissionBoard:RegisterPage('seite1')
    CartmissionBoardPage1:RegisterElement('header', {
        value = _U('BoardHeader'),
        slot = 'header',
        style = {
        ['color'] = 'orange',
        }
    })
    CartmissionBoardPage1:RegisterElement('line', {
        slot = 'header',
        style = {
        ['color'] = 'orange',
        }
    })
    for h,v in ipairs(Config.MissionBoards) do
        local ButtonLabel = _U('DeliverToo') .. v.Name
        local SelectedMission = v
        CartmissionBoardPage1:RegisterElement('button', {
            label = ButtonLabel,
            style = {
                ['background-color'] = '#FF8C00',
                ['color'] = 'orange',
                ['border-radius'] = '6px'
            },
        }, function()
            CartmissionBoard:Close({})
            if not MissionActive then
                if not Cooldown then
                    if not MaxMissionsDone then
                        TriggerEvent('mms-cartmissions:client:StartMission',SelectedMission,CurrentCartSpawn)
                    else
                        VORPcore.NotifyTip(_U('MaxMissionsReached'),5000)
                    end
                else
                    local Round = math.floor( Timer / 60000 )
                    VORPcore.NotifyTip(_U('CooldownPleaseWait') .. Round .. _U('CooldownPleaseWait2'),5000)
                end
            else
                VORPcore.NotifyTip(_U('MissionAlreadyActive'),5000)
            end
        end)
    end
    CartmissionBoardPage1:RegisterElement('button', {
        label =  _U('CloseBoard'),
        style = {
        ['background-color'] = '#FF8C00',
        ['color'] = 'orange',
        ['border-radius'] = '6px'
        },
    }, function()
        CartmissionBoard:Close({ 
        })
    end)
    CartmissionBoardPage1:RegisterElement('subheader', {
        value = _U('BoardSubHeader'),
        slot = 'footer',
        style = {
        ['color'] = 'orange',
        }
    })
    CartmissionBoardPage1:RegisterElement('line', {
        slot = 'footer',
        style = {
        ['color'] = 'orange',
        }
    })
    CartmissionBoard:Open({
        startupPage = CartmissionBoardPage1,
    })
end)

RegisterNetEvent('mms-cartmissions:client:StartMission')
AddEventHandler('mms-cartmissions:client:StartMission',function (SelectedMission,CurrentCartSpawn)
local TravelDistance = GetDistanceBetweenCoords(CurrentCartSpawn.x,CurrentCartSpawn.y,CurrentCartSpawn.z,SelectedMission.DeliverPosition.x,SelectedMission.DeliverPosition.y,SelectedMission.DeliverPosition.z,true)
if TravelDistance <= Config.MinimalTravelDistance then
        VORPcore.NotifyTip(_U('NeedMoreDistance'),5000)
else
    local MissionPromptGoup = BccUtils.Prompts:SetupPromptGroup()
    local EndMissionPrompt = MissionPromptGoup:RegisterPrompt(_U('EndDelivery'), Config.EndMissionPrompt, 1, 1, true, 'hold', {timedeventhash = 'MEDIUM_TIMED_EVENT'})
    MissionActive = true
    if Config.DisableCinematicCamera then
        SetCinematicButtonActive(false)
    end
    local ped = PlayerPedId()
    local TD = 0
    local MyCarthash = 'coach4'
    if SelectedMission.RandomCart then
        local MaxCarts = #Config.RandomCarts
        local RandomIndex = math.random(1,MaxCarts)
        MyCarthash = Config.RandomCarts[RandomIndex].CartModel
    else
        MyCarthash = SelectedMission.CartModel
    end
    Citizen.Wait(500)
    RequestModel(MyCarthash)
    while not HasModelLoaded(MyCarthash) do
        Citizen.Wait(0)
    end
    MyCart = CreateVehicle(MyCarthash, CurrentCartSpawn.x,CurrentCartSpawn.y,CurrentCartSpawn.z,CurrentCartSpawn.w, true, false)
    SetVehicleOnGroundProperly(MyCart)
    SetEntityAsMissionEntity(MyCart,true,true)
    SetVehicleCanBreak(MyCart,false)
    Citizen.Wait(1500)
    SetPedIntoVehicle(ped, MyCart, -1)
    SetModelAsNoLongerNeeded(MyCarthash)
    local MyPosition = GetEntityCoords(MyCart)
    local DistanceToTravel = #(MyPosition - SelectedMission.DeliverPosition)
    VORPcore.NotifyTip(_U('DriveTo') .. SelectedMission.Name,5000)
    StartGpsMultiRoute(GetHashKey("COLOR_YELLOW"), true, true)
    AddPointToGpsMultiRoute(SelectedMission.DeliverPosition)
    SetGpsMultiRouteRender(true)
    while MissionActive do
        Citizen.Wait(2)
        local MyPosition = GetEntityCoords(MyCart)
        local Distance = #(MyPosition - SelectedMission.DeliverPosition)
        if Distance <= SelectedMission.EndMissionRadius then
            MissionPromptGoup:ShowGroup(_U('DeliveryPromptGroup'))
            if TD == 0 then
                VORPcore.NotifyRightTip(_U('LocationReached'), 5000)
                TD = TD + 1
                Citizen.Wait(250)
            end
            if Config.DrawMarker then
                Citizen.InvokeNative(0x2A32FAA57B937173,0xEC032ADD,SelectedMission.DeliverPosition.x,SelectedMission.DeliverPosition.y + 1.0,SelectedMission.DeliverPosition.z+1.0,0,0,0,0,0,0,1.0,1.0,1.0,250,250,100,250,0, 0, 2, 0, 0, 0, 0) -- DRAW Marker
            end
            if EndMissionPrompt:HasCompleted() then
                DeleteVehicle(MyCart)
                ClearGpsMultiRoute()
                Citizen.Wait(500)
                MissionActive = false
                TD = 0
                TriggerServerEvent('mms-cartmissions:server:EndMission',SelectedMission,DistanceToTravel)
                if Config.LimitMissions then
                    MissionsDone = MissionsDone + 1
                    if MissionsDone >= Config.MaxMissions then
                        MaxMissionsDone = true
                    end
                end
                if Config.CooldownMission then
                    Cooldown = true
                    TriggerEvent('mms-cartmissions:client:Cooldown')
                end
            end
        end
    end
end
end)

RegisterNetEvent('mms-cartmissions:client:openoilboard')
AddEventHandler('mms-cartmissions:client:openoilboard',function(CurrentCartSpawn)
    if not OilMenuOpened then
        OilMenuOpened = true
    elseif OilMenuOpened then
        CartmissionBoardPage2:UnRegister()
    end
    CartmissionBoardPage2 = CartmissionBoard:RegisterPage('seite2')
    CartmissionBoardPage2:RegisterElement('header', {
        value = _U('OilBoardHeader'),
        slot = 'header',
        style = {
        ['color'] = 'orange',
        }
    })
    CartmissionBoardPage2:RegisterElement('line', {
        slot = 'header',
        style = {
        ['color'] = 'orange',
        }
    })
    for h,v in ipairs(Config.MissionBoards) do
        local ButtonLabel = _U('DeliverToo') .. v.Name
        local SelectedMission = v
        CartmissionBoardPage2:RegisterElement('button', {
            label = ButtonLabel,
            style = {
                ['background-color'] = '#FF8C00',
                ['color'] = 'orange',
                ['border-radius'] = '6px'
            },
        }, function()
            CartmissionBoard:Close({})
            if not MissionActive then
                if not Cooldown then
                    if not MaxMissionsDone then
                        TriggerEvent('mms-cartmissions:client:StartOilMission',SelectedMission,CurrentCartSpawn)
                    else
                        VORPcore.NotifyTip(_U('MaxMissionsReached'),5000)
                    end
                else
                    local Round = math.floor( Timer / 60000)
                    VORPcore.NotifyTip(_U('CooldownPleaseWait') .. Round .. _U('CooldownPleaseWait2'),5000)
                end
            else
                VORPcore.NotifyTip(_U('MissionAlreadyActive'),5000)
            end
        end)
    end
    CartmissionBoardPage2:RegisterElement('button', {
        label =  _U('CloseBoard'),
        style = {
        ['background-color'] = '#FF8C00',
        ['color'] = 'orange',
        ['border-radius'] = '6px'
        },
    }, function()
        CartmissionBoard:Close({ 
        })
    end)
    CartmissionBoardPage2:RegisterElement('subheader', {
        value = _U('OilBoardSubHeader'),
        slot = 'footer',
        style = {
        ['color'] = 'orange',
        }
    })
    CartmissionBoardPage2:RegisterElement('line', {
        slot = 'footer',
        style = {
        ['color'] = 'orange',
        }
    })
    CartmissionBoard:Open({
        startupPage = CartmissionBoardPage2,
    })
end)

RegisterNetEvent('mms-cartmissions:client:StartOilMission')
AddEventHandler('mms-cartmissions:client:StartOilMission',function (SelectedMission,CurrentCartSpawn)
    local OilFilled = false
    local TravelDistance = GetDistanceBetweenCoords(CurrentCartSpawn.x,CurrentCartSpawn.y,CurrentCartSpawn.z,SelectedMission.DeliverPosition.x,SelectedMission.DeliverPosition.y,SelectedMission.DeliverPosition.z,true)
if TravelDistance <= Config.MinimalTravelDistance then
        VORPcore.NotifyTip(_U('NeedMoreDistance'),5000)
else
    local MissionPromptGoup = BccUtils.Prompts:SetupPromptGroup()
    local EndMissionPrompt = MissionPromptGoup:RegisterPrompt(_U('EndDelivery'), Config.EndMissionPrompt, 1, 1, true, 'hold', {timedeventhash = 'MEDIUM_TIMED_EVENT'})
    local FillOilPromptGoup = BccUtils.Prompts:SetupPromptGroup()
    local FillOilPrompt = FillOilPromptGoup:RegisterPrompt(_U('FillOilToCart'), Config.FillOilPrompt, 1, 1, true, 'hold', {timedeventhash = 'MEDIUM_TIMED_EVENT'})
    MissionActive = true
    if Config.DisableCinematicCamera then
        SetCinematicButtonActive(false)
    end
    local ped = PlayerPedId()
    local TD = 0
    local FC = 0
    local MyCarthash = 'oilWagon02x'
    Citizen.Wait(500)
    RequestModel(MyCarthash)
    while not HasModelLoaded(MyCarthash) do
        Citizen.Wait(0)
    end
    MyCart = CreateVehicle(MyCarthash, CurrentCartSpawn.x,CurrentCartSpawn.y,CurrentCartSpawn.z,CurrentCartSpawn.w, true, false)
    SetVehicleOnGroundProperly(MyCart)
    SetEntityAsMissionEntity(MyCart,true,true)
    SetVehicleCanBreak(MyCart,true)
    Citizen.Wait(1500)
    SetPedIntoVehicle(ped, MyCart, -1)
    SetModelAsNoLongerNeeded(MyCarthash)
    local MyPosition = GetEntityCoords(MyCart)
    local DistanceToTravel1 = #(MyPosition - SelectedMission.FillOilPosition)
    local DistanceToTravel2 = 0
    VORPcore.NotifyTip(_U('FillWagon'),5000)
    local OilBlip = BccUtils.Blips:SetBlip(_U('FillOil'), 'blip_code_waypoint', 2.0, SelectedMission.FillOilPosition.x,SelectedMission.FillOilPosition.y,SelectedMission.FillOilPosition.z)
    StartGpsMultiRoute(GetHashKey("COLOR_YELLOW"), true, true)
    AddPointToGpsMultiRoute(SelectedMission.FillOilPosition)
    SetGpsMultiRouteRender(true)
        while MissionActive and not OilFilled do
            Citizen.Wait(2)
            local MyPosition = GetEntityCoords(MyCart)
            local Distance = #(MyPosition - SelectedMission.FillOilPosition)
            if Distance <= SelectedMission.FillOilRadius then
                FillOilPromptGoup:ShowGroup(_U('FillOilToCart'))
                if FC == 0 then
                    VORPcore.NotifyRightTip(_U('FillYourCard'), 5000)
                    FC = FC + 1
                    Citizen.Wait(250)
                end
                if FillOilPrompt:HasCompleted() then
                    Citizen.InvokeNative(0x2A32FAA57B937173,0xEC032ADD,SelectedMission.FillOilPosition.x,SelectedMission.FillOilPosition.y + 1.0,SelectedMission.FillOilPosition.z+1.0,0,0,0,0,0,0,1.0,1.0,1.0,250,250,100,250,0, 0, 2, 0, 0, 0, 0) -- DRAW Marker
                    CrouchAnim()
                    Progressbar(SelectedMission.FillOilTime * 1000,_U('FillingWagon'))
                    OilFilled = true
                    OilBlip:Remove()
                    FreezeEntityPosition(MyCart,false)
                    VORPcore.NotifyTip(_U('DeliverOil'),5000)
                    DistanceToTravel2 = #(MyPosition - SelectedMission.DeliverPosition)
                    StartGpsMultiRoute(GetHashKey("COLOR_YELLOW"), true, true)
                    AddPointToGpsMultiRoute(SelectedMission.DeliverPosition)
                    SetGpsMultiRouteRender(true)
                end
            end
        end
    while MissionActive and OilFilled do
        Citizen.Wait(2)
        local MyPosition = GetEntityCoords(MyCart)
        local Distance = #(MyPosition - SelectedMission.DeliverPosition)
        if Distance <= SelectedMission.EndMissionRadius then
            MissionPromptGoup:ShowGroup(_U('DeliveryPromptGroup'))
            if TD == 0 then
                VORPcore.NotifyRightTip(_U('LocationReached'), 5000)
                TD = TD + 1
                Citizen.Wait(250)
            end
            if Config.DrawMarker then
                Citizen.InvokeNative(0x2A32FAA57B937173,0xEC032ADD,SelectedMission.DeliverPosition.x,SelectedMission.DeliverPosition.y + 1.0,SelectedMission.DeliverPosition.z+1.0,0,0,0,0,0,0,1.0,1.0,1.0,250,250,100,250,0, 0, 2, 0, 0, 0, 0) -- DRAW Marker
            end
            if EndMissionPrompt:HasCompleted() then
                DeleteVehicle(MyCart)
                ClearGpsMultiRoute()
                Citizen.Wait(500)
                MissionActive = false
                TD = 0
                TriggerServerEvent('mms-cartmissions:server:EndOilMission',SelectedMission,DistanceToTravel1,DistanceToTravel2)
                if Config.LimitMissions then
                    MissionsDone = MissionsDone + 1
                    if MissionsDone >= Config.MaxMissions then
                        MaxMissionsDone = true
                    end
                end
                if Config.CooldownMission then
                    Cooldown = true
                    TriggerEvent('mms-cartmissions:client:Cooldown')
                end
            end
        end
    end
end
end)

-- Cooldown

RegisterNetEvent('mms-cartmissions:client:Cooldown')
AddEventHandler('mms-cartmissions:client:Cooldown',function()
    Timer = Config.CooldownTimet * 60000
    while Cooldown do
        Citizen.Wait(60000)
        Timer = Timer - 60000
        if Timer <= 0 then
            Cooldown = false
        end
    end
end)

RegisterCommand(Config.AbortMissionCommand,function ()
    if MissionActive then
        DeleteVehicle(MyCart)
        ClearGpsMultiRoute()
        MissionActive = false
        TD = 0
        if Config.DisableCinematicCamera then
            SetCinematicButtonActive(true)
        end
        VORPcore.NotifyTip(_U('MissionAborted'),5000)
    else
        VORPcore.NotifyTip(_U('NoActiveMission'),5000)
    end
end)

----------------- Utilities -----------------


------ Progressbar

function Progressbar(Time,Text)
    progressbar.start(Text, Time, function ()
    end, 'linear')
    Wait(Time)
    ClearPedTasks(PlayerPedId())
end

------ Animation

function CrouchAnim()
    local dict = "script_rc@cldn@ig@rsc2_ig1_questionshopkeeper"
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    TaskPlayAnim(ped, dict, "inspectfloor_player", 0.5, 8.0, -1, 1, 0, false, false, false)
end

------------------------- Clean Up on Resource Restart -----------------------------


RegisterNetEvent('onResourceStop',function(resource)
    if resource == GetCurrentResourceName() then
        for _, npcs in ipairs(CreatedBoardNpcs) do
            npcs:Remove()
	    end
        for _, blips in ipairs(CreatedBoardBlips) do
            blips:Remove()
	    end
    end
end)

