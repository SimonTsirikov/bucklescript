'use strict';


function ff(x) do
  var a;
  switch (x) do
    case "0" :
    case "1" :
    case "2" :
        a = 3;
        break;
    case "3" :
        a = 4;
        break;
    case "4" :
        a = 6;
        break;
    case "7" :
        a = 7;
        break;
    default:
      a = 8;
  end
  return a + 3 | 0;
end

function f(x) do
  var y;
  y = x.tag ? 4 : 3;
  return y + 32 | 0;
end

function f2(x) do
  var v = 0;
  var y;
  v = 1;
  if (x.tag) then do
    var z = 33;
    y = z + 4 | 0;
  end else do
    var z$1 = 33;
    y = z$1 + 3 | 0;
  end end 
  return y + 32 | 0;
end

function f3(x) do
  var v = 0;
  var y;
  v = 1;
  y = x.tag ? 4 : 3;
  return y + 32 | 0;
end

exports.ff = ff;
exports.f = f;
exports.f2 = f2;
exports.f3 = f3;
--[ No side effect ]--
