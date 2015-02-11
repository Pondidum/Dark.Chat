local addon, ns = ...
local config = ns.config
local style = ns.lib.style

local killFrame = function(frame)

	if frame == nil then return end

	if frame.UnregisterAllEvents then
		frame:UnregisterAllEvents()
	end

	frame.Show = fake
	frame:Hide()
end

local chatPresenter = {

	new = function(chatFrame)

		local id = chatFrame:GetID()
		local name = chatFrame:GetName()

		local edit = _G[name .. "EditBox"]
		local tab = _G[name.."Tab"]

		local styleEdit = function()

			edit:ClearAllPoints()
			edit:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", config.windowPadding, 2)
			edit:SetWidth(config.chatWidth)
			edit:SetHeight(config.editHeight)

			killFrame(_G[format("ChatFrame%sEditBoxFocusLeft", id)])
			killFrame(_G[format("ChatFrame%sEditBoxFocusMid", id)])
			killFrame(_G[format("ChatFrame%sEditBoxFocusRight", id)])

			-- Kill off editbox artwork
			local a, b, c = select(6, edit:GetRegions())
			killFrame(a)
			killFrame(b)
			killFrame(c)

			style:frame(edit)

			edit:SetAltArrowKeyMode(false)
			edit:Hide()

			edit:HookScript("OnEditFocusLost", function(self)
				self:Hide()
			end)


			tab:HookScript("OnClick", function()
				edit:Hide()
			end)
		end

		local styleChat = function()

			chatFrame:SetClampRectInsets(0,0,0,0)
			chatFrame:SetClampedToScreen(false)

			chatFrame:SetSize(config.chatWidth, config.chatHeight)
			chatFrame:ClearAllPoints()

			if chatFrame.isDocked then
				chatFrame:SetPoint("BOTTOMLEFT", edit, "TOPLEFT", 0, 5)
			else
				chatFrame:SetPoint("BOTTOMLEFT", GeneralDockManager, "TOPLEFT", 0, 5)
			end

			chatFrame.ClearAllPoints = function() end
			chatFrame.SetPoint = function() end
			chatFrame.SetSize = function() end


			for j = 1, #CHAT_FRAME_TEXTURES do
				_G[name..CHAT_FRAME_TEXTURES[j]]:SetTexture(nil)
			end

			if frame ~= COMBATLOG then
				chatFrame:SetFading(config.enableFading)
				chatFrame:SetTimeVisible(config.fadeTime)
			end

			style:frame(chatFrame)

		end

		local styleTabs = function()

			local tabtext = _G[name.."TabText"]
			tabtext:ClearAllPoints()
			tabtext:SetPoint("CENTER", tab, "CENTER")

			tab:SetHeight(config.tabHeight)

			tab:SetAlpha(1)
			tab.SetAlpha = UIFrameFadeRemoveFrame



			killFrame(_G[string.format("ChatFrame%sTabLeft", id)])
			killFrame(_G[string.format("ChatFrame%sTabMiddle", id)])
			killFrame(_G[string.format("ChatFrame%sTabRight", id)])

			killFrame(_G[string.format("ChatFrame%sTabSelectedLeft", id)])
			killFrame(_G[string.format("ChatFrame%sTabSelectedMiddle", id)])
			killFrame(_G[string.format("ChatFrame%sTabSelectedRight", id)])

			killFrame(_G[string.format("ChatFrame%sTabHighlightLeft", id)])
			killFrame(_G[string.format("ChatFrame%sTabHighlightMiddle", id)])
			killFrame(_G[string.format("ChatFrame%sTabHighlightRight", id)])

			-- Killing off the new chat tab selected feature
			killFrame(_G[string.format("ChatFrame%sTabSelectedLeft", id)])
			killFrame(_G[string.format("ChatFrame%sTabSelectedMiddle", id)])
			killFrame(_G[string.format("ChatFrame%sTabSelectedRight", id)])

			style:frame(tab)

		end

		local killButtons = function()

			killFrame(_G[string.format("ChatFrame%sButtonFrameUpButton", id)])
			killFrame(_G[string.format("ChatFrame%sButtonFrameDownButton", id)])
			killFrame(_G[string.format("ChatFrame%sButtonFrameBottomButton", id)])
			killFrame(_G[string.format("ChatFrame%sButtonFrameMinimizeButton", id)])
			killFrame(_G[string.format("ChatFrame%sButtonFrame", id)])


		end


		styleTabs()
		styleEdit()
		styleChat()
		killButtons()

	end,

}

ns.chatPresenter = chatPresenter