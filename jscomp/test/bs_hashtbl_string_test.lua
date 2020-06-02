--[['use strict';]]

Belt_Id = require "../../lib/js/belt_Id.lua";
Hashtbl = require "../../lib/js/hashtbl.lua";
Belt_HashMap = require "../../lib/js/belt_HashMap.lua";
Belt_MapDict = require "../../lib/js/belt_MapDict.lua";
Caml_primitive = require "../../lib/js/caml_primitive.lua";
Belt_HashMapInt = require "../../lib/js/belt_HashMapInt.lua";
Belt_HashSetInt = require "../../lib/js/belt_HashSetInt.lua";
Belt_HashMapString = require "../../lib/js/belt_HashMapString.lua";
Caml_hash_primitive = require "../../lib/js/caml_hash_primitive.lua";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions.lua";
Belt_internalBucketsType = require "../../lib/js/belt_internalBucketsType.lua";

function hash_string(s) do
  return Caml_hash_primitive.caml_hash_final_mix(Caml_hash_primitive.caml_hash_mix_string(0, s));
end end

function hashString (str)do 
                                              var hash = 5381,
                                              i    = str.length | 0;

                                              while(i !== 0) {
                                              hash = (hash * 33) ^ str.charCodeAt(--i);
                                              }
                                              return hash
                                              
                                            end;

__String = Belt_Id.hashable(Hashtbl.hash, (function (x, y) do
        return x == y;
      end end));

String1 = Belt_Id.hashable(hashString, (function (x, y) do
        return x == y;
      end end));

String2 = Belt_Id.hashable((function (x) do
        return Caml_hash_primitive.caml_hash_final_mix(Caml_hash_primitive.caml_hash_mix_string(0, x));
      end end), (function (x, y) do
        return x == y;
      end end));

Int = Belt_Id.hashable(Hashtbl.hash, (function (x, y) do
        return x == y;
      end end));

empty = Belt_internalBucketsType.make(Int.hash, Int.eq, 500000);

function bench(param) do
  for i = 0 , 1000000 , 1 do
    Belt_HashMap.set(empty, i, i);
  end
  for i$1 = 0 , 1000000 , 1 do
    if (not Belt_HashMap.has(empty, i$1)) then do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[[ tuple ]][
              "bs_hashtbl_string_test.ml",
              50,
              4
            ]
          ];
    end
     end 
  end
  return Belt_HashMap.logStats(empty);
end end

function bench2(m) do
  empty = Belt_internalBucketsType.make(m.hash, m.eq, 1000000);
  for i = 0 , 1000000 , 1 do
    Belt_HashMap.set(empty, String(i), i);
  end
  for i$1 = 0 , 1000000 , 1 do
    if (not Belt_HashMap.has(empty, String(i$1))) then do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[[ tuple ]][
              "bs_hashtbl_string_test.ml",
              76,
              4
            ]
          ];
    end
     end 
  end
  for i$2 = 0 , 1000000 , 1 do
    Belt_HashMap.remove(empty, String(i$2));
  end
  if (empty.size == 0) then do
    return 0;
  end else do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]][
            "bs_hashtbl_string_test.ml",
            82,
            2
          ]
        ];
  end end 
end end

function bench3(m) do
  empty = do
    cmp: m.cmp,
    data: Belt_MapDict.empty
  end;
  cmp = m.cmp;
  table = empty.data;
  for i = 0 , 1000000 , 1 do
    table = Belt_MapDict.set(table, String(i), i, cmp);
  end
  for i$1 = 0 , 1000000 , 1 do
    if (not Belt_MapDict.has(table, String(i$1), cmp)) then do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[[ tuple ]][
              "bs_hashtbl_string_test.ml",
              98,
              4
            ]
          ];
    end
     end 
  end
  for i$2 = 0 , 1000000 , 1 do
    table = Belt_MapDict.remove(table, String(i$2), cmp);
  end
  if (Belt_MapDict.size(table) == 0) then do
    return 0;
  end else do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]][
            "bs_hashtbl_string_test.ml",
            105,
            2
          ]
        ];
  end end 
end end

Sx = Belt_Id.comparable(Caml_primitive.caml_string_compare);

function bench4(param) do
  table = Belt_internalBucketsType.make(--[[ () ]]0, --[[ () ]]0, 1000000);
  for i = 0 , 1000000 , 1 do
    Belt_HashMapString.set(table, String(i), i);
  end
  for i$1 = 0 , 1000000 , 1 do
    if (not Belt_HashMapString.has(table, String(i$1))) then do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[[ tuple ]][
              "bs_hashtbl_string_test.ml",
              118,
              4
            ]
          ];
    end
     end 
  end
  for i$2 = 0 , 1000000 , 1 do
    Belt_HashMapString.remove(table, String(i$2));
  end
  if (Belt_HashMapString.isEmpty(table)) then do
    return 0;
  end else do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]][
            "bs_hashtbl_string_test.ml",
            124,
            2
          ]
        ];
  end end 
end end

function bench5(param) do
  table = Belt_internalBucketsType.make(Int.hash, Int.eq, 1000000);
  console.time("test/bs_hashtbl_string_test.ml 133");
  for i = 0 , 1000000 , 1 do
    Belt_HashMap.set(table, i, i);
  end
  console.timeEnd("test/bs_hashtbl_string_test.ml 133");
  console.time("test/bs_hashtbl_string_test.ml 137");
  for i$1 = 0 , 1000000 , 1 do
    if (not Belt_HashMap.has(table, i$1)) then do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[[ tuple ]][
              "bs_hashtbl_string_test.ml",
              138,
              6
            ]
          ];
    end
     end 
  end
  console.timeEnd("test/bs_hashtbl_string_test.ml 137");
  console.time("test/bs_hashtbl_string_test.ml 141");
  for i$2 = 0 , 1000000 , 1 do
    Belt_HashMap.remove(table, i$2);
  end
  console.timeEnd("test/bs_hashtbl_string_test.ml 141");
  if (Belt_HashMap.isEmpty(table)) then do
    return 0;
  end else do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]][
            "bs_hashtbl_string_test.ml",
            144,
            2
          ]
        ];
  end end 
end end

function bench6(param) do
  table = Belt_internalBucketsType.make(--[[ () ]]0, --[[ () ]]0, 1000000);
  for i = 0 , 1000000 , 1 do
    Belt_HashMapInt.set(table, i, i);
  end
  for i$1 = 0 , 1000000 , 1 do
    if (not Belt_HashMapInt.has(table, i$1)) then do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[[ tuple ]][
              "bs_hashtbl_string_test.ml",
              156,
              4
            ]
          ];
    end
     end 
  end
  for i$2 = 0 , 1000000 , 1 do
    Belt_HashMapInt.remove(table, i$2);
  end
  if (table.size == 0) then do
    return 0;
  end else do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]][
            "bs_hashtbl_string_test.ml",
            162,
            2
          ]
        ];
  end end 
end end

function bench7(param) do
  hintSize = 2000000;
  table = Belt_internalBucketsType.make(--[[ () ]]0, --[[ () ]]0, hintSize);
  for i = 0 , 1000000 , 1 do
    Belt_HashSetInt.add(table, i);
  end
  for i$1 = 0 , 1000000 , 1 do
    if (not Belt_HashSetInt.has(table, i$1)) then do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[[ tuple ]][
              "bs_hashtbl_string_test.ml",
              181,
              4
            ]
          ];
    end
     end 
  end
  for i$2 = 0 , 1000000 , 1 do
    Belt_HashSetInt.remove(table, i$2);
  end
  if (table.size == 0) then do
    return 0;
  end else do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]][
            "bs_hashtbl_string_test.ml",
            192,
            2
          ]
        ];
  end end 
end end

console.time("test/bs_hashtbl_string_test.ml 203");

bench7(--[[ () ]]0);

console.timeEnd("test/bs_hashtbl_string_test.ml 203");

N = --[[ alias ]]0;

count = 1000000;

initial_size = 1000000;

M = --[[ alias ]]0;

Md = --[[ alias ]]0;

Md0 = --[[ alias ]]0;

H = --[[ alias ]]0;

H0 = --[[ alias ]]0;

HI = --[[ alias ]]0;

S = --[[ alias ]]0;

exports.hash_string = hash_string;
exports.hashString = hashString;
exports.__String = __String;
exports.String1 = String1;
exports.String2 = String2;
exports.Int = Int;
exports.N = N;
exports.empty = empty;
exports.bench = bench;
exports.count = count;
exports.initial_size = initial_size;
exports.M = M;
exports.bench2 = bench2;
exports.Md = Md;
exports.Md0 = Md0;
exports.bench3 = bench3;
exports.Sx = Sx;
exports.H = H;
exports.bench4 = bench4;
exports.H0 = H0;
exports.bench5 = bench5;
exports.HI = HI;
exports.bench6 = bench6;
exports.S = S;
exports.bench7 = bench7;
--[[ String Not a pure module ]]
