console = {log = print};

Mt = require "./mt";
List = require "../../lib/js/list";
Curry = require "../../lib/js/curry";
Stack = require "../../lib/js/stack";
Caml_obj = require "../../lib/js/caml_obj";
Mt_global = require "./mt_global";

suites = {
  contents = --[[ [] ]]0
};

test_id = {
  contents = 0
};

function eq(f, param) do
  return Mt_global.collect_eq(test_id, suites, f, param[0], param[1]);
end end

function assert_(loc, v) do
  return eq(loc, --[[ tuple ]]{
              v,
              true
            });
end end

function to_list(s) do
  l = {
    contents = --[[ [] ]]0
  };
  List.iter((function(x) do
          l.contents = --[[ :: ]]{
            x,
            l.contents
          };
          return --[[ () ]]0;
        end end), s.c);
  return l.contents;
end end

S = {
  Empty = Stack.Empty,
  create = Stack.create,
  push = Stack.push,
  pop = Stack.pop,
  top = Stack.top,
  clear = Stack.clear,
  copy = Stack.copy,
  is_empty = Stack.is_empty,
  length = Stack.length,
  iter = Stack.iter,
  fold = Stack.fold,
  to_list = to_list
};

function does_raise(f, s) do
  xpcall(function() do
    Curry._1(f, s);
    return false;
  end end,function(exn) do
    if (exn == Stack.Empty) then do
      return true;
    end else do
      error(exn)
    end end 
  end end)
end end

s = {
  c = --[[ [] ]]0,
  len = 0
};

assert_("File \"stack_comp_test.ml\", line 33, characters 32-39", to_list(s) == --[[ [] ]]0 and s.len == 0);

Stack.push(1, s);

assert_("File \"stack_comp_test.ml\", line 34, characters 32-39", Caml_obj.caml_equal(to_list(s), --[[ :: ]]{
          1,
          --[[ [] ]]0
        }) and s.len == 1);

Stack.push(2, s);

assert_("File \"stack_comp_test.ml\", line 35, characters 32-39", Caml_obj.caml_equal(to_list(s), --[[ :: ]]{
          1,
          --[[ :: ]]{
            2,
            --[[ [] ]]0
          }
        }) and s.len == 2);

Stack.push(3, s);

assert_("File \"stack_comp_test.ml\", line 36, characters 32-39", Caml_obj.caml_equal(to_list(s), --[[ :: ]]{
          1,
          --[[ :: ]]{
            2,
            --[[ :: ]]{
              3,
              --[[ [] ]]0
            }
          }
        }) and s.len == 3);

Stack.push(4, s);

assert_("File \"stack_comp_test.ml\", line 37, characters 32-39", Caml_obj.caml_equal(to_list(s), --[[ :: ]]{
          1,
          --[[ :: ]]{
            2,
            --[[ :: ]]{
              3,
              --[[ :: ]]{
                4,
                --[[ [] ]]0
              }
            }
          }
        }) and s.len == 4);

assert_("File \"stack_comp_test.ml\", line 38, characters 10-17", Stack.pop(s) == 4);

assert_("File \"stack_comp_test.ml\", line 38, characters 41-48", Caml_obj.caml_equal(to_list(s), --[[ :: ]]{
          1,
          --[[ :: ]]{
            2,
            --[[ :: ]]{
              3,
              --[[ [] ]]0
            }
          }
        }) and s.len == 3);

assert_("File \"stack_comp_test.ml\", line 39, characters 10-17", Stack.pop(s) == 3);

assert_("File \"stack_comp_test.ml\", line 39, characters 41-48", Caml_obj.caml_equal(to_list(s), --[[ :: ]]{
          1,
          --[[ :: ]]{
            2,
            --[[ [] ]]0
          }
        }) and s.len == 2);

assert_("File \"stack_comp_test.ml\", line 40, characters 10-17", Stack.pop(s) == 2);

assert_("File \"stack_comp_test.ml\", line 40, characters 41-48", Caml_obj.caml_equal(to_list(s), --[[ :: ]]{
          1,
          --[[ [] ]]0
        }) and s.len == 1);

assert_("File \"stack_comp_test.ml\", line 41, characters 10-17", Stack.pop(s) == 1);

assert_("File \"stack_comp_test.ml\", line 41, characters 41-48", to_list(s) == --[[ [] ]]0 and s.len == 0);

assert_("File \"stack_comp_test.ml\", line 42, characters 10-17", does_raise(Stack.pop, s));

s_1 = {
  c = --[[ [] ]]0,
  len = 0
};

Stack.push(1, s_1);

assert_("File \"stack_comp_test.ml\", line 47, characters 22-29", Stack.pop(s_1) == 1);

assert_("File \"stack_comp_test.ml\", line 47, characters 53-60", does_raise(Stack.pop, s_1));

Stack.push(2, s_1);

assert_("File \"stack_comp_test.ml\", line 48, characters 22-29", Stack.pop(s_1) == 2);

assert_("File \"stack_comp_test.ml\", line 48, characters 53-60", does_raise(Stack.pop, s_1));

assert_("File \"stack_comp_test.ml\", line 49, characters 10-17", s_1.len == 0);

s_2 = {
  c = --[[ [] ]]0,
  len = 0
};

Stack.push(1, s_2);

assert_("File \"stack_comp_test.ml\", line 54, characters 22-29", Stack.top(s_2) == 1);

Stack.push(2, s_2);

assert_("File \"stack_comp_test.ml\", line 55, characters 22-29", Stack.top(s_2) == 2);

Stack.push(3, s_2);

assert_("File \"stack_comp_test.ml\", line 56, characters 22-29", Stack.top(s_2) == 3);

assert_("File \"stack_comp_test.ml\", line 57, characters 10-17", Stack.top(s_2) == 3);

assert_("File \"stack_comp_test.ml\", line 57, characters 41-48", Stack.pop(s_2) == 3);

assert_("File \"stack_comp_test.ml\", line 58, characters 10-17", Stack.top(s_2) == 2);

assert_("File \"stack_comp_test.ml\", line 58, characters 41-48", Stack.pop(s_2) == 2);

assert_("File \"stack_comp_test.ml\", line 59, characters 10-17", Stack.top(s_2) == 1);

assert_("File \"stack_comp_test.ml\", line 59, characters 41-48", Stack.pop(s_2) == 1);

assert_("File \"stack_comp_test.ml\", line 60, characters 10-17", does_raise(Stack.top, s_2));

assert_("File \"stack_comp_test.ml\", line 61, characters 10-17", does_raise(Stack.top, s_2));

s_3 = {
  c = --[[ [] ]]0,
  len = 0
};

for i = 1 , 10 , 1 do
  Stack.push(i, s_3);
end

Stack.clear(s_3);

assert_("File \"stack_comp_test.ml\", line 68, characters 10-17", s_3.len == 0);

assert_("File \"stack_comp_test.ml\", line 69, characters 10-17", does_raise(Stack.pop, s_3));

assert_("File \"stack_comp_test.ml\", line 70, characters 10-17", Caml_obj.caml_equal(s_3, {
          c = --[[ [] ]]0,
          len = 0
        }));

Stack.push(42, s_3);

assert_("File \"stack_comp_test.ml\", line 72, characters 10-17", Stack.pop(s_3) == 42);

s1 = {
  c = --[[ [] ]]0,
  len = 0
};

for i_1 = 1 , 10 , 1 do
  Stack.push(i_1, s1);
end

s2 = Stack.copy(s1);

assert_("File \"stack_comp_test.ml\", line 79, characters 10-17", Caml_obj.caml_equal(to_list(s1), --[[ :: ]]{
          1,
          --[[ :: ]]{
            2,
            --[[ :: ]]{
              3,
              --[[ :: ]]{
                4,
                --[[ :: ]]{
                  5,
                  --[[ :: ]]{
                    6,
                    --[[ :: ]]{
                      7,
                      --[[ :: ]]{
                        8,
                        --[[ :: ]]{
                          9,
                          --[[ :: ]]{
                            10,
                            --[[ [] ]]0
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }));

assert_("File \"stack_comp_test.ml\", line 80, characters 10-17", Caml_obj.caml_equal(to_list(s2), --[[ :: ]]{
          1,
          --[[ :: ]]{
            2,
            --[[ :: ]]{
              3,
              --[[ :: ]]{
                4,
                --[[ :: ]]{
                  5,
                  --[[ :: ]]{
                    6,
                    --[[ :: ]]{
                      7,
                      --[[ :: ]]{
                        8,
                        --[[ :: ]]{
                          9,
                          --[[ :: ]]{
                            10,
                            --[[ [] ]]0
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }));

assert_("File \"stack_comp_test.ml\", line 81, characters 10-17", s1.len == 10);

assert_("File \"stack_comp_test.ml\", line 82, characters 10-17", s2.len == 10);

for i_2 = 10 , 1 , -1 do
  assert_("File \"stack_comp_test.ml\", line 84, characters 12-19", Stack.pop(s1) == i_2);
end

for i_3 = 10 , 1 , -1 do
  assert_("File \"stack_comp_test.ml\", line 87, characters 12-19", Stack.pop(s2) == i_3);
end

s_4 = {
  c = --[[ [] ]]0,
  len = 0
};

assert_("File \"stack_comp_test.ml\", line 93, characters 10-17", s_4.c == --[[ [] ]]0);

for i_4 = 1 , 10 , 1 do
  Stack.push(i_4, s_4);
  assert_("File \"stack_comp_test.ml\", line 96, characters 12-19", s_4.len == i_4);
  assert_("File \"stack_comp_test.ml\", line 97, characters 12-19", s_4.c ~= --[[ [] ]]0);
end

for i_5 = 10 , 1 , -1 do
  assert_("File \"stack_comp_test.ml\", line 100, characters 12-19", s_4.len == i_5);
  assert_("File \"stack_comp_test.ml\", line 101, characters 12-19", s_4.c ~= --[[ [] ]]0);
  Stack.pop(s_4);
end

assert_("File \"stack_comp_test.ml\", line 104, characters 10-17", s_4.len == 0);

assert_("File \"stack_comp_test.ml\", line 105, characters 10-17", s_4.c == --[[ [] ]]0);

s_5 = {
  c = --[[ [] ]]0,
  len = 0
};

for i_6 = 10 , 1 , -1 do
  Stack.push(i_6, s_5);
end

i_7 = {
  contents = 1
};

List.iter((function(j) do
        assert_("File \"stack_comp_test.ml\", line 112, characters 27-34", i_7.contents == j);
        i_7.contents = i_7.contents + 1 | 0;
        return --[[ () ]]0;
      end end), s_5.c);

s1_1 = {
  c = --[[ [] ]]0,
  len = 0
};

assert_("File \"stack_comp_test.ml\", line 117, characters 10-17", s1_1.len == 0);

assert_("File \"stack_comp_test.ml\", line 117, characters 45-52", to_list(s1_1) == --[[ [] ]]0);

s2_1 = Stack.copy(s1_1);

assert_("File \"stack_comp_test.ml\", line 119, characters 10-17", s1_1.len == 0);

assert_("File \"stack_comp_test.ml\", line 119, characters 45-52", to_list(s1_1) == --[[ [] ]]0);

assert_("File \"stack_comp_test.ml\", line 120, characters 10-17", s2_1.len == 0);

assert_("File \"stack_comp_test.ml\", line 120, characters 45-52", to_list(s2_1) == --[[ [] ]]0);

s1_2 = {
  c = --[[ [] ]]0,
  len = 0
};

for i_8 = 1 , 4 , 1 do
  Stack.push(i_8, s1_2);
end

assert_("File \"stack_comp_test.ml\", line 126, characters 10-17", s1_2.len == 4);

assert_("File \"stack_comp_test.ml\", line 126, characters 45-52", Caml_obj.caml_equal(to_list(s1_2), --[[ :: ]]{
          1,
          --[[ :: ]]{
            2,
            --[[ :: ]]{
              3,
              --[[ :: ]]{
                4,
                --[[ [] ]]0
              }
            }
          }
        }));

s2_2 = Stack.copy(s1_2);

assert_("File \"stack_comp_test.ml\", line 128, characters 10-17", s1_2.len == 4);

assert_("File \"stack_comp_test.ml\", line 128, characters 45-52", Caml_obj.caml_equal(to_list(s1_2), --[[ :: ]]{
          1,
          --[[ :: ]]{
            2,
            --[[ :: ]]{
              3,
              --[[ :: ]]{
                4,
                --[[ [] ]]0
              }
            }
          }
        }));

assert_("File \"stack_comp_test.ml\", line 129, characters 10-17", s2_2.len == 4);

assert_("File \"stack_comp_test.ml\", line 129, characters 45-52", Caml_obj.caml_equal(to_list(s2_2), --[[ :: ]]{
          1,
          --[[ :: ]]{
            2,
            --[[ :: ]]{
              3,
              --[[ :: ]]{
                4,
                --[[ [] ]]0
              }
            }
          }
        }));

Mt.from_pair_suites("Stack_comp_test", suites.contents);

exports = {}
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.assert_ = assert_;
exports.S = S;
exports.does_raise = does_raise;
--[[ s Not a pure module ]]
