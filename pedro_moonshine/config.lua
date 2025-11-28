Config = Config or {}

Config.Inventory = 'auto' 
-- 'auto' = detect automatically
-- 'qb'   = force qb-inventory
-- 'ox'   = force ox_inventory

-- ============================
-- HARVEST LOCATIONS
-- ============================
Config.HarvestLocations = {
    corn = {
        label = "Pick Corn",
        time = 3500,
        locations = {
            vector3(2441.65, 4755.21, 34.31),
            vector3(2438.90, 4760.10, 34.30),
            vector3(2445.22, 4752.18, 34.32)
        }
    },

    yeast = {
        label = "Collect Wild Yeast",
        time = 4000,
        locations = {
            vector3(2169.34, 4985.18, 41.42),
            vector3(2172.22, 4980.44, 41.41)
        }
    },

    sugar = {
        label = "Gather Sugar Cane",
        time = 4500,
        locations = {
            vector3(2678.85, 3516.92, 53.38),
            vector3(2680.01, 3513.88, 53.40)
        }
    },

    apples = {
        label = "Pick Apples",
        time = 5000,
        locations = {
            vector3(2225.25, 4767.30, 41.65),
            vector3(2200.12, 4783.94, 41.62)
        }
    },

    honey = {
        label = "Collect Honey",
        time = 5500,
        locations = {
            vector3(2105.12, 4681.48, 41.89),
            vector3(2120.77, 4690.50, 41.84)
        }
    },

    berries = {
        label = "Pick Berries",
        time = 4500,
        locations = {
            vector3(2155.33, 4938.25, 41.20),
            vector3(2170.65, 4951.30, 41.10)
        }
    }
}

-- ============================
-- MOONSHINE RECIPES
-- ============================
Config.MoonshineRecipes = {
    regular = {
        label = "Moonshine",
        output = "moonshine",
        outputAmount = 1,
        time = 10000,
        recipe = {
            { item = "corn", amount = 3 },
            { item = "yeast", amount = 1 },
            { item = "sugar", amount = 2 }
        }
    },

    apple_pie = {
        label = "Apple Pie Moonshine",
        output = "applepie_moonshine",
        outputAmount = 1,
        time = 12000,
        recipe = {
            { item = "corn", amount = 2 },
            { item = "yeast", amount = 1 },
            { item = "apples", amount = 3 },
            { item = "sugar", amount = 2 }
        }
    },

    honeyshine = {
        label = "Honey Moonshine",
        output = "honey_moonshine",
        outputAmount = 1,
        time = 14000,
        recipe = {
            { item = "corn", amount = 2 },
            { item = "honey", amount = 2 },
            { item = "yeast", amount = 1 }
        }
    },

    berryshine = {
        label = "Berry Moonshine",
        output = "berry_moonshine",
        outputAmount = 1,
        time = 16000,
        recipe = {
            { item = "corn", amount = 2 },
            { item = "berries", amount = 4 },
            { item = "yeast", amount = 1 }
        }
    }
}
