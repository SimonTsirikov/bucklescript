__console = {log = print};

Bytes = require "..bytes";
Curry = require "..curry";
Caml_bytes = require "..caml_bytes";
Caml_primitive = require "..caml_primitive";
Caml_builtin_exceptions = require "..caml_builtin_exceptions";

function make(n, c) do
  return Caml_bytes.bytes_to_string(Bytes.make(n, c));
end end

function init(n, f) do
  return Caml_bytes.bytes_to_string(Bytes.init(n, f));
end end

function copy(s) do
  return Caml_bytes.bytes_to_string(Bytes.copy(Caml_bytes.bytes_of_string(s)));
end end

function sub(s, ofs, len) do
  return Caml_bytes.bytes_to_string(Bytes.sub(Caml_bytes.bytes_of_string(s), ofs, len));
end end

function ensure_ge(x, y) do
  if (x >= y) then do
    return x;
  end else do
    error({
      Caml_builtin_exceptions.invalid_argument,
      "String.concat"
    })
  end end 
end end

function sum_lengths(_acc, seplen, _param) do
  while(true) do
    param = _param;
    acc = _acc;
    if (param) then do
      tl = param[2];
      hd = param[1];
      if (tl) then do
        _param = tl;
        _acc = ensure_ge((#hd + seplen | 0) + acc | 0, acc);
        ::continue:: ;
      end else do
        return #hd + acc | 0;
      end end 
    end else do
      return acc;
    end end 
  end;
end end

function unsafe_blits(dst, _pos, sep, seplen, _param) do
  while(true) do
    param = _param;
    pos = _pos;
    if (param) then do
      tl = param[2];
      hd = param[1];
      if (tl) then do
        Caml_bytes.caml_blit_string(hd, 0, dst, pos, #hd);
        Caml_bytes.caml_blit_string(sep, 0, dst, pos + #hd | 0, seplen);
        _param = tl;
        _pos = (pos + #hd | 0) + seplen | 0;
        ::continue:: ;
      end else do
        Caml_bytes.caml_blit_string(hd, 0, dst, pos, #hd);
        return dst;
      end end 
    end else do
      return dst;
    end end 
  end;
end end

function concat(sep, l) do
  if (l) then do
    seplen = #sep;
    return Caml_bytes.bytes_to_string(unsafe_blits(Caml_bytes.caml_create_bytes(sum_lengths(0, seplen, l)), 0, sep, seplen, l));
  end else do
    return "";
  end end 
end end

function iter(f, s) do
  for i = 0 , #s - 1 | 0 , 1 do
    Curry._1(f, s.charCodeAt(i));
  end
  return --[[ () ]]0;
end end

function iteri(f, s) do
  for i = 0 , #s - 1 | 0 , 1 do
    Curry._2(f, i, s.charCodeAt(i));
  end
  return --[[ () ]]0;
end end

function map(f, s) do
  return Caml_bytes.bytes_to_string(Bytes.map(f, Caml_bytes.bytes_of_string(s)));
end end

function mapi(f, s) do
  return Caml_bytes.bytes_to_string(Bytes.mapi(f, Caml_bytes.bytes_of_string(s)));
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
  if (s == "" or not (is_space(s.charCodeAt(0)) or is_space(s.charCodeAt(#s - 1 | 0)))) then do
    return s;
  end else do
    return Caml_bytes.bytes_to_string(Bytes.trim(Caml_bytes.bytes_of_string(s)));
  end end 
end end

function escaped(s) do
  needs_escape = function(_i) do
    while(true) do
      i = _i;
      if (i >= #s) then do
        return false;
      end else do
        match = s.charCodeAt(i);
        if (match >= 32) then do
          switcher = match - 34 | 0;
          if (switcher > 58 or switcher < 0) then do
            if (switcher >= 93) then do
              return true;
            end else do
              _i = i + 1 | 0;
              ::continue:: ;
            end end 
          end else if (switcher > 57 or switcher < 1) then do
            return true;
          end else do
            _i = i + 1 | 0;
            ::continue:: ;
          end end  end 
        end else do
          return true;
        end end 
      end end 
    end;
  end end;
  if (needs_escape(0)) then do
    return Caml_bytes.bytes_to_string(Bytes.escaped(Caml_bytes.bytes_of_string(s)));
  end else do
    return s;
  end end 
end end

function index_rec(s, lim, _i, c) do
  while(true) do
    i = _i;
    if (i >= lim) then do
      error(Caml_builtin_exceptions.not_found)
    end
     end 
    if (s.charCodeAt(i) == c) then do
      return i;
    end else do
      _i = i + 1 | 0;
      ::continue:: ;
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
    end else if (s.charCodeAt(i) == c) then do
      return i;
    end else do
      _i = i + 1 | 0;
      ::continue:: ;
    end end  end 
  end;
end end

function index_opt(s, c) do
  return index_rec_opt(s, #s, 0, c);
end end

function index_from(s, i, c) do
  l = #s;
  if (i < 0 or i > l) then do
    error({
      Caml_builtin_exceptions.invalid_argument,
      "String.index_from / Bytes.index_from"
    })
  end
   end 
  return index_rec(s, l, i, c);
end end

function index_from_opt(s, i, c) do
  l = #s;
  if (i < 0 or i > l) then do
    error({
      Caml_builtin_exceptions.invalid_argument,
      "String.index_from_opt / Bytes.index_from_opt"
    })
  end
   end 
  return index_rec_opt(s, l, i, c);
end end

function rindex_rec(s, _i, c) do
  while(true) do
    i = _i;
    if (i < 0) then do
      error(Caml_builtin_exceptions.not_found)
    end
     end 
    if (s.charCodeAt(i) == c) then do
      return i;
    end else do
      _i = i - 1 | 0;
      ::continue:: ;
    end end 
  end;
end end

function rindex(s, c) do
  return rindex_rec(s, #s - 1 | 0, c);
end end

function rindex_from(s, i, c) do
  if (i < -1 or i >= #s) then do
    error({
      Caml_builtin_exceptions.invalid_argument,
      "String.rindex_from / Bytes.rindex_from"
    })
  end
   end 
  return rindex_rec(s, i, c);
end end

function rindex_rec_opt(s, _i, c) do
  while(true) do
    i = _i;
    if (i < 0) then do
      return ;
    end else if (s.charCodeAt(i) == c) then do
      return i;
    end else do
      _i = i - 1 | 0;
      ::continue:: ;
    end end  end 
  end;
end end

function rindex_opt(s, c) do
  return rindex_rec_opt(s, #s - 1 | 0, c);
end end

function rindex_from_opt(s, i, c) do
  if (i < -1 or i >= #s) then do
    error({
      Caml_builtin_exceptions.invalid_argument,
      "String.rindex_from_opt / Bytes.rindex_from_opt"
    })
  end
   end 
  return rindex_rec_opt(s, i, c);
end end

function contains_from(s, i, c) do
  l = #s;
  if (i < 0 or i > l) then do
    error({
      Caml_builtin_exceptions.invalid_argument,
      "String.contains_from / Bytes.contains_from"
    })
  end
   end 
  xpcall(function() do
    index_rec(s, l, i, c);
    return true;
  end end,function(exn) do
    if (exn == Caml_builtin_exceptions.not_found) then do
      return false;
    end else do
      error(exn)
    end end 
  end end)
end end

function contains(s, c) do
  return contains_from(s, 0, c);
end end

function rcontains_from(s, i, c) do
  if (i < 0 or i >= #s) then do
    error({
      Caml_builtin_exceptions.invalid_argument,
      "String.rcontains_from / Bytes.rcontains_from"
    })
  end
   end 
  xpcall(function() do
    rindex_rec(s, i, c);
    return true;
  end end,function(exn) do
    if (exn == Caml_builtin_exceptions.not_found) then do
      return false;
    end else do
      error(exn)
    end end 
  end end)
end end

function uppercase_ascii(s) do
  return Caml_bytes.bytes_to_string(Bytes.uppercase_ascii(Caml_bytes.bytes_of_string(s)));
end end

function lowercase_ascii(s) do
  return Caml_bytes.bytes_to_string(Bytes.lowercase_ascii(Caml_bytes.bytes_of_string(s)));
end end

function capitalize_ascii(s) do
  return Caml_bytes.bytes_to_string(Bytes.capitalize_ascii(Caml_bytes.bytes_of_string(s)));
end end

function uncapitalize_ascii(s) do
  return Caml_bytes.bytes_to_string(Bytes.uncapitalize_ascii(Caml_bytes.bytes_of_string(s)));
end end

compare = Caml_primitive.caml_string_compare;

function split_on_char(sep, s) do
  r = --[[ [] ]]0;
  j = #s;
  for i = #s - 1 | 0 , 0 , -1 do
    if (s.charCodeAt(i) == sep) then do
      r = --[[ :: ]]{
        sub(s, i + 1 | 0, (j - i | 0) - 1 | 0),
        r
      };
      j = i;
    end
     end 
  end
  return --[[ :: ]]{
          sub(s, 0, j),
          r
        };
end end

function uppercase(s) do
  return Caml_bytes.bytes_to_string(Bytes.uppercase(Caml_bytes.bytes_of_string(s)));
end end

function lowercase(s) do
  return Caml_bytes.bytes_to_string(Bytes.lowercase(Caml_bytes.bytes_of_string(s)));
end end

function capitalize(s) do
  return Caml_bytes.bytes_to_string(Bytes.capitalize(Caml_bytes.bytes_of_string(s)));
end end

function uncapitalize(s) do
  return Caml_bytes.bytes_to_string(Bytes.uncapitalize(Caml_bytes.bytes_of_string(s)));
end end

fill = Bytes.fill;

blit = Bytes.blit_string;

function equal(prim, prim_1) do
  return prim == prim_1;
end end

exports = {};
exports.make = make;
exports.init = init;
exports.copy = copy;
exports.sub = sub;
exports.fill = fill;
exports.blit = blit;
exports.concat = concat;
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
exports.split_on_char = split_on_char;
return exports;
--[[ No side effect ]]
