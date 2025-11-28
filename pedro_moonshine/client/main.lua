local QBCore = exports['qb-core']:GetCoreObject()
local placingStill = false
local placedStill = nil

-- detect inventory
local usingOx = false
CreateThread(function()
    if GetResourceState('ox_inventory') == 'started' then
        usingOx = true
        print("^2[PEDRO MOONSHINE] Using ox_inventory on client^7")
    else
        print("^2[PEDRO MOONSHINE] Using qb-inventory on client^7")
    end
end)

--------------------------------------------------------------------------------
-- PLACE MOONSHINE STILL
--------------------------------------------------------------------------------
RegisterNetEvent("pedro_moonshine:client:PlaceStill", function()
    print("^2[PEDRO_MOONSHINE]: PlaceStill event fired^7")

    if placingStill then return end
    if placedStill and DoesEntityExist(placedStill) then
        QBCore.Functions.Notify("You already have a still placed", "error")
        return
    end

    placingStill = true

    local ped = PlayerPedId()
    local heading = GetEntityHeading(ped)

    local model = `fury_potstill_03`

    RequestModel(model)
    while not HasModelLoaded(model) do Wait(10) end

    local offset = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.8, -1.0)

    placedStill = CreateObject(
        model,
        offset.x,
        offset.y,
        offset.z,
        true,
        true,
        false
    )

    if not DoesEntityExist(placedStill) then
        print("^1[PEDRO_MOONSHINE] OBJECT FAILED TO CREATE^7")
        placingStill = false
        return
    end

    PlaceObjectOnGroundProperly(placedStill)
    SetEntityHeading(placedStill, heading)
    FreezeEntityPosition(placedStill, true)
    SetEntityAsMissionEntity(placedStill, true, true)
    SetModelAsNoLongerNeeded(model)

    print("^2[PEDRO_MOONSHINE] STILL SPAWNED SUCCESSFULLY^7")

    -- Remove the still from inventory
    TriggerServerEvent("pedro_moonshine:server:RemoveStillItem")

    -- Add ox_target interactions
    if GetResourceState('ox_target') == 'started' then
        exports.ox_target:addLocalEntity(placedStill, {
            {
                name = "start_distill",
                icon = "fa-solid fa-fire-burner",
                label = "Start Distilling",
                distance = 2.5,
                onSelect = function()
                    TriggerEvent("moonshine:client:startDistill")
                end
            },
            {
                name = "pickup_still",
                icon = "fa-solid fa-hand",
                label = "Pick Up Still",
                distance = 2.5,
                onSelect = function()
                    if not placedStill or not DoesEntityExist(placedStill) then
                        QBCore.Functions.Notify("No still to pick up", "error")
                        return
                    end

                    exports.ox_target:removeLocalEntity(placedStill)
                    DeleteEntity(placedStill)
                    placedStill = nil

                    TriggerServerEvent("pedro_moonshine:server:GiveStillBack")

                    -- Only show item box for QB inventory
                    if not usingOx then
                        TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["moonshine_still"], "add")
                    end

                    QBCore.Functions.Notify("Still picked up and returned", "success")
                end
            }
        })
    end

    QBCore.Functions.Notify("Moonshine still placed!", "success")
    placingStill = false
end)

--------------------------------------------------------------------------------
-- DISTILL MENU (SHOW INGREDIENTS)
--------------------------------------------------------------------------------
RegisterNetEvent("moonshine:client:startDistill", function()
    if not placedStill or not DoesEntityExist(placedStill) then
        QBCore.Functions.Notify("No still found", "error")
        return
    end

    local options = {}

    for key, recipe in pairs(Config.MoonshineRecipes) do
        local ingredientText = ""

        for i, ingredient in ipairs(recipe.recipe) do
            local label = ingredient.item
            local shared = QBCore.Shared.Items[ingredient.item]

            if shared and shared.label then
                label = shared.label
            end

            ingredientText = ingredientText .. ingredient.amount .. "x " .. label

            if i < #recipe.recipe then
                ingredientText = ingredientText .. "\n"
            end
        end

        options[#options + 1] = {
            title = recipe.label,
            description =
                "Required:\n" .. ingredientText ..
                "\n\nTime: " .. (recipe.time / 1000) .. " seconds",
            event = "moonshine:client:confirmDistill",
            args = key
        }
    end

    lib.registerContext({
        id = 'moonshine_menu',
        title = 'Moonshine Distilling Menu',
        options = options
    })

    lib.showContext('moonshine_menu')
end)

--------------------------------------------------------------------------------
-- DISTILL PROCESS
--------------------------------------------------------------------------------
RegisterNetEvent("moonshine:client:confirmDistill", function(recipeKey)
    if not placedStill or not DoesEntityExist(placedStill) then
        QBCore.Functions.Notify("Your still is gone", "error")
        return
    end

    local recipe = Config.MoonshineRecipes[recipeKey]
    if not recipe then return end

    QBCore.Functions.Progressbar(
        'distilling_' .. recipeKey,
        'Distilling ' .. recipe.label .. '...',
        recipe.time,
        false,
        true,
        { disableMovement = true, disableCombat = true },
        { animDict = "mini@repair", anim = "fixing_a_player" },
        {},
        {},
        function()
            TriggerServerEvent("pedro_moonshine:server:finishDistill", recipeKey)
        end
    )
end)
