game 'rdr3'
fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

shared_scripts {
    'config.lua'
}

client_scripts {
  'client/client.lua'
}

server_scripts {
  'server/server.lua',
  'server/items.lua'
}
lua54 'yes'
