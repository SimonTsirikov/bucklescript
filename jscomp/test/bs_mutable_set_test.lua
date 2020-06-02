console = {log = print};

Mt = require "./mt";
Belt_List = require "../../lib/js/belt_List";
Belt_Array = require "../../lib/js/belt_Array";
Belt_Range = require "../../lib/js/belt_Range";
Caml_array = require "../../lib/js/caml_array";
Array_data_util = require "./array_data_util";
Belt_MutableSetInt = require "../../lib/js/belt_MutableSetInt";
Belt_internalAVLset = require "../../lib/js/belt_internalAVLset";
Belt_internalSetInt = require "../../lib/js/belt_internalSetInt";

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

xs = Array_data_util.range(0, 30);

u = do
  data: Belt_internalSetInt.fromArray(xs)
end;

b("File \"bs_mutable_set_test.ml\", line 20, characters 4-11", Belt_MutableSetInt.removeCheck(u, 0));

b("File \"bs_mutable_set_test.ml\", line 21, characters 4-11", not Belt_MutableSetInt.removeCheck(u, 0));

b("File \"bs_mutable_set_test.ml\", line 22, characters 4-11", Belt_MutableSetInt.removeCheck(u, 30));

b("File \"bs_mutable_set_test.ml\", line 23, characters 4-11", Belt_MutableSetInt.removeCheck(u, 20));

eq("File \"bs_mutable_set_test.ml\", line 24, characters 5-12", Belt_internalAVLset.size(u.data), 28);

r = Array_data_util.randomRange(0, 30);

b("File \"bs_mutable_set_test.ml\", line 26, characters 4-11", 29 == Belt_internalAVLset.maxUndefined(u.data));

b("File \"bs_mutable_set_test.ml\", line 27, characters 4-11", 1 == Belt_internalAVLset.minUndefined(u.data));

Belt_MutableSetInt.add(u, 3);

for i = 0 , #r - 1 | 0 , 1 do
  Belt_MutableSetInt.remove(u, r[i]);
end

b("File \"bs_mutable_set_test.ml\", line 32, characters 4-11", Belt_MutableSetInt.isEmpty(u));

Belt_MutableSetInt.add(u, 0);

Belt_MutableSetInt.add(u, 1);

Belt_MutableSetInt.add(u, 2);

Belt_MutableSetInt.add(u, 0);

eq("File \"bs_mutable_set_test.ml\", line 37, characters 5-12", Belt_internalAVLset.size(u.data), 3);

b("File \"bs_mutable_set_test.ml\", line 38, characters 4-11", not Belt_MutableSetInt.isEmpty(u));

for i_1 = 0 , 3 , 1 do
  Belt_MutableSetInt.remove(u, i_1);
end

b("File \"bs_mutable_set_test.ml\", line 42, characters 4-11", Belt_MutableSetInt.isEmpty(u));

Belt_MutableSetInt.mergeMany(u, Array_data_util.randomRange(0, 20000));

Belt_MutableSetInt.mergeMany(u, Array_data_util.randomRange(0, 200));

eq("File \"bs_mutable_set_test.ml\", line 45, characters 5-12", Belt_internalAVLset.size(u.data), 20001);

Belt_MutableSetInt.removeMany(u, Array_data_util.randomRange(0, 200));

eq("File \"bs_mutable_set_test.ml\", line 47, characters 5-12", Belt_internalAVLset.size(u.data), 19800);

Belt_MutableSetInt.removeMany(u, Array_data_util.randomRange(0, 1000));

eq("File \"bs_mutable_set_test.ml\", line 49, characters 5-12", Belt_internalAVLset.size(u.data), 19000);

Belt_MutableSetInt.removeMany(u, Array_data_util.randomRange(0, 1000));

eq("File \"bs_mutable_set_test.ml\", line 51, characters 5-12", Belt_internalAVLset.size(u.data), 19000);

Belt_MutableSetInt.removeMany(u, Array_data_util.randomRange(1000, 10000));

eq("File \"bs_mutable_set_test.ml\", line 53, characters 5-12", Belt_internalAVLset.size(u.data), 10000);

Belt_MutableSetInt.removeMany(u, Array_data_util.randomRange(10000, 19999));

eq("File \"bs_mutable_set_test.ml\", line 55, characters 5-12", Belt_internalAVLset.size(u.data), 1);

b("File \"bs_mutable_set_test.ml\", line 56, characters 4-11", Belt_internalSetInt.has(u.data, 20000));

Belt_MutableSetInt.removeMany(u, Array_data_util.randomRange(10000, 30000));

b("File \"bs_mutable_set_test.ml\", line 58, characters 4-11", Belt_MutableSetInt.isEmpty(u));

xs_1 = Array_data_util.randomRange(1000, 2000);

v = do
  data: Belt_internalSetInt.fromArray(xs_1)
end;

bs = Belt_Array.map(Array_data_util.randomRange(500, 1499), (function(x) do
        return Belt_MutableSetInt.removeCheck(v, x);
      end end));

indeedRemoved = Belt_Array.reduce(bs, 0, (function(acc, x) do
        if (x) then do
          return acc + 1 | 0;
        end else do
          return acc;
        end end 
      end end));

eq("File \"bs_mutable_set_test.ml\", line 65, characters 5-12", indeedRemoved, 500);

eq("File \"bs_mutable_set_test.ml\", line 66, characters 5-12", Belt_internalAVLset.size(v.data), 501);

cs = Belt_Array.map(Array_data_util.randomRange(500, 2000), (function(x) do
        return Belt_MutableSetInt.addCheck(v, x);
      end end));

indeedAded = Belt_Array.reduce(cs, 0, (function(acc, x) do
        if (x) then do
          return acc + 1 | 0;
        end else do
          return acc;
        end end 
      end end));

eq("File \"bs_mutable_set_test.ml\", line 69, characters 5-12", indeedAded, 1000);

eq("File \"bs_mutable_set_test.ml\", line 70, characters 5-12", Belt_internalAVLset.size(v.data), 1501);

b("File \"bs_mutable_set_test.ml\", line 71, characters 4-11", Belt_MutableSetInt.isEmpty(do
          data: nil
        end));

eq("File \"bs_mutable_set_test.ml\", line 72, characters 5-12", Belt_internalAVLset.minimum(v.data), 500);

eq("File \"bs_mutable_set_test.ml\", line 73, characters 5-12", Belt_internalAVLset.maximum(v.data), 2000);

eq("File \"bs_mutable_set_test.ml\", line 74, characters 5-12", Belt_internalAVLset.minUndefined(v.data), 500);

eq("File \"bs_mutable_set_test.ml\", line 75, characters 5-12", Belt_internalAVLset.maxUndefined(v.data), 2000);

eq("File \"bs_mutable_set_test.ml\", line 76, characters 5-12", Belt_MutableSetInt.reduce(v, 0, (function(x, y) do
            return x + y | 0;
          end end)), 1876250);

b("File \"bs_mutable_set_test.ml\", line 77, characters 4-11", Belt_List.eq(Belt_internalAVLset.toList(v.data), Belt_List.makeBy(1501, (function(i) do
                return i + 500 | 0;
              end end)), (function(x, y) do
            return x == y;
          end end)));

eq("File \"bs_mutable_set_test.ml\", line 78, characters 5-12", Belt_internalAVLset.toArray(v.data), Array_data_util.range(500, 2000));

Belt_internalAVLset.checkInvariantInternal(v.data);

eq("File \"bs_mutable_set_test.ml\", line 80, characters 5-12", Belt_internalSetInt.get(v.data, 3), undefined);

eq("File \"bs_mutable_set_test.ml\", line 81, characters 5-12", Belt_internalSetInt.get(v.data, 1200), 1200);

match = Belt_MutableSetInt.split(v, 1000);

match_1 = match[0];

bb = match_1[1];

aa = match_1[0];

b("File \"bs_mutable_set_test.ml\", line 83, characters 4-11", match[1]);

b("File \"bs_mutable_set_test.ml\", line 84, characters 4-11", Belt_Array.eq(Belt_internalAVLset.toArray(aa.data), Array_data_util.range(500, 999), (function(x, y) do
            return x == y;
          end end)));

b("File \"bs_mutable_set_test.ml\", line 85, characters 4-11", Belt_Array.eq(Belt_internalAVLset.toArray(bb.data), Array_data_util.range(1001, 2000), (function(prim, prim_1) do
            return prim == prim_1;
          end end)));

b("File \"bs_mutable_set_test.ml\", line 86, characters 5-12", Belt_MutableSetInt.subset(aa, v));

b("File \"bs_mutable_set_test.ml\", line 87, characters 4-11", Belt_MutableSetInt.subset(bb, v));

b("File \"bs_mutable_set_test.ml\", line 88, characters 4-11", Belt_MutableSetInt.isEmpty(Belt_MutableSetInt.intersect(aa, bb)));

c = Belt_MutableSetInt.removeCheck(v, 1000);

b("File \"bs_mutable_set_test.ml\", line 90, characters 4-11", c);

match_2 = Belt_MutableSetInt.split(v, 1000);

match_3 = match_2[0];

bb_1 = match_3[1];

aa_1 = match_3[0];

b("File \"bs_mutable_set_test.ml\", line 92, characters 4-11", not match_2[1]);

b("File \"bs_mutable_set_test.ml\", line 93, characters 4-11", Belt_Array.eq(Belt_internalAVLset.toArray(aa_1.data), Array_data_util.range(500, 999), (function(prim, prim_1) do
            return prim == prim_1;
          end end)));

b("File \"bs_mutable_set_test.ml\", line 94, characters 4-11", Belt_Array.eq(Belt_internalAVLset.toArray(bb_1.data), Array_data_util.range(1001, 2000), (function(prim, prim_1) do
            return prim == prim_1;
          end end)));

b("File \"bs_mutable_set_test.ml\", line 95, characters 5-12", Belt_MutableSetInt.subset(aa_1, v));

b("File \"bs_mutable_set_test.ml\", line 96, characters 4-11", Belt_MutableSetInt.subset(bb_1, v));

b("File \"bs_mutable_set_test.ml\", line 97, characters 4-11", Belt_MutableSetInt.isEmpty(Belt_MutableSetInt.intersect(aa_1, bb_1)));

xs_2 = Array_data_util.randomRange(0, 100);

aa_2 = do
  data: Belt_internalSetInt.fromArray(xs_2)
end;

xs_3 = Array_data_util.randomRange(40, 120);

bb_2 = do
  data: Belt_internalSetInt.fromArray(xs_3)
end;

cc = Belt_MutableSetInt.union(aa_2, bb_2);

xs_4 = Array_data_util.randomRange(0, 120);

b("File \"bs_mutable_set_test.ml\", line 106, characters 4-11", Belt_MutableSetInt.eq(cc, do
          data: Belt_internalSetInt.fromArray(xs_4)
        end));

xs_5 = Array_data_util.randomRange(0, 20);

xs_6 = Array_data_util.randomRange(21, 40);

xs_7 = Array_data_util.randomRange(0, 40);

b("File \"bs_mutable_set_test.ml\", line 108, characters 4-11", Belt_MutableSetInt.eq(Belt_MutableSetInt.union(do
              data: Belt_internalSetInt.fromArray(xs_5)
            end, do
              data: Belt_internalSetInt.fromArray(xs_6)
            end), do
          data: Belt_internalSetInt.fromArray(xs_7)
        end));

dd = Belt_MutableSetInt.intersect(aa_2, bb_2);

xs_8 = Array_data_util.randomRange(40, 100);

b("File \"bs_mutable_set_test.ml\", line 113, characters 4-11", Belt_MutableSetInt.eq(dd, do
          data: Belt_internalSetInt.fromArray(xs_8)
        end));

xs_9 = Array_data_util.randomRange(0, 20);

xs_10 = Array_data_util.randomRange(21, 40);

b("File \"bs_mutable_set_test.ml\", line 114, characters 4-11", Belt_MutableSetInt.eq(Belt_MutableSetInt.intersect(do
              data: Belt_internalSetInt.fromArray(xs_9)
            end, do
              data: Belt_internalSetInt.fromArray(xs_10)
            end), do
          data: nil
        end));

xs_11 = Array_data_util.randomRange(21, 40);

xs_12 = Array_data_util.randomRange(0, 20);

b("File \"bs_mutable_set_test.ml\", line 120, characters 4-11", Belt_MutableSetInt.eq(Belt_MutableSetInt.intersect(do
              data: Belt_internalSetInt.fromArray(xs_11)
            end, do
              data: Belt_internalSetInt.fromArray(xs_12)
            end), do
          data: nil
        end));

b("File \"bs_mutable_set_test.ml\", line 126, characters 4-11", Belt_MutableSetInt.eq(Belt_MutableSetInt.intersect(do
              data: Belt_internalSetInt.fromArray({
                    1,
                    3,
                    4,
                    5,
                    7,
                    9
                  })
            end, do
              data: Belt_internalSetInt.fromArray({
                    2,
                    4,
                    5,
                    6,
                    8,
                    10
                  })
            end), do
          data: Belt_internalSetInt.fromArray({
                4,
                5
              })
        end));

xs_13 = Array_data_util.randomRange(0, 39);

b("File \"bs_mutable_set_test.ml\", line 132, characters 4-11", Belt_MutableSetInt.eq(Belt_MutableSetInt.diff(aa_2, bb_2), do
          data: Belt_internalSetInt.fromArray(xs_13)
        end));

xs_14 = Array_data_util.randomRange(101, 120);

b("File \"bs_mutable_set_test.ml\", line 134, characters 4-11", Belt_MutableSetInt.eq(Belt_MutableSetInt.diff(bb_2, aa_2), do
          data: Belt_internalSetInt.fromArray(xs_14)
        end));

xs_15 = Array_data_util.randomRange(21, 40);

xs_16 = Array_data_util.randomRange(0, 20);

xs_17 = Array_data_util.randomRange(21, 40);

b("File \"bs_mutable_set_test.ml\", line 136, characters 4-11", Belt_MutableSetInt.eq(Belt_MutableSetInt.diff(do
              data: Belt_internalSetInt.fromArray(xs_15)
            end, do
              data: Belt_internalSetInt.fromArray(xs_16)
            end), do
          data: Belt_internalSetInt.fromArray(xs_17)
        end));

xs_18 = Array_data_util.randomRange(0, 20);

xs_19 = Array_data_util.randomRange(21, 40);

xs_20 = Array_data_util.randomRange(0, 20);

b("File \"bs_mutable_set_test.ml\", line 142, characters 4-11", Belt_MutableSetInt.eq(Belt_MutableSetInt.diff(do
              data: Belt_internalSetInt.fromArray(xs_18)
            end, do
              data: Belt_internalSetInt.fromArray(xs_19)
            end), do
          data: Belt_internalSetInt.fromArray(xs_20)
        end));

xs_21 = Array_data_util.randomRange(0, 20);

xs_22 = Array_data_util.randomRange(0, 40);

xs_23 = Array_data_util.randomRange(0, -1);

b("File \"bs_mutable_set_test.ml\", line 149, characters 4-11", Belt_MutableSetInt.eq(Belt_MutableSetInt.diff(do
              data: Belt_internalSetInt.fromArray(xs_21)
            end, do
              data: Belt_internalSetInt.fromArray(xs_22)
            end), do
          data: Belt_internalSetInt.fromArray(xs_23)
        end));

xs_24 = Array_data_util.randomRange(0, 1000);

a0 = do
  data: Belt_internalSetInt.fromArray(xs_24)
end;

a1 = Belt_MutableSetInt.keep(a0, (function(x) do
        return x % 2 == 0;
      end end));

a2 = Belt_MutableSetInt.keep(a0, (function(x) do
        return x % 2 ~= 0;
      end end));

match_4 = Belt_MutableSetInt.partition(a0, (function(x) do
        return x % 2 == 0;
      end end));

a4 = match_4[1];

a3 = match_4[0];

b("File \"bs_mutable_set_test.ml\", line 164, characters 4-11", Belt_MutableSetInt.eq(a1, a3));

b("File \"bs_mutable_set_test.ml\", line 165, characters 4-11", Belt_MutableSetInt.eq(a2, a4));

Belt_List.forEach(--[[ :: ]]{
      a0,
      --[[ :: ]]{
        a1,
        --[[ :: ]]{
          a2,
          --[[ :: ]]{
            a3,
            --[[ :: ]]{
              a4,
              --[[ [] ]]0
            }
          }
        }
      }
    }, (function(x) do
        return Belt_internalAVLset.checkInvariantInternal(x.data);
      end end));

v_1 = do
  data: nil
end;

for i_2 = 0 , 100000 , 1 do
  Belt_MutableSetInt.add(v_1, i_2);
end

Belt_internalAVLset.checkInvariantInternal(v_1.data);

b("File \"bs_mutable_set_test.ml\", line 178, characters 4-11", Belt_Range.every(0, 100000, (function(i) do
            return Belt_internalSetInt.has(v_1.data, i);
          end end)));

eq("File \"bs_mutable_set_test.ml\", line 181, characters 5-12", Belt_internalAVLset.size(v_1.data), 100001);

u_1 = Belt_Array.concat(Array_data_util.randomRange(30, 100), Array_data_util.randomRange(40, 120));

v_2 = do
  data: nil
end;

Belt_MutableSetInt.mergeMany(v_2, u_1);

eq("File \"bs_mutable_set_test.ml\", line 187, characters 5-12", Belt_internalAVLset.size(v_2.data), 91);

eq("File \"bs_mutable_set_test.ml\", line 188, characters 5-12", Belt_internalAVLset.toArray(v_2.data), Array_data_util.range(30, 120));

u_2 = Belt_Array.concat(Array_data_util.randomRange(0, 100000), Array_data_util.randomRange(0, 100));

v_3 = do
  data: Belt_internalSetInt.fromArray(u_2)
end;

eq("File \"bs_mutable_set_test.ml\", line 193, characters 5-12", Belt_internalAVLset.size(v_3.data), 100001);

u_3 = Array_data_util.randomRange(50000, 80000);

for i_3 = 0 , #u_3 - 1 | 0 , 1 do
  Belt_MutableSetInt.remove(v_3, i_3);
end

eq("File \"bs_mutable_set_test.ml\", line 200, characters 5-12", Belt_internalAVLset.size(v_3.data), 70000);

vv = Array_data_util.randomRange(0, 100000);

for i_4 = 0 , #vv - 1 | 0 , 1 do
  Belt_MutableSetInt.remove(v_3, Caml_array.caml_array_get(vv, i_4));
end

eq("File \"bs_mutable_set_test.ml\", line 206, characters 5-12", Belt_internalAVLset.size(v_3.data), 0);

b("File \"bs_mutable_set_test.ml\", line 207, characters 4-11", Belt_MutableSetInt.isEmpty(v_3));

xs_25 = Belt_Array.makeBy(30, (function(i) do
        return i;
      end end));

v_4 = do
  data: Belt_internalSetInt.fromArray(xs_25)
end;

Belt_MutableSetInt.remove(v_4, 30);

Belt_MutableSetInt.remove(v_4, 29);

b("File \"bs_mutable_set_test.ml\", line 213, characters 4-11", 28 == Belt_internalAVLset.maxUndefined(v_4.data));

Belt_MutableSetInt.remove(v_4, 0);

b("File \"bs_mutable_set_test.ml\", line 215, characters 4-11", 1 == Belt_internalAVLset.minUndefined(v_4.data));

eq("File \"bs_mutable_set_test.ml\", line 216, characters 5-12", Belt_internalAVLset.size(v_4.data), 28);

vv_1 = Array_data_util.randomRange(1, 28);

for i_5 = 0 , #vv_1 - 1 | 0 , 1 do
  Belt_MutableSetInt.remove(v_4, Caml_array.caml_array_get(vv_1, i_5));
end

eq("File \"bs_mutable_set_test.ml\", line 221, characters 5-12", Belt_internalAVLset.size(v_4.data), 0);

function id(loc, x) do
  u = do
    data: Belt_internalAVLset.fromSortedArrayUnsafe(x)
  end;
  Belt_internalAVLset.checkInvariantInternal(u.data);
  return b(loc, Belt_Array.every2(Belt_internalAVLset.toArray(u.data), x, (function(prim, prim_1) do
                    return prim == prim_1;
                  end end)));
end end

id("File \"bs_mutable_set_test.ml\", line 229, characters 5-12", {});

id("File \"bs_mutable_set_test.ml\", line 230, characters 5-12", {0});

id("File \"bs_mutable_set_test.ml\", line 231, characters 5-12", {
      0,
      1
    });

id("File \"bs_mutable_set_test.ml\", line 232, characters 5-12", {
      0,
      1,
      2
    });

id("File \"bs_mutable_set_test.ml\", line 233, characters 5-12", {
      0,
      1,
      2,
      3
    });

id("File \"bs_mutable_set_test.ml\", line 234, characters 5-12", {
      0,
      1,
      2,
      3,
      4
    });

id("File \"bs_mutable_set_test.ml\", line 235, characters 5-12", {
      0,
      1,
      2,
      3,
      4,
      5
    });

id("File \"bs_mutable_set_test.ml\", line 236, characters 5-12", {
      0,
      1,
      2,
      3,
      4,
      6
    });

id("File \"bs_mutable_set_test.ml\", line 237, characters 5-12", {
      0,
      1,
      2,
      3,
      4,
      6,
      7
    });

id("File \"bs_mutable_set_test.ml\", line 238, characters 5-12", {
      0,
      1,
      2,
      3,
      4,
      6,
      7,
      8
    });

id("File \"bs_mutable_set_test.ml\", line 239, characters 5-12", {
      0,
      1,
      2,
      3,
      4,
      6,
      7,
      8,
      9
    });

id("File \"bs_mutable_set_test.ml\", line 240, characters 5-12", Array_data_util.range(0, 1000));

xs_26 = Array_data_util.randomRange(0, 1000);

v_5 = do
  data: Belt_internalSetInt.fromArray(xs_26)
end;

copyV = Belt_MutableSetInt.keep(v_5, (function(x) do
        return x % 8 == 0;
      end end));

match_5 = Belt_MutableSetInt.partition(v_5, (function(x) do
        return x % 8 == 0;
      end end));

cc_1 = Belt_MutableSetInt.keep(v_5, (function(x) do
        return x % 8 ~= 0;
      end end));

for i_6 = 0 , 200 , 1 do
  Belt_MutableSetInt.remove(v_5, i_6);
end

eq("File \"bs_mutable_set_test.ml\", line 250, characters 5-12", Belt_internalAVLset.size(copyV.data), 126);

eq("File \"bs_mutable_set_test.ml\", line 251, characters 5-12", Belt_internalAVLset.toArray(copyV.data), Belt_Array.makeBy(126, (function(i) do
            return (i << 3);
          end end)));

eq("File \"bs_mutable_set_test.ml\", line 252, characters 5-12", Belt_internalAVLset.size(v_5.data), 800);

b("File \"bs_mutable_set_test.ml\", line 253, characters 4-11", Belt_MutableSetInt.eq(copyV, match_5[0]));

b("File \"bs_mutable_set_test.ml\", line 254, characters 4-11", Belt_MutableSetInt.eq(cc_1, match_5[1]));

xs_27 = Array_data_util.randomRange(0, 1000);

v_6 = do
  data: Belt_internalSetInt.fromArray(xs_27)
end;

match_6 = Belt_MutableSetInt.split(v_6, 400);

match_7 = match_6[0];

xs_28 = Array_data_util.randomRange(0, 399);

b("File \"bs_mutable_set_test.ml\", line 259, characters 4-11", Belt_MutableSetInt.eq(match_7[0], do
          data: Belt_internalSetInt.fromArray(xs_28)
        end));

xs_29 = Array_data_util.randomRange(401, 1000);

b("File \"bs_mutable_set_test.ml\", line 260, characters 4-11", Belt_MutableSetInt.eq(match_7[1], do
          data: Belt_internalSetInt.fromArray(xs_29)
        end));

xs_30 = Belt_Array.map(Array_data_util.randomRange(0, 1000), (function(x) do
        return (x << 1);
      end end));

d = do
  data: Belt_internalSetInt.fromArray(xs_30)
end;

match_8 = Belt_MutableSetInt.split(d, 1001);

match_9 = match_8[0];

xs_31 = Belt_Array.makeBy(501, (function(x) do
        return (x << 1);
      end end));

b("File \"bs_mutable_set_test.ml\", line 263, characters 4-11", Belt_MutableSetInt.eq(match_9[0], do
          data: Belt_internalSetInt.fromArray(xs_31)
        end));

xs_32 = Belt_Array.makeBy(500, (function(x) do
        return 1002 + (x << 1) | 0;
      end end));

b("File \"bs_mutable_set_test.ml\", line 264, characters 4-11", Belt_MutableSetInt.eq(match_9[1], do
          data: Belt_internalSetInt.fromArray(xs_32)
        end));

xs_33 = Array_data_util.randomRange(0, 100);

aa_3 = do
  data: Belt_internalSetInt.fromArray(xs_33)
end;

xs_34 = Array_data_util.randomRange(40, 120);

bb_3 = do
  data: Belt_internalSetInt.fromArray(xs_34)
end;

cc_2 = Belt_MutableSetInt.union(aa_3, bb_3);

xs_35 = Array_data_util.randomRange(0, 120);

b("File \"bs_mutable_set_test.ml\", line 274, characters 4-11", Belt_MutableSetInt.eq(cc_2, do
          data: Belt_internalSetInt.fromArray(xs_35)
        end));

xs_36 = Array_data_util.randomRange(0, 20);

xs_37 = Array_data_util.randomRange(21, 40);

xs_38 = Array_data_util.randomRange(0, 40);

b("File \"bs_mutable_set_test.ml\", line 276, characters 4-11", Belt_MutableSetInt.eq(Belt_MutableSetInt.union(do
              data: Belt_internalSetInt.fromArray(xs_36)
            end, do
              data: Belt_internalSetInt.fromArray(xs_37)
            end), do
          data: Belt_internalSetInt.fromArray(xs_38)
        end));

dd_1 = Belt_MutableSetInt.intersect(aa_3, bb_3);

xs_39 = Array_data_util.randomRange(40, 100);

b("File \"bs_mutable_set_test.ml\", line 281, characters 4-11", Belt_MutableSetInt.eq(dd_1, do
          data: Belt_internalSetInt.fromArray(xs_39)
        end));

xs_40 = Array_data_util.randomRange(0, 20);

xs_41 = Array_data_util.randomRange(21, 40);

b("File \"bs_mutable_set_test.ml\", line 282, characters 4-11", Belt_MutableSetInt.eq(Belt_MutableSetInt.intersect(do
              data: Belt_internalSetInt.fromArray(xs_40)
            end, do
              data: Belt_internalSetInt.fromArray(xs_41)
            end), do
          data: nil
        end));

xs_42 = Array_data_util.randomRange(21, 40);

xs_43 = Array_data_util.randomRange(0, 20);

b("File \"bs_mutable_set_test.ml\", line 288, characters 4-11", Belt_MutableSetInt.eq(Belt_MutableSetInt.intersect(do
              data: Belt_internalSetInt.fromArray(xs_42)
            end, do
              data: Belt_internalSetInt.fromArray(xs_43)
            end), do
          data: nil
        end));

b("File \"bs_mutable_set_test.ml\", line 294, characters 4-11", Belt_MutableSetInt.eq(Belt_MutableSetInt.intersect(do
              data: Belt_internalSetInt.fromArray({
                    1,
                    3,
                    4,
                    5,
                    7,
                    9
                  })
            end, do
              data: Belt_internalSetInt.fromArray({
                    2,
                    4,
                    5,
                    6,
                    8,
                    10
                  })
            end), do
          data: Belt_internalSetInt.fromArray({
                4,
                5
              })
        end));

xs_44 = Array_data_util.randomRange(0, 39);

b("File \"bs_mutable_set_test.ml\", line 300, characters 4-11", Belt_MutableSetInt.eq(Belt_MutableSetInt.diff(aa_3, bb_3), do
          data: Belt_internalSetInt.fromArray(xs_44)
        end));

xs_45 = Array_data_util.randomRange(101, 120);

b("File \"bs_mutable_set_test.ml\", line 302, characters 4-11", Belt_MutableSetInt.eq(Belt_MutableSetInt.diff(bb_3, aa_3), do
          data: Belt_internalSetInt.fromArray(xs_45)
        end));

xs_46 = Array_data_util.randomRange(21, 40);

xs_47 = Array_data_util.randomRange(0, 20);

xs_48 = Array_data_util.randomRange(21, 40);

b("File \"bs_mutable_set_test.ml\", line 304, characters 4-11", Belt_MutableSetInt.eq(Belt_MutableSetInt.diff(do
              data: Belt_internalSetInt.fromArray(xs_46)
            end, do
              data: Belt_internalSetInt.fromArray(xs_47)
            end), do
          data: Belt_internalSetInt.fromArray(xs_48)
        end));

xs_49 = Array_data_util.randomRange(0, 20);

xs_50 = Array_data_util.randomRange(21, 40);

xs_51 = Array_data_util.randomRange(0, 20);

b("File \"bs_mutable_set_test.ml\", line 310, characters 4-11", Belt_MutableSetInt.eq(Belt_MutableSetInt.diff(do
              data: Belt_internalSetInt.fromArray(xs_49)
            end, do
              data: Belt_internalSetInt.fromArray(xs_50)
            end), do
          data: Belt_internalSetInt.fromArray(xs_51)
        end));

xs_52 = Array_data_util.randomRange(0, 20);

xs_53 = Array_data_util.randomRange(0, 40);

xs_54 = Array_data_util.randomRange(0, -1);

b("File \"bs_mutable_set_test.ml\", line 317, characters 4-11", Belt_MutableSetInt.eq(Belt_MutableSetInt.diff(do
              data: Belt_internalSetInt.fromArray(xs_52)
            end, do
              data: Belt_internalSetInt.fromArray(xs_53)
            end), do
          data: Belt_internalSetInt.fromArray(xs_54)
        end));

Mt.from_pair_suites("Bs_mutable_set_test", suites.contents);

N = --[[ alias ]]0;

I = --[[ alias ]]0;

R = --[[ alias ]]0;

A = --[[ alias ]]0;

L = --[[ alias ]]0;

empty = Belt_MutableSetInt.make;

fromArray = Belt_MutableSetInt.fromArray;

$plus$plus = Belt_MutableSetInt.union;

f = Belt_MutableSetInt.fromArray;

$eq$tilde = Belt_MutableSetInt.eq;

exports = {}
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.b = b;
exports.N = N;
exports.I = I;
exports.R = R;
exports.A = A;
exports.L = L;
exports.empty = empty;
exports.fromArray = fromArray;
exports.$plus$plus = $plus$plus;
exports.f = f;
exports.$eq$tilde = $eq$tilde;
--[[ u Not a pure module ]]
