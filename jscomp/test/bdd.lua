--[['use strict';]]

Caml_array = require "../../lib/js/caml_array";
Caml_int32 = require "../../lib/js/caml_int32";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

function __eval(_bdd, vars) do
  while(true) do
    bdd = _bdd;
    if (typeof bdd == "number") then do
      return bdd == 0;
    end else if (Caml_array.caml_array_get(vars, bdd[1])) then do
      _bdd = bdd[3];
      ::continue:: ;
    end else do
      _bdd = bdd[0];
      ::continue:: ;
    end end  end 
  end;
end end

function getId(bdd) do
  if (typeof bdd == "number") then do
    if (bdd ~= 0) then do
      return 0;
    end else do
      return 1;
    end end 
  end else do
    return bdd[2];
  end end 
end end

nodeC = do
  contents: 1
end;

sz_1 = do
  contents: 8191
end;

htab = do
  contents: Caml_array.caml_make_vect(sz_1.contents + 1 | 0, --[[ [] ]]0)
end;

n_items = do
  contents: 0
end;

function hashVal(x, y, v) do
  return ((x << 1) + y | 0) + (v << 2) | 0;
end end

function resize(newSize) do
  arr = htab.contents;
  newSz_1 = newSize - 1 | 0;
  newArr = Caml_array.caml_make_vect(newSize, --[[ [] ]]0);
  copyBucket = function (_bucket) do
    while(true) do
      bucket = _bucket;
      if (bucket) then do
        n = bucket[0];
        if (typeof n == "number") then do
          error({
            Caml_builtin_exceptions.assert_failure,
            --[[ tuple ]]{
              "bdd.ml",
              54,
              27
            }
          })
        end
         end 
        ind = hashVal(getId(n[0]), getId(n[3]), n[1]) & newSz_1;
        Caml_array.caml_array_set(newArr, ind, --[[ :: ]]{
              n,
              Caml_array.caml_array_get(newArr, ind)
            });
        _bucket = bucket[1];
        ::continue:: ;
      end else do
        return --[[ () ]]0;
      end end 
    end;
  end end;
  for n = 0 , sz_1.contents , 1 do
    copyBucket(Caml_array.caml_array_get(arr, n));
  end
  htab.contents = newArr;
  sz_1.contents = newSz_1;
  return --[[ () ]]0;
end end

function insert(idl, idh, v, ind, bucket, newNode) do
  if (n_items.contents <= sz_1.contents) then do
    Caml_array.caml_array_set(htab.contents, ind, --[[ :: ]]{
          newNode,
          bucket
        });
    n_items.contents = n_items.contents + 1 | 0;
    return --[[ () ]]0;
  end else do
    resize((sz_1.contents + sz_1.contents | 0) + 2 | 0);
    ind_1 = hashVal(idl, idh, v) & sz_1.contents;
    return Caml_array.caml_array_set(htab.contents, ind_1, --[[ :: ]]{
                newNode,
                Caml_array.caml_array_get(htab.contents, ind_1)
              });
  end end 
end end

function resetUnique(param) do
  sz_1.contents = 8191;
  htab.contents = Caml_array.caml_make_vect(sz_1.contents + 1 | 0, --[[ [] ]]0);
  n_items.contents = 0;
  nodeC.contents = 1;
  return --[[ () ]]0;
end end

function mkNode(low, v, high) do
  idl = getId(low);
  idh = getId(high);
  if (idl == idh) then do
    return low;
  end else do
    ind = hashVal(idl, idh, v) & sz_1.contents;
    bucket = Caml_array.caml_array_get(htab.contents, ind);
    _b = bucket;
    while(true) do
      b = _b;
      if (b) then do
        n = b[0];
        if (typeof n == "number") then do
          error({
            Caml_builtin_exceptions.assert_failure,
            --[[ tuple ]]{
              "bdd.ml",
              99,
              31
            }
          })
        end
         end 
        if (v == n[1] and idl == getId(n[0]) and idh == getId(n[3])) then do
          return n;
        end else do
          _b = b[1];
          ::continue:: ;
        end end 
      end else do
        n_002 = (nodeC.contents = nodeC.contents + 1 | 0, nodeC.contents);
        n_1 = --[[ Node ]]{
          low,
          v,
          n_002,
          high
        };
        insert(getId(low), getId(high), v, ind, bucket, n_1);
        return n_1;
      end end 
    end;
  end end 
end end

function cmpVar(x, y) do
  if (x < y) then do
    return --[[ LESS ]]0;
  end else if (x > y) then do
    return --[[ GREATER ]]2;
  end else do
    return --[[ EQUAL ]]1;
  end end  end 
end end

function mkVar(x) do
  return mkNode(--[[ Zero ]]1, x, --[[ One ]]0);
end end

andslot1 = Caml_array.caml_make_vect(1999, 0);

andslot2 = Caml_array.caml_make_vect(1999, 0);

andslot3 = Caml_array.caml_make_vect(1999, --[[ Zero ]]1);

xorslot1 = Caml_array.caml_make_vect(1999, 0);

xorslot2 = Caml_array.caml_make_vect(1999, 0);

xorslot3 = Caml_array.caml_make_vect(1999, --[[ Zero ]]1);

notslot1 = Caml_array.caml_make_vect(1999, 0);

notslot2 = Caml_array.caml_make_vect(1999, --[[ One ]]0);

function hash(x, y) do
  return ((x << 1) + y | 0) % 1999;
end end

function not(n) do
  if (typeof n == "number") then do
    if (n ~= 0) then do
      return --[[ One ]]0;
    end else do
      return --[[ Zero ]]1;
    end end 
  end else do
    id = n[2];
    h = id % 1999;
    if (id == Caml_array.caml_array_get(notslot1, h)) then do
      return Caml_array.caml_array_get(notslot2, h);
    end else do
      f = mkNode(not(n[0]), n[1], not(n[3]));
      Caml_array.caml_array_set(notslot1, h, id);
      Caml_array.caml_array_set(notslot2, h, f);
      return f;
    end end 
  end end 
end end

function and2(n1, n2) do
  if (typeof n1 == "number") then do
    if (n1 ~= 0) then do
      return --[[ Zero ]]1;
    end else do
      return n2;
    end end 
  end else do
    r1 = n1[3];
    i1 = n1[2];
    v1 = n1[1];
    l1 = n1[0];
    if (typeof n2 == "number") then do
      if (n2 ~= 0) then do
        return --[[ Zero ]]1;
      end else do
        return n1;
      end end 
    end else do
      r2 = n2[3];
      i2 = n2[2];
      v2 = n2[1];
      l2 = n2[0];
      h = hash(i1, i2);
      if (i1 == Caml_array.caml_array_get(andslot1, h) and i2 == Caml_array.caml_array_get(andslot2, h)) then do
        return Caml_array.caml_array_get(andslot3, h);
      end else do
        match = cmpVar(v1, v2);
        f;
        local ___conditional___=(match);
        do
           if ___conditional___ = 0--[[ LESS ]] then do
              f = mkNode(and2(l1, n2), v1, and2(r1, n2));end else 
           if ___conditional___ = 1--[[ EQUAL ]] then do
              f = mkNode(and2(l1, l2), v1, and2(r1, r2));end else 
           if ___conditional___ = 2--[[ GREATER ]] then do
              f = mkNode(and2(n1, l2), v2, and2(n1, r2));end else 
           do end end end end
          
        end
        Caml_array.caml_array_set(andslot1, h, i1);
        Caml_array.caml_array_set(andslot2, h, i2);
        Caml_array.caml_array_set(andslot3, h, f);
        return f;
      end end 
    end end 
  end end 
end end

function xor(n1, n2) do
  if (typeof n1 == "number") then do
    if (n1 ~= 0) then do
      return n2;
    end else do
      return not(n2);
    end end 
  end else do
    r1 = n1[3];
    i1 = n1[2];
    v1 = n1[1];
    l1 = n1[0];
    if (typeof n2 == "number") then do
      if (n2 ~= 0) then do
        return n1;
      end else do
        return not(n1);
      end end 
    end else do
      r2 = n2[3];
      i2 = n2[2];
      v2 = n2[1];
      l2 = n2[0];
      h = hash(i1, i2);
      if (i1 == Caml_array.caml_array_get(andslot1, h) and i2 == Caml_array.caml_array_get(andslot2, h)) then do
        return Caml_array.caml_array_get(andslot3, h);
      end else do
        match = cmpVar(v1, v2);
        f;
        local ___conditional___=(match);
        do
           if ___conditional___ = 0--[[ LESS ]] then do
              f = mkNode(xor(l1, n2), v1, xor(r1, n2));end else 
           if ___conditional___ = 1--[[ EQUAL ]] then do
              f = mkNode(xor(l1, l2), v1, xor(r1, r2));end else 
           if ___conditional___ = 2--[[ GREATER ]] then do
              f = mkNode(xor(n1, l2), v2, xor(n1, r2));end else 
           do end end end end
          
        end
        Caml_array.caml_array_set(andslot1, h, i1);
        Caml_array.caml_array_set(andslot2, h, i2);
        Caml_array.caml_array_set(andslot3, h, f);
        return f;
      end end 
    end end 
  end end 
end end

function hwb(n) do
  h = function (i, j) do
    if (i == j) then do
      return mkNode(--[[ Zero ]]1, i, --[[ One ]]0);
    end else do
      return xor(and2(not(mkNode(--[[ Zero ]]1, j, --[[ One ]]0)), h(i, j - 1 | 0)), and2(mkNode(--[[ Zero ]]1, j, --[[ One ]]0), g(i, j - 1 | 0)));
    end end 
  end end;
  g = function (i, j) do
    if (i == j) then do
      return mkNode(--[[ Zero ]]1, i, --[[ One ]]0);
    end else do
      return xor(and2(not(mkNode(--[[ Zero ]]1, i, --[[ One ]]0)), h(i + 1 | 0, j)), and2(mkNode(--[[ Zero ]]1, i, --[[ One ]]0), g(i + 1 | 0, j)));
    end end 
  end end;
  return h(0, n - 1 | 0);
end end

seed = do
  contents: 0
end;

function random(param) do
  seed.contents = Caml_int32.imul(seed.contents, 25173) + 17431 | 0;
  return (seed.contents & 1) > 0;
end end

function random_vars(n) do
  vars = Caml_array.caml_make_vect(n, false);
  for i = 0 , n - 1 | 0 , 1 do
    Caml_array.caml_array_set(vars, i, random(--[[ () ]]0));
  end
  return vars;
end end

function bool_equal(a, b) do
  if (a) then do
    if (b) then do
      return true;
    end else do
      return false;
    end end 
  end else if (b) then do
    return false;
  end else do
    return true;
  end end  end 
end end

function test_hwb(bdd, vars) do
  ntrue = 0;
  for i = 0 , #vars - 1 | 0 , 1 do
    if (Caml_array.caml_array_get(vars, i)) then do
      ntrue = ntrue + 1 | 0;
    end
     end 
  end
  return bool_equal(__eval(bdd, vars), ntrue > 0 and Caml_array.caml_array_get(vars, ntrue - 1 | 0) or false);
end end

function main(param) do
  bdd = hwb(22);
  succeeded = true;
  for i = 1 , 100 , 1 do
    succeeded = succeeded and test_hwb(bdd, random_vars(22));
  end
  if (succeeded) then do
    return 0;
  end else do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "bdd.ml",
        233,
        2
      }
    })
  end end 
end end

main(--[[ () ]]0);

initSize_1 = 8191;

zero = --[[ Zero ]]1;

one = --[[ One ]]0;

cacheSize = 1999;

exports.__eval = __eval;
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
--[[  Not a pure module ]]
