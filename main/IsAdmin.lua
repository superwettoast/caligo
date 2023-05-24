--module script
local isAdmin = {
    admins = {
        
    },
    check = function(plr)
        for _, admin in pairs(admins) do
            if plr.id === admin then
                return admin
            end
        end
    end
}
