local addon, ns = ...

local originalSetItemRef = SetItemRef
local function ReplacementSetItemRef(link, text, button, chatFrame)

	if strsub(link, 1, 3) == "url" then

		local chatFrameEditBox = ChatEdit_ChooseBoxForSend()
		local url = strsub(link, 5);
		if (not chatFrameEditBox:IsShown()) then
			ChatEdit_ActivateChat(chatFrameEditBox)
		end
		chatFrameEditBox:Insert(url)
		chatFrameEditBox:HighlightText()

	else
		originalSetItemRef(link, text, button, chatFrame)
	end
	
end
SetItemRef = ReplacementSetItemRef



local createUrl = function(url)
	return " |cff".. ns.config.linkColor .. "|Hurl:" .. url .. "|h" .. url .. "|h|r "
end

local function AddLinkSyntax(chatstring)

	if type(chatstring) == "string" then
	
		local extraspace
		
		if not strfind(chatstring, "^ ") then
			extraspace = true;
			chatstring = " " .. chatstring
		end
		
		chatstring = gsub (chatstring, " www%.([_A-Za-z0-9-]+)%.(%S+)%s?", createUrl("www.%1.%2"))
		chatstring = gsub (chatstring, " (%a+)://(%S+)%s?", createUrl("%1://%2"))
		chatstring = gsub (chatstring, " ([_A-Za-z0-9-%.]+)@([_A-Za-z0-9-]+)(%.+)([_A-Za-z0-9-%.]+)%s?", createUrl("%1@%2%3%4"))
		chatstring = gsub (chatstring, " (%d%d?%d?)%.(%d%d?%d?)%.(%d%d?%d?)%.(%d%d?%d?):(%d%d?%d?%d?%d?)%s?", createUrl("%1.%2.%3.%4:%5"))
		chatstring = gsub (chatstring, " (%d%d?%d?)%.(%d%d?%d?)%.(%d%d?%d?)%.(%d%d?%d?)%s?", createUrl("%1.%2.%3.%4"))
		
		if extraspace then
			chatstring = strsub(chatstring, 2);
		end
		
	end
	
	return chatstring
end

for i = 1, NUM_CHAT_WINDOWS do

	local frame = _G["ChatFrame" .. i]
	local addmessage = frame.AddMessage

	frame.AddMessage =	function(self, text, ...) 
							addmessage(self, AddLinkSyntax(text), ...) 
						end
end