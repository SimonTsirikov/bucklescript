'use strict';

var Mt = require("./mt.js");
var Block = require("../../lib/js/block.js");
var Js_types = require("../../lib/js/js_types.js");

function string_or_number(x) do
  var ty = Js_types.classify(x);
  if (typeof ty == "number") do
    switch (ty) do
      case --[ JSFalse ]--0 :
      case --[ JSTrue ]--1 :
          return false;
      default:
        return false;
    end
  end else do
    switch (ty.tag | 0) do
      case --[ JSNumber ]--0 :
          console.log(ty[0] + 3);
          return true;
      case --[ JSString ]--1 :
          console.log(ty[0] .. "hei");
          return true;
      case --[ JSFunction ]--2 :
          console.log("Function");
          return false;
      default:
        return false;
    end
  end
end

var suites_000 = --[ tuple ]--[
  "int_type",
  (function (param) do
      return --[ Eq ]--Block.__(0, [
                "number",
                "number"
              ]);
    end)
];

var suites_001 = --[ :: ]--[
  --[ tuple ]--[
    "string_type",
    (function (param) do
        return --[ Eq ]--Block.__(0, [
                  "string",
                  "string"
                ]);
      end)
  ],
  --[ :: ]--[
    --[ tuple ]--[
      "number_gadt_test",
      (function (param) do
          return --[ Eq ]--Block.__(0, [
                    Js_types.test(3, --[ Number ]--3),
                    true
                  ]);
        end)
    ],
    --[ :: ]--[
      --[ tuple ]--[
        "boolean_gadt_test",
        (function (param) do
            return --[ Eq ]--Block.__(0, [
                      Js_types.test(true, --[ Boolean ]--2),
                      true
                    ]);
          end)
      ],
      --[ :: ]--[
        --[ tuple ]--[
          "undefined_gadt_test",
          (function (param) do
              return --[ Eq ]--Block.__(0, [
                        Js_types.test(undefined, --[ Undefined ]--0),
                        true
                      ]);
            end)
        ],
        --[ :: ]--[
          --[ tuple ]--[
            "string_on_number1",
            (function (param) do
                return --[ Eq ]--Block.__(0, [
                          string_or_number("xx"),
                          true
                        ]);
              end)
          ],
          --[ :: ]--[
            --[ tuple ]--[
              "string_on_number2",
              (function (param) do
                  return --[ Eq ]--Block.__(0, [
                            string_or_number(3.02),
                            true
                          ]);
                end)
            ],
            --[ :: ]--[
              --[ tuple ]--[
                "string_on_number3",
                (function (param) do
                    return --[ Eq ]--Block.__(0, [
                              string_or_number((function (x) do
                                      return x;
                                    end)),
                              false
                            ]);
                  end)
              ],
              --[ :: ]--[
                --[ tuple ]--[
                  "string_gadt_test",
                  (function (param) do
                      return --[ Eq ]--Block.__(0, [
                                Js_types.test("3", --[ String ]--4),
                                true
                              ]);
                    end)
                ],
                --[ :: ]--[
                  --[ tuple ]--[
                    "string_gadt_test_neg",
                    (function (param) do
                        return --[ Eq ]--Block.__(0, [
                                  Js_types.test(3, --[ String ]--4),
                                  false
                                ]);
                      end)
                  ],
                  --[ :: ]--[
                    --[ tuple ]--[
                      "function_gadt_test",
                      (function (param) do
                          return --[ Eq ]--Block.__(0, [
                                    Js_types.test((function (x) do
                                            return x;
                                          end), --[ Function ]--5),
                                    true
                                  ]);
                        end)
                    ],
                    --[ :: ]--[
                      --[ tuple ]--[
                        "object_gadt_test",
                        (function (param) do
                            return --[ Eq ]--Block.__(0, [
                                      Js_types.test(do
                                            x: 3
                                          end, --[ Object ]--6),
                                      true
                                    ]);
                          end)
                      ],
                      --[ [] ]--0
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
      ]
    ]
  ]
];

var suites = --[ :: ]--[
  suites_000,
  suites_001
];

Mt.from_pair_suites("Typeof_test", suites);

exports.string_or_number = string_or_number;
exports.suites = suites;
--[  Not a pure module ]--
