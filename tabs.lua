local addon, ns = ...

local class = ns.lib.class
local dsl = ns.lib.controls.dsl

local tabs = class:extend({

	ctor = function(self)

		self.buttons = {}

		self:buildUI()
		self:fillTabs()

	end,

	buildUI = function(self)

		local conf = {
			type = "Group",
			name = "DarkChatTabs",
			layout = "horizontal",
			origin = "BOTTOMLEFT",
			itemSpacing = 4,
			wrap = false,
			autosize = "both",
			points = {
				{ "LEFT", "UIParent", "LEFT", 20, 0 } --temp
			},
			size = { 400, 30 }
		}

		self.frame = dsl:single(UIParent, conf)

	end,

	fillTabs = function(self)

		for i = 1, NUM_CHAT_WINDOWS do

			local name, fontSize, r, g, b, alpha, shown, locked, docked, uninteractable = GetChatWindowInfo(i);

			if shown then

				self:getOrCreateTab(i, name)

			end

		end

	end,

	getOrCreateTab = function(self, id, name)

		local tab = self.buttons[id]

		if tab then
			return tab
		end

		local conf = {
			type = "button",
			name = "$parentTab"..id,
			text = name,
			click = function(component, mouseButton)
				local chatFrame = _G["ChatFrame"..id]

				chatFrame:Show()
			end,
		}

		tab = dsl:single(self.frame, conf)

		self.buttons[id] = tab
		self.frame:add(tab)

		return tab

	end,

})

ns.tabs = tabs
