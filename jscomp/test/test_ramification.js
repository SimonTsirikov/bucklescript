'use strict';


function ff(x) do
  a;
  local ___conditional___=(x);
  do
     if ___conditional___ = "0"
     or ___conditional___ = "1"
     or ___conditional___ = "2" then do
        a = 3;end else 
     if ___conditional___ = "3" then do
        a = 4;end else 
     if ___conditional___ = "4" then do
        a = 6;end else 
     if ___conditional___ = "7" then do
        a = 7;end else 
     do end end end end end
    else do
      a = 8;
      end end
      
  end
  return a + 3 | 0;
end end

function f(x) do
  y;
  y = x.tag and 4 or 3;
  return y + 32 | 0;
end end

function f2(x) do
  v = 0;
  y;
  v = 1;
  if (x.tag) then do
    z = 33;
    y = z + 4 | 0;
  end else do
    z$1 = 33;
    y = z$1 + 3 | 0;
  end end 
  return y + 32 | 0;
end end

function f3(x) do
  v = 0;
  y;
  v = 1;
  y = x.tag and 4 or 3;
  return y + 32 | 0;
end end

exports.ff = ff;
exports.f = f;
exports.f2 = f2;
exports.f3 = f3;
--[ No side effect ]--
