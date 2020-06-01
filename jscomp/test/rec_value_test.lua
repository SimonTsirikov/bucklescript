'use strict';

Mt = require("./mt.lua");
List = require("../../lib/js/list.lua");
Block = require("../../lib/js/block.lua");
Curry = require("../../lib/js/curry.lua");
Caml_obj = require("../../lib/js/caml_obj.lua");
CamlinternalLazy = require("../../lib/js/camlinternalLazy.lua");
Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.lua");

x = [];

x[0] = 1;

x[1] = x;

a = [];

b = [];

c = [];

Caml_obj.caml_update_dummy(a, --[[ :: ]][
      2,
      b
    ]);

Caml_obj.caml_update_dummy(b, --[[ :: ]][
      3,
      c
    ]);

Caml_obj.caml_update_dummy(c, --[[ :: ]][
      3,
      a
    ]);

xx = [];

xx[0] = 1;

xx[1] = xx;

function naive(n) do
  if (n == 0 or n == 1) then do
    return 1;
  end else do
    return (n + naive(n - 1 | 0) | 0) + naive(n - 2 | 0) | 0;
  end end 
end end

four = do
  contents: 2
end;

three = do
  contents: 3
end;

v = do
  contents: (function (param) do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[[ tuple ]][
              "rec_value_test.ml",
              23,
              24
            ]
          ];
    end end)
end;

function fib(n) do
  local ___conditional___=(n);
  do
     if ___conditional___ = 0 then do
        return four.contents;end end end 
     if ___conditional___ = 1 then do
        return 1;end end end 
     if ___conditional___ = 2 then do
        return three.contents;end end end 
     if ___conditional___ = 3 then do
        v.contents = CamlinternalLazy.force(fib);
        return 1;end end end 
     do
    else do
      return fib(n - 1 | 0) + fib(n - 2 | 0) | 0;
      end end
      
  end
end end

function zs(param) do
  return List.hd(xs[0]);
end end

xs_000 = --[[ :: ]][
  2,
  --[[ [] ]]0
];

xs = --[[ tuple ]][
  xs_000,
  zs
];

function fib2(n) do
  if (n == 0 or n == 1) then do
    return 1;
  end else do
    return fib2(n - 1 | 0) + fib2(n - 2 | 0) | 0;
  end end 
end end

two = 2;

function fib3(n) do
  if (n == 0 or n == 1) then do
    return 1;
  end else do
    return fib3(n - 1 | 0) + fib3(n - 2 | 0) | 0;
  end end 
end end

function even(n) do
  if (n == 0) then do
    return true;
  end else do
    n$1 = n - 1 | 0;
    if (n$1 == 1) then do
      return true;
    end else do
      return even(n$1 - 1 | 0);
    end end 
  end end 
end end

function even2(_n) do
  while(true) do
    n = _n;
    if (n == 0) then do
      return true;
    end else do
      _n = n - 1 | 0;
      continue ;
    end end 
  end;
end end

function lazy_v(param) do
  CamlinternalLazy.force(lazy_v);
  return --[[ () ]]0;
end end

function sum(_acc, _n) do
  while(true) do
    n = _n;
    acc = _acc;
    if (n > 0) then do
      _n = n - 1 | 0;
      _acc = acc + n | 0;
      continue ;
    end else do
      return acc;
    end end 
  end;
end end

fake_v = --[[ :: ]][
  1,
  --[[ :: ]][
    2,
    --[[ [] ]]0
  ]
];

fake_y = --[[ :: ]][
  2,
  --[[ :: ]][
    3,
    --[[ [] ]]0
  ]
];

fake_z = --[[ :: ]][
  1,
  fake_y
];

fake_y2 = --[[ :: ]][
  2,
  --[[ :: ]][
    3,
    --[[ [] ]]0
  ]
];

fake_z2_001 = --[[ :: ]][
  sum(0, 10),
  fake_y2
];

fake_z2 = --[[ :: ]][
  1,
  fake_z2_001
];

rec_variant_b = [];

rec_variant_a = [];

Caml_obj.caml_update_dummy(rec_variant_b, --[[ B ]]Block.__(0, [
        "gho",
        (function (param) do
            return rec_variant_a;
          end end)
      ]));

Caml_obj.caml_update_dummy(rec_variant_a, --[[ A ]]Block.__(1, [
        3,
        (function (param) do
            return rec_variant_b;
          end end)
      ]));

suites_000 = --[[ tuple ]][
  "hd",
  (function (param) do
      return --[[ Eq ]]Block.__(0, [
                1,
                List.hd(List.tl(x))
              ]);
    end end)
];

suites_001 = --[[ :: ]][
  --[[ tuple ]][
    "mutual",
    (function (param) do
        tmp;
        if (a) then do
          match = a[1];
          if (match) then do
            tmp = match[0];
          end else do
            throw [
                  Caml_builtin_exceptions.assert_failure,
                  --[[ tuple ]][
                    "rec_value_test.ml",
                    108,
                    2
                  ]
                ];
          end end 
        end else do
          throw [
                Caml_builtin_exceptions.assert_failure,
                --[[ tuple ]][
                  "rec_value_test.ml",
                  108,
                  2
                ]
              ];
        end end 
        return --[[ Eq ]]Block.__(0, [
                  3,
                  tmp
                ]);
      end end)
  ],
  --[[ :: ]][
    --[[ tuple ]][
      "rec_sum",
      (function (param) do
          return --[[ Eq ]]Block.__(0, [
                    55,
                    sum(0, 10)
                  ]);
        end end)
    ],
    --[[ :: ]][
      --[[ tuple ]][
        "File \"rec_value_test.ml\", line 111, characters 2-9",
        (function (param) do
            return --[[ Eq ]]Block.__(0, [
                      --[[ :: ]][
                        1,
                        --[[ :: ]][
                          2,
                          --[[ [] ]]0
                        ]
                      ],
                      fake_v
                    ]);
          end end)
      ],
      --[[ :: ]][
        --[[ tuple ]][
          "File \"rec_value_test.ml\", line 114, characters 2-9",
          (function (param) do
              return --[[ Eq ]]Block.__(0, [
                        --[[ :: ]][
                          2,
                          --[[ :: ]][
                            3,
                            --[[ [] ]]0
                          ]
                        ],
                        fake_y
                      ]);
            end end)
        ],
        --[[ :: ]][
          --[[ tuple ]][
            "File \"rec_value_test.ml\", line 117, characters 2-9",
            (function (param) do
                return --[[ Eq ]]Block.__(0, [
                          --[[ :: ]][
                            1,
                            --[[ :: ]][
                              2,
                              --[[ :: ]][
                                3,
                                --[[ [] ]]0
                              ]
                            ]
                          ],
                          fake_z
                        ]);
              end end)
          ],
          --[[ :: ]][
            --[[ tuple ]][
              "File \"rec_value_test.ml\", line 120, characters 2-9",
              (function (param) do
                  return --[[ Eq ]]Block.__(0, [
                            --[[ :: ]][
                              1,
                              --[[ :: ]][
                                55,
                                --[[ :: ]][
                                  2,
                                  --[[ :: ]][
                                    3,
                                    --[[ [] ]]0
                                  ]
                                ]
                              ]
                            ],
                            fake_z2
                          ]);
                end end)
            ],
            --[[ :: ]][
              --[[ tuple ]][
                "File \"rec_value_test.ml\", line 123, characters 2-9",
                (function (param) do
                    return --[[ Eq ]]Block.__(0, [
                              --[[ :: ]][
                                2,
                                --[[ :: ]][
                                  3,
                                  --[[ [] ]]0
                                ]
                              ],
                              fake_y2
                            ]);
                  end end)
              ],
              --[[ :: ]][
                --[[ tuple ]][
                  "File \"rec_value_test.ml\", line 126, characters 2-9",
                  (function (param) do
                      return --[[ Eq ]]Block.__(0, [
                                3,
                                3
                              ]);
                    end end)
                ],
                --[[ :: ]][
                  --[[ tuple ]][
                    "File \"rec_value_test.ml\", line 129, characters 2-9",
                    (function (param) do
                        if (rec_variant_b.tag) then do
                          throw [
                                Caml_builtin_exceptions.assert_failure,
                                --[[ tuple ]][
                                  "rec_value_test.ml",
                                  132,
                                  11
                                ]
                              ];
                        end else do
                          return --[[ Eq ]]Block.__(0, [
                                    Curry._1(rec_variant_b[1], --[[ () ]]0),
                                    rec_variant_a
                                  ]);
                        end end 
                      end end)
                  ],
                  --[[ :: ]][
                    --[[ tuple ]][
                      "File \"rec_value_test.ml\", line 134, characters 2-9",
                      (function (param) do
                          if (rec_variant_a.tag) then do
                            return --[[ Eq ]]Block.__(0, [
                                      Curry._1(rec_variant_a[1], --[[ () ]]0),
                                      rec_variant_b
                                    ]);
                          end else do
                            throw [
                                  Caml_builtin_exceptions.assert_failure,
                                  --[[ tuple ]][
                                    "rec_value_test.ml",
                                    137,
                                    11
                                  ]
                                ];
                          end end 
                        end end)
                    ],
                    --[[ [] ]]0
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

suites = --[[ :: ]][
  suites_000,
  suites_001
];

function fake_minus(n) do
  console.log(n);
  return n + 1 | 0;
end end

fake_odd = fake_minus;

function fake_inline_minus(n) do
  return n + 1 | 0;
end end

fake_inline = fake_inline_minus;

fake_inline_inlie2 = fake_inline_minus(3);

Mt.from_pair_suites("Rec_value_test", suites);

v$1 = 3;

exports.x = x;
exports.a = a;
exports.b = b;
exports.c = c;
exports.xx = xx;
exports.naive = naive;
exports.fib = fib;
exports.xs = xs;
exports.fib2 = fib2;
exports.two = two;
exports.fib3 = fib3;
exports.even = even;
exports.even2 = even2;
exports.lazy_v = lazy_v;
exports.sum = sum;
exports.fake_v = fake_v;
exports.fake_y = fake_y;
exports.fake_z = fake_z;
exports.fake_z2 = fake_z2;
exports.fake_y2 = fake_y2;
exports.v = v$1;
exports.rec_variant_b = rec_variant_b;
exports.rec_variant_a = rec_variant_a;
exports.suites = suites;
exports.fake_odd = fake_odd;
exports.fake_minus = fake_minus;
exports.fake_inline = fake_inline;
exports.fake_inline_minus = fake_inline_minus;
exports.fake_inline_inlie2 = fake_inline_inlie2;
--[[ fake_z2 Not a pure module ]]
