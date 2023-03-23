local memoryleaker = [[
--SCRIPT
]] 
local function script_path()
	local str = debug.getinfo(2, "S").source:sub(2)
	return str:match("(.*[/%\\])") or "";
end
package.path = script_path() .. "?.lua;" .. package.path;
local op = require("src.cli");
op:option({
  script = memoryleaker
}) 
