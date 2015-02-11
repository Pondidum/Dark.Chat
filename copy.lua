local addon, ns = ...

local createChatCopy = function()

	local panel = ns.copyPanel:new()

	for i = 1, NUM_CHAT_WINDOWS do

		local chatFrame = _G["ChatFrame" .. i]

		ns.copyButton:new(chatFrame, panel)

	end

end

createChatCopy()