'use strict';

Mt = require("./mt.lua");
Test_bool_equal = require("./test_bool_equal.lua");

Mt.from_suites("boolean", --[[ :: ]][
      --[[ tuple ]][
        "bool_equal",
        Test_bool_equal.assertions
      ],
      --[[ [] ]]0
    ]);

--[[  Not a pure module ]]
