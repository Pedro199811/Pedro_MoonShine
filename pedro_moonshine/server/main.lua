print("^1[PEDRO MOONSHINE] SERVER FILE LOADED SUCCESSFULLY^7")

-- PEDRO MOONSHINE | VERSION + GITHUB CHECK
CreateThread(function()
    Wait(3000)

    local resourceName   = GetCurrentResourceName()
    local currentVersion = GetResourceMetadata(resourceName, "version", 0) or "UNKNOWN"

    local versionURL = "https://raw.githubusercontent.com/Pedro199811/pedro_moonshine/main/version.txt"
    local githubURL  = "https://github.com/Pedro199811/pedro_moonshine"

PerformHttpRequest(versionURL, function(code, result)
    local latestVersion = "UNKNOWN"

    if result and code == 200 then
        latestVersion = result:gsub("%s+", ""):gsub("[\"']", "")
    end

    print("^5[ script:"..resourceName.." ]  ----------------------------------------------------^0")
    print("^5[ script:"..resourceName.." ] |  ██████╗ ███████╗██████╗ ██████╗  ██████╗         |^0")
    print("^5[ script:"..resourceName.." ] |  ██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔═══██╗        |^0")
    print("^5[ script:"..resourceName.." ] |  ██████╔╝█████╗  ██║  ██║██████╔╝██║   ██║        |^0")
    print("^5[ script:"..resourceName.." ] |  ██╔═══╝ ██╔══╝  ██║  ██║██╔══██╗██║   ██║        |^0")
    print("^5[ script:"..resourceName.." ] |  ██║     ███████╗██████╔╝██║  ██║╚██████╔╝        |^0")
    print("^5[ script:"..resourceName.." ] |  ╚═╝     ╚══════╝╚═════╝ ╚═╝  ╚═╝ ╚═════╝         |^0")
    print("^5[ script:"..resourceName.." ] |                                                    |^0")
    print("^5[ script:"..resourceName.." ] |      PEDRO MOONSHINE SYSTEM - QBCORE / OX         |^0")
    print("^5[ script:"..resourceName.." ] ------------------------------------------------------^0")
    print("^5[ script:"..resourceName.." ] | INSTALLED VERSION : ".. tostring(currentVersion) .. string.rep(" ", 26 - #tostring(currentVersion)) .. "|^0")
    print("^5[ script:"..resourceName.." ] | LATEST VERSION    : ".. tostring(latestVersion) .. string.rep(" ", 26 - #tostring(latestVersion)) .. "|^0")
    print("^5[ script:"..resourceName.." ] ------------------------------------------------------^0")
    print("^5[ script:"..resourceName.." ] | GitHub: ".. githubURL .. string.rep(" ", 46 - #githubURL) .. "|^0")
    print("^5[ script:"..resourceName.." ] ------------------------------------------------------^0")

    if latestVersion ~= "UNKNOWN" and tostring(currentVersion) ~= tostring(latestVersion) then
        print("^1[ script:"..resourceName.." ]  OUTDATED - PLEASE UPDATE YOUR SCRIPT!^0")
    else
        print("^2[ script:"..resourceName.." ]  SCRIPT IS UP TO DATE ✔^0")
    end
end, "GET")
end)

local QBCore = exports['qb-core']:GetCoreObject()

----------------------------------
-- INVENTORY AUTO DETECTION
----------------------------------
local usingOx = false

CreateThread(function()
    Wait(1500)

    print("^6--------------------------------------^0")
    print("^3[ PEDRO MOONSHINE ] INVENTORY SYSTEM^0")
    print("^6--------------------------------------^0")

    if GetResourceState('ox_inventory') == 'started' then
        usingOx = true
        print("^2[ INVENTORY DETECTED ]: ox_inventory ✅^0")
    else
        usingOx = false
        print("^2[ INVENTORY DETECTED ]: qb-inventory ✅^0")

        QBCore.Functions.CreateUseableItem("moonshine_still", function(source)
            print("^2[PEDRO_MOONSHINE]: moonshine_still USED by: " .. source .. "^7")
            TriggerClientEvent("pedro_moonshine:client:PlaceStill", source)
        end)
    end

    print("^6--------------------------------------^0")
end)

----------------------------------
-- REMOVE STILL FROM PLAYER
----------------------------------
RegisterNetEvent('pedro_moonshine:server:RemoveStillItem', function()
    local src = source

    if usingOx then
        exports.ox_inventory:RemoveItem(src, 'moonshine_still', 1)
    else
        local Player = QBCore.Functions.GetPlayer(src)
        if Player then
            Player.Functions.RemoveItem("moonshine_still", 1)
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["moonshine_still"], "remove")
        end
    end
end)

----------------------------------
-- GIVE STILL BACK
----------------------------------
RegisterNetEvent('pedro_moonshine:server:GiveStillBack', function()
    local src = source

    if usingOx then
        exports.ox_inventory:AddItem(src, 'moonshine_still', 1)
    else
        local Player = QBCore.Functions.GetPlayer(src)
        if Player then
            Player.Functions.AddItem("moonshine_still", 1)
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items["moonshine_still"], "add")
        end
    end
end)

----------------------------------
-- DISTILLING FINISH + PURITY
----------------------------------
RegisterNetEvent("pedro_moonshine:server:finishDistill", function(recipeKey)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local recipe = Config.MoonshineRecipes[recipeKey]
    if not recipe then return end

    for _, v in ipairs(recipe.recipe) do
        local item = Player.Functions.GetItemByName(v.item)
        if not item or item.amount < v.amount then
            TriggerClientEvent('QBCore:Notify', src, "Missing: " .. v.item, "error")
            return
        end
    end

    for _, v in ipairs(recipe.recipe) do
        Player.Functions.RemoveItem(v.item, v.amount)

        if not usingOx then
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[v.item], "remove")
        end
    end

    local purity = math.random(70, 100)

    if recipeKey == "apple_pie" then
        purity = purity + 3
    elseif recipeKey == "honeyshine" then
        purity = purity + 5
    elseif recipeKey == "berryshine" then
        purity = purity - 2
    end

    if purity > 100 then purity = 100 end
    if purity < 0 then purity = 0 end

    local info = { purity = purity }

    if usingOx then
        exports.ox_inventory:AddItem(src, recipe.output, recipe.outputAmount, info)
    else
        Player.Functions.AddItem(recipe.output, recipe.outputAmount, false, info)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items[recipe.output], "add")
    end

    TriggerClientEvent('QBCore:Notify', src, recipe.label .. " completed! Purity: " .. purity .. "%", "success")
end)
