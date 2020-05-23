'use strict';

var Bytes = require("./bytes.js");
var Curry = require("./curry.js");
var $$String = require("./string.js");
var Caml_bytes = require("./caml_bytes.js");
var Pervasives = require("./pervasives.js");
var Caml_string = require("./caml_string.js");
var Caml_builtin_exceptions = require("./caml_builtin_exceptions.js");

function create(n) do
  var n$1 = n < 1 ? 1 : n;
  var s = Caml_bytes.caml_create_bytes(n$1);
  return do
          buffer: s,
          position: 0,
          length: n$1,
          initial_buffer: s
        end;
end

function contents(b) do
  return Bytes.sub_string(b.buffer, 0, b.position);
end

function to_bytes(b) do
  return Bytes.sub(b.buffer, 0, b.position);
end

function sub(b, ofs, len) do
  if (ofs < 0 or len < 0 or ofs > (b.position - len | 0)) do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Buffer.sub"
        ];
  end
  return Bytes.sub_string(b.buffer, ofs, len);
end

function blit(src, srcoff, dst, dstoff, len) do
  if (len < 0 or srcoff < 0 or srcoff > (src.position - len | 0) or dstoff < 0 or dstoff > (#dst - len | 0)) do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Buffer.blit"
        ];
  end
  return Caml_bytes.caml_blit_bytes(src.buffer, srcoff, dst, dstoff, len);
end

function nth(b, ofs) do
  if (ofs < 0 or ofs >= b.position) do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Buffer.nth"
        ];
  end
  return b.buffer[ofs];
end

function length(b) do
  return b.position;
end

function clear(b) do
  b.position = 0;
  return --[ () ]--0;
end

function reset(b) do
  b.position = 0;
  b.buffer = b.initial_buffer;
  b.length = #b.buffer;
  return --[ () ]--0;
end

function resize(b, more) do
  var len = b.length;
  var new_len = len;
  while((b.position + more | 0) > new_len) do
    new_len = (new_len << 1);
  end;
  var new_buffer = Caml_bytes.caml_create_bytes(new_len);
  Bytes.blit(b.buffer, 0, new_buffer, 0, b.position);
  b.buffer = new_buffer;
  b.length = new_len;
  return --[ () ]--0;
end

function add_char(b, c) do
  var pos = b.position;
  if (pos >= b.length) do
    resize(b, 1);
  end
  b.buffer[pos] = c;
  b.position = pos + 1 | 0;
  return --[ () ]--0;
end

function add_utf_8_uchar(b, u) do
  var u$1 = u;
  if (u$1 < 0) do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "buffer.ml",
            90,
            19
          ]
        ];
  end
  if (u$1 <= 127) do
    return add_char(b, u$1);
  end else if (u$1 <= 2047) do
    var pos = b.position;
    if ((pos + 2 | 0) > b.length) do
      resize(b, 2);
    end
    b.buffer[pos] = 192 | (u$1 >>> 6);
    b.buffer[pos + 1 | 0] = 128 | u$1 & 63;
    b.position = pos + 2 | 0;
    return --[ () ]--0;
  end else if (u$1 <= 65535) do
    var pos$1 = b.position;
    if ((pos$1 + 3 | 0) > b.length) do
      resize(b, 3);
    end
    b.buffer[pos$1] = 224 | (u$1 >>> 12);
    b.buffer[pos$1 + 1 | 0] = 128 | (u$1 >>> 6) & 63;
    b.buffer[pos$1 + 2 | 0] = 128 | u$1 & 63;
    b.position = pos$1 + 3 | 0;
    return --[ () ]--0;
  end else if (u$1 <= 1114111) do
    var pos$2 = b.position;
    if ((pos$2 + 4 | 0) > b.length) do
      resize(b, 4);
    end
    b.buffer[pos$2] = 240 | (u$1 >>> 18);
    b.buffer[pos$2 + 1 | 0] = 128 | (u$1 >>> 12) & 63;
    b.buffer[pos$2 + 2 | 0] = 128 | (u$1 >>> 6) & 63;
    b.buffer[pos$2 + 3 | 0] = 128 | u$1 & 63;
    b.position = pos$2 + 4 | 0;
    return --[ () ]--0;
  end else do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "buffer.ml",
            123,
            8
          ]
        ];
  end
end

function add_utf_16be_uchar(b, u) do
  var u$1 = u;
  if (u$1 < 0) do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "buffer.ml",
            126,
            19
          ]
        ];
  end
  if (u$1 <= 65535) do
    var pos = b.position;
    if ((pos + 2 | 0) > b.length) do
      resize(b, 2);
    end
    b.buffer[pos] = (u$1 >>> 8);
    b.buffer[pos + 1 | 0] = u$1 & 255;
    b.position = pos + 2 | 0;
    return --[ () ]--0;
  end else if (u$1 <= 1114111) do
    var u$prime = u$1 - 65536 | 0;
    var hi = 55296 | (u$prime >>> 10);
    var lo = 56320 | u$prime & 1023;
    var pos$1 = b.position;
    if ((pos$1 + 4 | 0) > b.length) do
      resize(b, 4);
    end
    b.buffer[pos$1] = (hi >>> 8);
    b.buffer[pos$1 + 1 | 0] = hi & 255;
    b.buffer[pos$1 + 2 | 0] = (lo >>> 8);
    b.buffer[pos$1 + 3 | 0] = lo & 255;
    b.position = pos$1 + 4 | 0;
    return --[ () ]--0;
  end else do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "buffer.ml",
            144,
            8
          ]
        ];
  end
end

function add_utf_16le_uchar(b, u) do
  var u$1 = u;
  if (u$1 < 0) do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "buffer.ml",
            147,
            19
          ]
        ];
  end
  if (u$1 <= 65535) do
    var pos = b.position;
    if ((pos + 2 | 0) > b.length) do
      resize(b, 2);
    end
    b.buffer[pos] = u$1 & 255;
    b.buffer[pos + 1 | 0] = (u$1 >>> 8);
    b.position = pos + 2 | 0;
    return --[ () ]--0;
  end else if (u$1 <= 1114111) do
    var u$prime = u$1 - 65536 | 0;
    var hi = 55296 | (u$prime >>> 10);
    var lo = 56320 | u$prime & 1023;
    var pos$1 = b.position;
    if ((pos$1 + 4 | 0) > b.length) do
      resize(b, 4);
    end
    b.buffer[pos$1] = hi & 255;
    b.buffer[pos$1 + 1 | 0] = (hi >>> 8);
    b.buffer[pos$1 + 2 | 0] = lo & 255;
    b.buffer[pos$1 + 3 | 0] = (lo >>> 8);
    b.position = pos$1 + 4 | 0;
    return --[ () ]--0;
  end else do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "buffer.ml",
            165,
            8
          ]
        ];
  end
end

function add_substring(b, s, offset, len) do
  if (offset < 0 or len < 0 or offset > (#s - len | 0)) do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Buffer.add_substring/add_subbytes"
        ];
  end
  var new_position = b.position + len | 0;
  if (new_position > b.length) do
    resize(b, len);
  end
  Bytes.blit_string(s, offset, b.buffer, b.position, len);
  b.position = new_position;
  return --[ () ]--0;
end

function add_subbytes(b, s, offset, len) do
  return add_substring(b, Caml_bytes.bytes_to_string(s), offset, len);
end

function add_string(b, s) do
  var len = #s;
  var new_position = b.position + len | 0;
  if (new_position > b.length) do
    resize(b, len);
  end
  Bytes.blit_string(s, 0, b.buffer, b.position, len);
  b.position = new_position;
  return --[ () ]--0;
end

function add_bytes(b, s) do
  return add_string(b, Caml_bytes.bytes_to_string(s));
end

function add_buffer(b, bs) do
  return add_subbytes(b, bs.buffer, 0, bs.position);
end

function add_channel(b, ic, len) do
  if (len < 0) do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Buffer.add_channel"
        ];
  end
  if ((b.position + len | 0) > b.length) do
    resize(b, len);
  end
  var b$1 = b;
  var ic$1 = ic;
  var _len = len;
  while(true) do
    var len$1 = _len;
    if (len$1 > 0) do
      var n = Pervasives.input(ic$1, b$1.buffer, b$1.position, len$1);
      b$1.position = b$1.position + n | 0;
      if (n == 0) do
        throw Caml_builtin_exceptions.end_of_file;
      end
      _len = len$1 - n | 0;
      continue ;
    end else do
      return 0;
    end
  end;
end

function output_buffer(oc, b) do
  return Pervasives.output(oc, b.buffer, 0, b.position);
end

function closing(param) do
  if (param ~= 40) do
    if (param ~= 123) do
      throw [
            Caml_builtin_exceptions.assert_failure,
            --[ tuple ]--[
              "buffer.ml",
              216,
              9
            ]
          ];
    end else do
      return --[ "}" ]--125;
    end
  end else do
    return --[ ")" ]--41;
  end
end

function advance_to_closing(opening, closing, k, s, start) do
  var _k = k;
  var _i = start;
  var lim = #s;
  while(true) do
    var i = _i;
    var k$1 = _k;
    if (i >= lim) do
      throw Caml_builtin_exceptions.not_found;
    end
    if (Caml_string.get(s, i) == opening) do
      _i = i + 1 | 0;
      _k = k$1 + 1 | 0;
      continue ;
    end else if (Caml_string.get(s, i) == closing) do
      if (k$1 == 0) do
        return i;
      end else do
        _i = i + 1 | 0;
        _k = k$1 - 1 | 0;
        continue ;
      end
    end else do
      _i = i + 1 | 0;
      continue ;
    end
  end;
end

function advance_to_non_alpha(s, start) do
  var _i = start;
  var lim = #s;
  while(true) do
    var i = _i;
    if (i >= lim) do
      return lim;
    end else do
      var match = Caml_string.get(s, i);
      if (match >= 91) do
        if (match >= 97) do
          if (match >= 123) do
            return i;
          end
          
        end else if (match ~= 95) do
          return i;
        end
        
      end else if (match >= 58) do
        if (match < 65) do
          return i;
        end
        
      end else if (match < 48) do
        return i;
      end
      _i = i + 1 | 0;
      continue ;
    end
  end;
end

function find_ident(s, start, lim) do
  if (start >= lim) do
    throw Caml_builtin_exceptions.not_found;
  end
  var c = Caml_string.get(s, start);
  if (c ~= 40 and c ~= 123) do
    var stop = advance_to_non_alpha(s, start + 1 | 0);
    return --[ tuple ]--[
            $$String.sub(s, start, stop - start | 0),
            stop
          ];
  end
  var new_start = start + 1 | 0;
  var stop$1 = advance_to_closing(c, closing(c), 0, s, new_start);
  return --[ tuple ]--[
          $$String.sub(s, new_start, (stop$1 - start | 0) - 1 | 0),
          stop$1 + 1 | 0
        ];
end

function add_substitute(b, f, s) do
  var lim = #s;
  var _previous = --[ " " ]--32;
  var _i = 0;
  while(true) do
    var i = _i;
    var previous = _previous;
    if (i < lim) do
      var current = Caml_string.get(s, i);
      if (current ~= 36) do
        if (previous == --[ "\\" ]--92) do
          add_char(b, --[ "\\" ]--92);
          add_char(b, current);
          _i = i + 1 | 0;
          _previous = --[ " " ]--32;
          continue ;
        end else if (current ~= 92) do
          add_char(b, current);
          _i = i + 1 | 0;
          _previous = current;
          continue ;
        end else do
          _i = i + 1 | 0;
          _previous = current;
          continue ;
        end
      end else if (previous == --[ "\\" ]--92) do
        add_char(b, current);
        _i = i + 1 | 0;
        _previous = --[ " " ]--32;
        continue ;
      end else do
        var j = i + 1 | 0;
        var match = find_ident(s, j, lim);
        add_string(b, Curry._1(f, match[0]));
        _i = match[1];
        _previous = --[ " " ]--32;
        continue ;
      end
    end else if (previous == --[ "\\" ]--92) do
      return add_char(b, previous);
    end else do
      return 0;
    end
  end;
end

function truncate(b, len) do
  if (len < 0 or len > b.position) do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Buffer.truncate"
        ];
  end
  b.position = len;
  return --[ () ]--0;
end

exports.create = create;
exports.contents = contents;
exports.to_bytes = to_bytes;
exports.sub = sub;
exports.blit = blit;
exports.nth = nth;
exports.length = length;
exports.clear = clear;
exports.reset = reset;
exports.add_char = add_char;
exports.add_utf_8_uchar = add_utf_8_uchar;
exports.add_utf_16le_uchar = add_utf_16le_uchar;
exports.add_utf_16be_uchar = add_utf_16be_uchar;
exports.add_string = add_string;
exports.add_bytes = add_bytes;
exports.add_substring = add_substring;
exports.add_subbytes = add_subbytes;
exports.add_substitute = add_substitute;
exports.add_buffer = add_buffer;
exports.add_channel = add_channel;
exports.output_buffer = output_buffer;
exports.truncate = truncate;
--[ No side effect ]--
