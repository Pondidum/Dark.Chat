local addon, ns = ...

local style = ns.lib.style
local class = ns.lib.class

local copyButton = class:extend({

	ctor = function(self, parent, panel)
		self.parent = parent
		self.panel = panel

		self:createUI()
	end,

	createUI = function(self)

		local button = CreateFrame("Button", "$parentCopyButton", self.parent)

		button:SetPoint("BOTTOMRIGHT", self.parent, "BOTTOMRIGHT", -2, 2)
		button:SetHeight(10)
		button:SetWidth(10)
		button:SetNormalTexture(tex)
		button:SetHighlightTexture([[Interface\Buttons\ButtonHilight-Square]])

		button:SetScript("OnClick", function()
			local text = self:buildText()

			self.panel:setText(text)
			self.panel:show()
		end)

		style:frame(button)

		self.button = button

	end,

	buildText = function(self)

		local regions = {self.parent:GetRegions()}
		local text = {}

		for i, v in ipairs(regions) do

			if v:GetObjectType() == "FontString" then
				table.insert(text, v:GetText())
			end

		end

		table.sort(text, function(a, b) return a < b end)

		return text
	end,

})

ns.copyButton = copyButton
