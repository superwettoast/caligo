local command = {}

command.data = {
	name = 'cmds',
	description = 'show a list of cmds.',
	permissions = 0 --permissions. 0 = public, number+ roles that can use the command.
}

local cmd_gui = game.ServerStorage.CALIGO.GUI.CaligoCommands
local command_object = game.ServerStorage.CALIGO.GUI.CommandsTemplate

command.execute = function(args, player, perms, admins)
	local command_folder = game.ServerStorage.CALIGO.Commands
	local gui = cmd_gui:Clone()
	gui.Parent = player.PlayerGui
	for _, cmd in ipairs(command_folder:GetChildren()) do
		task.wait(0.05) --gives the illusion of it actually doing alot of shit
		if cmd:IsA('ModuleScript') then
			local required_cmd = require(cmd);
			if required_cmd.data and required_cmd.execute then
				if required_cmd.data.permissions <= perms then
					local c_obj = command_object:Clone()
					c_obj.Parent = gui.Commands.Container
					c_obj.Description.Text = required_cmd.data.description
					c_obj.CommandName.Text = required_cmd.data.name
				end
			end
		end
	end
end

return command
