local caligo = {
    name = 'example',
    description = 'this is an example cmd',
    execute = function(plr, args)
        print(plr, ' executed a command with args: ', args)
    end,
    permissions = 100
    aliases = nil
}

return caligo