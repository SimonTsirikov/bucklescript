--[['use strict';]]

Export_keyword = require "./export_keyword.lua";

function test2(v) do
  return do
          open: v.open,
          window: v.window
        end;
end end

function test(p) do
  return --[[ tuple ]][
          p.catch,
          p.then
        ];
end end

__case = Export_keyword.__case;

__window = Export_keyword.__window;

__switch = Export_keyword.__switch;

exports.test2 = test2;
exports.test = test;
exports.__case = __case;
exports.__window = __window;
exports.__switch = __switch;
--[[ No side effect ]]
