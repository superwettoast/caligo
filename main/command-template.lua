local caligo = {
    data = {
        name = "test",
        description = "a test command."
        permissions = 0, --users with admin permissions this or above can use this command
    },
    function execute(args, user)
        print(user,' ran the test cmd')
    end
}

return caligo
