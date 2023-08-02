fx_version "cerulean"
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
game "rdr3"

client_script {

  'client.lua'

}

server_scripts {

  '@mysql-async/lib/MySQL.lua',
  'server.lua'

}
