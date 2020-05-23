

import * as Bytes from "./bytes.js";
import * as Curry from "./curry.js";
import * as Caml_bytes from "./caml_bytes.js";
import * as Caml_primitive from "./caml_primitive.js";
import * as Caml_builtin_exceptions from "./caml_builtin_exceptions.js";

function make(n, c) do
  return Caml_bytes.bytes_to_string(Bytes.make(n, c));
end

function init(n, f) do
  return Caml_bytes.bytes_to_string(Bytes.init(n, f));
end

function copy(s) do
  return Caml_bytes.bytes_to_string(Bytes.copy(Caml_bytes.bytes_of_string(s)));
end

function sub(s, ofs, len) do
  return Caml_bytes.bytes_to_string(Bytes.sub(Caml_bytes.bytes_of_string(s), ofs, len));
end

function ensure_ge(x, y) do
  if (x >= y) do
    return x;
  end else do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "String.concat"
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

function unsafe_blits(dst, _pos, sep, seplen, _param) do
  while(true) do
    var param = _param;
    var pos = _pos;
    if (param) do
      var tl = param[1];
      var hd = param[0];
      if (tl) do
        Caml_bytes.caml_blit_string(hd, 0, dst, pos, #hd);
        Caml_bytes.caml_blit_string(sep, 0, dst, pos + #hd | 0, seplen);
        _param = tl;
        _pos = (pos + #hd | 0) + seplen | 0;
        continue ;
      end else do
        Caml_bytes.caml_blit_string(hd, 0, dst, pos, #hd);
        return dst;
      end
    end else do
      return dst;
    end
  end;
end

function concat(sep, l) do
  if (l) do
    var seplen = #sep;
    return Caml_bytes.bytes_to_string(unsafe_blits(Caml_bytes.caml_create_bytes(sum_lengths(0, seplen, l)), 0, sep, seplen, l));
  end else do
    return "";
  end
end

function iter(f, s) do
  for(var i = 0 ,i_finish = #s - 1 | 0; i <= i_finish; ++i)do
    Curry._1(f, s.charCodeAt(i));
  end
  return --[ () ]--0;
end

function iteri(f, s) do
  for(var i = 0 ,i_finish = #s - 1 | 0; i <= i_finish; ++i)do
    Curry._2(f, i, s.charCodeAt(i));
  end
  return --[ () ]--0;
end

function map(f, s) do
  return Caml_bytes.bytes_to_string(Bytes.map(f, Caml_bytes.bytes_of_string(s)));
end

function mapi(f, s) do
  return Caml_bytes.bytes_to_string(Bytes.mapi(f, Caml_bytes.bytes_of_string(s)));
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
  if (s == "" or !(is_space(s.charCodeAt(0)) or is_space(s.charCodeAt(#s - 1 | 0)))) do
    return s;
  end else do
    return Caml_bytes.bytes_to_string(Bytes.trim(Caml_bytes.bytes_of_string(s)));
  end
end

function escaped(s) do
  var needs_escape = function (_i) do
    while(true) do
      var i = _i;
      if (i >= #s) do
        return false;
      end else do
        var match = s.charCodeAt(i);
        if (match >= 32) do
          var switcher = match - 34 | 0;
          if (switcher > 58 or switcher < 0) do
            if (switcher >= 93) do
              return true;
            end else do
              _i = i + 1 | 0;
              continue ;
            end
          end else if (switcher > 57 or switcher < 1) do
            return true;
          end else do
            _i = i + 1 | 0;
            continue ;
          end
        end else do
          return true;
        end
      end
    end;
  end;
  if (needs_escape(0)) do
    return Caml_bytes.bytes_to_string(Bytes.escaped(Caml_bytes.bytes_of_string(s)));
  end else do
    return s;
  end
end

function index_rec(s, lim, _i, c) do
  while(true) do
    var i = _i;
    if (i >= lim) do
      throw Caml_builtin_exceptions.not_found;
    end
    if (s.charCodeAt(i) == c) do
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
    end else if (s.charCodeAt(i) == c) do
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
    if (s.charCodeAt(i) == c) do
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
    end else if (s.charCodeAt(i) == c) do
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

function uppercase_ascii(s) do
  return Caml_bytes.bytes_to_string(Bytes.uppercase_ascii(Caml_bytes.bytes_of_string(s)));
end

function lowercase_ascii(s) do
  return Caml_bytes.bytes_to_string(Bytes.lowercase_ascii(Caml_bytes.bytes_of_string(s)));
end

function capitalize_ascii(s) do
  return Caml_bytes.bytes_to_string(Bytes.capitalize_ascii(Caml_bytes.bytes_of_string(s)));
end

function uncapitalize_ascii(s) do
  return Caml_bytes.bytes_to_string(Bytes.uncapitalize_ascii(Caml_bytes.bytes_of_string(s)));
end

var compare = Caml_primitive.caml_string_compare;

function split_on_char(sep, s) do
  var r = --[ [] ]--0;
  var j = #s;
  for(var i = #s - 1 | 0; i >= 0; --i)do
    if (s.charCodeAt(i) == sep) do
      r = --[ :: ]--[
        sub(s, i + 1 | 0, (j - i | 0) - 1 | 0),
        r
      ];
      j = i;
    end
    
  end
  return --[ :: ]--[
          sub(s, 0, j),
          r
        ];
end

function uppercase(s) do
  return Caml_bytes.bytes_to_string(Bytes.uppercase(Caml_bytes.bytes_of_string(s)));
end

function lowercase(s) do
  return Caml_bytes.bytes_to_string(Bytes.lowercase(Caml_bytes.bytes_of_string(s)));
end

function capitalize(s) do
  return Caml_bytes.bytes_to_string(Bytes.capitalize(Caml_bytes.bytes_of_string(s)));
end

function uncapitalize(s) do
  return Caml_bytes.bytes_to_string(Bytes.uncapitalize(Caml_bytes.bytes_of_string(s)));
end

var fill = Bytes.fill;

var blit = Bytes.blit_string;

function equal(prim, prim$1) do
  return prim == prim$1;
end

export do
  make ,
  init ,
  copy ,
  sub ,
  fill ,
  blit ,
  concat ,
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
  split_on_char ,
  
end
--[ No side effect ]--
