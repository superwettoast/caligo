local command = {}

command.data = {
	name = 'kick',
	description = 'kicks a player from the game.',
	permissions = 200 --permissions. 0 = public, number+ roles that can use the command.
}

local cmd_gui = game.ServerStorage.CALIGO.GUI.CaligoCommands
local command_object = game.ServerStorage.CALIGO.GUI.CommandsTemplate

command.execute = function(args, player, perms, admins)
	if game.Players:GetPlayerByUserId(args[1]) then
		local targetPlayer = game.Players:GetPlayerByUserId(args[1]) or game.Players:FindFirstChild(args[1])
		if admins[targetPlayer.UserId] then
			if admins[targetPlayer.UserId].permission <= perms then
				targetPlayer:Kick()
			end
		else 
			targetPlayer:Kick()
		end
	end
end

return command
