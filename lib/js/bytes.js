'use strict';

var Char = require("./char.js");
var Curry = require("./curry.js");
var Caml_bytes = require("./caml_bytes.js");
var Caml_primitive = require("./caml_primitive.js");
var Caml_builtin_exceptions = require("./caml_builtin_exceptions.js");

function make(n, c) do
  var s = Caml_bytes.caml_create_bytes(n);
  Caml_bytes.caml_fill_bytes(s, 0, n, c);
  return s;
end

function init(n, f) do
  var s = Caml_bytes.caml_create_bytes(n);
  for(var i = 0 ,i_finish = n - 1 | 0; i <= i_finish; ++i)do
    s[i] = Curry._1(f, i);
  end
  return s;
end

var empty = [];

function copy(s) do
  var len = #s;
  var r = Caml_bytes.caml_create_bytes(len);
  Caml_bytes.caml_blit_bytes(s, 0, r, 0, len);
  return r;
end

function to_string(b) do
  return Caml_bytes.bytes_to_string(copy(b));
end

function of_string(s) do
  return copy(Caml_bytes.bytes_of_string(s));
end

function sub(s, ofs, len) do
  if (ofs < 0 or len < 0 or ofs > (#s - len | 0)) do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "String.sub / Bytes.sub"
        ];
  end
  var r = Caml_bytes.caml_create_bytes(len);
  Caml_bytes.caml_blit_bytes(s, ofs, r, 0, len);
  return r;
end

function sub_string(b, ofs, len) do
  return Caml_bytes.bytes_to_string(sub(b, ofs, len));
end

function $plus$plus(a, b) do
  var c = a + b | 0;
  var match = a < 0;
  var match$1 = b < 0;
  var match$2 = c < 0;
  if (match) do
    if (match$1 and !match$2) do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "Bytes.extend"
          ];
    end else do
      return c;
    end
  end else if (match$1) do
    return c;
  end else do
    if (match$2) do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "Bytes.extend"
          ];
    end
    return c;
  end
end

function extend(s, left, right) do
  var len = $plus$plus($plus$plus(#s, left), right);
  var r = Caml_bytes.caml_create_bytes(len);
  var match = left < 0 ? --[ tuple ]--[
      -left | 0,
      0
    ] : --[ tuple ]--[
      0,
      left
    ];
  var dstoff = match[1];
  var srcoff = match[0];
  var cpylen = Caml_primitive.caml_int_min(#s - srcoff | 0, len - dstoff | 0);
  if (cpylen > 0) do
    Caml_bytes.caml_blit_bytes(s, srcoff, r, dstoff, cpylen);
  end
  return r;
end

function fill(s, ofs, len, c) do
  if (ofs < 0 or len < 0 or ofs > (#s - len | 0)) do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "String.fill / Bytes.fill"
        ];
  end
  return Caml_bytes.caml_fill_bytes(s, ofs, len, c);
end

function blit(s1, ofs1, s2, ofs2, len) do
  if (len < 0 or ofs1 < 0 or ofs1 > (#s1 - len | 0) or ofs2 < 0 or ofs2 > (#s2 - len | 0)) do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Bytes.blit"
        ];
  end
  return Caml_bytes.caml_blit_bytes(s1, ofs1, s2, ofs2, len);
end

function blit_string(s1, ofs1, s2, ofs2, len) do
  if (len < 0 or ofs1 < 0 or ofs1 > (#s1 - len | 0) or ofs2 < 0 or ofs2 > (#s2 - len | 0)) do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "String.blit / Bytes.blit_string"
        ];
  end
  return Caml_bytes.caml_blit_string(s1, ofs1, s2, ofs2, len);
end

function iter(f, a) do
  for(var i = 0 ,i_finish = #a - 1 | 0; i <= i_finish; ++i)do
    Curry._1(f, a[i]);
  end
  return --[ () ]--0;
end

function iteri(f, a) do
  for(var i = 0 ,i_finish = #a - 1 | 0; i <= i_finish; ++i)do
    Curry._2(f, i, a[i]);
  end
  return --[ () ]--0;
end

function ensure_ge(x, y) do
  if (x >= y) do
    return x;
  end else do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Bytes.concat"
        ];
  end
end

function sum_lengths(_acc, seplen, _param) do
  while(true) do
    var param = _param;
    var acc = _acc;
    if (param) do
      var tl = param[1];
      var hd = param[0];
      if (tl) do
        _param = tl;
        _acc = ensure_ge((#hd + seplen | 0) + acc | 0, acc);
        continue ;
      end else do
        return #hd + acc | 0;
      end
    end else do
      return acc;
    end
  end;
end

function concat(sep, l) do
  if (l) do
    var seplen = #sep;
    var dst = Caml_bytes.caml_create_bytes(sum_lengths(0, seplen, l));
    var _pos = 0;
    var sep$1 = sep;
    var seplen$1 = seplen;
    var _param = l;
    while(true) do
      var param = _param;
      var pos = _pos;
      if (param) do
        var tl = param[1];
        var hd = param[0];
        if (tl) do
          Caml_bytes.caml_blit_bytes(hd, 0, dst, pos, #hd);
          Caml_bytes.caml_blit_bytes(sep$1, 0, dst, pos + #hd | 0, seplen$1);
          _param = tl;
          _pos = (pos + #hd | 0) + seplen$1 | 0;
          continue ;
        end else do
          Caml_bytes.caml_blit_bytes(hd, 0, dst, pos, #hd);
          return dst;
        end
      end else do
        return dst;
      end
    end;
  end else do
    return empty;
  end
end

function cat(s1, s2) do
  var l1 = #s1;
  var l2 = #s2;
  var r = Caml_bytes.caml_create_bytes(l1 + l2 | 0);
  Caml_bytes.caml_blit_bytes(s1, 0, r, 0, l1);
  Caml_bytes.caml_blit_bytes(s2, 0, r, l1, l2);
  return r;
end

function is_space(param) do
  var switcher = param - 9 | 0;
  if (switcher > 4 or switcher < 0) do
    return switcher == 23;
  end else do
    return switcher ~= 2;
  end
end

function trim(s) do
  var len = #s;
  var i = 0;
  while(i < len and is_space(s[i])) do
    i = i + 1 | 0;
  end;
  var j = len - 1 | 0;
  while(j >= i and is_space(s[j])) do
    j = j - 1 | 0;
  end;
  if (j >= i) do
    return sub(s, i, (j - i | 0) + 1 | 0);
  end else do
    return empty;
  end
end

function escaped(s) do
  var n = 0;
  for(var i = 0 ,i_finish = #s - 1 | 0; i <= i_finish; ++i)do
    var match = s[i];
    var tmp;
    if (match >= 32) do
      var switcher = match - 34 | 0;
      tmp = switcher > 58 or switcher < 0 ? (
          switcher >= 93 ? 4 : 1
        ) : (
          switcher > 57 or switcher < 1 ? 2 : 1
        );
    end else do
      tmp = match >= 11 ? (
          match ~= 13 ? 4 : 2
        ) : (
          match >= 8 ? 2 : 4
        );
    end
    n = n + tmp | 0;
  end
  if (n == #s) do
    return copy(s);
  end else do
    var s$prime = Caml_bytes.caml_create_bytes(n);
    n = 0;
    for(var i$1 = 0 ,i_finish$1 = #s - 1 | 0; i$1 <= i_finish$1; ++i$1)do
      var c = s[i$1];
      var exit = 0;
      if (c >= 35) do
        if (c ~= 92) do
          if (c >= 127) do
            exit = 1;
          end else do
            s$prime[n] = c;
          end
        end else do
          exit = 2;
        end
      end else if (c >= 32) do
        if (c >= 34) do
          exit = 2;
        end else do
          s$prime[n] = c;
        end
      end else if (c >= 14) do
        exit = 1;
      end else do
        switch (c) do
          case 8 :
              s$prime[n] = --[ "\\" ]--92;
              n = n + 1 | 0;
              s$prime[n] = --[ "b" ]--98;
              break;
          case 9 :
              s$prime[n] = --[ "\\" ]--92;
              n = n + 1 | 0;
              s$prime[n] = --[ "t" ]--116;
              break;
          case 10 :
              s$prime[n] = --[ "\\" ]--92;
              n = n + 1 | 0;
              s$prime[n] = --[ "n" ]--110;
              break;
          case 0 :
          case 1 :
          case 2 :
          case 3 :
          case 4 :
          case 5 :
          case 6 :
          case 7 :
          case 11 :
          case 12 :
              exit = 1;
              break;
          case 13 :
              s$prime[n] = --[ "\\" ]--92;
              n = n + 1 | 0;
              s$prime[n] = --[ "r" ]--114;
              break;
          
        end
      end
      switch (exit) do
        case 1 :
            s$prime[n] = --[ "\\" ]--92;
            n = n + 1 | 0;
            s$prime[n] = 48 + (c / 100 | 0) | 0;
            n = n + 1 | 0;
            s$prime[n] = 48 + (c / 10 | 0) % 10 | 0;
            n = n + 1 | 0;
            s$prime[n] = 48 + c % 10 | 0;
            break;
        case 2 :
            s$prime[n] = --[ "\\" ]--92;
            n = n + 1 | 0;
            s$prime[n] = c;
            break;
        
      end
      n = n + 1 | 0;
    end
    return s$prime;
  end
end

function map(f, s) do
  var l = #s;
  if (l == 0) do
    return s;
  end else do
    var r = Caml_bytes.caml_create_bytes(l);
    for(var i = 0 ,i_finish = l - 1 | 0; i <= i_finish; ++i)do
      r[i] = Curry._1(f, s[i]);
    end
    return r;
  end
end

function mapi(f, s) do
  var l = #s;
  if (l == 0) do
    return s;
  end else do
    var r = Caml_bytes.caml_create_bytes(l);
    for(var i = 0 ,i_finish = l - 1 | 0; i <= i_finish; ++i)do
      r[i] = Curry._2(f, i, s[i]);
    end
    return r;
  end
end

function uppercase_ascii(s) do
  return map(Char.uppercase_ascii, s);
end

function lowercase_ascii(s) do
  return map(Char.lowercase_ascii, s);
end

function apply1(f, s) do
  if (#s == 0) do
    return s;
  end else do
    var r = copy(s);
    r[0] = Curry._1(f, s[0]);
    return r;
  end
end

function capitalize_ascii(s) do
  return apply1(Char.uppercase_ascii, s);
end

function uncapitalize_ascii(s) do
  return apply1(Char.lowercase_ascii, s);
end

function index_rec(s, lim, _i, c) do
  while(true) do
    var i = _i;
    if (i >= lim) do
      throw Caml_builtin_exceptions.not_found;
    end
    if (s[i] == c) do
      return i;
    end else do
      _i = i + 1 | 0;
      continue ;
    end
  end;
end

function index(s, c) do
  return index_rec(s, #s, 0, c);
end

function index_rec_opt(s, lim, _i, c) do
  while(true) do
    var i = _i;
    if (i >= lim) do
      return ;
    end else if (s[i] == c) do
      return i;
    end else do
      _i = i + 1 | 0;
      continue ;
    end
  end;
end

function index_opt(s, c) do
  return index_rec_opt(s, #s, 0, c);
end

function index_from(s, i, c) do
  var l = #s;
  if (i < 0 or i > l) do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "String.index_from / Bytes.index_from"
        ];
  end
  return index_rec(s, l, i, c);
end

function index_from_opt(s, i, c) do
  var l = #s;
  if (i < 0 or i > l) do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "String.index_from_opt / Bytes.index_from_opt"
        ];
  end
  return index_rec_opt(s, l, i, c);
end

function rindex_rec(s, _i, c) do
  while(true) do
    var i = _i;
    if (i < 0) do
      throw Caml_builtin_exceptions.not_found;
    end
    if (s[i] == c) do
      return i;
    end else do
      _i = i - 1 | 0;
      continue ;
    end
  end;
end

function rindex(s, c) do
  return rindex_rec(s, #s - 1 | 0, c);
end

function rindex_from(s, i, c) do
  if (i < -1 or i >= #s) do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "String.rindex_from / Bytes.rindex_from"
        ];
  end
  return rindex_rec(s, i, c);
end

function rindex_rec_opt(s, _i, c) do
  while(true) do
    var i = _i;
    if (i < 0) do
      return ;
    end else if (s[i] == c) do
      return i;
    end else do
      _i = i - 1 | 0;
      continue ;
    end
  end;
end

function rindex_opt(s, c) do
  return rindex_rec_opt(s, #s - 1 | 0, c);
end

function rindex_from_opt(s, i, c) do
  if (i < -1 or i >= #s) do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "String.rindex_from_opt / Bytes.rindex_from_opt"
        ];
  end
  return rindex_rec_opt(s, i, c);
end

function contains_from(s, i, c) do
  var l = #s;
  if (i < 0 or i > l) do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "String.contains_from / Bytes.contains_from"
        ];
  end
  try do
    index_rec(s, l, i, c);
    return true;
  end
  catch (exn)do
    if (exn == Caml_builtin_exceptions.not_found) do
      return false;
    end else do
      throw exn;
    end
  end
end

function contains(s, c) do
  return contains_from(s, 0, c);
end

function rcontains_from(s, i, c) do
  if (i < 0 or i >= #s) do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "String.rcontains_from / Bytes.rcontains_from"
        ];
  end
  try do
    rindex_rec(s, i, c);
    return true;
  end
  catch (exn)do
    if (exn == Caml_builtin_exceptions.not_found) do
      return false;
    end else do
      throw exn;
    end
  end
end

var compare = Caml_primitive.caml_bytes_compare;

function uppercase(s) do
  return map(Char.uppercase, s);
end

function lowercase(s) do
  return map(Char.lowercase, s);
end

function capitalize(s) do
  return apply1(Char.uppercase, s);
end

function uncapitalize(s) do
  return apply1(Char.lowercase, s);
end

var equal = Caml_primitive.caml_bytes_equal;

var unsafe_to_string = Caml_bytes.bytes_to_string;

var unsafe_of_string = Caml_bytes.bytes_of_string;

exports.make = make;
exports.init = init;
exports.empty = empty;
exports.copy = copy;
exports.of_string = of_string;
exports.to_string = to_string;
exports.sub = sub;
exports.sub_string = sub_string;
exports.extend = extend;
exports.fill = fill;
exports.blit = blit;
exports.blit_string = blit_string;
exports.concat = concat;
exports.cat = cat;
exports.iter = iter;
exports.iteri = iteri;
exports.map = map;
exports.mapi = mapi;
exports.trim = trim;
exports.escaped = escaped;
exports.index = index;
exports.index_opt = index_opt;
exports.rindex = rindex;
exports.rindex_opt = rindex_opt;
exports.index_from = index_from;
exports.index_from_opt = index_from_opt;
exports.rindex_from = rindex_from;
exports.rindex_from_opt = rindex_from_opt;
exports.contains = contains;
exports.contains_from = contains_from;
exports.rcontains_from = rcontains_from;
exports.uppercase = uppercase;
exports.lowercase = lowercase;
exports.capitalize = capitalize;
exports.uncapitalize = uncapitalize;
exports.uppercase_ascii = uppercase_ascii;
exports.lowercase_ascii = lowercase_ascii;
exports.capitalize_ascii = capitalize_ascii;
exports.uncapitalize_ascii = uncapitalize_ascii;
exports.compare = compare;
exports.equal = equal;
exports.unsafe_to_string = unsafe_to_string;
exports.unsafe_of_string = unsafe_of_string;
--[ No side effect ]--
