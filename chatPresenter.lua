local addon, ns = ...
local config = ns.config 

local ui = Dark.core.ui
local style = Dark.core.style

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

			ui.killFrame(_G[format("ChatFrame%sEditBoxFocusLeft", id)])
			ui.killFrame(_G[format("ChatFrame%sEditBoxFocusMid", id)])
			ui.killFrame(_G[format("ChatFrame%sEditBoxFocusRight", id)])
			
			-- Kill off editbox artwork
			local a, b, c = select(6, edit:GetRegions()) 
			ui.killFrame(a)
			ui.killFrame(b)
			ui.killFrame(c)
			
			style.addBackground(edit)
			style.addShadow(edit)		

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

			style.addBackground(chatFrame)
			style.addShadow(chatFrame)

		end

		local styleTabs = function()

			local tabtext = _G[name.."TabText"]
			tabtext:ClearAllPoints()
			tabtext:SetPoint("CENTER", tab, "CENTER")

			tab:SetHeight(config.tabHeight)

			tab:SetAlpha(1)
			tab.SetAlpha = UIFrameFadeRemoveFrame
			


			ui.killFrame(_G[string.format("ChatFrame%sTabLeft", id)])
			ui.killFrame(_G[string.format("ChatFrame%sTabMiddle", id)])
			ui.killFrame(_G[string.format("ChatFrame%sTabRight", id)])

			ui.killFrame(_G[string.format("ChatFrame%sTabSelectedLeft", id)])
			ui.killFrame(_G[string.format("ChatFrame%sTabSelectedMiddle", id)])
			ui.killFrame(_G[string.format("ChatFrame%sTabSelectedRight", id)])

			ui.killFrame(_G[string.format("ChatFrame%sTabHighlightLeft", id)])
			ui.killFrame(_G[string.format("ChatFrame%sTabHighlightMiddle", id)])
			ui.killFrame(_G[string.format("ChatFrame%sTabHighlightRight", id)])

			-- Killing off the new chat tab selected feature
			ui.killFrame(_G[string.format("ChatFrame%sTabSelectedLeft", id)])
			ui.killFrame(_G[string.format("ChatFrame%sTabSelectedMiddle", id)])
			ui.killFrame(_G[string.format("ChatFrame%sTabSelectedRight", id)])

			style.addBackground(tab)
			style.addShadow(tab)

		end

		local killButtons = function()

			ui.killFrame(_G[string.format("ChatFrame%sButtonFrameUpButton", id)])
			ui.killFrame(_G[string.format("ChatFrame%sButtonFrameDownButton", id)])
			ui.killFrame(_G[string.format("ChatFrame%sButtonFrameBottomButton", id)])
			ui.killFrame(_G[string.format("ChatFrame%sButtonFrameMinimizeButton", id)])
			ui.killFrame(_G[string.format("ChatFrame%sButtonFrame", id)])


		end


		styleTabs()
		styleEdit()
		styleChat()
		killButtons()

	end,

}

ns.chatPresenter = chatPresenter