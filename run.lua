local addon, ns = ...
local ui = Dark.core.ui

local run = function()

	local perChatFrame = function()
		for i = 1, NUM_CHAT_WINDOWS do

			local frame = _G[string.format("ChatFrame%s", i)]

			ns.chatPresenter.new(frame)

		end
	end

	local general = function()
		ui.killFrame(FriendsMicroButton)
		ui.killFrame(ChatFrameMenuButton)
	end

	local settings = function()

		ToggleChatColorNamesByClassGroup(true, "SAY")
		ToggleChatColorNamesByClassGroup(true, "EMOTE")
		ToggleChatColorNamesByClassGroup(true, "YELL")
		ToggleChatColorNamesByClassGroup(true, "GUILD")
		ToggleChatColorNamesByClassGroup(true, "OFFICER")
		ToggleChatColorNamesByClassGroup(true, "GUILD_ACHIEVEMENT")
		ToggleChatColorNamesByClassGroup(true, "ACHIEVEMENT")
		ToggleChatColorNamesByClassGroup(true, "WHISPER")
		ToggleChatColorNamesByClassGroup(true, "PARTY")
		ToggleChatColorNamesByClassGroup(true, "PARTY_LEADER")
		ToggleChatColorNamesByClassGroup(true, "RAID")
		ToggleChatColorNamesByClassGroup(true, "RAID_LEADER")
		ToggleChatColorNamesByClassGroup(true, "RAID_WARNING")
		ToggleChatColorNamesByClassGroup(true, "BATTLEGROUND")
		ToggleChatColorNamesByClassGroup(true, "BATTLEGROUND_LEADER")	
		ToggleChatColorNamesByClassGroup(true, "CHANNEL1")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL2")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL3")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL4")
		ToggleChatColorNamesByClassGroup(true, "CHANNEL5")

		ChatTypeInfo.WHISPER.sticky = 1
		ChatTypeInfo.BN_WHISPER.sticky = 1
		ChatTypeInfo.OFFICER.sticky = 1
		ChatTypeInfo.RAID_WARNING.sticky = 1
		ChatTypeInfo.CHANNEL.sticky = 1

	end	

	perChatFrame()
	general()
	settings()
	
end

run()
Dark.chat = ns