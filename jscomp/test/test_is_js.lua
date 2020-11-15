__console = {log = print};

Mt = require "..mt";

suites = {
  contents = --[[ [] ]]0
};

test_id = {
  contents = 0
};

function b(loc, x) do
  return Mt.bool_suites(test_id, suites, loc, x);
end end

b("File \"test_is_js.ml\", line 15, characters 2-9", true);

b("File \"test_is_js.ml\", line 23, characters 2-9", true);

b("File \"test_is_js.ml\", line 37, characters 2-9", true);

Mt.from_pair_suites("Test_is_js", suites.contents);

exports = {};
return exports;
--[[  Not a pure module ]]
