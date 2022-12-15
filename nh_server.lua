if(Config.ESX) then 
    ESX = TriggerEvent(Config.Object, function(obj) 
        ESX = obj
    end)
end

RegisterServerEvent("playerConnecting", function(reject)
    local src = source 
    if(Config.MySQL == "oxmysql") then 
        MySQL.query("SELECT ip from ip_whitelist WHERE ip = @playerIP", {
            ["@playerIP"] = GetPlayerEndpoint(src)
        }, function(res)
            if(res[1].ip == nil) then 
                reject("Your IP Adress is not in AllowList")
                return
            end
        end)
    else
        MySQL.Async.fetchAll("SELECT ip from ip_whitelist WHERE ip = @playerIP", {
            ["@playerIP"] = GetPlayerEndpoint(src)
        }, function(res)
            if(res[1].ip == nil) then 
                reject("Your IP Adress is not in AllowList")
                return
            end
        end)
    end
end)

RegisterCommand("addip", function(source)
    local src = source 
    if(Config.ESX) then 
        local data = ESX.GetPlayerFromId(src)
        if(data.group ~= "user") then 
            if(Config.MySQL == "oxmysql") then 
                MySQL.execute("INSERT INTO ip_whitelist VALUES (@playerIP)", {
                    ["@playerIP"] = args[1]
                })
            end
        end
    else
        if(src == 0) then 
            if(Config.MySQL == "oxmysql") then 
                MySQL.execute("INSERT INTO ip_whitelist VALUES (@playerIP)", {
                    ["@playerIP"] = args[1]
                })
            else
                MySQL.Async.execute("INSERT INTO ip_whitelist VALUES (@playerIP)", {
                    ["@playerIP"] = args[1]
                })
            end
        end
    end
end)

-- OLD CODE

-- ESX = nil
-- TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- AddEventHandler("playerConnecting", function(reject)

--     local src = source

--     MySQL.Async.fetchAll('SELECT ip FROM n_ipwhitelist WHERE ip = @ip', {
-- 		['@ip'] = GetPlayerEndpoint(src)
-- 	}, function(result)
--         if(result[1].ip == nil) then
--             reject("Nie znajdujesz sie na IP Allowlist")
--         end
-- 	end)
-- end)

-- RegisterCommand('ipadd', function(xPlayer, args)
    
--     local data = xPlayer
    
--     if(args[1] ~= nil) then
--         if(data.group ~= 'user') then    
--             MySQL.Async.execute('INSERT INTO `n_ipwhitelist` (`ip`) VALUES (@ip)', {['@ip'] = args[1]})
--         else
--             data.showNotification('~r~[N-WHITELIST] Nie posiadasz permisji')
--         end
--     else
--         data.showNotification('~r~[N-WHITELIST] Musisz podac IP')
--     end
-- end)