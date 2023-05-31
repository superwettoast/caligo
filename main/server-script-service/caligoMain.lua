local config = {
    prefix = "?", --this don't work rn cuz im lazy
    owner = game.CreatorId
};

local command_folder = game.ServerStorage.caligo.commands;
local commands = {};

for _,cmd in pairs(command_folder.GetChildren()) do 
    if cmd:IsA('ModuleScript') then --checks if the command is a module script
        local workingCmd = require(cmd);
        if workingCmd.data and workingCmd.execute then --checks if the possible command has data and execute.
            table.insert(commands, cmd.data); --add the command to the valid commands table
        end;
    end;
end;

--command handlers
local event = game.ReplicatedStorage.Caligo.Events.command;
event.OnServerEvent:Connect(function(plr, command)
    local args = msg.split(' '); -- converts the command to an array, -- makes it easier to get args
    if table.find(commands, args[1]) then --checks if the command actually exists command exists
        local data = table.find(commands,  args[1]); --gets the data from the command
        local newArgs = table.remove(args[1]); --removes the command from the args, table and arrays act simular in lua.
        pcall(data.execute, plr, newArgs); --protect call
    else 
        local errorCode = 404;
        local response = "command doesn't exist/cannot be found";
        event:FireClient(response, errorCode); --tells the client that there was an error with the code.
    end;
end);


game.Players.PlayerAdded:Connect(function(plr) --chat based
    player.Chatted:Connect(function(msg)
        local args = msg.split(' ');
        if table.find(commands, args[1]) then
            local data = table.find(commands,  args[1]);
            local newArgs = table.remove(args[1]); 
            pcall(data.execute, newArgs, plr); --pcall = protected call
        else
            local errorCode = 404;
            local response = "command doesn't exist/cannot be found";
            warn(response, errorCode)
        end;
    end);    
end);
