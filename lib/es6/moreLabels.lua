

local __Map = require "..map.lua";
local __Set = require "..set.lua";
local Hashtbl = require "..hashtbl.lua";

Hashtbl_1 = Hashtbl;

__Map_1 = __Map;

__Set_1 = __Set;

export do
  Hashtbl_1 as Hashtbl,
  __Map_1 as __Map,
  __Set_1 as __Set,
  
end
--[[ No side effect ]]
