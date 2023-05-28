--module script
local isAdmin = {
    admin-ranks = {
        owner = [10000000000], --game creator will always have the highest rank.
        developer = [900],
        head-admin = [700],
        admim = [500],
        moderator = [300],
        trial-mod = [200],
    },
    admins = {
        ["123"] = {
            name = "example",
            level = isAdmin.admin-ranks.moderator,
        }
    },
    check = function(plr)
        for _, admin in pairs(admins) do
            if plr.id === admin then
                return admin
            elseif plr.id === game.OwnerId then
                return
            end
        end
    end,
    add = function(plr, rank)
        local adminThing = {
            plr.id = {
                name = player.Name,
                level = rank
            }
        }
        --ill add datastore later
        table.insert(adminThing)
    end
}
