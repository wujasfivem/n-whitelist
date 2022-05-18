ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler("playerConnecting", function(reject)

    local src = source

    MySQL.Async.fetchAll('SELECT ip FROM n_ipwhitelist WHERE ip = @ip', {
		['@ip'] = GetPlayerEndpoint(src)
	}, function(result)
        if(result[1].ip == nil) then
            reject("Nie znajdujesz sie na IP Allowlist")
        end
	end)
end)

RegisterCommand('ipadd', function(xPlayer, args)
    
    local data = xPlayer
    
    if(args[1] ~= nil) then
        if(data.group ~= 'user') then    
            MySQL.Async.execute('INSERT INTO `n_ipwhitelist` (`ip`) VALUES (@ip)', {['@ip'] = args[1]})
        else
            data.showNotification('~r~[N-WHITELIST] Nie posiadasz permisji')
        end
    else
        data.showNotification('~r~[N-WHITELIST] Musisz podac IP')
    end
end)