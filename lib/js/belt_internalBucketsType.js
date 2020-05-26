'use strict';


function power_2_above(_x, n) do
  while(true) do
    var x = _x;
    if (x >= n or (x << 1) < x) then do
      return x;
    end else do
      _x = (x << 1);
      continue ;
    end end 
  end;
end

function make(hash, eq, hintSize) do
  var s = power_2_above(16, hintSize);
  return do
          size: 0,
          buckets: new Array(s),
          hash: hash,
          eq: eq
        end;
end

function clear(h) do
  h.size = 0;
  var h_buckets = h.buckets;
  var len = #h_buckets;
  for var i = 0 , len - 1 | 0 , 1 do
    h_buckets[i] = undefined;
  end
  return --[ () ]--0;
end

function isEmpty(h) do
  return h.size == 0;
end

var emptyOpt = undefined;

exports.emptyOpt = emptyOpt;
exports.make = make;
exports.clear = clear;
exports.isEmpty = isEmpty;
--[ No side effect ]--
