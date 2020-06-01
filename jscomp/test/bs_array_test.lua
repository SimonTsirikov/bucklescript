'use strict';

Mt = require("./mt.lua");
Block = require("../../lib/js/block.lua");
Curry = require("../../lib/js/curry.lua");
Js_list = require("../../lib/js/js_list.lua");
Caml_obj = require("../../lib/js/caml_obj.lua");
Belt_List = require("../../lib/js/belt_List.lua");
Js_vector = require("../../lib/js/js_vector.lua");
Belt_Array = require("../../lib/js/belt_Array.lua");
Caml_array = require("../../lib/js/caml_array.lua");
Caml_primitive = require("../../lib/js/caml_primitive.lua");
Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.lua");

suites = do
  contents: --[[ [] ]]0
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

function b(loc, x) do
  return Mt.bool_suites(test_id, suites, loc, x);
end end

function $$throw(loc, x) do
  return Mt.throw_suites(test_id, suites, loc, x);
end end

function neq(loc, x, y) do
  test_id.contents = test_id.contents + 1 | 0;
  suites.contents = --[[ :: ]][
    --[[ tuple ]][
      loc .. (" id " .. String(test_id.contents)),
      (function (param) do
          return --[[ Neq ]]Block.__(1, [
                    x,
                    y
                  ]);
        end end)
    ],
    suites.contents
  ];
  return --[[ () ]]0;
end end

console.log([
            1,
            2,
            3,
            4
          ].filter((function (x) do
                return x > 2;
              end end)).map((function (x, i) do
              return x + i | 0;
            end end)).reduce((function (x, y) do
            return x + y | 0;
          end end), 0));

v = [
  1,
  2
];

eq("File \"bs_array_test.ml\", line 25, characters 5-12", --[[ tuple ]][
      Belt_Array.get(v, 0),
      Belt_Array.get(v, 1),
      Belt_Array.get(v, 2),
      Belt_Array.get(v, 3),
      Belt_Array.get(v, -1)
    ], --[[ tuple ]][
      1,
      2,
      undefined,
      undefined,
      undefined
    ]);

$$throw("File \"bs_array_test.ml\", line 28, characters 8-15", (function (param) do
        Belt_Array.getExn([
              0,
              1
            ], -1);
        return --[[ () ]]0;
      end end));

$$throw("File \"bs_array_test.ml\", line 29, characters 8-15", (function (param) do
        Belt_Array.getExn([
              0,
              1
            ], 2);
        return --[[ () ]]0;
      end end));

partial_arg = [
  0,
  1
];

function f(param) do
  return Belt_Array.getExn(partial_arg, param);
end end

b("File \"bs_array_test.ml\", line 30, characters 4-11", Caml_obj.caml_equal(--[[ tuple ]][
          Curry._1(f, 0),
          Curry._1(f, 1)
        ], --[[ tuple ]][
          0,
          1
        ]));

$$throw("File \"bs_array_test.ml\", line 31, characters 8-15", (function (param) do
        return Belt_Array.setExn([
                    0,
                    1
                  ], -1, 0);
      end end));

$$throw("File \"bs_array_test.ml\", line 32, characters 8-15", (function (param) do
        return Belt_Array.setExn([
                    0,
                    1
                  ], 2, 0);
      end end));

b("File \"bs_array_test.ml\", line 33, characters 4-11", not Belt_Array.set([
          1,
          2
        ], 2, 0));

v$1 = [
  1,
  2
];

if (not Belt_Array.set(v$1, 0, 0)) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[[ tuple ]][
          "bs_array_test.ml",
          34,
          33
        ]
      ];
end
 end 

b("File \"bs_array_test.ml\", line 34, characters 4-11", Belt_Array.getExn(v$1, 0) == 0);

v$2 = [
  1,
  2
];

if (not Belt_Array.set(v$2, 1, 0)) then do
  throw [
        Caml_builtin_exceptions.assert_failure,
        --[[ tuple ]][
          "bs_array_test.ml",
          35,
          32
        ]
      ];
end
 end 

b("File \"bs_array_test.ml\", line 35, characters 4-11", Belt_Array.getExn(v$2, 1) == 0);

v$3 = [
  1,
  2
];

b("File \"bs_array_test.ml\", line 36, characters 4-11", (Belt_Array.setExn(v$3, 0, 0), Belt_Array.getExn(v$3, 0) == 0));

v$4 = [
  1,
  2
];

b("File \"bs_array_test.ml\", line 37, characters 4-11", (Belt_Array.setExn(v$4, 1, 0), Belt_Array.getExn(v$4, 1) == 0));

function id(x) do
  return eq("File \"bs_array_test.ml\", line 40, characters 5-12", Js_vector.toList(Js_list.toVector(x)), x);
end end

eq("File \"bs_array_test.ml\", line 44, characters 5-12", Js_list.toVector(--[[ :: ]][
          1,
          --[[ :: ]][
            2,
            --[[ :: ]][
              3,
              --[[ [] ]]0
            ]
          ]
        ]), [
      1,
      2,
      3
    ]);

eq("File \"bs_array_test.ml\", line 45, characters 6-13", Js_vector.map((function (x) do
            return x + 1 | 0;
          end end), [
          1,
          2,
          3
        ]), [
      2,
      3,
      4
    ]);

eq("File \"bs_array_test.ml\", line 48, characters 5-12", Caml_array.caml_make_vect(5, 3), [
      3,
      3,
      3,
      3,
      3
    ]);

a = Js_vector.init(5, (function (i) do
        return i + 1 | 0;
      end end));

eq("File \"bs_array_test.ml\", line 50, characters 5-12", (Js_vector.filterInPlace((function (j) do
              return j % 2 == 0;
            end end), a), a), [
      2,
      4
    ]);

a$1 = Js_vector.init(5, (function (i) do
        return i + 1 | 0;
      end end));

eq("File \"bs_array_test.ml\", line 57, characters 5-12", (Js_vector.filterInPlace((function (j) do
              return j % 2 ~= 0;
            end end), a$1), a$1), [
      1,
      3,
      5
    ]);

eq("File \"bs_array_test.ml\", line 64, characters 5-12", Js_list.toVector(--[[ :: ]][
          1,
          --[[ :: ]][
            2,
            --[[ :: ]][
              3,
              --[[ [] ]]0
            ]
          ]
        ]), [
      1,
      2,
      3
    ]);

eq("File \"bs_array_test.ml\", line 66, characters 5-12", Js_list.toVector(--[[ :: ]][
          1,
          --[[ [] ]]0
        ]), [1]);

id(--[[ [] ]]0);

id(--[[ :: ]][
      1,
      --[[ [] ]]0
    ]);

id(--[[ :: ]][
      1,
      --[[ :: ]][
        2,
        --[[ :: ]][
          3,
          --[[ :: ]][
            4,
            --[[ :: ]][
              5,
              --[[ [] ]]0
            ]
          ]
        ]
      ]
    ]);

id(Js_vector.toList(Js_vector.init(100, (function (i) do
                return i;
              end end))));

function add(x, y) do
  return x + y | 0;
end end

v$5 = Belt_Array.makeBy(3000, (function (i) do
        return i;
      end end));

u = Belt_Array.shuffle(v$5);

neq("File \"bs_array_test.ml\", line 77, characters 6-13", u, v$5);

eq("File \"bs_array_test.ml\", line 79, characters 5-12", Belt_Array.reduce(u, 0, add), Belt_Array.reduce(v$5, 0, add));

b("File \"bs_array_test.ml\", line 84, characters 4-11", Caml_obj.caml_equal(Belt_Array.range(0, 3), [
          0,
          1,
          2,
          3
        ]));

b("File \"bs_array_test.ml\", line 85, characters 4-11", Caml_obj.caml_equal(Belt_Array.range(3, 0), []));

b("File \"bs_array_test.ml\", line 86, characters 4-11", Caml_obj.caml_equal(Belt_Array.range(3, 3), [3]));

b("File \"bs_array_test.ml\", line 88, characters 4-11", Caml_obj.caml_equal(Belt_Array.rangeBy(0, 10, 3), [
          0,
          3,
          6,
          9
        ]));

b("File \"bs_array_test.ml\", line 89, characters 4-11", Caml_obj.caml_equal(Belt_Array.rangeBy(0, 12, 3), [
          0,
          3,
          6,
          9,
          12
        ]));

b("File \"bs_array_test.ml\", line 90, characters 4-11", Caml_obj.caml_equal(Belt_Array.rangeBy(33, 0, 1), []));

b("File \"bs_array_test.ml\", line 91, characters 4-11", Caml_obj.caml_equal(Belt_Array.rangeBy(33, 0, -1), []));

b("File \"bs_array_test.ml\", line 92, characters 4-11", Caml_obj.caml_equal(Belt_Array.rangeBy(3, 12, -1), []));

b("File \"bs_array_test.ml\", line 93, characters 4-11", Caml_obj.caml_equal(Belt_Array.rangeBy(3, 3, 0), []));

b("File \"bs_array_test.ml\", line 94, characters 4-11", Caml_obj.caml_equal(Belt_Array.rangeBy(3, 3, 1), [3]));

eq("File \"bs_array_test.ml\", line 99, characters 5-12", Belt_Array.reduceReverse([], 100, (function (prim, prim$1) do
            return prim - prim$1 | 0;
          end end)), 100);

eq("File \"bs_array_test.ml\", line 100, characters 5-12", Belt_Array.reduceReverse([
          1,
          2
        ], 100, (function (prim, prim$1) do
            return prim - prim$1 | 0;
          end end)), 97);

eq("File \"bs_array_test.ml\", line 101, characters 5-12", Belt_Array.reduceReverse([
          1,
          2,
          3,
          4
        ], 100, (function (prim, prim$1) do
            return prim - prim$1 | 0;
          end end)), 90);

eq("File \"bs_array_test.ml\", line 102, characters 5-12", Belt_Array.reduceWithIndex([
          1,
          2,
          3,
          4
        ], 0, (function (acc, x, i) do
            return (acc + x | 0) + i | 0;
          end end)), 16);

b("File \"bs_array_test.ml\", line 103, characters 4-11", Belt_Array.reduceReverse2([
          1,
          2,
          3
        ], [
          1,
          2
        ], 0, (function (acc, x, y) do
            return (acc + x | 0) + y | 0;
          end end)) == 6);

function addone(x) do
  return x + 1 | 0;
end end

function makeMatrixExn(sx, sy, init) do
  if (not (sx >= 0 and sy >= 0)) then do
    throw new Error("File \"bs_array_test.ml\", line 109, characters 4-10");
  end
   end 
  res = new Array(sx);
  for x = 0 , sx - 1 | 0 , 1 do
    initY = new Array(sy);
    for y = 0 , sy - 1 | 0 , 1 do
      initY[y] = init;
    end
    res[x] = initY;
  end
  return res;
end end

eq("File \"bs_array_test.ml\", line 121, characters 5-12", Belt_Array.makeBy(0, (function (param) do
            return 1;
          end end)), []);

eq("File \"bs_array_test.ml\", line 122, characters 5-12", Belt_Array.makeBy(3, (function (i) do
            return i;
          end end)), [
      0,
      1,
      2
    ]);

eq("File \"bs_array_test.ml\", line 123, characters 5-12", makeMatrixExn(3, 4, 1), [
      [
        1,
        1,
        1,
        1
      ],
      [
        1,
        1,
        1,
        1
      ],
      [
        1,
        1,
        1,
        1
      ]
    ]);

eq("File \"bs_array_test.ml\", line 126, characters 5-12", makeMatrixExn(3, 0, 0), [
      [],
      [],
      []
    ]);

eq("File \"bs_array_test.ml\", line 127, characters 5-12", makeMatrixExn(0, 3, 1), []);

eq("File \"bs_array_test.ml\", line 128, characters 5-12", makeMatrixExn(1, 1, 1), [[1]]);

eq("File \"bs_array_test.ml\", line 129, characters 5-12", [].slice(0), []);

eq("File \"bs_array_test.ml\", line 130, characters 5-12", Belt_Array.map([], (function (prim) do
            return prim + 1 | 0;
          end end)), []);

eq("File \"bs_array_test.ml\", line 131, characters 5-12", Belt_Array.mapWithIndex([], add), []);

eq("File \"bs_array_test.ml\", line 132, characters 5-12", Belt_Array.mapWithIndex([
          1,
          2,
          3
        ], add), [
      1,
      3,
      5
    ]);

eq("File \"bs_array_test.ml\", line 133, characters 5-12", Belt_List.fromArray([]), --[[ [] ]]0);

eq("File \"bs_array_test.ml\", line 134, characters 5-12", Belt_List.fromArray([1]), --[[ :: ]][
      1,
      --[[ [] ]]0
    ]);

eq("File \"bs_array_test.ml\", line 135, characters 5-12", Belt_List.fromArray([
          1,
          2,
          3
        ]), --[[ :: ]][
      1,
      --[[ :: ]][
        2,
        --[[ :: ]][
          3,
          --[[ [] ]]0
        ]
      ]
    ]);

eq("File \"bs_array_test.ml\", line 136, characters 5-12", Belt_Array.map([
          1,
          2,
          3
        ], (function (prim) do
            return prim + 1 | 0;
          end end)), [
      2,
      3,
      4
    ]);

eq("File \"bs_array_test.ml\", line 137, characters 5-12", Belt_List.toArray(--[[ [] ]]0), []);

eq("File \"bs_array_test.ml\", line 138, characters 5-12", Belt_List.toArray(--[[ :: ]][
          1,
          --[[ [] ]]0
        ]), [1]);

eq("File \"bs_array_test.ml\", line 139, characters 5-12", Belt_List.toArray(--[[ :: ]][
          1,
          --[[ :: ]][
            2,
            --[[ [] ]]0
          ]
        ]), [
      1,
      2
    ]);

eq("File \"bs_array_test.ml\", line 140, characters 5-12", Belt_List.toArray(--[[ :: ]][
          1,
          --[[ :: ]][
            2,
            --[[ :: ]][
              3,
              --[[ [] ]]0
            ]
          ]
        ]), [
      1,
      2,
      3
    ]);

v$6 = Belt_Array.makeBy(10, (function (i) do
        return i;
      end end));

v0 = Belt_Array.keep(v$6, (function (x) do
        return x % 2 == 0;
      end end));

v1 = Belt_Array.keep(v$6, (function (x) do
        return x % 3 == 0;
      end end));

v2 = Belt_Array.keepMap(v$6, (function (x) do
        if (x % 2 == 0) then do
          return x + 1 | 0;
        end
         end 
      end end));

eq("File \"bs_array_test.ml\", line 147, characters 5-12", v0, [
      0,
      2,
      4,
      6,
      8
    ]);

eq("File \"bs_array_test.ml\", line 148, characters 5-12", v1, [
      0,
      3,
      6,
      9
    ]);

eq("File \"bs_array_test.ml\", line 149, characters 5-12", v2, [
      1,
      3,
      5,
      7,
      9
    ]);

a$2 = [
  1,
  2,
  3,
  4,
  5
];

match = Belt_Array.partition(a$2, (function (x) do
        return x % 2 == 0;
      end end));

eq("File \"bs_array_test.ml\", line 154, characters 5-12", match[0], [
      2,
      4
    ]);

eq("File \"bs_array_test.ml\", line 155, characters 5-12", match[1], [
      1,
      3,
      5
    ]);

match$1 = Belt_Array.partition(a$2, (function (x) do
        return x == 2;
      end end));

eq("File \"bs_array_test.ml\", line 157, characters 5-12", match$1[0], [2]);

eq("File \"bs_array_test.ml\", line 158, characters 5-12", match$1[1], [
      1,
      3,
      4,
      5
    ]);

match$2 = Belt_Array.partition([], (function (x) do
        return false;
      end end));

eq("File \"bs_array_test.ml\", line 160, characters 5-12", match$2[0], []);

eq("File \"bs_array_test.ml\", line 161, characters 5-12", match$2[1], []);

a$3 = [
  1,
  2,
  3,
  4,
  5
];

eq("File \"bs_array_test.ml\", line 165, characters 5-12", Belt_Array.slice(a$3, 0, 2), [
      1,
      2
    ]);

eq("File \"bs_array_test.ml\", line 166, characters 5-12", Belt_Array.slice(a$3, 0, 5), [
      1,
      2,
      3,
      4,
      5
    ]);

eq("File \"bs_array_test.ml\", line 167, characters 5-12", Belt_Array.slice(a$3, 0, 15), [
      1,
      2,
      3,
      4,
      5
    ]);

eq("File \"bs_array_test.ml\", line 168, characters 5-12", Belt_Array.slice(a$3, 5, 1), []);

eq("File \"bs_array_test.ml\", line 169, characters 5-12", Belt_Array.slice(a$3, 4, 1), [5]);

eq("File \"bs_array_test.ml\", line 170, characters 5-12", Belt_Array.slice(a$3, -1, 1), [5]);

eq("File \"bs_array_test.ml\", line 171, characters 5-12", Belt_Array.slice(a$3, -1, 2), [5]);

eq("File \"bs_array_test.ml\", line 172, characters 5-12", Belt_Array.slice(a$3, -2, 1), [4]);

eq("File \"bs_array_test.ml\", line 173, characters 5-12", Belt_Array.slice(a$3, -2, 2), [
      4,
      5
    ]);

eq("File \"bs_array_test.ml\", line 174, characters 5-12", Belt_Array.slice(a$3, -2, 3), [
      4,
      5
    ]);

eq("File \"bs_array_test.ml\", line 175, characters 5-12", Belt_Array.slice(a$3, -10, 3), [
      1,
      2,
      3
    ]);

eq("File \"bs_array_test.ml\", line 176, characters 5-12", Belt_Array.slice(a$3, -10, 4), [
      1,
      2,
      3,
      4
    ]);

eq("File \"bs_array_test.ml\", line 177, characters 5-12", Belt_Array.slice(a$3, -10, 5), [
      1,
      2,
      3,
      4,
      5
    ]);

eq("File \"bs_array_test.ml\", line 178, characters 5-12", Belt_Array.slice(a$3, -10, 6), [
      1,
      2,
      3,
      4,
      5
    ]);

eq("File \"bs_array_test.ml\", line 179, characters 5-12", Belt_Array.slice(a$3, 0, 0), []);

eq("File \"bs_array_test.ml\", line 180, characters 5-12", Belt_Array.slice(a$3, 0, -1), []);

a$4 = [
  1,
  2,
  3,
  4,
  5
];

eq("File \"bs_array_test.ml\", line 184, characters 5-12", Belt_Array.sliceToEnd(a$4, 0), [
      1,
      2,
      3,
      4,
      5
    ]);

eq("File \"bs_array_test.ml\", line 185, characters 5-12", Belt_Array.sliceToEnd(a$4, 5), []);

eq("File \"bs_array_test.ml\", line 186, characters 5-12", Belt_Array.sliceToEnd(a$4, 4), [5]);

eq("File \"bs_array_test.ml\", line 187, characters 5-12", Belt_Array.sliceToEnd(a$4, -1), [5]);

eq("File \"bs_array_test.ml\", line 188, characters 5-12", Belt_Array.sliceToEnd(a$4, -2), [
      4,
      5
    ]);

eq("File \"bs_array_test.ml\", line 189, characters 5-12", Belt_Array.sliceToEnd(a$4, -10), [
      1,
      2,
      3,
      4,
      5
    ]);

a$5 = Belt_Array.makeBy(10, (function (x) do
        return x;
      end end));

Belt_Array.fill(a$5, 0, 3, 0);

eq("File \"bs_array_test.ml\", line 194, characters 6-13", a$5.slice(0), [
      0,
      0,
      0,
      3,
      4,
      5,
      6,
      7,
      8,
      9
    ]);

Belt_Array.fill(a$5, 2, 8, 1);

eq("File \"bs_array_test.ml\", line 196, characters 5-12", a$5.slice(0), [
      0,
      0,
      1,
      1,
      1,
      1,
      1,
      1,
      1,
      1
    ]);

Belt_Array.fill(a$5, 8, 1, 9);

eq("File \"bs_array_test.ml\", line 198, characters 5-12", a$5.slice(0), [
      0,
      0,
      1,
      1,
      1,
      1,
      1,
      1,
      9,
      1
    ]);

Belt_Array.fill(a$5, 8, 2, 9);

eq("File \"bs_array_test.ml\", line 200, characters 5-12", a$5.slice(0), [
      0,
      0,
      1,
      1,
      1,
      1,
      1,
      1,
      9,
      9
    ]);

Belt_Array.fill(a$5, 8, 3, 12);

eq("File \"bs_array_test.ml\", line 202, characters 5-12", a$5.slice(0), [
      0,
      0,
      1,
      1,
      1,
      1,
      1,
      1,
      12,
      12
    ]);

Belt_Array.fill(a$5, -2, 3, 11);

eq("File \"bs_array_test.ml\", line 204, characters 5-12", a$5.slice(0), [
      0,
      0,
      1,
      1,
      1,
      1,
      1,
      1,
      11,
      11
    ]);

Belt_Array.fill(a$5, -3, 3, 10);

eq("File \"bs_array_test.ml\", line 206, characters 5-12", a$5.slice(0), [
      0,
      0,
      1,
      1,
      1,
      1,
      1,
      10,
      10,
      10
    ]);

Belt_Array.fill(a$5, -3, 1, 7);

eq("File \"bs_array_test.ml\", line 208, characters 5-12", a$5.slice(0), [
      0,
      0,
      1,
      1,
      1,
      1,
      1,
      7,
      10,
      10
    ]);

Belt_Array.fill(a$5, -13, 1, 7);

eq("File \"bs_array_test.ml\", line 210, characters 5-12", a$5.slice(0), [
      7,
      0,
      1,
      1,
      1,
      1,
      1,
      7,
      10,
      10
    ]);

Belt_Array.fill(a$5, -13, 12, 7);

eq("File \"bs_array_test.ml\", line 212, characters 5-12", a$5.slice(0), Belt_Array.make(10, 7));

Belt_Array.fill(a$5, 0, -1, 2);

eq("File \"bs_array_test.ml\", line 214, characters 5-12", a$5.slice(0), Belt_Array.make(10, 7));

b$1 = [
  1,
  2,
  3
];

Belt_Array.fill(b$1, 0, 0, 0);

eq("File \"bs_array_test.ml\", line 217, characters 5-12", b$1, [
      1,
      2,
      3
    ]);

Belt_Array.fill(b$1, 4, 1, 0);

eq("File \"bs_array_test.ml\", line 219, characters 5-12", b$1, [
      1,
      2,
      3
    ]);

a0 = Belt_Array.makeBy(10, (function (x) do
        return x;
      end end));

b0 = Belt_Array.make(10, 3);

Belt_Array.blit(a0, 1, b0, 2, 5);

eq("File \"bs_array_test.ml\", line 225, characters 5-12", b0.slice(0), [
      3,
      3,
      1,
      2,
      3,
      4,
      5,
      3,
      3,
      3
    ]);

Belt_Array.blit(a0, -1, b0, 2, 5);

eq("File \"bs_array_test.ml\", line 228, characters 5-12", b0.slice(0), [
      3,
      3,
      9,
      2,
      3,
      4,
      5,
      3,
      3,
      3
    ]);

Belt_Array.blit(a0, -1, b0, -2, 5);

eq("File \"bs_array_test.ml\", line 231, characters 5-12", b0.slice(0), [
      3,
      3,
      9,
      2,
      3,
      4,
      5,
      3,
      9,
      3
    ]);

Belt_Array.blit(a0, -2, b0, -2, 2);

eq("File \"bs_array_test.ml\", line 234, characters 5-12", b0.slice(0), [
      3,
      3,
      9,
      2,
      3,
      4,
      5,
      3,
      8,
      9
    ]);

Belt_Array.blit(a0, -11, b0, -11, 100);

eq("File \"bs_array_test.ml\", line 237, characters 5-12", b0.slice(0), a0);

Belt_Array.blit(a0, -11, b0, -11, 2);

eq("File \"bs_array_test.ml\", line 239, characters 5-12", b0.slice(0), a0);

aa = Belt_Array.makeBy(10, (function (x) do
        return x;
      end end));

Belt_Array.blit(aa, -1, aa, 1, 2);

eq("File \"bs_array_test.ml\", line 242, characters 5-12", aa.slice(0), [
      0,
      9,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9
    ]);

Belt_Array.blit(aa, -2, aa, 1, 2);

eq("File \"bs_array_test.ml\", line 244, characters 5-12", aa.slice(0), [
      0,
      8,
      9,
      3,
      4,
      5,
      6,
      7,
      8,
      9
    ]);

Belt_Array.blit(aa, -5, aa, 4, 3);

eq("File \"bs_array_test.ml\", line 246, characters 5-12", aa.slice(0), [
      0,
      8,
      9,
      3,
      5,
      6,
      7,
      7,
      8,
      9
    ]);

Belt_Array.blit(aa, 4, aa, 5, 3);

eq("File \"bs_array_test.ml\", line 248, characters 5-12", aa.slice(0), [
      0,
      8,
      9,
      3,
      5,
      5,
      6,
      7,
      8,
      9
    ]);

eq("File \"bs_array_test.ml\", line 249, characters 5-12", Belt_Array.make(0, 3), []);

eq("File \"bs_array_test.ml\", line 250, characters 5-12", Belt_Array.make(-1, 3), []);

c = [
  0,
  1,
  2
];

Belt_Array.blit(c, 4, c, 1, 1);

eq("File \"bs_array_test.ml\", line 253, characters 5-12", c, [
      0,
      1,
      2
    ]);

eq("File \"bs_array_test.ml\", line 256, characters 5-12", Belt_Array.zip([
          1,
          2,
          3
        ], [
          2,
          3,
          4,
          1
        ]), [
      --[[ tuple ]][
        1,
        2
      ],
      --[[ tuple ]][
        2,
        3
      ],
      --[[ tuple ]][
        3,
        4
      ]
    ]);

eq("File \"bs_array_test.ml\", line 257, characters 5-12", Belt_Array.zip([
          2,
          3,
          4,
          1
        ], [
          1,
          2,
          3
        ]), [
      --[[ tuple ]][
        2,
        1
      ],
      --[[ tuple ]][
        3,
        2
      ],
      --[[ tuple ]][
        4,
        3
      ]
    ]);

eq("File \"bs_array_test.ml\", line 258, characters 5-12", Belt_Array.zipBy([
          2,
          3,
          4,
          1
        ], [
          1,
          2,
          3
        ], (function (prim, prim$1) do
            return prim - prim$1 | 0;
          end end)), [
      1,
      1,
      1
    ]);

eq("File \"bs_array_test.ml\", line 259, characters 5-12", Belt_Array.zipBy([
          1,
          2,
          3
        ], [
          2,
          3,
          4,
          1
        ], (function (prim, prim$1) do
            return prim - prim$1 | 0;
          end end)), Belt_Array.map([
          1,
          1,
          1
        ], (function (x) do
            return -x | 0;
          end end)));

eq("File \"bs_array_test.ml\", line 260, characters 5-12", Belt_Array.unzip([
          --[[ tuple ]][
            1,
            2
          ],
          --[[ tuple ]][
            2,
            3
          ],
          --[[ tuple ]][
            3,
            4
          ]
        ]), --[[ tuple ]][
      [
        1,
        2,
        3
      ],
      [
        2,
        3,
        4
      ]
    ]);

function sumUsingForEach(xs) do
  v = do
    contents: 0
  end;
  Belt_Array.forEach(xs, (function (x) do
          v.contents = v.contents + x | 0;
          return --[[ () ]]0;
        end end));
  return v.contents;
end end

eq("File \"bs_array_test.ml\", line 270, characters 5-12", sumUsingForEach([
          0,
          1,
          2,
          3,
          4
        ]), 10);

b("File \"bs_array_test.ml\", line 271, characters 4-11", not Belt_Array.every([
          0,
          1,
          2,
          3,
          4
        ], (function (x) do
            return x > 2;
          end end)));

b("File \"bs_array_test.ml\", line 272, characters 4-11", Belt_Array.some([
          1,
          3,
          7,
          8
        ], (function (x) do
            return x % 2 == 0;
          end end)));

b("File \"bs_array_test.ml\", line 273, characters 4-11", not Belt_Array.some([
          1,
          3,
          7
        ], (function (x) do
            return x % 2 == 0;
          end end)));

b("File \"bs_array_test.ml\", line 274, characters 4-11", not Belt_Array.eq([
          0,
          1
        ], [1], (function (prim, prim$1) do
            return prim == prim$1;
          end end)));

c$1 = do
  contents: 0
end;

b("File \"bs_array_test.ml\", line 275, characters 4-11", (Belt_Array.forEachWithIndex([
            1,
            1,
            1
          ], (function (i, v) do
              c$1.contents = (c$1.contents + i | 0) + v | 0;
              return --[[ () ]]0;
            end end)), c$1.contents == 6));

function id$1(loc, x) do
  u = x.slice(0);
  return eq("File \"bs_array_test.ml\", line 285, characters 5-12", Belt_Array.reverse(x), (Belt_Array.reverseInPlace(u), u));
end end

id$1("File \"bs_array_test.ml\", line 290, characters 5-12", []);

id$1("File \"bs_array_test.ml\", line 291, characters 5-12", [1]);

id$1("File \"bs_array_test.ml\", line 292, characters 5-12", [
      1,
      2
    ]);

id$1("File \"bs_array_test.ml\", line 293, characters 5-12", [
      1,
      2,
      3
    ]);

id$1("File \"bs_array_test.ml\", line 294, characters 5-12", [
      1,
      2,
      3,
      4
    ]);

function every2(xs, ys) do
  partial_arg = Belt_List.toArray(ys);
  partial_arg$1 = Belt_List.toArray(xs);
  return (function (param) do
      return Belt_Array.every2(partial_arg$1, partial_arg, param);
    end end);
end end

function some2(xs, ys) do
  partial_arg = Belt_List.toArray(ys);
  partial_arg$1 = Belt_List.toArray(xs);
  return (function (param) do
      return Belt_Array.some2(partial_arg$1, partial_arg, param);
    end end);
end end

eq("File \"bs_array_test.ml\", line 304, characters 5-12", every2(--[[ [] ]]0, --[[ :: ]][
            1,
            --[[ [] ]]0
          ])((function (x, y) do
            return x > y;
          end end)), true);

eq("File \"bs_array_test.ml\", line 305, characters 5-12", every2(--[[ :: ]][
            2,
            --[[ :: ]][
              3,
              --[[ [] ]]0
            ]
          ], --[[ :: ]][
            1,
            --[[ [] ]]0
          ])((function (x, y) do
            return x > y;
          end end)), true);

eq("File \"bs_array_test.ml\", line 306, characters 5-12", every2(--[[ :: ]][
            2,
            --[[ [] ]]0
          ], --[[ :: ]][
            1,
            --[[ [] ]]0
          ])((function (x, y) do
            return x > y;
          end end)), true);

eq("File \"bs_array_test.ml\", line 307, characters 5-12", every2(--[[ :: ]][
            2,
            --[[ :: ]][
              3,
              --[[ [] ]]0
            ]
          ], --[[ :: ]][
            1,
            --[[ :: ]][
              4,
              --[[ [] ]]0
            ]
          ])((function (x, y) do
            return x > y;
          end end)), false);

eq("File \"bs_array_test.ml\", line 308, characters 5-12", every2(--[[ :: ]][
            2,
            --[[ :: ]][
              3,
              --[[ [] ]]0
            ]
          ], --[[ :: ]][
            1,
            --[[ :: ]][
              0,
              --[[ [] ]]0
            ]
          ])((function (x, y) do
            return x > y;
          end end)), true);

eq("File \"bs_array_test.ml\", line 309, characters 5-12", some2(--[[ [] ]]0, --[[ :: ]][
            1,
            --[[ [] ]]0
          ])((function (x, y) do
            return x > y;
          end end)), false);

eq("File \"bs_array_test.ml\", line 310, characters 5-12", some2(--[[ :: ]][
            2,
            --[[ :: ]][
              3,
              --[[ [] ]]0
            ]
          ], --[[ :: ]][
            1,
            --[[ [] ]]0
          ])((function (x, y) do
            return x > y;
          end end)), true);

eq("File \"bs_array_test.ml\", line 311, characters 5-12", some2(--[[ :: ]][
            2,
            --[[ :: ]][
              3,
              --[[ [] ]]0
            ]
          ], --[[ :: ]][
            1,
            --[[ :: ]][
              4,
              --[[ [] ]]0
            ]
          ])((function (x, y) do
            return x > y;
          end end)), true);

eq("File \"bs_array_test.ml\", line 312, characters 5-12", some2(--[[ :: ]][
            0,
            --[[ :: ]][
              3,
              --[[ [] ]]0
            ]
          ], --[[ :: ]][
            1,
            --[[ :: ]][
              4,
              --[[ [] ]]0
            ]
          ])((function (x, y) do
            return x > y;
          end end)), false);

eq("File \"bs_array_test.ml\", line 313, characters 5-12", some2(--[[ :: ]][
            0,
            --[[ :: ]][
              3,
              --[[ [] ]]0
            ]
          ], --[[ :: ]][
            3,
            --[[ :: ]][
              2,
              --[[ [] ]]0
            ]
          ])((function (x, y) do
            return x > y;
          end end)), true);

eq("File \"bs_array_test.ml\", line 318, characters 5-12", Belt_Array.concat([], [
          1,
          2,
          3
        ]), [
      1,
      2,
      3
    ]);

eq("File \"bs_array_test.ml\", line 319, characters 5-12", Belt_Array.concat([], []), []);

eq("File \"bs_array_test.ml\", line 320, characters 5-12", Belt_Array.concat([
          3,
          2
        ], [
          1,
          2,
          3
        ]), [
      3,
      2,
      1,
      2,
      3
    ]);

eq("File \"bs_array_test.ml\", line 321, characters 5-12", Belt_Array.concatMany([
          [
            3,
            2
          ],
          [
            1,
            2,
            3
          ]
        ]), [
      3,
      2,
      1,
      2,
      3
    ]);

eq("File \"bs_array_test.ml\", line 322, characters 5-12", Belt_Array.concatMany([
          [
            3,
            2
          ],
          [
            1,
            2,
            3
          ],
          [],
          [0]
        ]), [
      3,
      2,
      1,
      2,
      3,
      0
    ]);

eq("File \"bs_array_test.ml\", line 323, characters 5-12", Belt_Array.concatMany([
          [],
          [
            3,
            2
          ],
          [
            1,
            2,
            3
          ],
          [],
          [0]
        ]), [
      3,
      2,
      1,
      2,
      3,
      0
    ]);

eq("File \"bs_array_test.ml\", line 324, characters 5-12", Belt_Array.concatMany([
          [],
          []
        ]), []);

b("File \"bs_array_test.ml\", line 327, characters 4-11", Belt_Array.cmp([
          1,
          2,
          3
        ], [
          0,
          1,
          2,
          3
        ], Caml_primitive.caml_int_compare) < 0);

b("File \"bs_array_test.ml\", line 328, characters 4-11", Belt_Array.cmp([
          0,
          1,
          2,
          3
        ], [
          1,
          2,
          3
        ], Caml_primitive.caml_int_compare) > 0);

b("File \"bs_array_test.ml\", line 329, characters 4-11", Belt_Array.cmp([
          1,
          2,
          3
        ], [
          0,
          1,
          2
        ], Caml_primitive.caml_int_compare) > 0);

b("File \"bs_array_test.ml\", line 330, characters 4-11", Belt_Array.cmp([
          1,
          2,
          3
        ], [
          1,
          2,
          3
        ], Caml_primitive.caml_int_compare) == 0);

b("File \"bs_array_test.ml\", line 331, characters 4-11", Belt_Array.cmp([
          1,
          2,
          4
        ], [
          1,
          2,
          3
        ], Caml_primitive.caml_int_compare) > 0);

eq("File \"bs_array_test.ml\", line 334, characters 5-12", Belt_Array.getBy([
          1,
          2,
          3
        ], (function (x) do
            return x > 1;
          end end)), 2);

eq("File \"bs_array_test.ml\", line 335, characters 5-12", Belt_Array.getBy([
          1,
          2,
          3
        ], (function (x) do
            return x > 3;
          end end)), undefined);

eq("File \"bs_array_test.ml\", line 338, characters 5-12", Belt_Array.getIndexBy([
          1,
          2,
          3
        ], (function (x) do
            return x > 1;
          end end)), 1);

eq("File \"bs_array_test.ml\", line 339, characters 5-12", Belt_Array.getIndexBy([
          1,
          2,
          3
        ], (function (x) do
            return x > 3;
          end end)), undefined);

Mt.from_pair_suites("File \"bs_array_test.ml\", line 341, characters 23-30", suites.contents);

A = --[[ alias ]]0;

L = --[[ alias ]]0;

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.b = b;
exports.$$throw = $$throw;
exports.neq = neq;
exports.A = A;
exports.L = L;
exports.add = add;
exports.addone = addone;
exports.makeMatrixExn = makeMatrixExn;
exports.sumUsingForEach = sumUsingForEach;
exports.id = id$1;
--[[  Not a pure module ]]
