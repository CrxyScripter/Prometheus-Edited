local ScriptToObfuscate = [[
--SCRIPT
]] 

local function script_path()
	local str = debug.getinfo(2, "S").source:sub(2)
	return str:match("(.*[/%\\])") or "";
end

package.path = script_path() .. "?.lua;" .. package.path;

local Obfuscator = require("src.cli");
Obfuscator({
  Script = ScriptToObfuscate
}) 
