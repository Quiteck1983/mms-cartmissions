Config = {}

Config.defaultlang = "de_lang"

-- Webhook Settings

Config.WebHook = false

Config.WHTitle = 'Cartmissions:'
Config.WHLink = ''  -- Discord WH link Here
Config.WHColor = 16711680 -- red
Config.WHName = 'Cartmissions:' -- name
Config.WHLogo = '' -- must be 30x30px
Config.WHFooterLogo = '' -- must be 30x30px
Config.WHAvatar = '' -- must be 30x30px

-- Script Settings

Config.OpenNormalMission = 0x760A9C6F
Config.EndMissionPrompt = 0x760A9C6F
Config.OpenOilMissions = 0x27D1C284
Config.FillOilPrompt = 0x760A9C6F

Config.AbortMissionCommand = 'CancelDelivery'
Config.MinimalTravelDistance = 50 -- DO NOT Touch
Config.DrawMarker = true -- Draw Marker At location
Config.DisableCinematicCamera = true

Config.RandomCarts = { -- Only if RandomCart = true
    { CartModel = 'cart01' },
    { CartModel = 'cart02' },
    { CartModel = 'cart03' },
    { CartModel = 'cart04' },
    { CartModel = 'cart05' },
    { CartModel = 'cart06' },
    { CartModel = 'cart07' },
    { CartModel = 'cart08' },
    { CartModel = 'buggy01' },
    { CartModel = 'buggy02' },
    { CartModel = 'buggy03' },
    { CartModel = 'coach2' },
    { CartModel = 'coach3' },
    { CartModel = 'coach4' },
    { CartModel = 'coach5' },
    { CartModel = 'coach6' },
}

Config.MissionBoards = {
    {
        Name = 'Emerald Ranch',
        Coords = vector3(1417.74, 308.41, 87.75),
        CreateNPC = true,
        NPCHeading = 276.29,
        NPCModel = 'a_f_o_sdupperclass_01',
        CreateBlip = true,
        BlipSprite = 'blip_ambient_coach',
        RandomCart = true,
        CartModel = 'coach4', -- Only if RandomCart = false
        CartSpawn = vector4(1425.03, 309.16, 87.48, 0.89),
        DeliverPosition = vector3(1420.74, 308.87, 87.57),
        RewardPerDistance = 0.035, -- Reward Per meter If Fix Reward is False
        FixReward = false,
        Reward = 15,  --- IF Use Fix Reward
        EndMissionRadius = 10,
        EnableOilMissions = true,
        FillOilPosition = vector3(555.57, 599.92, 111.17),
        FillOilTime = 10, -- Time in Sec
        FillOilRadius = 5,
    },
    {
        Name = 'Van Horn',
        Coords = vector3(2958.24, 785.48, 50.52),
        CreateNPC = true,
        NPCHeading = 145.5,
        NPCModel = 'a_f_o_sdupperclass_01',
        CreateBlip = true,
        BlipSprite = 'blip_ambient_coach',
        RandomCart = true,
        CartModel = 'coach4', -- Only if RandomCart = false
        CartSpawn = vector4(2955.99, 785.35, 50.52, 177.62),
        DeliverPosition = vector3(2955.99, 785.35, 50.52),
        RewardPerDistance = 0.035, -- Reward Per meter If Fix Reward is False
        FixReward = false,
        Reward = 15,  --- IF Use Fix Reward
        EndMissionRadius = 10,
        EnableOilMissions = true,
        FillOilPosition = vector3(555.57, 599.92, 111.17),
        FillOilTime = 10, -- Time in Sec
        FillOilRadius = 5,
    },
    {
        Name = 'Saint Denis',
        Coords = vector3(2502.73, -1420.02, 45.28),
        CreateNPC = true,
        NPCHeading = 92.99,
        NPCModel = 'a_f_o_sdupperclass_01',
        CreateBlip = true,
        BlipSprite = 'blip_ambient_coach',
        RandomCart = true,
        CartModel = 'coach4', -- Only if RandomCart = false
        CartSpawn = vector4(2500.19, -1421.19, 45.26, 357.7),
        DeliverPosition = vector3(2499.95, -1419.29, 45.24),
        RewardPerDistance = 0.035, -- Reward Per meter If Fix Reward is False
        FixReward = false,
        Reward = 15,  --- IF Use Fix Reward
        EndMissionRadius = 10,
        EnableOilMissions = true,
        FillOilPosition = vector3(555.57, 599.92, 111.17),
        FillOilTime = 10, -- Time in Sec
        FillOilRadius = 5,
    },
    {
        Name = 'Rhodes',
        Coords = vector3(1390.65, -1293.63, 76.34),
        CreateNPC = true,
        NPCHeading = 248.71,
        NPCModel = 'a_f_o_sdupperclass_01',
        CreateBlip = true,
        BlipSprite = 'blip_ambient_coach',
        RandomCart = true,
        CartModel = 'coach4', -- Only if RandomCart = false
        CartSpawn = vector4(1392.74, -1295.21, 76.51, 157.48),
        DeliverPosition = vector3(1392.74, -1295.21, 76.51),
        RewardPerDistance = 0.035, -- Reward Per meter If Fix Reward is False
        FixReward = false,
        Reward = 15,  --- IF Use Fix Reward
        EndMissionRadius = 10,
        EnableOilMissions = true,
        FillOilPosition = vector3(555.57, 599.92, 111.17),
        FillOilTime = 10, -- Time in Sec
        FillOilRadius = 5,
    },
    {
        Name = 'Bacchus Station',
        Coords = vector3(576.95, 1662.04, 187.91),
        CreateNPC = true,
        NPCHeading = 346.15,
        NPCModel = 'a_f_o_sdupperclass_01',
        CreateBlip = true,
        BlipSprite = 'blip_ambient_coach',
        RandomCart = true,
        CartModel = 'coach4', -- Only if RandomCart = false
        CartSpawn = vector4(581.03, 1665.39, 185.42, 251.74),
        DeliverPosition = vector3(581.03, 1665.39, 185.42),
        RewardPerDistance = 0.035, -- Reward Per meter If Fix Reward is False
        FixReward = false,
        Reward = 15,  --- IF Use Fix Reward
        EndMissionRadius = 10,
        EnableOilMissions = true,
        FillOilPosition = vector3(555.57, 599.92, 111.17),
        FillOilTime = 10, -- Time in Sec
        FillOilRadius = 5,
    },
    {
        Name = 'Wapiti',
        Coords = vector3(435.5, 2213.75, 246.63),
        CreateNPC = true,
        NPCHeading = 127.28,
        NPCModel = 'a_f_o_sdupperclass_01',
        CreateBlip = true,
        BlipSprite = 'blip_ambient_coach',
        RandomCart = true,
        CartModel = 'coach4', -- Only if RandomCart = false
        CartSpawn = vector4(434.52, 2211.19, 246.25, 224.82),
        DeliverPosition = vector3(434.52, 2211.19, 246.25),
        RewardPerDistance = 0.035, -- Reward Per meter If Fix Reward is False
        FixReward = false,
        Reward = 15,  --- IF Use Fix Reward
        EndMissionRadius = 10,
        EnableOilMissions = true,
        FillOilPosition = vector3(555.57, 599.92, 111.17),
        FillOilTime = 10, -- Time in Sec
        FillOilRadius = 5,
    },
    {
        Name = 'Öl Felder',
        Coords = vector3(482.33, 596.0, 108.88),
        CreateNPC = true,
        NPCHeading = 161.65,
        NPCModel = 'a_f_o_sdupperclass_01',
        CreateBlip = true,
        BlipSprite = 'blip_ambient_coach',
        RandomCart = true,
        CartModel = 'coach4', -- Only if RandomCart = false
        CartSpawn = vector4(482.26, 590.64, 108.5, 256.92),
        DeliverPosition = vector3(482.26, 590.64, 108.5),
        RewardPerDistance = 0.035, -- Reward Per meter If Fix Reward is False
        FixReward = false,
        Reward = 15,  --- IF Use Fix Reward
        EndMissionRadius = 10,
        EnableOilMissions = true,
        FillOilPosition = vector3(555.57, 599.92, 111.17),
        FillOilTime = 10, -- Time in Sec
        FillOilRadius = 5,
    },
    {
        Name = 'Valentine',
        Coords = vector3(-336.12, 757.86, 115.96),
        CreateNPC = true,
        NPCHeading = 139.01,
        NPCModel = 'a_f_o_sdupperclass_01',
        CreateBlip = true,
        BlipSprite = 'blip_ambient_coach',
        RandomCart = true,
        CartModel = 'coach4', -- Only if RandomCart = false
        CartSpawn = vector4(-342.79, 754.93, 115.27, 198.99),
        DeliverPosition = vector3(-342.79, 754.93, 115.27),
        RewardPerDistance = 0.035, -- Reward Per meter If Fix Reward is False
        FixReward = false,
        Reward = 15,  --- IF Use Fix Reward
        EndMissionRadius = 10,
        EnableOilMissions = true,
        FillOilPosition = vector3(555.57, 599.92, 111.17),
        FillOilTime = 10, -- Time in Sec
        FillOilRadius = 5,
    },
    {
        Name = 'Strawberry',
        Coords = vector3(-1786.37, -432.29, 154.44),
        CreateNPC = true,
        NPCHeading = 23.87,
        NPCModel = 'a_f_o_sdupperclass_01',
        CreateBlip = true,
        BlipSprite = 'blip_ambient_coach',
        RandomCart = true,
        CartModel = 'coach4', -- Only if RandomCart = false
        CartSpawn = vector4(-1787.65, -428.0, 154.49, 305.52),
        DeliverPosition = vector3(-1787.65, -428.0, 154.49),
        RewardPerDistance = 0.035, -- Reward Per meter If Fix Reward is False
        FixReward = false,
        Reward = 15,  --- IF Use Fix Reward
        EndMissionRadius = 10,
        EnableOilMissions = true,
        FillOilPosition = vector3(555.57, 599.92, 111.17),
        FillOilTime = 10, -- Time in Sec
        FillOilRadius = 5,
    },
    {
        Name = 'Blackwater',
        Coords = vector3(-860.61, -1337.29, 42.55),
        CreateNPC = true,
        NPCHeading = 99.39,
        NPCModel = 'a_f_o_sdupperclass_01',
        CreateBlip = true,
        BlipSprite = 'blip_ambient_coach',
        RandomCart = true,
        CartModel = 'coach4', -- Only if RandomCart = false
        CartSpawn = vector4(-863.62, -1336.88, 42.41, 358.01),
        DeliverPosition = vector3(-863.62, -1336.88, 42.41),
        RewardPerDistance = 0.035, -- Reward Per meter If Fix Reward is False
        FixReward = false,
        Reward = 15,  --- IF Use Fix Reward
        EndMissionRadius = 10,
        EnableOilMissions = true,
        FillOilPosition = vector3(555.57, 599.92, 111.17),
        FillOilTime = 10, -- Time in Sec
        FillOilRadius = 5,
    },
    {
        Name = 'Thieves Landing',
        Coords = vector3(-1393.08, -2202.32, 42.77),
        CreateNPC = true,
        NPCHeading = 283.16,
        NPCModel = 'a_f_o_sdupperclass_01',
        CreateBlip = true,
        BlipSprite = 'blip_ambient_coach',
        RandomCart = true,
        CartModel = 'coach4', -- Only if RandomCart = false
        CartSpawn = vector4(-1390.1, -2201.08, 42.76, 2.11),
        DeliverPosition = vector3(-1390.1, -2201.08, 42.76),
        RewardPerDistance = 0.035, -- Reward Per meter If Fix Reward is False
        FixReward = false,
        Reward = 15,  --- IF Use Fix Reward
        EndMissionRadius = 10,
        EnableOilMissions = true,
        FillOilPosition = vector3(555.57, 599.92, 111.17),
        FillOilTime = 10, -- Time in Sec
        FillOilRadius = 5,
    },
    {
        Name = 'McFarlens Ranch',
        Coords = vector3(-2365.34, -2400.74, 61.23),
        CreateNPC = true,
        NPCHeading = 233.88,
        NPCModel = 'a_f_o_sdupperclass_01',
        CreateBlip = true,
        BlipSprite = 'blip_ambient_coach',
        RandomCart = true,
        CartModel = 'coach4', -- Only if RandomCart = false
        CartSpawn = vector4(-2363.83, -2404.06, 61.08, 242.11),
        DeliverPosition = vector3(-2363.83, -2404.06, 61.08),
        RewardPerDistance = 0.035, -- Reward Per meter If Fix Reward is False
        FixReward = false,
        Reward = 15,  --- IF Use Fix Reward
        EndMissionRadius = 10,
        EnableOilMissions = true,
        FillOilPosition = vector3(555.57, 599.92, 111.17),
        FillOilTime = 10, -- Time in Sec
        FillOilRadius = 5,
    },
    {
        Name = 'Armadillo',
        Coords = vector3(-3612.12, -2560.52, -14.97),
        CreateNPC = true,
        NPCHeading = 261.78,
        NPCModel = 'a_f_o_sdupperclass_01',
        CreateBlip = true,
        BlipSprite = 'blip_ambient_coach',
        RandomCart = true,
        CartModel = 'coach4', -- Only if RandomCart = false
        CartSpawn = vector4(-3607.86, -2563.68, -14.84, 209.49),
        DeliverPosition = vector3(-3607.86, -2563.68, -14.84),
        RewardPerDistance = 0.035, -- Reward Per meter If Fix Reward is False
        FixReward = false,
        Reward = 15,  --- IF Use Fix Reward
        EndMissionRadius = 10,
        EnableOilMissions = true,
        FillOilPosition = vector3(555.57, 599.92, 111.17),
        FillOilTime = 10, -- Time in Sec
        FillOilRadius = 5,
    },
    {
        Name = 'Tumbleweed',
        Coords = vector3(-5497.88, -2957.37, -1.57),
        CreateNPC = true,
        NPCHeading = 23.39,
        NPCModel = 'a_f_o_sdupperclass_01',
        CreateBlip = true,
        BlipSprite = 'blip_ambient_coach',
        RandomCart = true,
        CartModel = 'coach4', -- Only if RandomCart = false
        CartSpawn = vector4(-5498.91, -2951.12, -2.56, 278.46),
        DeliverPosition = vector3(-5498.91, -2951.12, -2.56),
        RewardPerDistance = 0.035, -- Reward Per meter If Fix Reward is False
        FixReward = false,
        Reward = 15,  --- IF Use Fix Reward
        EndMissionRadius = 10,
        EnableOilMissions = true,
        FillOilPosition = vector3(555.57, 599.92, 111.17),
        FillOilTime = 10, -- Time in Sec
        FillOilRadius = 5,
    },
}
