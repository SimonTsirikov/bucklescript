

import * as __Array from "./array.lua";
import * as Curry from "./curry.lua";
import * as Int32 from "./int32.lua";
import * as Int64 from "./int64.lua";
import * as Digest from "./digest.lua";
import * as Caml_sys from "./caml_sys.lua";
import * as Nativeint from "./nativeint.lua";
import * as Caml_array from "./caml_array.lua";
import * as Caml_int64 from "./caml_int64.lua";
import * as Caml_string from "./caml_string.lua";
import * as Caml_builtin_exceptions from "./caml_builtin_exceptions.lua";

function assign(st1, st2) do
  __Array.blit(st2.st, 0, st1.st, 0, 55);
  st1.idx = st2.idx;
  return --[[ () ]]0;
end end

function full_init(s, seed) do
  combine = function (accu, x) do
    return Digest.string(accu .. String(x));
  end end;
  extract = function (d) do
    return ((Caml_string.get(d, 0) + (Caml_string.get(d, 1) << 8) | 0) + (Caml_string.get(d, 2) << 16) | 0) + (Caml_string.get(d, 3) << 24) | 0;
  end end;
  seed$1 = #seed == 0 and [0] or seed;
  l = #seed$1;
  for i = 0 , 54 , 1 do
    Caml_array.caml_array_set(s.st, i, i);
  end
  accu = "x";
  for i$1 = 0 , 54 + (
    55 > l and 55 or l
  ) | 0 , 1 do
    j = i$1 % 55;
    k = i$1 % l;
    accu = combine(accu, Caml_array.caml_array_get(seed$1, k));
    Caml_array.caml_array_set(s.st, j, (Caml_array.caml_array_get(s.st, j) ^ extract(accu)) & 1073741823);
  end
  s.idx = 0;
  return --[[ () ]]0;
end end

function make(seed) do
  result = do
    st: Caml_array.caml_make_vect(55, 0),
    idx: 0
  end;
  full_init(result, seed);
  return result;
end end

function make_self_init(param) do
  return make(Caml_sys.caml_sys_random_seed(--[[ () ]]0));
end end

function copy(s) do
  result = do
    st: Caml_array.caml_make_vect(55, 0),
    idx: 0
  end;
  assign(result, s);
  return result;
end end

function bits(s) do
  s.idx = (s.idx + 1 | 0) % 55;
  curval = Caml_array.caml_array_get(s.st, s.idx);
  newval = Caml_array.caml_array_get(s.st, (s.idx + 24 | 0) % 55) + (curval ^ (curval >>> 25) & 31) | 0;
  newval30 = newval & 1073741823;
  Caml_array.caml_array_set(s.st, s.idx, newval30);
  return newval30;
end end

function __int(s, bound) do
  if (bound > 1073741823 or bound <= 0) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Random.int"
        ];
  end
   end 
  s$1 = s;
  n = bound;
  while(true) do
    r = bits(s$1);
    v = r % n;
    if ((r - v | 0) > ((1073741823 - n | 0) + 1 | 0)) then do
      continue ;
    end else do
      return v;
    end end 
  end;
end end

function int32(s, bound) do
  if (bound <= 0) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Random.int32"
        ];
  end
   end 
  s$1 = s;
  n = bound;
  while(true) do
    b1 = bits(s$1);
    b2 = ((bits(s$1) & 1) << 30);
    r = b1 | b2;
    v = r % n;
    if ((r - v | 0) > ((Int32.max_int - n | 0) + 1 | 0)) then do
      continue ;
    end else do
      return v;
    end end 
  end;
end end

function int64(s, bound) do
  if (Caml_int64.le(bound, --[[ int64 ]][
          --[[ hi ]]0,
          --[[ lo ]]0
        ])) then do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Random.int64"
        ];
  end
   end 
  s$1 = s;
  n = bound;
  while(true) do
    b1 = Caml_int64.of_int32(bits(s$1));
    b2 = Caml_int64.lsl_(Caml_int64.of_int32(bits(s$1)), 30);
    b3 = Caml_int64.lsl_(Caml_int64.of_int32(bits(s$1) & 7), 60);
    r = Caml_int64.or_(b1, Caml_int64.or_(b2, b3));
    v = Caml_int64.mod_(r, n);
    if (Caml_int64.gt(Caml_int64.sub(r, v), Caml_int64.add(Caml_int64.sub(Int64.max_int, n), --[[ int64 ]][
                --[[ hi ]]0,
                --[[ lo ]]1
              ]))) then do
      continue ;
    end else do
      return v;
    end end 
  end;
end end

nativeint = Nativeint.size == 32 and int32 or (function (s, bound) do
      return Caml_int64.to_int32(int64(s, Caml_int64.of_int32(bound)));
    end end);

function rawfloat(s) do
  r1 = bits(s);
  r2 = bits(s);
  return (r1 / 1073741824.0 + r2) / 1073741824.0;
end end

function __float(s, bound) do
  return rawfloat(s) * bound;
end end

function bool(s) do
  return (bits(s) & 1) == 0;
end end

__default = do
  st: [
    987910699,
    495797812,
    364182224,
    414272206,
    318284740,
    990407751,
    383018966,
    270373319,
    840823159,
    24560019,
    536292337,
    512266505,
    189156120,
    730249596,
    143776328,
    51606627,
    140166561,
    366354223,
    1003410265,
    700563762,
    981890670,
    913149062,
    526082594,
    1021425055,
    784300257,
    667753350,
    630144451,
    949649812,
    48546892,
    415514493,
    258888527,
    511570777,
    89983870,
    283659902,
    308386020,
    242688715,
    482270760,
    865188196,
    1027664170,
    207196989,
    193777847,
    619708188,
    671350186,
    149669678,
    257044018,
    87658204,
    558145612,
    183450813,
    28133145,
    901332182,
    710253903,
    510646120,
    652377910,
    409934019,
    801085050
  ],
  idx: 0
end;

function bits$1(param) do
  return bits(__default);
end end

function __int$1(bound) do
  return __int(__default, bound);
end end

function int32$1(bound) do
  return int32(__default, bound);
end end

function nativeint$1(bound) do
  return Curry._2(nativeint, __default, bound);
end end

function int64$1(bound) do
  return int64(__default, bound);
end end

function __float$1(scale) do
  return rawfloat(__default) * scale;
end end

function bool$1(param) do
  return bool(__default);
end end

function full_init$1(seed) do
  return full_init(__default, seed);
end end

function init(seed) do
  return full_init(__default, [seed]);
end end

function self_init(param) do
  return full_init$1(Caml_sys.caml_sys_random_seed(--[[ () ]]0));
end end

function get_state(param) do
  return copy(__default);
end end

function set_state(s) do
  return assign(__default, s);
end end

State = do
  make: make,
  make_self_init: make_self_init,
  copy: copy,
  bits: bits,
  __int: __int,
  int32: int32,
  nativeint: nativeint,
  int64: int64,
  __float: __float,
  bool: bool
end;

export do
  init ,
  full_init$1 as full_init,
  self_init ,
  bits$1 as bits,
  __int$1 as __int,
  int32$1 as int32,
  nativeint$1 as nativeint,
  int64$1 as int64,
  __float$1 as __float,
  bool$1 as bool,
  State ,
  get_state ,
  set_state ,
  
end
--[[ No side effect ]]
