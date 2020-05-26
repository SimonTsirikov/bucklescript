'use strict';

Mt = require("./mt.js");
Block = require("../../lib/js/block.js");
Test_google_closure = require("./test_google_closure.js");

Mt.from_pair_suites("Closure", --[ :: ]--[
      --[ tuple ]--[
        "partial",
        (function (param) do
            return --[ Eq ]--Block.__(0, [
                      --[ tuple ]--[
                        Test_google_closure.a,
                        Test_google_closure.b,
                        Test_google_closure.c
                      ],
                      --[ tuple ]--[
                        "3",
                        101,
                        [
                          1,
                          2
                        ]
                      ]
                    ]);
          end end)
      ],
      --[ [] ]--0
    ]);

--[  Not a pure module ]--
