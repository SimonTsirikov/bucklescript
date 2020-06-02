console.log = print;

Mt = require "./mt";
Test_bool_equal = require "./test_bool_equal";

Mt.from_suites("boolean", --[[ :: ]]{
      --[[ tuple ]]{
        "bool_equal",
        Test_bool_equal.assertions
      },
      --[[ [] ]]0
    });

--[[  Not a pure module ]]
