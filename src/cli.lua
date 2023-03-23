-- This Script is Part of the Prometheus Obfuscator by Levno_710
--
-- cli.lua
-- This script contains the Code for the Prometheus CLI

-- Configure package.path for requiring Prometheus
local function script_path()
	local str = debug.getinfo(2, "S").source:sub(2)
	return str:match("(.*[/%\\])")
end
package.path = script_path() .. "?.lua;" .. package.path;
---@diagnostic disable-next-line: different-requires
local Prometheus = require("prometheus");
Prometheus.Logger.logLevel = Prometheus.Logger.LogLevel.Info;

string.split = function(str, sep)
    local fields = {}
    local pattern = string.format("([^%s]+)", sep)
    str:gsub(pattern, function(c) fields[#fields+1] = c end)
    return fields
end

local function lines_from(file)
    if not file_exists(file) then return {} end
    local lines = {}
    for line in io.lines(file) do
      lines[#lines + 1] = line
    end
    return lines
  end

-- CLI
local config;
local sourceFile = Option.Script
Prometheus.colors.enabled = false;

local preset = Prometheus.Presets[arg[i]];
config = preset

local source = table.concat(lines_from(sourceFile), "\n");
local pipeline = Prometheus.Pipeline:fromConfig(config);
local out = pipeline:apply(source, sourceFile);

print(out) 
