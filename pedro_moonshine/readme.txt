

🍶 Pedro Moonshine System

A custom moonshine production system for FiveM (QB-Core + Ox)

Crafted by Pedro for serious roleplay servers.
Fully compatible with QBCore, ox_inventory, and ox_target.

✨ Features

✅ Place and use a realistic Moonshine Still
✅ Distill multiple flavours of moonshine
✅ Ingredient collection & processing
✅ Custom purity system (70%–100%)
✅ Pick up and reuse the still
✅ Fully configurable & expandable
✅ Auto-detects inventory system
✅ Works with ox_target for interactions

Current flavours:

🥃 Regular Moonshine

🍎 Apple Pie Moonshine

🍯 Honey Moonshine

🍓 Berry Moonshine

📦 Item List
🧪 Outputs

moonshine – Regular Moonshine

applepie_moonshine – Apple Pie Moonshine

honey_moonshine – Honeyshine

berry_moonshine – Berry Moonshine

🌾 Ingredients

corn

yeast

sugar

apples

honey

berries

🛠 Utility

moonshine_still – Used to place the still

⚙️ Installation
1️⃣ Add the resource

Download or copy the pedro_moonshine folder.

Place it in:

resources/[standalone]/pedro_moonshine


Add this to your server.cfg:

ensure pedro_moonshine

2️⃣ Requirements

Make sure these resources are installed and started before pedro_moonshine:

qb-core

oxmysql (or compatible MySQL solution)

ox_target

Either:

ox_inventory OR

qb-inventory

The script will auto-detect which inventory is running.

3️⃣ Add items (QB-Core)

In qb-core/shared/items.lua, add:

['moonshine'] = {
    name = 'moonshine',
    label = 'Regular Moonshine',
    weight = 500,
    type = 'item',
    image = 'moonshine.png',
    unique = false,
    useable = true,
    description = 'Illegally distilled moonshine'
},

['applepie_moonshine'] = {
    name = 'applepie_moonshine',
    label = 'Apple Pie Moonshine',
    weight = 500,
    type = 'item',
    image = 'applepie_moonshine.png',
    unique = false,
    useable = true,
    description = 'Sweet apple-flavoured moonshine'
},

['honey_moonshine'] = {
    name = 'honey_moonshine',
    label = 'Honeyshine',
    weight = 500,
    type = 'item',
    image = 'honey.png',
    unique = false,
    useable = true,
    description = 'Smooth honey-infused moonshine'
},

['berry_moonshine'] = {
    name = 'berry_moonshine',
    label = 'Berry Moonshine',
    weight = 500,
    type = 'item',
    image = 'berryshine.png',
    unique = false,
    useable = true,
    description = 'Moonshine made with wild berries'
},

['corn'] = {
    name = 'corn',
    label = 'Corn',
    weight = 80,
    type = 'item',
    image = 'corn.png',
    unique = false,
    useable = true,
    description = 'Freshly harvested corn'
},

['yeast'] = {
    name = 'yeast',
    label = 'Yeast',
    weight = 50,
    type = 'item',
    image = 'yeast.png',
    unique = false,
    useable = true,
    description = 'Wildly collected yeast'
},

['sugar'] = {
    name = 'sugar',
    label = 'Sugar',
    weight = 100,
    type = 'item',
    image = 'sugar.png',
    unique = false,
    useable = true,
    description = 'Sweet sugar crystals'
},

['apples'] = {
    name = 'apples',
    label = 'Apples',
    weight = 80,
    type = 'item',
    image = 'apples.png',
    unique = false,
    useable = true,
    description = 'Fresh apples'
},

['honey'] = {
    name = 'honey',
    label = 'Honey',
    weight = 50,
    type = 'item',
    image = 'honey.png',
    unique = false,
    useable = true,
    description = 'Fresh collected honey'
},

['berries'] = {
    name = 'berries',
    label = 'Wild Berries',
    weight = 50,
    type = 'item',
    image = 'berries.png',
    unique = false,
    useable = true,
    description = 'Picked wild berries'
},

['moonshine_still'] = {
    name = 'moonshine_still',
    label = 'Moonshine Still',
    weight = 1000,
    type = 'item',
    image = 'moonshine_still.png',
    unique = true,
    useable = true,
    description = 'Used to place a moonshine still'
},

4️⃣ Add items (ox_inventory)

In ox_inventory/data/items.lua, add:

['moonshine'] = {
    label = 'Regular Moonshine',
    weight = 500,
    stack = true,
    close = true,
    description = 'Illegally distilled moonshine',
    consume = 0,
    client = {
        image = 'moonshine.png'
    },
},

['applepie_moonshine'] = {
    label = 'Apple Pie Moonshine',
    weight = 500,
    stack = true,
    close = true,
    description = 'Sweet apple-flavoured moonshine',
    consume = 0,
    client = {
        image = 'applepie_moonshine.png'
    },
},

['honey_moonshine'] = {
    label = 'Honeyshine',
    weight = 500,
    stack = true,
    close = true,
    description = 'Smooth honey-infused moonshine',
    consume = 0,
    client = {
        image = 'honey.png'
    },
},

['berry_moonshine'] = {
    label = 'Berry Moonshine',
    weight = 500,
    stack = true,
    close = true,
    description = 'Moonshine made with wild berries',
    consume = 0,
    client = {
        image = 'berryshine.png'
    },
},

['corn'] = {
    label = 'Corn',
    weight = 80,
    stack = true,
    close = true,
    description = 'Freshly harvested corn',
    client = {
        image = 'corn.png'
    },
},

['yeast'] = {
    label = 'Yeast',
    weight = 50,
    stack = true,
    close = true,
    description = 'Wildly collected yeast',
    client = {
        image = 'yeast.png'
    },
},

['sugar'] = {
    label = 'Sugar',
    weight = 100,
    stack = true,
    close = true,
    description = 'Sweet sugar crystals',
    client = {
        image = 'sugar.png'
    },
},

['apples'] = {
    label = 'Apples',
    weight = 80,
    stack = true,
    close = true,
    description = 'Fresh apples',
    client = {
        image = 'apples.png'
    },
},

['honey'] = {
    label = 'Honey',
    weight = 50,
    stack = true,
    close = true,
    description = 'Fresh collected honey',
    client = {
        image = 'honey.png'
    },
},

['berries'] = {
    label = 'Wild Berries',
    weight = 50,
    stack = true,
    close = true,
    description = 'Picked wild berries',
    client = {
        image = 'berries.png'
    },
},

['moonshine_still'] = {
    label = 'Moonshine Still',
    weight = 1000,
    stack = false,
    close = true,
    description = 'Used to place a moonshine still',
    client = {
        event = 'pedro_moonshine:client:PlaceStill'
    },
},


Then in console:

ox_inventory:reloadItems

5️⃣ Final test

Restart the resource:

restart pedro_moonshine


Give yourself a still:

/giveitem [yourid] moonshine_still 1


Open your inventory and use the Moonshine Still

The still should appear in front of you and be usable via ox_target

🎯 Usage Flow

Use moonshine_still to place the still

Interact with the still (ox_target)

Choose a recipe (Regular / Apple Pie / Honey / Berry)

Wait for distilling to finish

Receive moonshine with random purity %

Pick the still back up and move it
all images are in images folder 