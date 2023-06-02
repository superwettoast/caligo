--config
local admins = {
	[-1] = {
		name = 'Player1',
		permission = 200
	}
};

--
local recieve_cmd = game.ReplicatedStorage.CALIGO.Events.sendCommand;
local command_folder = game.ServerStorage.CALIGO.Commands;

local registered_commands = {};

for _, cmd in ipairs(command_folder:GetChildren()) do
	if cmd:IsA('ModuleScript') then
		local required_cmd = require(cmd);
		if required_cmd.data and required_cmd.execute then
			registered_commands[required_cmd.data.name] = cmd;
		else
			warn(string.format("[WARNING] The command module %s is missing a required 'data' or 'execute' property.", cmd.Name));
		end
	end
end

recieve_cmd.OnServerEvent:Connect(function(plr, recieved_cmd)
	local args = string.split(recieved_cmd,' ');
	if registered_commands[args[1]] then
		local cmd = require(registered_commands[args[1]]);
		if admins[plr.UserId] then
			if admins[plr.UserId].permission >= cmd.data.permissions then
				table.remove(args, 1);
				pcall(cmd.execute, args, plr, admins[plr.UserId].permission, admins);
			end
		elseif cmd.data.permissions == 0 then
			table.remove(args, 1);
			pcall(cmd.execute, args, plr, 0, admins);
		end
	else 
		warn('COMMAND:', recieved_cmd, 'COULD NOT BE FOUND.');
	end
end)

if game.CreatorType == Enum.CreatorType.User then
	local creator = {
		name = game.Players:GetNameFromUserIdAsync(game.CreatorId),
		permission = 99999999
	}
	admins[game.CreatorId] = creator
end