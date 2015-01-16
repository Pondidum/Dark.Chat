local addon, ns = ...

local class = ns.lib.class
local dsl = ns.lib.controls.dsl

local tabs = class:extend({

	ctor = function(self, filter)

		self.filter = filter

		self.buttons = {}
		self.linked = {}

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
			autosize = "both",
			points = {
				{ "LEFT", "UIParent", "LEFT", 20, 0 } --temp
			},
			size = { 400, 30 }
		}

		self.frame = dsl:single(UIParent, conf)

	end,

	addTab = function(self, id, text, target)

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

	end,

	hideAllLinkedFrames = function(self)

		for id, frame in pairs(self.linked) do
			frame:Hide()
		end

	end,

})

ns.tabs = tabs
