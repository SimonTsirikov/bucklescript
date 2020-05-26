

import * as Js_int from "./js_int.js";

function unsafe_ceil(prim) do
  return Math.ceil(prim);
end

function ceil_int(f) do
  if (f > Js_int.max) then do
    return Js_int.max;
  end else if (f < Js_int.min) then do
    return Js_int.min;
  end else do
    return Math.ceil(f);
  end end  end 
end

function unsafe_floor(prim) do
  return Math.floor(prim);
end

function floor_int(f) do
  if (f > Js_int.max) then do
    return Js_int.max;
  end else if (f < Js_int.min) then do
    return Js_int.min;
  end else do
    return Math.floor(f);
  end end  end 
end

function random_int(min, max) do
  return floor_int(Math.random() * (max - min | 0)) + min | 0;
end

ceil = ceil_int;

floor = floor_int;

export do
  unsafe_ceil ,
  ceil_int ,
  ceil ,
  unsafe_floor ,
  floor_int ,
  floor ,
  random_int ,
  
end
--[ No side effect ]--
