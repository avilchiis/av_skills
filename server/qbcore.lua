if Config.Framework == "QBCore" then

    QBCore = exports['qb-core']:GetCoreObject()

    lib.callback.register('av_skills:getData', function(source)
        local Player = QBCore.Functions.GetPlayer(source)
        local citizenid = Player.PlayerData.citizenid
        local data = MySQL.single.await('SELECT * FROM players WHERE citizenid = ?', {citizenid})
        if not data.skills then
            data.skills = json.encode(Config.Skills)
            MySQL.insert.await('UPDATE players SET skills = ? WHERE citizenid = ?', {data.skills,citizenid})
        end
        return json.decode(data.skills)
    end)

    RegisterServerEvent('av_skills:save', function(skills)
        local Player = QBCore.Functions.GetPlayer(source)
        local citizenid = Player.PlayerData.citizenid
        print(json.encode(skills))
        MySQL.insert.await('UPDATE players SET skills = ? WHERE citizenid = ?', {json.encode(skills),citizenid})
    end)

    function addXP(src,skill,points)
        local Player = QBCore.Functions.GetPlayer(src)
        local citizenid = Player.PlayerData.citizenid
        local data = MySQL.single.await('SELECT * FROM players WHERE citizenid = ?', {citizenid})
        local skills = json.decode(data.skills)
        if skills[skill] then
            skills[skill] = tonumber(skills[skill]) + tonumber(points)
            if skills[skill] > 100 then skills[skill] = 100 end
            MySQL.insert.await('UPDATE players SET skills = ? WHERE citizenid = ?', {json.encode(skills),citizenid})
            return true
        end
        return false
    end

    function removeXP(src,skill,points)
        local Player = QBCore.Functions.GetPlayer(src)
        local citizenid = Player.PlayerData.citizenid
        local data = MySQL.single.await('SELECT * FROM players WHERE citizenid = ?', {citizenid})
        local skills = json.decode(data.skills)
        if skills[skill] then
            skills[skill] = tonumber(skills[skill]) - tonumber(points)
            if skills[skill] < 0 then skills[skill] = 0 end
            MySQL.insert.await('UPDATE players SET skills = ? WHERE citizenid = ?', {json.encode(skills),citizenid})
            return true
        end
        return false
    end

    function setXP(src,skill,points)
        local Player = QBCore.Functions.GetPlayer(src)
        local citizenid = Player.PlayerData.citizenid
        local data = MySQL.single.await('SELECT * FROM players WHERE citizenid = ?', {citizenid})
        local skills = json.decode(data.skills)
        if skills[skill] then
            skills[skill] = tonumber(points)
            if skills[skill] > 100 then skills[skill] = 100 end
            if skills[skill] < 0 then skills[skill] = 0 end
            MySQL.insert.await('UPDATE players SET skills = ? WHERE citizenid = ?', {json.encode(skills),citizenid})
            return true
        end
        return false
    end

    function getXP(src,skill)
        local Player = QBCore.Functions.GetPlayer(src)
        local citizenid = Player.PlayerData.citizenid
        local data = MySQL.single.await('SELECT * FROM players WHERE citizenid = ?', {citizenid})
        local skills = json.decode(data.skills)
        if skills[skill] then
            return tonumber(skills[skill])
        else
            return false
        end
    end
end