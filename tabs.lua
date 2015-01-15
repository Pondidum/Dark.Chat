local addon, ns = ...

local class = ns.lib.class
local dsl = ns.lib.controls.dsl

local tabs = class:extend({

	ctor = function(self)

		self.tabs = {}

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
			autosize = "x",
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

				local tab = self:getOrCreateTab(i, name)

				self.frame:add(tab)

			end

		end

	end,

	getOrCreateTab = function(self, id, name)

		local tab = self.tabs[id]

		if tab then
			return tab
		end

		local conf = {
			type = "button",
			name = "$parentTab"..id,
			text = name,
		}

		tab = dsl:single(self.frame, conf)

		self.tabs[id] = tab

		return tab

	end,

})

ns.tabs = tabs
