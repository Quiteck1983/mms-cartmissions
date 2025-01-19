local VORPcore = exports.vorp_core:GetCore()

RegisterServerEvent('mms-cartmissions:server:EndMission',function(SelectedMission,DistanceToTravel)
    local src = source
    local Character = VORPcore.getUser(src).getUsedCharacter
    local Name = Character.firstname .. ' ' .. Character.lastname
    local Money = 0
    if SelectedMission.FixReward then
        Money = SelectedMission.Reward
    else
        local Calculate = SelectedMission.RewardPerDistance * DistanceToTravel
        Money = math.floor(Calculate)
    end
    Character.addCurrency(0,Money)
    VORPcore.NotifyTip(src,_U('YouGotReward') .. Money,5000)
    if Config.WebHook then
        VORPcore.AddWebhook(Config.WHTitle, Config.WHLink, Name .. _U('WHReward') .. Money, Config.WHColor, Config.WHName, Config.WHLogo, Config.WHFooterLogo, Config.WHAvatar)
    end
end)

RegisterServerEvent('mms-cartmissions:server:EndOilMission',function(SelectedMission,DistanceToTravel1,DistanceToTravel2)
    local src = source
    local Character = VORPcore.getUser(src).getUsedCharacter
    local Name = Character.firstname .. ' ' .. Character.lastname
    local Money = 0
    if SelectedMission.FixReward then
        Money = SelectedMission.Reward
    else
        local Calculate1 = SelectedMission.RewardPerDistance * DistanceToTravel1
        local Calculate2 = SelectedMission.RewardPerDistance * DistanceToTravel2
        local Calculate3 = Calculate1 + Calculate2
        Money = math.floor(Calculate3)
    end
    Character.addCurrency(0,Money)
    VORPcore.NotifyTip(src,_U('YouGotReward') .. Money,5000)
    if Config.WebHook then
        VORPcore.AddWebhook(Config.WHTitle, Config.WHLink, Name .. _U('WHReward') .. Money, Config.WHColor, Config.WHName, Config.WHLogo, Config.WHFooterLogo, Config.WHAvatar)
    end
end)
