local Funcs = {
	ms = function(ms_instance)
		local S,E = pcall(require(ms_instance))
		return S and S, E and E
	end
}

for i,v in pairs(script.scripts:GetChildren()) do
	if v:IsA("ModuleScript") then
		local success, error = Funcs.ms(v)
		--warn(success and success, error and error)
	end
end


--local TestService = game:GetService("TestService")
