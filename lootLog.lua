local addon, ns = ...
local config = ns.config.lootLog

local class = Darker.class
local events = Darker.events
local fonts = Darker.media.fonts

local lootLog = class:extend({

	events = {
		"CHAT_MSG_LOOT",
		"CHAT_MSG_MONEY",
		"CHAT_MSG_COMBAT_FACTION_CHANGE",
		"CHAT_MSG_CURRENCY",
	},

	ctor = function(self)
		self:include(events)
		self:createUI()
	end,

	createUI = function(self)

		local frame = CreateFrame("ScrollingMessageFrame", "DarkLootLog", UIParent)
		frame:SetPoint("BOTTOMLEFT", MultiBarBottomRight, "BOTTOMRIGHT", 5, 0)

		if DarkBagFrame then
			frame:SetPoint("RIGHT", DarkBagFrame, "LEFT", -5, 0)
			frame:SetPoint("TOP", DarkBagsCurrency, "TOP", 0, 0)
		else
			frame:SetPoint("RIGHT", UIParent, "RIGHT", -5, 0)
			frame:SetPoint("TOP", MultiBarBottomRight, "TOP", 0, 0)
		end

		frame:SetFading(true)
		frame:SetTimeVisible(20)
		frame:SetMaxLines(120)
		frame:SetFont(fonts.normal, 12)
		frame:SetJustifyH(config.align)
		frame:SetHyperlinksEnabled(true)
		frame:EnableMouseWheel(true)
		frame:SetShadowColor(0, 0, 0)
		frame:SetShadowOffset(1.25, -1.25)

		frame:SetScript("OnHyperlinkClick", function(frame, link, text, button)
			SetItemRef(link, text, button, frame)
		end)

		frame:SetScript("OnMouseWheel", function(frame, delta)
			if ( delta > 0 ) then
				frame:ScrollUp();
			else
				frame:ScrollDown();
			end
		end)

		self.frame = frame

	end,

	addMessage = function(self, message, info)

		local timestamp = date("|cffffffff[%H:%M:%S]|r")

		if config.align == "RIGHT" then
			message = message .. " " .. timestamp
		else
			message = timestamp .. " " .. message
		end

		self.frame:AddMessage(message, info.r, info.g, info.b, info.id)
	end,


	CHAT_MSG_LOOT = function(self, message)
		self:addMessage(message, ChatTypeInfo["LOOT"])
	end,

	CHAT_MSG_MONEY = function(self, message)
		self:addMessage(message, ChatTypeInfo["MONEY"])
	end,

	CHAT_MSG_CURRENCY = function(self, message)
		self:addMessage(message, ChatTypeInfo["CURRENCY"])
	end,

	CHAT_MSG_COMBAT_FACTION_CHANGE = function(self, message)
		self:addMessage(message, ChatTypeInfo["COMBAT_FACTION_CHANGE"])
	end,
})

lootLog:new()
