fx_version 'adamant'

game 'rdr3'

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
    'server.lua',
    'svbeds.lua'
}

client_scripts {
    'client.lua',
    'beds.lua'
}

shared_scripts {
    'config.lua'
}