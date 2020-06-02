--[['use strict';]]

Bytes = require "../../lib/js/bytes.lua";

function gray_encode(b) do
  return b ^ (b >>> 1);
end end

function gray_decode(n) do
  _p = n;
  _n = (n >>> 1);
  while(true) do
    n$1 = _n;
    p = _p;
    if (n$1 == 0) then do
      return p;
    end else do
      _n = (n$1 >>> 1);
      _p = p ^ n$1;
      continue ;
    end end 
  end;
end end

function bool_string(len, n) do
  s = Bytes.make(len, --[[ "0" ]]48);
  _i = len - 1 | 0;
  _n = n;
  while(true) do
    n$1 = _n;
    i = _i;
    if ((n$1 & 1) == 1) then do
      s[i] = --[[ "1" ]]49;
    end
     end 
    if (i <= 0) then do
      return s;
    end else do
      _n = (n$1 >>> 1);
      _i = i - 1 | 0;
      continue ;
    end end 
  end;
end end

function next_power(v) do
  v$1 = v - 1 | 0;
  v$2 = (v$1 >>> 1) | v$1;
  v$3 = (v$2 >>> 2) | v$2;
  v$4 = (v$3 >>> 4) | v$3;
  v$5 = (v$4 >>> 8) | v$4;
  v$6 = (v$5 >>> 16) | v$5;
  return v$6 + 1 | 0;
end end

exports.gray_encode = gray_encode;
exports.gray_decode = gray_decode;
exports.bool_string = bool_string;
exports.next_power = next_power;
--[[ No side effect ]]
