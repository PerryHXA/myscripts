fx_version "adamant"
game "rdr3"
rdr3_warning "I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships."

client_script { 
"config.lua",
"main/client.lua"
}

server_script {
"main/server.lua",
'@mysql-async/lib/MySQL.lua',
"config.lua"
} 

ui_page "html/index.html"
files {
    'html/index.html',
    'html/*.js',
    'html/*.css',
    'html/images/*.png',
    'html/images/games/*.png',
    'html/images/games/*.jpg'
}

lua54 'yes'

escrow_ignore {
    'config.lua',
}