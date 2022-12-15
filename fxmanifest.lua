fx_version "bodacious"

games {"gta5"}
lua54 'yes'

server_script {						
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'nh_server.lua',
}