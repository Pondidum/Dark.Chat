local addon, ns = ...

local class = ns.lib.class
local dsl = ns.lib.controls.dsl

local tabs = class:extend({

	ctor = function(self)

		self.buttons = {}
		self.linked = {}

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

		if self.buttons[id] then
			return self.buttons[id]
		end

		local linked = _G["ChatFrame"..id]

		local tab = dsl:single(self.frame, {
			type = "button",
			name = "$parentTab"..id,
			text = name,
			click = function(component, mouseButton)

				self:hideAllLinkedFrames()
				linked:Show()

			end,
		})

		self.buttons[id] = tab
		self.linked[id] = linked

		self.frame:add(tab)

		return tab

	end,

	hideAllLinkedFrames = function(self)

		for id, frame in pairs(self.linked) do
			frame:Hide()
		end

	end,

})

ns.tabs = tabs
