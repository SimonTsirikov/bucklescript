console = {log = print};

Mt = require "./mt";
Curry = require "../../lib/js/curry";
Caml_obj = require "../../lib/js/caml_obj";
Belt_Array = require "../../lib/js/belt_Array";
Belt_MutableQueue = require "../../lib/js/belt_MutableQueue";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

suites = {
  contents = --[[ [] ]]0
};

test_id = {
  contents = 0
};

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

function b(loc, x) do
  return Mt.bool_suites(test_id, suites, loc, x);
end end

function does_raise(f, q) do
  xpcall(function() do
    Curry._1(f, q);
    return false;
  end end,function(exn) do
    return true;
  end end)
end end

function $plus$plus(q, x) do
  Belt_MutableQueue.add(q, x);
  return q;
end end

q = Belt_MutableQueue.make(--[[ () ]]0);

if (not (Caml_obj.caml_equal(Belt_MutableQueue.toArray(q), {}) and q.length == 0)) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      21,
      2
    }
  })
end
 end 

if (not (Caml_obj.caml_equal(Belt_MutableQueue.toArray((Belt_MutableQueue.add(q, 1), q)), {1}) and q.length == 1)) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      22,
      2
    }
  })
end
 end 

if (not (Caml_obj.caml_equal(Belt_MutableQueue.toArray((Belt_MutableQueue.add(q, 2), q)), {
          1,
          2
        }) and q.length == 2)) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      23,
      2
    }
  })
end
 end 

if (not (Caml_obj.caml_equal(Belt_MutableQueue.toArray((Belt_MutableQueue.add(q, 3), q)), {
          1,
          2,
          3
        }) and q.length == 3)) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      24,
      2
    }
  })
end
 end 

if (not (Caml_obj.caml_equal(Belt_MutableQueue.toArray((Belt_MutableQueue.add(q, 4), q)), {
          1,
          2,
          3,
          4
        }) and q.length == 4)) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      25,
      2
    }
  })
end
 end 

if (Belt_MutableQueue.popExn(q) ~= 1) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      26,
      2
    }
  })
end
 end 

if (not (Caml_obj.caml_equal(Belt_MutableQueue.toArray(q), {
          2,
          3,
          4
        }) and q.length == 3)) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      26,
      27
    }
  })
end
 end 

if (Belt_MutableQueue.popExn(q) ~= 2) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      27,
      2
    }
  })
end
 end 

if (not (Caml_obj.caml_equal(Belt_MutableQueue.toArray(q), {
          3,
          4
        }) and q.length == 2)) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      27,
      27
    }
  })
end
 end 

if (Belt_MutableQueue.popExn(q) ~= 3) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      28,
      2
    }
  })
end
 end 

if (not (Caml_obj.caml_equal(Belt_MutableQueue.toArray(q), {4}) and q.length == 1)) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      28,
      27
    }
  })
end
 end 

if (Belt_MutableQueue.popExn(q) ~= 4) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      29,
      2
    }
  })
end
 end 

if (not (Caml_obj.caml_equal(Belt_MutableQueue.toArray(q), {}) and q.length == 0)) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      29,
      27
    }
  })
end
 end 

if (not does_raise(Belt_MutableQueue.popExn, q)) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      30,
      2
    }
  })
end
 end 

q_1 = Belt_MutableQueue.make(--[[ () ]]0);

if (Belt_MutableQueue.popExn((Belt_MutableQueue.add(q_1, 1), q_1)) ~= 1) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      35,
      2
    }
  })
end
 end 

if (not does_raise(Belt_MutableQueue.popExn, q_1)) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      35,
      34
    }
  })
end
 end 

if (Belt_MutableQueue.popExn((Belt_MutableQueue.add(q_1, 2), q_1)) ~= 2) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      36,
      2
    }
  })
end
 end 

if (not does_raise(Belt_MutableQueue.popExn, q_1)) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      36,
      34
    }
  })
end
 end 

if (q_1.length ~= 0) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      37,
      2
    }
  })
end
 end 

q_2 = Belt_MutableQueue.make(--[[ () ]]0);

if (Belt_MutableQueue.peekExn((Belt_MutableQueue.add(q_2, 1), q_2)) ~= 1) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      42,
      2
    }
  })
end
 end 

if (Belt_MutableQueue.peekExn((Belt_MutableQueue.add(q_2, 2), q_2)) ~= 1) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      43,
      2
    }
  })
end
 end 

if (Belt_MutableQueue.peekExn((Belt_MutableQueue.add(q_2, 3), q_2)) ~= 1) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      44,
      2
    }
  })
end
 end 

if (Belt_MutableQueue.peekExn(q_2) ~= 1) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      45,
      2
    }
  })
end
 end 

if (Belt_MutableQueue.popExn(q_2) ~= 1) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      45,
      28
    }
  })
end
 end 

if (Belt_MutableQueue.peekExn(q_2) ~= 2) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      46,
      2
    }
  })
end
 end 

if (Belt_MutableQueue.popExn(q_2) ~= 2) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      46,
      28
    }
  })
end
 end 

if (Belt_MutableQueue.peekExn(q_2) ~= 3) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      47,
      2
    }
  })
end
 end 

if (Belt_MutableQueue.popExn(q_2) ~= 3) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      47,
      28
    }
  })
end
 end 

if (not does_raise(Belt_MutableQueue.peekExn, q_2)) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      48,
      2
    }
  })
end
 end 

if (not does_raise(Belt_MutableQueue.peekExn, q_2)) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      49,
      2
    }
  })
end
 end 

q_3 = Belt_MutableQueue.make(--[[ () ]]0);

for i = 1 , 10 , 1 do
  Belt_MutableQueue.add(q_3, i);
end

Belt_MutableQueue.clear(q_3);

if (q_3.length ~= 0) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      56,
      2
    }
  })
end
 end 

if (not does_raise(Belt_MutableQueue.popExn, q_3)) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      57,
      2
    }
  })
end
 end 

if (not Caml_obj.caml_equal(q_3, Belt_MutableQueue.make(--[[ () ]]0))) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      58,
      2
    }
  })
end
 end 

Belt_MutableQueue.add(q_3, 42);

if (Belt_MutableQueue.popExn(q_3) ~= 42) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      60,
      2
    }
  })
end
 end 

q1 = Belt_MutableQueue.make(--[[ () ]]0);

for i_1 = 1 , 10 , 1 do
  Belt_MutableQueue.add(q1, i_1);
end

q2 = Belt_MutableQueue.copy(q1);

if (not Caml_obj.caml_equal(Belt_MutableQueue.toArray(q1), {
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10
      })) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      67,
      2
    }
  })
end
 end 

if (not Caml_obj.caml_equal(Belt_MutableQueue.toArray(q2), {
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        8,
        9,
        10
      })) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      68,
      2
    }
  })
end
 end 

if (q1.length ~= 10) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      69,
      2
    }
  })
end
 end 

if (q2.length ~= 10) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      70,
      2
    }
  })
end
 end 

for i_2 = 1 , 10 , 1 do
  if (Belt_MutableQueue.popExn(q1) ~= i_2) then do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "bs_queue_test.ml",
        72,
        4
      }
    })
  end
   end 
end

for i_3 = 1 , 10 , 1 do
  if (Belt_MutableQueue.popExn(q2) ~= i_3) then do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "bs_queue_test.ml",
        75,
        4
      }
    })
  end
   end 
end

q_4 = Belt_MutableQueue.make(--[[ () ]]0);

if (q_4.length ~= 0) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      81,
      2
    }
  })
end
 end 

for i_4 = 1 , 10 , 1 do
  Belt_MutableQueue.add(q_4, i_4);
  if (q_4.length ~= i_4) then do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "bs_queue_test.ml",
        84,
        4
      }
    })
  end
   end 
  if (q_4.length == 0) then do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "bs_queue_test.ml",
        85,
        4
      }
    })
  end
   end 
end

for i_5 = 10 , 1 , -1 do
  if (q_4.length ~= i_5) then do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "bs_queue_test.ml",
        88,
        4
      }
    })
  end
   end 
  if (q_4.length == 0) then do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "bs_queue_test.ml",
        89,
        4
      }
    })
  end
   end 
  Belt_MutableQueue.popExn(q_4);
end

if (q_4.length ~= 0) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      92,
      2
    }
  })
end
 end 

if (q_4.length ~= 0) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      93,
      2
    }
  })
end
 end 

q_5 = Belt_MutableQueue.make(--[[ () ]]0);

for i_6 = 1 , 10 , 1 do
  Belt_MutableQueue.add(q_5, i_6);
end

i_7 = {
  contents = 1
};

Belt_MutableQueue.forEach(q_5, (function(j) do
        if (i_7.contents ~= j) then do
          error({
            Caml_builtin_exceptions.assert_failure,
            --[[ tuple ]]{
              "bs_queue_test.ml",
              100,
              24
            }
          })
        end
         end 
        i_7.contents = i_7.contents + 1 | 0;
        return --[[ () ]]0;
      end end));

q1_1 = Belt_MutableQueue.make(--[[ () ]]0);

q2_1 = Belt_MutableQueue.make(--[[ () ]]0);

if (q1_1.length ~= 0) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      105,
      2
    }
  })
end
 end 

if (not Caml_obj.caml_equal(Belt_MutableQueue.toArray(q1_1), {})) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      105,
      26
    }
  })
end
 end 

if (q2_1.length ~= 0) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      106,
      2
    }
  })
end
 end 

if (not Caml_obj.caml_equal(Belt_MutableQueue.toArray(q2_1), {})) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      106,
      26
    }
  })
end
 end 

Belt_MutableQueue.transfer(q1_1, q2_1);

if (q1_1.length ~= 0) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      108,
      2
    }
  })
end
 end 

if (not Caml_obj.caml_equal(Belt_MutableQueue.toArray(q1_1), {})) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      108,
      26
    }
  })
end
 end 

if (q2_1.length ~= 0) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      109,
      2
    }
  })
end
 end 

if (not Caml_obj.caml_equal(Belt_MutableQueue.toArray(q2_1), {})) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      109,
      26
    }
  })
end
 end 

q1_2 = Belt_MutableQueue.make(--[[ () ]]0);

q2_2 = Belt_MutableQueue.make(--[[ () ]]0);

for i_8 = 1 , 4 , 1 do
  Belt_MutableQueue.add(q1_2, i_8);
end

if (q1_2.length ~= 4) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      115,
      2
    }
  })
end
 end 

if (not Caml_obj.caml_equal(Belt_MutableQueue.toArray(q1_2), {
        1,
        2,
        3,
        4
      })) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      115,
      26
    }
  })
end
 end 

if (q2_2.length ~= 0) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      116,
      2
    }
  })
end
 end 

if (not Caml_obj.caml_equal(Belt_MutableQueue.toArray(q2_2), {})) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      116,
      26
    }
  })
end
 end 

Belt_MutableQueue.transfer(q1_2, q2_2);

if (q1_2.length ~= 0) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      118,
      2
    }
  })
end
 end 

if (not Caml_obj.caml_equal(Belt_MutableQueue.toArray(q1_2), {})) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      118,
      26
    }
  })
end
 end 

if (q2_2.length ~= 4) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      119,
      2
    }
  })
end
 end 

if (not Caml_obj.caml_equal(Belt_MutableQueue.toArray(q2_2), {
        1,
        2,
        3,
        4
      })) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      119,
      26
    }
  })
end
 end 

q1_3 = Belt_MutableQueue.make(--[[ () ]]0);

q2_3 = Belt_MutableQueue.make(--[[ () ]]0);

for i_9 = 5 , 8 , 1 do
  Belt_MutableQueue.add(q2_3, i_9);
end

if (q1_3.length ~= 0) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      125,
      2
    }
  })
end
 end 

if (not Caml_obj.caml_equal(Belt_MutableQueue.toArray(q1_3), {})) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      125,
      26
    }
  })
end
 end 

if (q2_3.length ~= 4) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      126,
      2
    }
  })
end
 end 

if (not Caml_obj.caml_equal(Belt_MutableQueue.toArray(q2_3), {
        5,
        6,
        7,
        8
      })) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      126,
      26
    }
  })
end
 end 

Belt_MutableQueue.transfer(q1_3, q2_3);

if (q1_3.length ~= 0) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      128,
      2
    }
  })
end
 end 

if (not Caml_obj.caml_equal(Belt_MutableQueue.toArray(q1_3), {})) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      128,
      26
    }
  })
end
 end 

if (q2_3.length ~= 4) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      129,
      2
    }
  })
end
 end 

if (not Caml_obj.caml_equal(Belt_MutableQueue.toArray(q2_3), {
        5,
        6,
        7,
        8
      })) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      129,
      26
    }
  })
end
 end 

q1_4 = Belt_MutableQueue.make(--[[ () ]]0);

q2_4 = Belt_MutableQueue.make(--[[ () ]]0);

for i_10 = 1 , 4 , 1 do
  Belt_MutableQueue.add(q1_4, i_10);
end

for i_11 = 5 , 8 , 1 do
  Belt_MutableQueue.add(q2_4, i_11);
end

if (q1_4.length ~= 4) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      136,
      2
    }
  })
end
 end 

if (not Caml_obj.caml_equal(Belt_MutableQueue.toArray(q1_4), {
        1,
        2,
        3,
        4
      })) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      136,
      26
    }
  })
end
 end 

if (q2_4.length ~= 4) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      137,
      2
    }
  })
end
 end 

if (not Caml_obj.caml_equal(Belt_MutableQueue.toArray(q2_4), {
        5,
        6,
        7,
        8
      })) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      137,
      26
    }
  })
end
 end 

Belt_MutableQueue.transfer(q1_4, q2_4);

if (q1_4.length ~= 0) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      139,
      2
    }
  })
end
 end 

if (not Caml_obj.caml_equal(Belt_MutableQueue.toArray(q1_4), {})) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      139,
      26
    }
  })
end
 end 

v = {
  5,
  6,
  7,
  8,
  1,
  2,
  3,
  4
};

if (q2_4.length ~= 8) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      141,
      2
    }
  })
end
 end 

if (not Caml_obj.caml_equal(Belt_MutableQueue.toArray(q2_4), v)) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      141,
      26
    }
  })
end
 end 

if (Belt_MutableQueue.reduce(q2_4, 0, (function(x, y) do
          return x - y | 0;
        end end)) ~= Belt_Array.reduce(v, 0, (function(x, y) do
          return x - y | 0;
        end end))) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "bs_queue_test.ml",
      143,
      2
    }
  })
end
 end 

console.log("OK");

q_6 = Belt_MutableQueue.fromArray({
      1,
      2,
      3,
      4
    });

q1_5 = Belt_MutableQueue.map(q_6, (function(x) do
        return x - 1 | 0;
      end end));

eq("File \"bs_queue_test.ml\", line 154, characters 5-12", Belt_MutableQueue.toArray(q1_5), {
      0,
      1,
      2,
      3
    });

q_7 = Belt_MutableQueue.fromArray({});

b("File \"bs_queue_test.ml\", line 155, characters 4-11", q_7.length == 0);

q_8 = Belt_MutableQueue.map(Belt_MutableQueue.fromArray({}), (function(x) do
        return x + 1 | 0;
      end end));

b("File \"bs_queue_test.ml\", line 156, characters 4-11", q_8.length == 0);

Mt.from_pair_suites("Bs_queue_test", suites.contents);

Q = --[[ alias ]]0;

exports = {}
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.b = b;
exports.Q = Q;
exports.does_raise = does_raise;
exports.$plus$plus = $plus$plus;
--[[ q Not a pure module ]]
