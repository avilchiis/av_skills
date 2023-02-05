if Config.Framework == "ESX" then

    lib.callback.register('av_skills:getData', function(source)
        local Player = ESX.GetPlayerFromId(source)
        local identifier = Player.getIdentifier()
        local data = MySQL.single.await('SELECT skills FROM users WHERE identifier = ?', {identifier})
        return data
    end)

    RegisterServerEvent('av_skills:save', function(skills)
        local Player = ESX.GetPlayerFromId(source)
        local identifier = Player.getIdentifier()
        MySQL.insert.await('UPDATE users SET skills = ? WHERE identifier = ?', {json.encode(skills),identifier})
    end)

    function addXP(src,skill,points)
        local Player = ESX.GetPlayerFromId(src)
        local identifier = Player.getIdentifier()
        local data = MySQL.single.await('SELECT * FROM users WHERE identifier = ?', {identifier})
        local skills = json.decode(data.skills)
        if skills[skill] then
            skills[skill] = tonumber(skills[skill]) + tonumber(points)
            if skills[skill] > 100 then skills[skill] = 100 end
            MySQL.insert.await('UPDATE users SET skills = ? WHERE identifier = ?', {json.encode(skills),identifier})
            return true
        end
        return false
    end

    function removeXP(src,skill,points)
        local Player = ESX.GetPlayerFromId(src)
        local identifier = Player.getIdentifier()
        local data = MySQL.single.await('SELECT * FROM users WHERE identifier = ?', {identifier})
        local skills = json.decode(data.skills)
        if skills[skill] then
            skills[skill] = tonumber(skills[skill]) - tonumber(points)
            if skills[skill] < 0 then skills[skill] = 0 end
            MySQL.insert.await('UPDATE users SET skills = ? WHERE identifier = ?', {json.encode(skills),identifier})
            return true
        end
        return false
    end

    function setXP(src,skill,points)
        local Player = ESX.GetPlayerFromId(src)
        local identifier = Player.getIdentifier()
        local data = MySQL.single.await('SELECT * FROM users WHERE identifier = ?', {identifier})
        local skills = json.decode(data.skills)
        if skills[skill] then
            skills[skill] = tonumber(points)
            if skills[skill] > 100 then skills[skill] = 100 end
            if skills[skill] < 0 then skills[skill] = 0 end
            MySQL.insert.await('UPDATE users SET skills = ? WHERE identifier = ?', {json.encode(skills),identifier})
            return true
        end
        return false
    end

    function getXP(src,skill)
        local Player = ESX.GetPlayerFromId(src)
        local identifier = Player.getIdentifier()
        local data = MySQL.single.await('SELECT * FROM users WHERE identifier = ?', {identifier})
        local skills = json.decode(data.skills)
        if skills[skill] then
            return tonumber(skills[skill])
        else
            return false
        end
    end
end