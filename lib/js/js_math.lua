console = {log = print};

Js_int = require "./js_int";

function unsafe_ceil(prim) do
  return Math.ceil(prim);
end end

function ceil_int(f) do
  if (f > Js_int.max) then do
    return Js_int.max;
  end else if (f < Js_int.min) then do
    return Js_int.min;
  end else do
    return Math.ceil(f);
  end end  end 
end end

function unsafe_floor(prim) do
  return Math.floor(prim);
end end

function floor_int(f) do
  if (f > Js_int.max) then do
    return Js_int.max;
  end else if (f < Js_int.min) then do
    return Js_int.min;
  end else do
    return Math.floor(f);
  end end  end 
end end

function random_int(min, max) do
  return floor_int(Math.random() * (max - min | 0)) + min | 0;
end end

ceil = ceil_int;

floor = floor_int;

exports = {}
exports.unsafe_ceil = unsafe_ceil;
exports.ceil_int = ceil_int;
exports.ceil = ceil;
exports.unsafe_floor = unsafe_floor;
exports.floor_int = floor_int;
exports.floor = floor;
exports.random_int = random_int;
--[[ No side effect ]]
