fx_version 'cerulean'
game 'gta5'

author 'Pedro'
description 'Moonshine Script for QB-Core + ox_target'
version '1.0.0'

files {
    'stream/*.ydr',
    'stream/*.ytd',
    'stream/*.ytyp'
}

shared_scripts {
    '@ox_lib/init.lua',
    '@qb-core/shared/locale.lua',
    'config.lua',
    'shared/items.lua'
}

client_scripts {
    'client/main.lua',
    'client/harvest.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua',
    'server/harvest.lua'
}

dependencies {
    'qb-core',
    'ox_target',
    'ox_lib',
    'object_gizmo'
}
