

local createChatCopy = function()

	local frame = CreateFrame("Frame", "DarkChatCopy", UIParent)
	tinsert(UISpecialFrames, "DarkChatCopy")
	frame:SetBackdrop(PaneBackdrop)
	frame:SetBackdropColor(0,0,0,1)
	frame:SetWidth(500)
	frame:SetHeight(400)
	frame:SetPoint("CENTER", UIParent, "CENTER")
	frame:Hide()
	frame:SetFrameStrata("DIALOG")

	local scrollArea = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
	scrollArea:SetPoint("TOPLEFT", frame, "TOPLEFT", 8, -30)
	scrollArea:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -30, 8)
	
	local editBox = CreateFrame("EditBox", nil, frame)
	editBox:SetMultiLine(true)
	editBox:SetMaxLetters(99999)
	editBox:EnableMouse(true)
	editBox:SetAutoFocus(false)
	editBox:SetFontObject(ChatFontNormal)
	editBox:SetWidth(400)
	editBox:SetHeight(270)
	editBox:SetScript("OnEscapePressed", function() frame:Hide() end)
		
	scrollArea:SetScrollChild(editBox)


	local copy = function(f)

		local regions = {f:GetRegions()}
		local text = ""

		for i, v in ipairs(regions) do

			if v:GetObjectType() == "FontString" then
				text = text .. v:GetText()
			end

		end


		frame:Show()
		editBox:SetText(text)
		editBox:HighlightText(0)
	end

	for i = 1, NUM_CHAT_WINDOWS do
		
		local chatFrame = _G["ChatFrame" .. i]
		
		local button = CreateFrame("Button", nil, chatFrame)

		button:SetPoint("BOTTOMRIGHT", chatFrame, "BOTTOMRIGHT", 0, -5)
		button:SetHeight(10)
		button:SetWidth(10)
		button:SetNormalTexture(tex)
		button:SetHighlightTexture([[Interface\Buttons\ButtonHilight-Square]])
		
		button:SetScript("OnClick", function() 
			copy(chatFrame) 
		end)

	end

end