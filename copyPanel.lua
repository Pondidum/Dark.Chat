local addon, ns = ...

local style = ns.lib.style
local class = ns.lib.class

local copyPanel = class:extend({

	ctor = function(self)
		self:createUI()
	end,

	createUI = function(self)

		local frame = CreateFrame("Frame", "DarkChatCopy", UIParent)
		tinsert(UISpecialFrames, "DarkChatCopy")
		frame:SetBackdrop(PaneBackdrop)
		frame:SetBackdropColor(0,0,0,1)
		frame:SetWidth(500)
		frame:SetHeight(400)
		frame:SetPoint("CENTER", UIParent, "CENTER")
		frame:Hide()
		frame:SetFrameStrata("DIALOG")

		style:background(frame)

		local scrollArea = CreateFrame("ScrollFrame", "DarkChatCopyScroll", frame, "UIPanelScrollFrameTemplate")
		scrollArea:SetPoint("TOPLEFT", frame, "TOPLEFT", 8, -8)
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

		self.editBox = editBox
		self.frame = frame

	end,

	setText = function(self, text)

		self.editBox:SetText(table.concat(text, "\n"))
		self.editBox:HighlightText(0)

	end,

	show = function(self)
		self.frame:Show()
	end,

})

ns.copyPanel = copyPanel
