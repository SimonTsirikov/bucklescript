__console = {log = print};

Export_keyword = require "..export_keyword";

function test2(v) do
  return {
          open = v.open,
          window = v.__window
        };
end end

function test(p) do
  return --[[ tuple ]]{
          p.__catch,
          p.__then
        };
end end

__case = Export_keyword.__case;

__window = Export_keyword.__window;

__switch = Export_keyword.__switch;

exports = {};
exports.test2 = test2;
exports.test = test;
exports.__case = __case;
exports.__window = __window;
exports.__switch = __switch;
return exports;
--[[ No side effect ]]
