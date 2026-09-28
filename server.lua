local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('pauseMenu:getSettings', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier

    MySQL.Async.fetchScalar('SELECT menu_settings FROM player_data WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    }, function(result)
        if result then
            cb(json.decode(result))
        else
            MySQL.Async.fetchScalar('SELECT menu_settings FROM player_data WHERE identifier = @identifier', {
                ['@identifier'] = 'default'
            }, function(defaultSettings)
                cb(json.decode(defaultSettings))
            end)
        end
    end)
end)

RegisterServerEvent('pauseMenu:saveSettings')
AddEventHandler('pauseMenu:saveSettings', function(data)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier

    MySQL.Async.execute('INSERT INTO player_data (identifier, menu_settings) VALUES (@identifier, @menu_settings) ON DUPLICATE KEY UPDATE menu_settings = @menu_settings', {
        ['@identifier'] = identifier,
        ['@menu_settings'] = json.encode(data)
    })
end)