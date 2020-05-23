'use strict';

var Mt = require("./mt.js");

var suites = do
  contents: --[ [] ]--0
end;

var test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end

function fake_c2(a_type, b_type) do
  switch (a_type) do
    case "number" :
        if (b_type == "number") do
          return 33;
        end
        break;
    case "string" :
        return 1;
    case "undefined" :
        return -1;
    default:
      
  end
  if (b_type == "undefined") do
    return 1;
  end else if (a_type == "number") do
    return 3;
  end else do
    return 0;
  end
end

eq("File \"gpr_2931_test.ml\", line 19, characters 6-13", 3, fake_c2("number", "xx"));

Mt.from_pair_suites("Gpr_2931_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.fake_c2 = fake_c2;
--[  Not a pure module ]--
