--[['use strict';]]

List = require "../../lib/js/list.lua";

function v(x) do
  return --[[ tuple ]][
          List.length(x),
          List.length(x)
        ];
end end

L = --[[ alias ]]0;

exports.L = L;
exports.v = v;
--[[ No side effect ]]
