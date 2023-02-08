loaded = false

if Config.Framework == "QBCore" then
    QBCore = exports['qb-core']:GetCoreObject()
end

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    Sync()
    loaded = true
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    Sync()
    loaded = false
end)

RegisterNetEvent('esx:onPlayerLogout',function()
    Sync()
    loaded = false
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    Wait(1000)
    Sync()
	loaded = true
end)