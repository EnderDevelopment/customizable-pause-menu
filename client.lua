local ESX = nil
local isMenuOpen = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(1, 322) and not isMenuOpen then
            OpenPauseMenu()
        end
    end
end)

function OpenPauseMenu()
    isMenuOpen = true
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'openMenu',
        title = Config.MenuTitle,
        subtitle = Config.MenuSubtitle,
        backgroundColor = Config.MenuBackgroundColor,
        textColor = Config.MenuTextColor,
        buttonColor = Config.MenuButtonColor,
        buttonHoverColor = Config.MenuButtonHoverColor
    })
end

RegisterNUICallback('closeMenu', function(data, cb)
    isMenuOpen = false
    SetNuiFocus(false, false)
    cb({})
end)

RegisterNUICallback('saveSettings', function(data, cb)
    TriggerServerEvent('pauseMenu:saveSettings', data)
    cb({})
end)