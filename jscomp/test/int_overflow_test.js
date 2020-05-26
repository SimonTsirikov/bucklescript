'use strict';

Mt = require("./mt.js");
Block = require("../../lib/js/block.js");
Int32 = require("../../lib/js/int32.js");
Caml_int32 = require("../../lib/js/caml_int32.js");
Caml_string = require("../../lib/js/caml_string.js");

function hash_variant(s) do
  accu = 0;
  for i = 0 , #s - 1 | 0 , 1 do
    accu = Caml_int32.imul(223, accu) + Caml_string.get(s, i) & 2147483647;
  end
  if (accu > 1073741823) then do
    return accu - -2147483648 | 0;
  end else do
    return accu;
  end end 
end end

function hash_variant2(s) do
  accu = 0;
  for i = 0 , #s - 1 | 0 , 1 do
    accu = Caml_int32.imul(223, accu) + Caml_string.get(s, i) | 0;
  end
  accu = accu & 2147483647;
  if (accu > 1073741823) then do
    return accu - -2147483648 | 0;
  end else do
    return accu;
  end end 
end end

function fib(n) do
  if (n ~= 0 and n ~= 1) then do
    return fib(n - 1 | 0) + fib(n - 2 | 0) | 0;
  end else do
    return 1;
  end end 
end end

Mt.from_pair_suites("Int_overflow_test", --[ :: ]--[
      --[ tuple ]--[
        "plus_overflow",
        (function (param) do
            return --[ Eq ]--Block.__(0, [
                      true,
                      (Int32.max_int + 1 | 0) == Int32.min_int
                    ]);
          end end)
      ],
      --[ :: ]--[
        --[ tuple ]--[
          "minus_overflow",
          (function (param) do
              return --[ Eq ]--Block.__(0, [
                        true,
                        (Int32.min_int - Int32.one | 0) == Int32.max_int
                      ]);
            end end)
        ],
        --[ :: ]--[
          --[ tuple ]--[
            "flow_again",
            (function (param) do
                return --[ Eq ]--Block.__(0, [
                          2147483646,
                          (Int32.max_int + Int32.max_int | 0) + Int32.min_int | 0
                        ]);
              end end)
          ],
          --[ :: ]--[
            --[ tuple ]--[
              "flow_again",
              (function (param) do
                  return --[ Eq ]--Block.__(0, [
                            -2,
                            Int32.max_int + Int32.max_int | 0
                          ]);
                end end)
            ],
            --[ :: ]--[
              --[ tuple ]--[
                "hash_test",
                (function (param) do
                    return --[ Eq ]--Block.__(0, [
                              hash_variant("xxyyzzuuxxzzyy00112233"),
                              544087776
                            ]);
                  end end)
              ],
              --[ :: ]--[
                --[ tuple ]--[
                  "hash_test2",
                  (function (param) do
                      return --[ Eq ]--Block.__(0, [
                                hash_variant("xxyyzxzzyy"),
                                -449896130
                              ]);
                    end end)
                ],
                --[ :: ]--[
                  --[ tuple ]--[
                    "File \"int_overflow_test.ml\", line 37, characters 2-9",
                    (function (param) do
                        return --[ Eq ]--Block.__(0, [
                                  hash_variant2("xxyyzzuuxxzzyy00112233"),
                                  544087776
                                ]);
                      end end)
                  ],
                  --[ :: ]--[
                    --[ tuple ]--[
                      "File \"int_overflow_test.ml\", line 38, characters 2-9",
                      (function (param) do
                          return --[ Eq ]--Block.__(0, [
                                    hash_variant2("xxyyzxzzyy"),
                                    -449896130
                                  ]);
                        end end)
                    ],
                    --[ :: ]--[
                      --[ tuple ]--[
                        "int_literal_flow",
                        (function (param) do
                            return --[ Eq ]--Block.__(0, [
                                      -1,
                                      -1
                                    ]);
                          end end)
                      ],
                      --[ :: ]--[
                        --[ tuple ]--[
                          "int_literal_flow2",
                          (function (param) do
                              return --[ Eq ]--Block.__(0, [
                                        -1,
                                        -1
                                      ]);
                            end end)
                        ],
                        --[ :: ]--[
                          --[ tuple ]--[
                            "int_literal_flow3",
                            (function (param) do
                                return --[ Eq ]--Block.__(0, [
                                          -1,
                                          -1
                                        ]);
                              end end)
                          ],
                          --[ :: ]--[
                            --[ tuple ]--[
                              "int32_mul",
                              (function (param) do
                                  return --[ Eq ]--Block.__(0, [
                                            -33554431,
                                            -33554431
                                          ]);
                                end end)
                            ],
                            --[ :: ]--[
                              --[ tuple ]--[
                                "File \"int_overflow_test.ml\", line 44, characters 3-10",
                                (function (param) do
                                    return --[ Eq ]--Block.__(0, [
                                              Number("3") | 0,
                                              3
                                            ]);
                                  end end)
                              ],
                              --[ :: ]--[
                                --[ tuple ]--[
                                  "File \"int_overflow_test.ml\", line 46, characters 3-10",
                                  (function (param) do
                                      return --[ Eq ]--Block.__(0, [
                                                Number("3.2") | 0,
                                                3
                                              ]);
                                    end end)
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
          ]
        ]
      ]
    ]);

exports.hash_variant = hash_variant;
exports.hash_variant2 = hash_variant2;
exports.fib = fib;
--[  Not a pure module ]--
