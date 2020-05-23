'use strict';

var Belt_Id = require("../../lib/js/belt_Id.js");
var Hashtbl = require("../../lib/js/hashtbl.js");
var Belt_HashMap = require("../../lib/js/belt_HashMap.js");
var Belt_MapDict = require("../../lib/js/belt_MapDict.js");
var Caml_primitive = require("../../lib/js/caml_primitive.js");
var Belt_HashMapInt = require("../../lib/js/belt_HashMapInt.js");
var Belt_HashSetInt = require("../../lib/js/belt_HashSetInt.js");
var Belt_HashMapString = require("../../lib/js/belt_HashMapString.js");
var Caml_hash_primitive = require("../../lib/js/caml_hash_primitive.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");
var Belt_internalBucketsType = require("../../lib/js/belt_internalBucketsType.js");

function hash_string(s) do
  return Caml_hash_primitive.caml_hash_final_mix(Caml_hash_primitive.caml_hash_mix_string(0, s));
end

function hashString (str)do 
                                              var hash = 5381,
                                              i    = str.length | 0;

                                              while(i !== 0) {
                                              hash = (hash * 33) ^ str.charCodeAt(--i);
                                              }
                                              return hash
                                              
                                            end;

var $$String = Belt_Id.hashable(Hashtbl.hash, (function (x, y) do
        return x == y;
      end));

var String1 = Belt_Id.hashable(hashString, (function (x, y) do
        return x == y;
      end));

var String2 = Belt_Id.hashable((function (x) do
        return Caml_hash_primitive.caml_hash_final_mix(Caml_hash_primitive.caml_hash_mix_string(0, x));
      end), (function (x, y) do
        return x == y;
      end));

var Int = Belt_Id.hashable(Hashtbl.hash, (function (x, y) do
        return x == y;
      end));

var empty = Belt_internalBucketsType.make(Int.hash, Int.eq, 500000);

function bench(param) do
  for(var i = 0; i <= 1000000; ++i)do
    Belt_HashMap.set(empty, i, i);
  end
  for(var i$1 = 0; i$1 <= 1000000; ++i$1)do
    if (!Belt_HashMap.has(empty, i$1)) do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[ tuple ]--[
              "bs_hashtbl_string_test.ml",
              50,
              4
            ]
          ];
    end
    
  end
  return Belt_HashMap.logStats(empty);
end

function bench2(m) do
  var empty = Belt_internalBucketsType.make(m.hash, m.eq, 1000000);
  for(var i = 0; i <= 1000000; ++i)do
    Belt_HashMap.set(empty, String(i), i);
  end
  for(var i$1 = 0; i$1 <= 1000000; ++i$1)do
    if (!Belt_HashMap.has(empty, String(i$1))) do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[ tuple ]--[
              "bs_hashtbl_string_test.ml",
              76,
              4
            ]
          ];
    end
    
  end
  for(var i$2 = 0; i$2 <= 1000000; ++i$2)do
    Belt_HashMap.remove(empty, String(i$2));
  end
  if (empty.size == 0) do
    return 0;
  end else do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "bs_hashtbl_string_test.ml",
            82,
            2
          ]
        ];
  end
end

function bench3(m) do
  var empty = do
    cmp: m.cmp,
    data: Belt_MapDict.empty
  end;
  var cmp = m.cmp;
  var table = empty.data;
  for(var i = 0; i <= 1000000; ++i)do
    table = Belt_MapDict.set(table, String(i), i, cmp);
  end
  for(var i$1 = 0; i$1 <= 1000000; ++i$1)do
    if (!Belt_MapDict.has(table, String(i$1), cmp)) do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[ tuple ]--[
              "bs_hashtbl_string_test.ml",
              98,
              4
            ]
          ];
    end
    
  end
  for(var i$2 = 0; i$2 <= 1000000; ++i$2)do
    table = Belt_MapDict.remove(table, String(i$2), cmp);
  end
  if (Belt_MapDict.size(table) == 0) do
    return 0;
  end else do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "bs_hashtbl_string_test.ml",
            105,
            2
          ]
        ];
  end
end

var Sx = Belt_Id.comparable(Caml_primitive.caml_string_compare);

function bench4(param) do
  var table = Belt_internalBucketsType.make(--[ () ]--0, --[ () ]--0, 1000000);
  for(var i = 0; i <= 1000000; ++i)do
    Belt_HashMapString.set(table, String(i), i);
  end
  for(var i$1 = 0; i$1 <= 1000000; ++i$1)do
    if (!Belt_HashMapString.has(table, String(i$1))) do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[ tuple ]--[
              "bs_hashtbl_string_test.ml",
              118,
              4
            ]
          ];
    end
    
  end
  for(var i$2 = 0; i$2 <= 1000000; ++i$2)do
    Belt_HashMapString.remove(table, String(i$2));
  end
  if (Belt_HashMapString.isEmpty(table)) do
    return 0;
  end else do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "bs_hashtbl_string_test.ml",
            124,
            2
          ]
        ];
  end
end

function bench5(param) do
  var table = Belt_internalBucketsType.make(Int.hash, Int.eq, 1000000);
  console.time("test/bs_hashtbl_string_test.ml 133");
  for(var i = 0; i <= 1000000; ++i)do
    Belt_HashMap.set(table, i, i);
  end
  console.timeEnd("test/bs_hashtbl_string_test.ml 133");
  console.time("test/bs_hashtbl_string_test.ml 137");
  for(var i$1 = 0; i$1 <= 1000000; ++i$1)do
    if (!Belt_HashMap.has(table, i$1)) do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[ tuple ]--[
              "bs_hashtbl_string_test.ml",
              138,
              6
            ]
          ];
    end
    
  end
  console.timeEnd("test/bs_hashtbl_string_test.ml 137");
  console.time("test/bs_hashtbl_string_test.ml 141");
  for(var i$2 = 0; i$2 <= 1000000; ++i$2)do
    Belt_HashMap.remove(table, i$2);
  end
  console.timeEnd("test/bs_hashtbl_string_test.ml 141");
  if (Belt_HashMap.isEmpty(table)) do
    return 0;
  end else do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "bs_hashtbl_string_test.ml",
            144,
            2
          ]
        ];
  end
end

function bench6(param) do
  var table = Belt_internalBucketsType.make(--[ () ]--0, --[ () ]--0, 1000000);
  for(var i = 0; i <= 1000000; ++i)do
    Belt_HashMapInt.set(table, i, i);
  end
  for(var i$1 = 0; i$1 <= 1000000; ++i$1)do
    if (!Belt_HashMapInt.has(table, i$1)) do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[ tuple ]--[
              "bs_hashtbl_string_test.ml",
              156,
              4
            ]
          ];
    end
    
  end
  for(var i$2 = 0; i$2 <= 1000000; ++i$2)do
    Belt_HashMapInt.remove(table, i$2);
  end
  if (table.size == 0) do
    return 0;
  end else do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "bs_hashtbl_string_test.ml",
            162,
            2
          ]
        ];
  end
end

function bench7(param) do
  var hintSize = 2000000;
  var table = Belt_internalBucketsType.make(--[ () ]--0, --[ () ]--0, hintSize);
  for(var i = 0; i <= 1000000; ++i)do
    Belt_HashSetInt.add(table, i);
  end
  for(var i$1 = 0; i$1 <= 1000000; ++i$1)do
    if (!Belt_HashSetInt.has(table, i$1)) do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[ tuple ]--[
              "bs_hashtbl_string_test.ml",
              181,
              4
            ]
          ];
    end
    
  end
  for(var i$2 = 0; i$2 <= 1000000; ++i$2)do
    Belt_HashSetInt.remove(table, i$2);
  end
  if (table.size == 0) do
    return 0;
  end else do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "bs_hashtbl_string_test.ml",
            192,
            2
          ]
        ];
  end
end

console.time("test/bs_hashtbl_string_test.ml 203");

bench7(--[ () ]--0);

console.timeEnd("test/bs_hashtbl_string_test.ml 203");

var N = --[ alias ]--0;

var count = 1000000;

var initial_size = 1000000;

var M = --[ alias ]--0;

var Md = --[ alias ]--0;

var Md0 = --[ alias ]--0;

var H = --[ alias ]--0;

var H0 = --[ alias ]--0;

var HI = --[ alias ]--0;

var S = --[ alias ]--0;

exports.hash_string = hash_string;
exports.hashString = hashString;
exports.$$String = $$String;
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
--[ String Not a pure module ]--
