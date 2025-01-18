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

