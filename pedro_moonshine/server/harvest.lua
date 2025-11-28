local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("ember_moonshine:server:GiveHarvestItem", function(item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local amount = math.random(1, 3)

    Player.Functions.AddItem(item, amount)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[item], "add")
    TriggerClientEvent('QBCore:Notify', src, "You collected "..amount.."x "..item, "success")
end)
