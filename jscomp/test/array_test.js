'use strict';

var Mt = require("./mt.js");
var List = require("../../lib/js/list.js");
var $$Array = require("../../lib/js/array.js");
var Block = require("../../lib/js/block.js");
var Curry = require("../../lib/js/curry.js");
var Caml_obj = require("../../lib/js/caml_obj.js");
var Caml_array = require("../../lib/js/caml_array.js");
var Caml_primitive = require("../../lib/js/caml_primitive.js");
var Caml_exceptions = require("../../lib/js/caml_exceptions.js");

function starts_with(xs, prefix, p) do
  var H = Caml_exceptions.create("H");
  var len1 = #xs;
  var len2 = #prefix;
  if (len2 > len1) then do
    return false;
  end else do
    try do
      for var i = 0 , len2 - 1 | 0 , 1 do
        if (!Curry._2(p, Caml_array.caml_array_get(xs, i), Caml_array.caml_array_get(prefix, i))) then do
          throw H;
        end
         end 
      end
      return true;
    end
    catch (exn)do
      if (exn == H) then do
        return false;
      end else do
        throw exn;
      end end 
    end
  end end 
end

function is_sorted(x) do
  var len = #x;
  var _i = 0;
  while(true) do
    var i = _i;
    if (i >= (len - 1 | 0)) then do
      return true;
    end else if (Caml_obj.caml_lessthan(Caml_array.caml_array_get(x, i), Caml_array.caml_array_get(x, i + 1 | 0))) then do
      _i = i + 1 | 0;
      continue ;
    end else do
      return false;
    end end  end 
  end;
end

var array_suites_000 = --[ tuple ]--[
  "init",
  (function (param) do
      return --[ Eq ]--Block.__(0, [
                $$Array.init(5, (function (x) do
                        return x;
                      end)),
                [
                  0,
                  1,
                  2,
                  3,
                  4
                ]
              ]);
    end)
];

var array_suites_001 = --[ :: ]--[
  --[ tuple ]--[
    "toList",
    (function (param) do
        var aux = function (xs) do
          return List.fold_left((function (acc, param) do
                        return --[ :: ]--[
                                --[ tuple ]--[
                                  $$Array.to_list(param[0]),
                                  param[1]
                                ],
                                acc
                              ];
                      end), --[ [] ]--0, xs);
        end;
        var match = List.split(aux(--[ :: ]--[
                  --[ tuple ]--[
                    [],
                    --[ [] ]--0
                  ],
                  --[ [] ]--0
                ]));
        return --[ Eq ]--Block.__(0, [
                  match[0],
                  match[1]
                ]);
      end)
  ],
  --[ :: ]--[
    --[ tuple ]--[
      "concat",
      (function (param) do
          return --[ Eq ]--Block.__(0, [
                    [
                      0,
                      1,
                      2,
                      3,
                      4,
                      5
                    ],
                    Caml_array.caml_array_concat(--[ :: ]--[
                          [
                            0,
                            1,
                            2
                          ],
                          --[ :: ]--[
                            [
                              3,
                              4
                            ],
                            --[ :: ]--[
                              [],
                              --[ :: ]--[
                                [5],
                                --[ [] ]--0
                              ]
                            ]
                          ]
                        ])
                  ]);
        end)
    ],
    --[ :: ]--[
      --[ tuple ]--[
        "make",
        (function (param) do
            return --[ Eq ]--Block.__(0, [
                      --[ tuple ]--[
                        Caml_array.caml_make_vect(100, --[ "a" ]--97),
                        Caml_array.caml_make_float_vect(100)
                      ],
                      --[ tuple ]--[
                        $$Array.init(100, (function (param) do
                                return --[ "a" ]--97;
                              end)),
                        $$Array.init(100, (function (param) do
                                return 0;
                              end))
                      ]
                    ]);
          end)
      ],
      --[ :: ]--[
        --[ tuple ]--[
          "sub",
          (function (param) do
              return --[ Eq ]--Block.__(0, [
                        $$Array.sub([
                              0,
                              1,
                              2,
                              3,
                              4
                            ], 2, 2),
                        [
                          2,
                          3
                        ]
                      ]);
            end)
        ],
        --[ :: ]--[
          --[ tuple ]--[
            "blit",
            (function (param) do
                var u = [
                  100,
                  0,
                  0
                ];
                var v = $$Array.init(3, (function (x) do
                        return (x << 1);
                      end));
                $$Array.blit(v, 1, u, 1, 2);
                return --[ Eq ]--Block.__(0, [
                          --[ tuple ]--[
                            [
                              0,
                              2,
                              4
                            ],
                            [
                              100,
                              2,
                              4
                            ]
                          ],
                          --[ tuple ]--[
                            v,
                            u
                          ]
                        ]);
              end)
          ],
          --[ :: ]--[
            --[ tuple ]--[
              "File \"array_test.ml\", line 63, characters 2-9",
              (function (param) do
                  var a0 = $$Array.init(100, (function (i) do
                          return (i << 0);
                        end));
                  $$Array.blit(a0, 10, a0, 5, 20);
                  return --[ Eq ]--Block.__(0, [
                            true,
                            starts_with(a0, [
                                  0,
                                  1,
                                  2,
                                  3,
                                  4,
                                  10,
                                  11,
                                  12,
                                  13,
                                  14,
                                  15,
                                  16,
                                  17,
                                  18,
                                  19,
                                  20,
                                  21,
                                  22,
                                  23,
                                  24,
                                  25,
                                  26,
                                  27,
                                  28
                                ], (function (prim, prim$1) do
                                    return prim == prim$1;
                                  end))
                          ]);
                end)
            ],
            --[ :: ]--[
              --[ tuple ]--[
                "File \"array_test.ml\", line 72, characters 2-9",
                (function (param) do
                    var a0 = $$Array.init(100, (function (i) do
                            return (i << 0);
                          end));
                    $$Array.blit(a0, 5, a0, 10, 20);
                    return --[ Eq ]--Block.__(0, [
                              true,
                              starts_with(a0, [
                                    0,
                                    1,
                                    2,
                                    3,
                                    4,
                                    5,
                                    6,
                                    7,
                                    8,
                                    9,
                                    5,
                                    6,
                                    7,
                                    8,
                                    9,
                                    10,
                                    11,
                                    12,
                                    13,
                                    14,
                                    15,
                                    16,
                                    17,
                                    18,
                                    19,
                                    20
                                  ], (function (prim, prim$1) do
                                      return prim == prim$1;
                                    end))
                            ]);
                  end)
              ],
              --[ :: ]--[
                --[ tuple ]--[
                  "make",
                  (function (param) do
                      return --[ Eq ]--Block.__(0, [
                                Caml_array.caml_make_vect(2, 1),
                                [
                                  1,
                                  1
                                ]
                              ]);
                    end)
                ],
                --[ :: ]--[
                  --[ tuple ]--[
                    "sort",
                    (function (param) do
                        var u = [
                          3,
                          0,
                          1
                        ];
                        $$Array.sort(Caml_primitive.caml_int_compare, u);
                        return --[ Eq ]--Block.__(0, [
                                  Caml_obj.caml_equal([
                                        0,
                                        1,
                                        3
                                      ], u),
                                  true
                                ]);
                      end)
                  ],
                  --[ :: ]--[
                    --[ tuple ]--[
                      "sort_large",
                      (function (param) do
                          var v = $$Array.init(4, (function (i) do
                                  return i % 17;
                                end));
                          $$Array.sort(Caml_primitive.caml_int_compare, v);
                          return --[ Eq ]--Block.__(0, [
                                    true,
                                    is_sorted(v)
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
];

var array_suites = --[ :: ]--[
  array_suites_000,
  array_suites_001
];

Mt.from_pair_suites("Array_test", array_suites);

--[  Not a pure module ]--
