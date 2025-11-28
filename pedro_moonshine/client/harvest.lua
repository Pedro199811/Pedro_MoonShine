local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    for item, data in pairs(Config.HarvestLocations) do
        for _, coords in ipairs(data.locations) do
            exports.ox_target:addSphereZone({
                coords = coords,
                radius = 1.5,
                options = {
                    {
                        name = "harvest_" .. item,
                        icon = "fa-solid fa-seedling",
                        label = data.label,
                        onSelect = function()
                            TriggerEvent("ember_moonshine:client:HarvestItem", item, data.time)
                        end
                    }
                }
            })
        end
    end
end)

RegisterNetEvent("ember_moonshine:client:HarvestItem", function(item, time)
    QBCore.Functions.Progressbar(
        "harvest_" .. item,
        "Collecting " .. item .. "...",
        time,
        false,
        true,
        {
            disableMovement = true,
            disableCombat = true
        },
        {
            animDict = "amb@world_human_gardener_plant@male@base",
            anim = "base"
        },
        {},
        {},
        function()
            TriggerServerEvent("ember_moonshine:server:GiveHarvestItem", item)
        end
    )
end)
