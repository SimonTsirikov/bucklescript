__console = {log = print};


function add(x,y){
  return x + y
}
;

__console.log(add(3.0, 2.0));

__console.log(add("x", "y"));

function add_dyn(kind,x,y){
  switch(kind){
  case "string" : return x + y;
  case "float" : return x + y;
  }
}
;

function string_of_kind(kind) do
  if (kind) then do
    return "string";
  end else do
    return "float";
  end end 
end end

function add2(k, x, y) do
  return add_dyn(k and "string" or "float", x, y);
end end

__console.log(add2(--[[ Float ]]0, 3.0, 2.0));

__console.log(add2(--[[ String ]]1, "x", "y"));

exports = {};
exports.string_of_kind = string_of_kind;
exports.add2 = add2;
return exports;
--[[  Not a pure module ]]
