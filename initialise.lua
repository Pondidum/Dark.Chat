local addon, ns = ...

local dark = Darker

ns.lib = {
	class = dark.class,
	events = dark.events,
	controls = dark.controls,
	style = dark.style
}

ns.killFrame = function(frame)

	if frame == nil then return end

	if frame.UnregisterAllEvents then
		frame:UnregisterAllEvents()
	end

	frame.Show = function()end
	frame:Hide()
end
