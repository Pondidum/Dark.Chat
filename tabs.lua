local addon, ns = ...

local class = ns.lib.class
local dsl = ns.lib.controls.dsl

local tabs = class:extend({

	ctor = function(self)

		self.buttons = {}
		self.linked = {}

		self:buildInterface()

	end,

	buildInterface = function(self)

		self.frame = dsl:single(UIParent, {
			type = "Group",
			name = "DarkChatTabs",
			layout = "horizontal",
			origin = "BOTTOMLEFT",
			itemSpacing = 4,
			wrap = false,
			autosize = "y",
			width = 400,
			points = {
				{ "LEFT", "UIParent", "LEFT", 20, 0 } --temp
			},
		})

		self.container = dsl:single(UIParent, {
			type = "frame",
			name = "DarkChatTabContainer",
			height = 120,
			points = {
				{ "TOPLEFT", "DarkChatTabs", "BOTTOMLEFT", 0, -4 },
				{ "TOPRIGHT", "DarkChatTabs", "BOTTOMRIGHT", 0, -4 }
			},
		})

	end,

	add = function(self, id, text, target)

		local tab = dsl:single(self.frame, {
			type = "button",
			name = "$parentTab"..id,
			text = text,
			click = function(component, mouseButton)

				self:hideAllLinkedFrames()
				target:Show()

			end,
		})

		self.buttons[id] = tab
		self.linked[id] = target

		self.frame:add(tab)
		self.container:add(target)

	end,

	hideAllLinkedFrames = function(self)

		for id, frame in pairs(self.linked) do
			frame:Hide()
		end

	end,

})

ns.tabs = tabs
