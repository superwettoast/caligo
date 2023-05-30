--script
local config = {
    prefix = "?" --this don't work rn cuz im lazy
}

local command_folder = game.ServerStorage.caligo.commands

local commands = {}

for _,cmd in pairs(command_folder.GetChildren()) do
    if cmd:IsA('ModuleScript') then
        local workingCmd = require(cmd)
        if workingCmd.data and workingCmd.execute then
            table.insert(commands, cmd.data)
        end
    end
end

--command handler thing idk
game.Players.PlayerAdded:Connect(function(plr)
    player.Chatted:Connect(function(msg)
        local args = msg.split(' ')
        if table.find(commands, args[1]) then
        local data = table.find(commands,  args[1])
        local newArgs = table.remove(args[1])
        pcall(data.execute, newArgs, plr)
        end
    end)    
end)
