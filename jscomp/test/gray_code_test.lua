--[['use strict';]]

Bytes = require "../../lib/js/bytes";

function gray_encode(b) do
  return b ^ (b >>> 1);
end end

function gray_decode(n) do
  _p = n;
  _n = (n >>> 1);
  while(true) do
    n_1 = _n;
    p = _p;
    if (n_1 == 0) then do
      return p;
    end else do
      _n = (n_1 >>> 1);
      _p = p ^ n_1;
      ::continue:: ;
    end end 
  end;
end end

function bool_string(len, n) do
  s = Bytes.make(len, --[[ "0" ]]48);
  _i = len - 1 | 0;
  _n = n;
  while(true) do
    n_1 = _n;
    i = _i;
    if ((n_1 & 1) == 1) then do
      s[i] = --[[ "1" ]]49;
    end
     end 
    if (i <= 0) then do
      return s;
    end else do
      _n = (n_1 >>> 1);
      _i = i - 1 | 0;
      ::continue:: ;
    end end 
  end;
end end

function next_power(v) do
  v_1 = v - 1 | 0;
  v_2 = (v_1 >>> 1) | v_1;
  v_3 = (v_2 >>> 2) | v_2;
  v_4 = (v_3 >>> 4) | v_3;
  v_5 = (v_4 >>> 8) | v_4;
  v_6 = (v_5 >>> 16) | v_5;
  return v_6 + 1 | 0;
end end

exports.gray_encode = gray_encode;
exports.gray_decode = gray_decode;
exports.bool_string = bool_string;
exports.next_power = next_power;
--[[ No side effect ]]
