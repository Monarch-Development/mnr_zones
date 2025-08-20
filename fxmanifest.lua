fx_version "cerulean"
game "gta5"
lua54 "yes"

name "mnr_zones"
description "Zones management script with Safezone & Speedlimit features"
author "IlMelons"
version "1.0.0"
repository "https://github.com/Monarch-Development/mnr_zones"

ox_lib "locale"

shared_scripts {
    "@ox_lib/init.lua",
}

client_scripts {
    "bridge/client/**/*.lua",
    "client/*.lua",
}

server_scripts {
    "server/*.lua",
}

files {
    "config/*.lua",
    "locales/*.json",
}