'use strict';

var Bytes = require("../../lib/js/bytes.js");

function gray_encode(b) do
  return b ^ (b >>> 1);
end

function gray_decode(n) do
  var _p = n;
  var _n = (n >>> 1);
  while(true) do
    var n$1 = _n;
    var p = _p;
    if (n$1 == 0) then do
      return p;
    end else do
      _n = (n$1 >>> 1);
      _p = p ^ n$1;
      continue ;
    end end 
  end;
end

function bool_string(len, n) do
  var s = Bytes.make(len, --[ "0" ]--48);
  var _i = len - 1 | 0;
  var _n = n;
  while(true) do
    var n$1 = _n;
    var i = _i;
    if ((n$1 & 1) == 1) then do
      s[i] = --[ "1" ]--49;
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
end

function next_power(v) do
  var v$1 = v - 1 | 0;
  var v$2 = (v$1 >>> 1) | v$1;
  var v$3 = (v$2 >>> 2) | v$2;
  var v$4 = (v$3 >>> 4) | v$3;
  var v$5 = (v$4 >>> 8) | v$4;
  var v$6 = (v$5 >>> 16) | v$5;
  return v$6 + 1 | 0;
end

exports.gray_encode = gray_encode;
exports.gray_decode = gray_decode;
exports.bool_string = bool_string;
exports.next_power = next_power;
--[ No side effect ]--
