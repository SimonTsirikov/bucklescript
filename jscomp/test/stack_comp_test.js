'use strict';

Mt = require("./mt.js");
List = require("../../lib/js/list.js");
Curry = require("../../lib/js/curry.js");
Stack = require("../../lib/js/stack.js");
Caml_obj = require("../../lib/js/caml_obj.js");
Mt_global = require("./mt_global.js");

suites = do
  contents: --[ [] ]--0
end;

test_id = do
  contents: 0
end;

function eq(f, param) do
  return Mt_global.collect_eq(test_id, suites, f, param[0], param[1]);
end end

function assert_(loc, v) do
  return eq(loc, --[ tuple ]--[
              v,
              true
            ]);
end end

function to_list(s) do
  l = do
    contents: --[ [] ]--0
  end;
  List.iter((function (x) do
          l.contents = --[ :: ]--[
            x,
            l.contents
          ];
          return --[ () ]--0;
        end end), s.c);
  return l.contents;
end end

S = do
  Empty: Stack.Empty,
  create: Stack.create,
  push: Stack.push,
  pop: Stack.pop,
  top: Stack.top,
  clear: Stack.clear,
  copy: Stack.copy,
  is_empty: Stack.is_empty,
  length: Stack.length,
  iter: Stack.iter,
  fold: Stack.fold,
  to_list: to_list
end;

function does_raise(f, s) do
  try do
    Curry._1(f, s);
    return false;
  end
  catch (exn)do
    if (exn == Stack.Empty) then do
      return true;
    end else do
      throw exn;
    end end 
  end
end end

s = do
  c: --[ [] ]--0,
  len: 0
end;

assert_("File \"stack_comp_test.ml\", line 33, characters 32-39", to_list(s) == --[ [] ]--0 and s.len == 0);

Stack.push(1, s);

assert_("File \"stack_comp_test.ml\", line 34, characters 32-39", Caml_obj.caml_equal(to_list(s), --[ :: ]--[
          1,
          --[ [] ]--0
        ]) and s.len == 1);

Stack.push(2, s);

assert_("File \"stack_comp_test.ml\", line 35, characters 32-39", Caml_obj.caml_equal(to_list(s), --[ :: ]--[
          1,
          --[ :: ]--[
            2,
            --[ [] ]--0
          ]
        ]) and s.len == 2);

Stack.push(3, s);

assert_("File \"stack_comp_test.ml\", line 36, characters 32-39", Caml_obj.caml_equal(to_list(s), --[ :: ]--[
          1,
          --[ :: ]--[
            2,
            --[ :: ]--[
              3,
              --[ [] ]--0
            ]
          ]
        ]) and s.len == 3);

Stack.push(4, s);

assert_("File \"stack_comp_test.ml\", line 37, characters 32-39", Caml_obj.caml_equal(to_list(s), --[ :: ]--[
          1,
          --[ :: ]--[
            2,
            --[ :: ]--[
              3,
              --[ :: ]--[
                4,
                --[ [] ]--0
              ]
            ]
          ]
        ]) and s.len == 4);

assert_("File \"stack_comp_test.ml\", line 38, characters 10-17", Stack.pop(s) == 4);

assert_("File \"stack_comp_test.ml\", line 38, characters 41-48", Caml_obj.caml_equal(to_list(s), --[ :: ]--[
          1,
          --[ :: ]--[
            2,
            --[ :: ]--[
              3,
              --[ [] ]--0
            ]
          ]
        ]) and s.len == 3);

assert_("File \"stack_comp_test.ml\", line 39, characters 10-17", Stack.pop(s) == 3);

assert_("File \"stack_comp_test.ml\", line 39, characters 41-48", Caml_obj.caml_equal(to_list(s), --[ :: ]--[
          1,
          --[ :: ]--[
            2,
            --[ [] ]--0
          ]
        ]) and s.len == 2);

assert_("File \"stack_comp_test.ml\", line 40, characters 10-17", Stack.pop(s) == 2);

assert_("File \"stack_comp_test.ml\", line 40, characters 41-48", Caml_obj.caml_equal(to_list(s), --[ :: ]--[
          1,
          --[ [] ]--0
        ]) and s.len == 1);

assert_("File \"stack_comp_test.ml\", line 41, characters 10-17", Stack.pop(s) == 1);

assert_("File \"stack_comp_test.ml\", line 41, characters 41-48", to_list(s) == --[ [] ]--0 and s.len == 0);

assert_("File \"stack_comp_test.ml\", line 42, characters 10-17", does_raise(Stack.pop, s));

s$1 = do
  c: --[ [] ]--0,
  len: 0
end;

Stack.push(1, s$1);

assert_("File \"stack_comp_test.ml\", line 47, characters 22-29", Stack.pop(s$1) == 1);

assert_("File \"stack_comp_test.ml\", line 47, characters 53-60", does_raise(Stack.pop, s$1));

Stack.push(2, s$1);

assert_("File \"stack_comp_test.ml\", line 48, characters 22-29", Stack.pop(s$1) == 2);

assert_("File \"stack_comp_test.ml\", line 48, characters 53-60", does_raise(Stack.pop, s$1));

assert_("File \"stack_comp_test.ml\", line 49, characters 10-17", s$1.len == 0);

s$2 = do
  c: --[ [] ]--0,
  len: 0
end;

Stack.push(1, s$2);

assert_("File \"stack_comp_test.ml\", line 54, characters 22-29", Stack.top(s$2) == 1);

Stack.push(2, s$2);

assert_("File \"stack_comp_test.ml\", line 55, characters 22-29", Stack.top(s$2) == 2);

Stack.push(3, s$2);

assert_("File \"stack_comp_test.ml\", line 56, characters 22-29", Stack.top(s$2) == 3);

assert_("File \"stack_comp_test.ml\", line 57, characters 10-17", Stack.top(s$2) == 3);

assert_("File \"stack_comp_test.ml\", line 57, characters 41-48", Stack.pop(s$2) == 3);

assert_("File \"stack_comp_test.ml\", line 58, characters 10-17", Stack.top(s$2) == 2);

assert_("File \"stack_comp_test.ml\", line 58, characters 41-48", Stack.pop(s$2) == 2);

assert_("File \"stack_comp_test.ml\", line 59, characters 10-17", Stack.top(s$2) == 1);

assert_("File \"stack_comp_test.ml\", line 59, characters 41-48", Stack.pop(s$2) == 1);

assert_("File \"stack_comp_test.ml\", line 60, characters 10-17", does_raise(Stack.top, s$2));

assert_("File \"stack_comp_test.ml\", line 61, characters 10-17", does_raise(Stack.top, s$2));

s$3 = do
  c: --[ [] ]--0,
  len: 0
end;

for i = 1 , 10 , 1 do
  Stack.push(i, s$3);
end

Stack.clear(s$3);

assert_("File \"stack_comp_test.ml\", line 68, characters 10-17", s$3.len == 0);

assert_("File \"stack_comp_test.ml\", line 69, characters 10-17", does_raise(Stack.pop, s$3));

assert_("File \"stack_comp_test.ml\", line 70, characters 10-17", Caml_obj.caml_equal(s$3, do
          c: --[ [] ]--0,
          len: 0
        end));

Stack.push(42, s$3);

assert_("File \"stack_comp_test.ml\", line 72, characters 10-17", Stack.pop(s$3) == 42);

s1 = do
  c: --[ [] ]--0,
  len: 0
end;

for i$1 = 1 , 10 , 1 do
  Stack.push(i$1, s1);
end

s2 = Stack.copy(s1);

assert_("File \"stack_comp_test.ml\", line 79, characters 10-17", Caml_obj.caml_equal(to_list(s1), --[ :: ]--[
          1,
          --[ :: ]--[
            2,
            --[ :: ]--[
              3,
              --[ :: ]--[
                4,
                --[ :: ]--[
                  5,
                  --[ :: ]--[
                    6,
                    --[ :: ]--[
                      7,
                      --[ :: ]--[
                        8,
                        --[ :: ]--[
                          9,
                          --[ :: ]--[
                            10,
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
        ]));

assert_("File \"stack_comp_test.ml\", line 80, characters 10-17", Caml_obj.caml_equal(to_list(s2), --[ :: ]--[
          1,
          --[ :: ]--[
            2,
            --[ :: ]--[
              3,
              --[ :: ]--[
                4,
                --[ :: ]--[
                  5,
                  --[ :: ]--[
                    6,
                    --[ :: ]--[
                      7,
                      --[ :: ]--[
                        8,
                        --[ :: ]--[
                          9,
                          --[ :: ]--[
                            10,
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
        ]));

assert_("File \"stack_comp_test.ml\", line 81, characters 10-17", s1.len == 10);

assert_("File \"stack_comp_test.ml\", line 82, characters 10-17", s2.len == 10);

for i$2 = 10 , 1 , -1 do
  assert_("File \"stack_comp_test.ml\", line 84, characters 12-19", Stack.pop(s1) == i$2);
end

for i$3 = 10 , 1 , -1 do
  assert_("File \"stack_comp_test.ml\", line 87, characters 12-19", Stack.pop(s2) == i$3);
end

s$4 = do
  c: --[ [] ]--0,
  len: 0
end;

assert_("File \"stack_comp_test.ml\", line 93, characters 10-17", s$4.c == --[ [] ]--0);

for i$4 = 1 , 10 , 1 do
  Stack.push(i$4, s$4);
  assert_("File \"stack_comp_test.ml\", line 96, characters 12-19", s$4.len == i$4);
  assert_("File \"stack_comp_test.ml\", line 97, characters 12-19", s$4.c ~= --[ [] ]--0);
end

for i$5 = 10 , 1 , -1 do
  assert_("File \"stack_comp_test.ml\", line 100, characters 12-19", s$4.len == i$5);
  assert_("File \"stack_comp_test.ml\", line 101, characters 12-19", s$4.c ~= --[ [] ]--0);
  Stack.pop(s$4);
end

assert_("File \"stack_comp_test.ml\", line 104, characters 10-17", s$4.len == 0);

assert_("File \"stack_comp_test.ml\", line 105, characters 10-17", s$4.c == --[ [] ]--0);

s$5 = do
  c: --[ [] ]--0,
  len: 0
end;

for i$6 = 10 , 1 , -1 do
  Stack.push(i$6, s$5);
end

i$7 = do
  contents: 1
end;

List.iter((function (j) do
        assert_("File \"stack_comp_test.ml\", line 112, characters 27-34", i$7.contents == j);
        i$7.contents = i$7.contents + 1 | 0;
        return --[ () ]--0;
      end end), s$5.c);

s1$1 = do
  c: --[ [] ]--0,
  len: 0
end;

assert_("File \"stack_comp_test.ml\", line 117, characters 10-17", s1$1.len == 0);

assert_("File \"stack_comp_test.ml\", line 117, characters 45-52", to_list(s1$1) == --[ [] ]--0);

s2$1 = Stack.copy(s1$1);

assert_("File \"stack_comp_test.ml\", line 119, characters 10-17", s1$1.len == 0);

assert_("File \"stack_comp_test.ml\", line 119, characters 45-52", to_list(s1$1) == --[ [] ]--0);

assert_("File \"stack_comp_test.ml\", line 120, characters 10-17", s2$1.len == 0);

assert_("File \"stack_comp_test.ml\", line 120, characters 45-52", to_list(s2$1) == --[ [] ]--0);

s1$2 = do
  c: --[ [] ]--0,
  len: 0
end;

for i$8 = 1 , 4 , 1 do
  Stack.push(i$8, s1$2);
end

assert_("File \"stack_comp_test.ml\", line 126, characters 10-17", s1$2.len == 4);

assert_("File \"stack_comp_test.ml\", line 126, characters 45-52", Caml_obj.caml_equal(to_list(s1$2), --[ :: ]--[
          1,
          --[ :: ]--[
            2,
            --[ :: ]--[
              3,
              --[ :: ]--[
                4,
                --[ [] ]--0
              ]
            ]
          ]
        ]));

s2$2 = Stack.copy(s1$2);

assert_("File \"stack_comp_test.ml\", line 128, characters 10-17", s1$2.len == 4);

assert_("File \"stack_comp_test.ml\", line 128, characters 45-52", Caml_obj.caml_equal(to_list(s1$2), --[ :: ]--[
          1,
          --[ :: ]--[
            2,
            --[ :: ]--[
              3,
              --[ :: ]--[
                4,
                --[ [] ]--0
              ]
            ]
          ]
        ]));

assert_("File \"stack_comp_test.ml\", line 129, characters 10-17", s2$2.len == 4);

assert_("File \"stack_comp_test.ml\", line 129, characters 45-52", Caml_obj.caml_equal(to_list(s2$2), --[ :: ]--[
          1,
          --[ :: ]--[
            2,
            --[ :: ]--[
              3,
              --[ :: ]--[
                4,
                --[ [] ]--0
              ]
            ]
          ]
        ]));

Mt.from_pair_suites("Stack_comp_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.assert_ = assert_;
exports.S = S;
exports.does_raise = does_raise;
--[ s Not a pure module ]--
