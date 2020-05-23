'use strict';

var Caml_array = require("../../lib/js/caml_array.js");
var Caml_int32 = require("../../lib/js/caml_int32.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

function $$eval(_bdd, vars) do
  while(true) do
    var bdd = _bdd;
    if (typeof bdd == "number") do
      return bdd == 0;
    end else if (Caml_array.caml_array_get(vars, bdd[1])) do
      _bdd = bdd[3];
      continue ;
    end else do
      _bdd = bdd[0];
      continue ;
    end
  end;
end

function getId(bdd) do
  if (typeof bdd == "number") do
    if (bdd ~= 0) do
      return 0;
    end else do
      return 1;
    end
  end else do
    return bdd[2];
  end
end

var nodeC = do
  contents: 1
end;

var sz_1 = do
  contents: 8191
end;

var htab = do
  contents: Caml_array.caml_make_vect(sz_1.contents + 1 | 0, --[ [] ]--0)
end;

var n_items = do
  contents: 0
end;

function hashVal(x, y, v) do
  return ((x << 1) + y | 0) + (v << 2) | 0;
end

function resize(newSize) do
  var arr = htab.contents;
  var newSz_1 = newSize - 1 | 0;
  var newArr = Caml_array.caml_make_vect(newSize, --[ [] ]--0);
  var copyBucket = function (_bucket) do
    while(true) do
      var bucket = _bucket;
      if (bucket) do
        var n = bucket[0];
        if (typeof n == "number") do
          throw [
                Caml_builtin_exceptions.assert_failure,
                --[ tuple ]--[
                  "bdd.ml",
                  54,
                  27
                ]
              ];
        end
        var ind = hashVal(getId(n[0]), getId(n[3]), n[1]) & newSz_1;
        Caml_array.caml_array_set(newArr, ind, --[ :: ]--[
              n,
              Caml_array.caml_array_get(newArr, ind)
            ]);
        _bucket = bucket[1];
        continue ;
      end else do
        return --[ () ]--0;
      end
    end;
  end;
  for(var n = 0 ,n_finish = sz_1.contents; n <= n_finish; ++n)do
    copyBucket(Caml_array.caml_array_get(arr, n));
  end
  htab.contents = newArr;
  sz_1.contents = newSz_1;
  return --[ () ]--0;
end

function insert(idl, idh, v, ind, bucket, newNode) do
  if (n_items.contents <= sz_1.contents) do
    Caml_array.caml_array_set(htab.contents, ind, --[ :: ]--[
          newNode,
          bucket
        ]);
    n_items.contents = n_items.contents + 1 | 0;
    return --[ () ]--0;
  end else do
    resize((sz_1.contents + sz_1.contents | 0) + 2 | 0);
    var ind$1 = hashVal(idl, idh, v) & sz_1.contents;
    return Caml_array.caml_array_set(htab.contents, ind$1, --[ :: ]--[
                newNode,
                Caml_array.caml_array_get(htab.contents, ind$1)
              ]);
  end
end

function resetUnique(param) do
  sz_1.contents = 8191;
  htab.contents = Caml_array.caml_make_vect(sz_1.contents + 1 | 0, --[ [] ]--0);
  n_items.contents = 0;
  nodeC.contents = 1;
  return --[ () ]--0;
end

function mkNode(low, v, high) do
  var idl = getId(low);
  var idh = getId(high);
  if (idl == idh) do
    return low;
  end else do
    var ind = hashVal(idl, idh, v) & sz_1.contents;
    var bucket = Caml_array.caml_array_get(htab.contents, ind);
    var _b = bucket;
    while(true) do
      var b = _b;
      if (b) do
        var n = b[0];
        if (typeof n == "number") do
          throw [
                Caml_builtin_exceptions.assert_failure,
                --[ tuple ]--[
                  "bdd.ml",
                  99,
                  31
                ]
              ];
        end
        if (v == n[1] and idl == getId(n[0]) and idh == getId(n[3])) do
          return n;
        end else do
          _b = b[1];
          continue ;
        end
      end else do
        var n_002 = (nodeC.contents = nodeC.contents + 1 | 0, nodeC.contents);
        var n$1 = --[ Node ]--[
          low,
          v,
          n_002,
          high
        ];
        insert(getId(low), getId(high), v, ind, bucket, n$1);
        return n$1;
      end
    end;
  end
end

function cmpVar(x, y) do
  if (x < y) do
    return --[ LESS ]--0;
  end else if (x > y) do
    return --[ GREATER ]--2;
  end else do
    return --[ EQUAL ]--1;
  end
end

function mkVar(x) do
  return mkNode(--[ Zero ]--1, x, --[ One ]--0);
end

var andslot1 = Caml_array.caml_make_vect(1999, 0);

var andslot2 = Caml_array.caml_make_vect(1999, 0);

var andslot3 = Caml_array.caml_make_vect(1999, --[ Zero ]--1);

var xorslot1 = Caml_array.caml_make_vect(1999, 0);

var xorslot2 = Caml_array.caml_make_vect(1999, 0);

var xorslot3 = Caml_array.caml_make_vect(1999, --[ Zero ]--1);

var notslot1 = Caml_array.caml_make_vect(1999, 0);

var notslot2 = Caml_array.caml_make_vect(1999, --[ One ]--0);

function hash(x, y) do
  return ((x << 1) + y | 0) % 1999;
end

function not(n) do
  if (typeof n == "number") do
    if (n ~= 0) do
      return --[ One ]--0;
    end else do
      return --[ Zero ]--1;
    end
  end else do
    var id = n[2];
    var h = id % 1999;
    if (id == Caml_array.caml_array_get(notslot1, h)) do
      return Caml_array.caml_array_get(notslot2, h);
    end else do
      var f = mkNode(not(n[0]), n[1], not(n[3]));
      Caml_array.caml_array_set(notslot1, h, id);
      Caml_array.caml_array_set(notslot2, h, f);
      return f;
    end
  end
end

function and2(n1, n2) do
  if (typeof n1 == "number") do
    if (n1 ~= 0) do
      return --[ Zero ]--1;
    end else do
      return n2;
    end
  end else do
    var r1 = n1[3];
    var i1 = n1[2];
    var v1 = n1[1];
    var l1 = n1[0];
    if (typeof n2 == "number") do
      if (n2 ~= 0) do
        return --[ Zero ]--1;
      end else do
        return n1;
      end
    end else do
      var r2 = n2[3];
      var i2 = n2[2];
      var v2 = n2[1];
      var l2 = n2[0];
      var h = hash(i1, i2);
      if (i1 == Caml_array.caml_array_get(andslot1, h) and i2 == Caml_array.caml_array_get(andslot2, h)) do
        return Caml_array.caml_array_get(andslot3, h);
      end else do
        var match = cmpVar(v1, v2);
        var f;
        switch (match) do
          case --[ LESS ]--0 :
              f = mkNode(and2(l1, n2), v1, and2(r1, n2));
              break;
          case --[ EQUAL ]--1 :
              f = mkNode(and2(l1, l2), v1, and2(r1, r2));
              break;
          case --[ GREATER ]--2 :
              f = mkNode(and2(n1, l2), v2, and2(n1, r2));
              break;
          
        end
        Caml_array.caml_array_set(andslot1, h, i1);
        Caml_array.caml_array_set(andslot2, h, i2);
        Caml_array.caml_array_set(andslot3, h, f);
        return f;
      end
    end
  end
end

function xor(n1, n2) do
  if (typeof n1 == "number") do
    if (n1 ~= 0) do
      return n2;
    end else do
      return not(n2);
    end
  end else do
    var r1 = n1[3];
    var i1 = n1[2];
    var v1 = n1[1];
    var l1 = n1[0];
    if (typeof n2 == "number") do
      if (n2 ~= 0) do
        return n1;
      end else do
        return not(n1);
      end
    end else do
      var r2 = n2[3];
      var i2 = n2[2];
      var v2 = n2[1];
      var l2 = n2[0];
      var h = hash(i1, i2);
      if (i1 == Caml_array.caml_array_get(andslot1, h) and i2 == Caml_array.caml_array_get(andslot2, h)) do
        return Caml_array.caml_array_get(andslot3, h);
      end else do
        var match = cmpVar(v1, v2);
        var f;
        switch (match) do
          case --[ LESS ]--0 :
              f = mkNode(xor(l1, n2), v1, xor(r1, n2));
              break;
          case --[ EQUAL ]--1 :
              f = mkNode(xor(l1, l2), v1, xor(r1, r2));
              break;
          case --[ GREATER ]--2 :
              f = mkNode(xor(n1, l2), v2, xor(n1, r2));
              break;
          
        end
        Caml_array.caml_array_set(andslot1, h, i1);
        Caml_array.caml_array_set(andslot2, h, i2);
        Caml_array.caml_array_set(andslot3, h, f);
        return f;
      end
    end
  end
end

function hwb(n) do
  var h = function (i, j) do
    if (i == j) do
      return mkNode(--[ Zero ]--1, i, --[ One ]--0);
    end else do
      return xor(and2(not(mkNode(--[ Zero ]--1, j, --[ One ]--0)), h(i, j - 1 | 0)), and2(mkNode(--[ Zero ]--1, j, --[ One ]--0), g(i, j - 1 | 0)));
    end
  end;
  var g = function (i, j) do
    if (i == j) do
      return mkNode(--[ Zero ]--1, i, --[ One ]--0);
    end else do
      return xor(and2(not(mkNode(--[ Zero ]--1, i, --[ One ]--0)), h(i + 1 | 0, j)), and2(mkNode(--[ Zero ]--1, i, --[ One ]--0), g(i + 1 | 0, j)));
    end
  end;
  return h(0, n - 1 | 0);
end

var seed = do
  contents: 0
end;

function random(param) do
  seed.contents = Caml_int32.imul(seed.contents, 25173) + 17431 | 0;
  return (seed.contents & 1) > 0;
end

function random_vars(n) do
  var vars = Caml_array.caml_make_vect(n, false);
  for(var i = 0 ,i_finish = n - 1 | 0; i <= i_finish; ++i)do
    Caml_array.caml_array_set(vars, i, random(--[ () ]--0));
  end
  return vars;
end

function bool_equal(a, b) do
  if (a) do
    if (b) do
      return true;
    end else do
      return false;
    end
  end else if (b) do
    return false;
  end else do
    return true;
  end
end

function test_hwb(bdd, vars) do
  var ntrue = 0;
  for(var i = 0 ,i_finish = #vars - 1 | 0; i <= i_finish; ++i)do
    if (Caml_array.caml_array_get(vars, i)) do
      ntrue = ntrue + 1 | 0;
    end
    
  end
  return bool_equal($$eval(bdd, vars), ntrue > 0 ? Caml_array.caml_array_get(vars, ntrue - 1 | 0) : false);
end

function main(param) do
  var bdd = hwb(22);
  var succeeded = true;
  for(var i = 1; i <= 100; ++i)do
    succeeded = succeeded and test_hwb(bdd, random_vars(22));
  end
  if (succeeded) do
    return 0;
  end else do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "bdd.ml",
            233,
            2
          ]
        ];
  end
end

main(--[ () ]--0);

var initSize_1 = 8191;

var zero = --[ Zero ]--1;

var one = --[ One ]--0;

var cacheSize = 1999;

exports.$$eval = $$eval;
exports.getId = getId;
exports.initSize_1 = initSize_1;
exports.nodeC = nodeC;
exports.sz_1 = sz_1;
exports.htab = htab;
exports.n_items = n_items;
exports.hashVal = hashVal;
exports.resize = resize;
exports.insert = insert;
exports.resetUnique = resetUnique;
exports.mkNode = mkNode;
exports.cmpVar = cmpVar;
exports.zero = zero;
exports.one = one;
exports.mkVar = mkVar;
exports.cacheSize = cacheSize;
exports.andslot1 = andslot1;
exports.andslot2 = andslot2;
exports.andslot3 = andslot3;
exports.xorslot1 = xorslot1;
exports.xorslot2 = xorslot2;
exports.xorslot3 = xorslot3;
exports.notslot1 = notslot1;
exports.notslot2 = notslot2;
exports.hash = hash;
exports.not = not;
exports.and2 = and2;
exports.xor = xor;
exports.hwb = hwb;
exports.seed = seed;
exports.random = random;
exports.random_vars = random_vars;
exports.bool_equal = bool_equal;
exports.test_hwb = test_hwb;
exports.main = main;
--[  Not a pure module ]--
