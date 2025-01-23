local ped = nil
local Locales = Config.Locale
CreateThread(function()


    RequestModel(GetHashKey(Config.BikePedModel))
    while not HasModelLoaded(GetHashKey(Config.BikePedModel)) do
        Wait(1)
    end
          
    RequestAnimDict("mini@strip_club@idles@bouncer@base")
    while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
        Wait(1)
    end

    local hash = GetHashKey(Config.BikePedModel)

    local veh = nil
    local berelve = false

    function Time(msec)

        lib.notify({
            title = 'Bicikli bérlés',
            description = 'Ennyi van még hátra',
            type = 'inform',
            duration = msec,
            position = 'bottom-right'
        })
        Wait(msec)
        DeleteVehicle(veh)
        berelve = false
    end

    local function Brinyo()

        local options = {}

        for _, cucc in ipairs(Config.Bikes) do 
            local type = nil
            
    
            table.insert(options, {
                title = cucc.label .. " - " .. cucc.price .. Locales.dollarpermin,
                icon = cucc.icon,
                image = cucc.kep,
                onSelect = function()
                    
                
                    lib.registerContext({
                        id = "kartya",
                        title = Locales.method,
                        options = {
                            {
                                title = Locales.card,
                                description = Locales.bankdesc,
                                icon = "credit-card",
                                iconColor = "#ffffff",
                                onSelect = function()
                                    type = "bank"
                                    local input = lib.inputDialog(Locales.Name, {{type = 'number', label = Locales.inputlabel, description = Locales.inputdesc, icon = 'clock'}})
                                    if input == nil then return end
                                    local masod = input[1] * 1000
                                    local perc = masod * 60
                                    local pez = input[1] * cucc.price
                                    local Playerdata = ESX.GetPlayerData()
                                    lib.callback('bp_rental:get', false, function(bankmoney, money2)
                                        local kellmeg = pez - bankmoney
                                        if bankmoney >= pez then
                                            TriggerServerEvent("bp_rental:remove", pez, type)
                                            Wait(250)
                                            if not IsModelInCdimage(cucc.lehivo) then return end
                                            RequestModel(cucc.lehivo)
                                            while not HasModelLoaded(cucc.lehivo) do 
                                                Wait(0)
                                            end
                                            
                                            veh = CreateVehicle(cucc.lehivo, GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), true, false) 
                                            SetModelAsNoLongerNeeded(cucc.lehivo)
                                            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                                            berelve = true
                                            Time(perc)
                                        else
                                            lib.notify({
                                                title = Locales.Name,
                                                description = Locales.nomoney .. kellmeg .. Locales.dollarmissing,
                                                type = 'error',
                                                position = 'bottom-right'
                                            }) 
                                        end
                                    end)
                                end
                            },
                            {
                                title = Locales.cash,
                                description = Locales.cashdesc,
                                icon = "wallet",
                                iconColor = "#ffffff",
                                onSelect = function()
                                    type = "money"
                                    local input = lib.inputDialog(Locales.Name, {{type = 'number', label = Locales.inputlabel, description = Locales.inputdesc, icon = 'clock'}})
                                    if input == nil then return end
                                    local masod = input[1] * 1000
                                    local perc = masod * 60
                                    local pez = input[1] * cucc.price
                                    local Playerdata = ESX.GetPlayerData()
                                    lib.callback('bp_rental:get', false, function(bankmoney, money2)
                                    local penz = money2
                                    local kellmeg = pez - penz
                                    if penz >= pez then
                                        TriggerServerEvent("bp_rental:remove", pez, type)
                                        if not IsModelInCdimage(cucc.lehivo) then return end
                                        RequestModel(cucc.lehivo)
                                        while not HasModelLoaded(cucc.lehivo) do 
                                            Wait(0)
                                        end
                                        
                                        veh = CreateVehicle(cucc.lehivo, GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), true, false) 
                                        SetModelAsNoLongerNeeded(cucc.lehivo)
                                        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
                                        berelve = true
                                        Time(perc)
                                    else
                                        lib.notify({
                                            title = Locales.Name,
                                            description = Locales.nomoney .. kellmeg .. Locales.dollarmissing,
                                            type = 'error',
                                            position = 'bottom-right'
                                        }) 
                                    end
                                end)
                            end}}})
                    lib.showContext("kartya")
                end,
                disabled = berelve
            })

            
        end

        lib.registerContext({
            id = 'bicikli',
            title = Locales.Name,
            options = options
        })
    end

    
    

    local options = {
        label = Locales.Name, 
        icon = "fa-solid fa-bicycle", 
        onSelect = function() 
            Brinyo()
            Wait(250)
            lib.showContext('bicikli')
        end
    }

    for _, coord in ipairs(Config.BikeLocations) do 
        if Config.ShowBlip then 
            local blip = AddBlipForCoord(coord)
            SetBlipSprite(blip, Config.BlipSprite) 
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, 0.8)
            SetBlipColour(blip, Config.BlipColor) 
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(Locales.BlipName)
        end
        print(coord)
        ped =  CreatePed(4, hash, coord.x, coord.y, coord.z-1, 3374176, false, true)
        SetEntityHeading(ped, coord.w)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
        
        local parameters = {
            coords = vec3(coord.x, coord.y, coord.z),
            radius = 0.5,
            options = options
        }
        
        exports.ox_target:addSphereZone(parameters)
    end
    
    
end)