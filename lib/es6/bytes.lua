

import * as Char from "./char.lua";
import * as Curry from "./curry.lua";
import * as Caml_bytes from "./caml_bytes.lua";
import * as Caml_primitive from "./caml_primitive.lua";
import * as Caml_builtin_exceptions from "./caml_builtin_exceptions.lua";

function make(n, c) do
  s = Caml_bytes.caml_create_bytes(n);
  Caml_bytes.caml_fill_bytes(s, 0, n, c);
  return s;
end end

function init(n, f) do
  s = Caml_bytes.caml_create_bytes(n);
  for i = 0 , n - 1 | 0 , 1 do
    s[i] = Curry._1(f, i);
  end
  return s;
end end

empty = {};

function copy(s) do
  len = #s;
  r = Caml_bytes.caml_create_bytes(len);
  Caml_bytes.caml_blit_bytes(s, 0, r, 0, len);
  return r;
end end

function to_string(b) do
  return Caml_bytes.bytes_to_string(copy(b));
end end

function of_string(s) do
  return copy(Caml_bytes.bytes_of_string(s));
end end

function sub(s, ofs, len) do
  if (ofs < 0 or len < 0 or ofs > (#s - len | 0)) then do
    throw {
          Caml_builtin_exceptions.invalid_argument,
          "String.sub / Bytes.sub"
        };
  end
   end 
  r = Caml_bytes.caml_create_bytes(len);
  Caml_bytes.caml_blit_bytes(s, ofs, r, 0, len);
  return r;
end end

function sub_string(b, ofs, len) do
  return Caml_bytes.bytes_to_string(sub(b, ofs, len));
end end

function $plus$plus(a, b) do
  c = a + b | 0;
  match = a < 0;
  match$1 = b < 0;
  match$2 = c < 0;
  if (match) then do
    if (match$1 and not match$2) then do
      throw {
            Caml_builtin_exceptions.invalid_argument,
            "Bytes.extend"
          };
    end else do
      return c;
    end end 
  end else if (match$1) then do
    return c;
  end else do
    if (match$2) then do
      throw {
            Caml_builtin_exceptions.invalid_argument,
            "Bytes.extend"
          };
    end
     end 
    return c;
  end end  end 
end end

function extend(s, left, right) do
  len = $plus$plus($plus$plus(#s, left), right);
  r = Caml_bytes.caml_create_bytes(len);
  match = left < 0 and --[[ tuple ]]{
      -left | 0,
      0
    } or --[[ tuple ]]{
      0,
      left
    };
  dstoff = match[1];
  srcoff = match[0];
  cpylen = Caml_primitive.caml_int_min(#s - srcoff | 0, len - dstoff | 0);
  if (cpylen > 0) then do
    Caml_bytes.caml_blit_bytes(s, srcoff, r, dstoff, cpylen);
  end
   end 
  return r;
end end

function fill(s, ofs, len, c) do
  if (ofs < 0 or len < 0 or ofs > (#s - len | 0)) then do
    throw {
          Caml_builtin_exceptions.invalid_argument,
          "String.fill / Bytes.fill"
        };
  end
   end 
  return Caml_bytes.caml_fill_bytes(s, ofs, len, c);
end end

function blit(s1, ofs1, s2, ofs2, len) do
  if (len < 0 or ofs1 < 0 or ofs1 > (#s1 - len | 0) or ofs2 < 0 or ofs2 > (#s2 - len | 0)) then do
    throw {
          Caml_builtin_exceptions.invalid_argument,
          "Bytes.blit"
        };
  end
   end 
  return Caml_bytes.caml_blit_bytes(s1, ofs1, s2, ofs2, len);
end end

function blit_string(s1, ofs1, s2, ofs2, len) do
  if (len < 0 or ofs1 < 0 or ofs1 > (#s1 - len | 0) or ofs2 < 0 or ofs2 > (#s2 - len | 0)) then do
    throw {
          Caml_builtin_exceptions.invalid_argument,
          "String.blit / Bytes.blit_string"
        };
  end
   end 
  return Caml_bytes.caml_blit_string(s1, ofs1, s2, ofs2, len);
end end

function iter(f, a) do
  for i = 0 , #a - 1 | 0 , 1 do
    Curry._1(f, a[i]);
  end
  return --[[ () ]]0;
end end

function iteri(f, a) do
  for i = 0 , #a - 1 | 0 , 1 do
    Curry._2(f, i, a[i]);
  end
  return --[[ () ]]0;
end end

function ensure_ge(x, y) do
  if (x >= y) then do
    return x;
  end else do
    throw {
          Caml_builtin_exceptions.invalid_argument,
          "Bytes.concat"
        };
  end end 
end end

function sum_lengths(_acc, seplen, _param) do
  while(true) do
    param = _param;
    acc = _acc;
    if (param) then do
      tl = param[1];
      hd = param[0];
      if (tl) then do
        _param = tl;
        _acc = ensure_ge((#hd + seplen | 0) + acc | 0, acc);
        continue ;
      end else do
        return #hd + acc | 0;
      end end 
    end else do
      return acc;
    end end 
  end;
end end

function concat(sep, l) do
  if (l) then do
    seplen = #sep;
    dst = Caml_bytes.caml_create_bytes(sum_lengths(0, seplen, l));
    _pos = 0;
    sep$1 = sep;
    seplen$1 = seplen;
    _param = l;
    while(true) do
      param = _param;
      pos = _pos;
      if (param) then do
        tl = param[1];
        hd = param[0];
        if (tl) then do
          Caml_bytes.caml_blit_bytes(hd, 0, dst, pos, #hd);
          Caml_bytes.caml_blit_bytes(sep$1, 0, dst, pos + #hd | 0, seplen$1);
          _param = tl;
          _pos = (pos + #hd | 0) + seplen$1 | 0;
          continue ;
        end else do
          Caml_bytes.caml_blit_bytes(hd, 0, dst, pos, #hd);
          return dst;
        end end 
      end else do
        return dst;
      end end 
    end;
  end else do
    return empty;
  end end 
end end

function cat(s1, s2) do
  l1 = #s1;
  l2 = #s2;
  r = Caml_bytes.caml_create_bytes(l1 + l2 | 0);
  Caml_bytes.caml_blit_bytes(s1, 0, r, 0, l1);
  Caml_bytes.caml_blit_bytes(s2, 0, r, l1, l2);
  return r;
end end

function is_space(param) do
  switcher = param - 9 | 0;
  if (switcher > 4 or switcher < 0) then do
    return switcher == 23;
  end else do
    return switcher ~= 2;
  end end 
end end

function trim(s) do
  len = #s;
  i = 0;
  while(i < len and is_space(s[i])) do
    i = i + 1 | 0;
  end;
  j = len - 1 | 0;
  while(j >= i and is_space(s[j])) do
    j = j - 1 | 0;
  end;
  if (j >= i) then do
    return sub(s, i, (j - i | 0) + 1 | 0);
  end else do
    return empty;
  end end 
end end

function escaped(s) do
  n = 0;
  for i = 0 , #s - 1 | 0 , 1 do
    match = s[i];
    tmp;
    if (match >= 32) then do
      switcher = match - 34 | 0;
      tmp = switcher > 58 or switcher < 0 and (
          switcher >= 93 and 4 or 1
        ) or (
          switcher > 57 or switcher < 1 and 2 or 1
        );
    end else do
      tmp = match >= 11 and (
          match ~= 13 and 4 or 2
        ) or (
          match >= 8 and 2 or 4
        );
    end end 
    n = n + tmp | 0;
  end
  if (n == #s) then do
    return copy(s);
  end else do
    s$prime = Caml_bytes.caml_create_bytes(n);
    n = 0;
    for i$1 = 0 , #s - 1 | 0 , 1 do
      c = s[i$1];
      exit = 0;
      if (c >= 35) then do
        if (c ~= 92) then do
          if (c >= 127) then do
            exit = 1;
          end else do
            s$prime[n] = c;
          end end 
        end else do
          exit = 2;
        end end 
      end else if (c >= 32) then do
        if (c >= 34) then do
          exit = 2;
        end else do
          s$prime[n] = c;
        end end 
      end else if (c >= 14) then do
        exit = 1;
      end else do
        local ___conditional___=(c);
        do
           if ___conditional___ = 8 then do
              s$prime[n] = --[[ "\\" ]]92;
              n = n + 1 | 0;
              s$prime[n] = --[[ "b" ]]98;end else 
           if ___conditional___ = 9 then do
              s$prime[n] = --[[ "\\" ]]92;
              n = n + 1 | 0;
              s$prime[n] = --[[ "t" ]]116;end else 
           if ___conditional___ = 10 then do
              s$prime[n] = --[[ "\\" ]]92;
              n = n + 1 | 0;
              s$prime[n] = --[[ "n" ]]110;end else 
           if ___conditional___ = 0
           or ___conditional___ = 1
           or ___conditional___ = 2
           or ___conditional___ = 3
           or ___conditional___ = 4
           or ___conditional___ = 5
           or ___conditional___ = 6
           or ___conditional___ = 7
           or ___conditional___ = 11
           or ___conditional___ = 12 then do
              exit = 1;end else 
           if ___conditional___ = 13 then do
              s$prime[n] = --[[ "\\" ]]92;
              n = n + 1 | 0;
              s$prime[n] = --[[ "r" ]]114;end else 
           do end end end end end end
          
        end
      end end  end  end 
      local ___conditional___=(exit);
      do
         if ___conditional___ = 1 then do
            s$prime[n] = --[[ "\\" ]]92;
            n = n + 1 | 0;
            s$prime[n] = 48 + (c / 100 | 0) | 0;
            n = n + 1 | 0;
            s$prime[n] = 48 + (c / 10 | 0) % 10 | 0;
            n = n + 1 | 0;
            s$prime[n] = 48 + c % 10 | 0;end else 
         if ___conditional___ = 2 then do
            s$prime[n] = --[[ "\\" ]]92;
            n = n + 1 | 0;
            s$prime[n] = c;end else 
         do end end end
        
      end
      n = n + 1 | 0;
    end
    return s$prime;
  end end 
end end

function map(f, s) do
  l = #s;
  if (l == 0) then do
    return s;
  end else do
    r = Caml_bytes.caml_create_bytes(l);
    for i = 0 , l - 1 | 0 , 1 do
      r[i] = Curry._1(f, s[i]);
    end
    return r;
  end end 
end end

function mapi(f, s) do
  l = #s;
  if (l == 0) then do
    return s;
  end else do
    r = Caml_bytes.caml_create_bytes(l);
    for i = 0 , l - 1 | 0 , 1 do
      r[i] = Curry._2(f, i, s[i]);
    end
    return r;
  end end 
end end

function uppercase_ascii(s) do
  return map(Char.uppercase_ascii, s);
end end

function lowercase_ascii(s) do
  return map(Char.lowercase_ascii, s);
end end

function apply1(f, s) do
  if (#s == 0) then do
    return s;
  end else do
    r = copy(s);
    r[0] = Curry._1(f, s[0]);
    return r;
  end end 
end end

function capitalize_ascii(s) do
  return apply1(Char.uppercase_ascii, s);
end end

function uncapitalize_ascii(s) do
  return apply1(Char.lowercase_ascii, s);
end end

function index_rec(s, lim, _i, c) do
  while(true) do
    i = _i;
    if (i >= lim) then do
      throw Caml_builtin_exceptions.not_found;
    end
     end 
    if (s[i] == c) then do
      return i;
    end else do
      _i = i + 1 | 0;
      continue ;
    end end 
  end;
end end

function index(s, c) do
  return index_rec(s, #s, 0, c);
end end

function index_rec_opt(s, lim, _i, c) do
  while(true) do
    i = _i;
    if (i >= lim) then do
      return ;
    end else if (s[i] == c) then do
      return i;
    end else do
      _i = i + 1 | 0;
      continue ;
    end end  end 
  end;
end end

function index_opt(s, c) do
  return index_rec_opt(s, #s, 0, c);
end end

function index_from(s, i, c) do
  l = #s;
  if (i < 0 or i > l) then do
    throw {
          Caml_builtin_exceptions.invalid_argument,
          "String.index_from / Bytes.index_from"
        };
  end
   end 
  return index_rec(s, l, i, c);
end end

function index_from_opt(s, i, c) do
  l = #s;
  if (i < 0 or i > l) then do
    throw {
          Caml_builtin_exceptions.invalid_argument,
          "String.index_from_opt / Bytes.index_from_opt"
        };
  end
   end 
  return index_rec_opt(s, l, i, c);
end end

function rindex_rec(s, _i, c) do
  while(true) do
    i = _i;
    if (i < 0) then do
      throw Caml_builtin_exceptions.not_found;
    end
     end 
    if (s[i] == c) then do
      return i;
    end else do
      _i = i - 1 | 0;
      continue ;
    end end 
  end;
end end

function rindex(s, c) do
  return rindex_rec(s, #s - 1 | 0, c);
end end

function rindex_from(s, i, c) do
  if (i < -1 or i >= #s) then do
    throw {
          Caml_builtin_exceptions.invalid_argument,
          "String.rindex_from / Bytes.rindex_from"
        };
  end
   end 
  return rindex_rec(s, i, c);
end end

function rindex_rec_opt(s, _i, c) do
  while(true) do
    i = _i;
    if (i < 0) then do
      return ;
    end else if (s[i] == c) then do
      return i;
    end else do
      _i = i - 1 | 0;
      continue ;
    end end  end 
  end;
end end

function rindex_opt(s, c) do
  return rindex_rec_opt(s, #s - 1 | 0, c);
end end

function rindex_from_opt(s, i, c) do
  if (i < -1 or i >= #s) then do
    throw {
          Caml_builtin_exceptions.invalid_argument,
          "String.rindex_from_opt / Bytes.rindex_from_opt"
        };
  end
   end 
  return rindex_rec_opt(s, i, c);
end end

function contains_from(s, i, c) do
  l = #s;
  if (i < 0 or i > l) then do
    throw {
          Caml_builtin_exceptions.invalid_argument,
          "String.contains_from / Bytes.contains_from"
        };
  end
   end 
  try do
    index_rec(s, l, i, c);
    return true;
  end
  catch (exn)do
    if (exn == Caml_builtin_exceptions.not_found) then do
      return false;
    end else do
      throw exn;
    end end 
  end
end end

function contains(s, c) do
  return contains_from(s, 0, c);
end end

function rcontains_from(s, i, c) do
  if (i < 0 or i >= #s) then do
    throw {
          Caml_builtin_exceptions.invalid_argument,
          "String.rcontains_from / Bytes.rcontains_from"
        };
  end
   end 
  try do
    rindex_rec(s, i, c);
    return true;
  end
  catch (exn)do
    if (exn == Caml_builtin_exceptions.not_found) then do
      return false;
    end else do
      throw exn;
    end end 
  end
end end

compare = Caml_primitive.caml_bytes_compare;

function uppercase(s) do
  return map(Char.uppercase, s);
end end

function lowercase(s) do
  return map(Char.lowercase, s);
end end

function capitalize(s) do
  return apply1(Char.uppercase, s);
end end

function uncapitalize(s) do
  return apply1(Char.lowercase, s);
end end

equal = Caml_primitive.caml_bytes_equal;

unsafe_to_string = Caml_bytes.bytes_to_string;

unsafe_of_string = Caml_bytes.bytes_of_string;

export do
  make ,
  init ,
  empty ,
  copy ,
  of_string ,
  to_string ,
  sub ,
  sub_string ,
  extend ,
  fill ,
  blit ,
  blit_string ,
  concat ,
  cat ,
  iter ,
  iteri ,
  map ,
  mapi ,
  trim ,
  escaped ,
  index ,
  index_opt ,
  rindex ,
  rindex_opt ,
  index_from ,
  index_from_opt ,
  rindex_from ,
  rindex_from_opt ,
  contains ,
  contains_from ,
  rcontains_from ,
  uppercase ,
  lowercase ,
  capitalize ,
  uncapitalize ,
  uppercase_ascii ,
  lowercase_ascii ,
  capitalize_ascii ,
  uncapitalize_ascii ,
  compare ,
  equal ,
  unsafe_to_string ,
  unsafe_of_string ,
  
end
--[[ No side effect ]]
