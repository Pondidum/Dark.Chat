local addon, ns = ...

local class = ns.lib.class
local dsl = ns.lib.controls.dsl

local tabs = class:extend({

	ctor = function(self)

		self.tabs = {}

		self:fillTabs()
		self:buildUI()

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

				if self.tabs[i] then
					self.tabs[i]:Show()
				else
					self.tabs[i] = self:createTab(i, name)
				end
			else
				if self.tabs[i] then
					self.tabs[i]:Hide()
				end
			end

		end

	end,

	createTab = function(self, id, name)

	end,

})

ns.tabs = tabs
