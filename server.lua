RegisterNetEvent("bp_rental:remove", function(oszseg, type)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        if type == "money" then
            xPlayer.removeAccountMoney("money", oszseg)
        elseif type == "bank" then
            local money = xPlayer.getAccount("bank").money
            if money >= oszseg then 
                xPlayer.removeAccountMoney("bank", oszseg)
            end
        end
    end
end)

lib.callback.register('bp_rental:get', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        local money = xPlayer.getAccount("bank").money
        local money2 = xPlayer.getAccount("money").money
        return money, money2
    end
end)