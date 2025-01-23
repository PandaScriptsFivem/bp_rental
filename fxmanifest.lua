fx_version 'cerulean'
game 'gta5'
author 'Bandi'
description 'Simple rental script from bp scripts'
lua54 'yes'

shared_script '@ox_lib/init.lua'
shared_script '@es_extended/imports.lua'
shared_script 'config.lua'
client_script 'client.lua'
server_script 'server.lua'

dependencies {
    'ox_lib',
    'ox_target'
}