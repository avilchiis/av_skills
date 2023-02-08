exports("getDefault", function()
    return Config.Skills
end)

exports("addXP", function(skill,points)
    if not loaded then
        Sync()
    end
    if not skill or not points then
        print('^2[ERROR] ^7Missing arguments addXP()')
        return false
    end
    if Config.Skills[skill] then
        Config.Skills[skill] = Config.Skills[skill] + tonumber(points)
        if Config.Skills[skill] > 100 then Config.Skills[skill] = 100 end
        TriggerServerEvent('av_skills:save',Config.Skills)
        return true
    else
        print('^2[ERROR] ^7Wrong skill name')
    end
    return false
end)

exports("removeXP", function(skill,points)
    if not loaded then
        Sync()
    end
    if not skill or not points then
        print('^2[ERROR] ^7Missing arguments addXP()')
        return false
    end
    if Config.Skills[skill] then
        Config.Skills[skill] = Config.Skills[skill] - tonumber(points)
        if Config.Skills[skill] < 0 then Config.Skills[skill] = 0 end
        TriggerServerEvent('av_skills:save',Config.Skills)
        return true
    else
        print('^2[ERROR] ^7Wrong skill name')
    end
    return false
end)

exports("setXP", function(skill,points)
    if not loaded then
        Sync()
    end
    if not skill or not points then
        print('^2[ERROR] ^7Missing arguments addXP()')
        return false
    end
    if Config.Skills[skill] then
        Config.Skills[skill] = tonumber(points)
        if Config.Skills[skill] > 100 then Config.Skills[skill] = 100 end
        if Config.Skills[skill] < 0 then Config.Skills[skill] = 0 end
        TriggerServerEvent('av_skills:save',Config.Skills)
        return true
    else
        print('^2[ERROR] ^7Wrong skill name')
    end
    return false
end)

exports("getXP", function(skill)
    if not loaded then
        Sync()
    end
    if Config.Skills[skill] then
        return Config.Skills[skill]
    else
        print('^2[ERROR] ^7Wrong skill name')
        return false
    end
end)