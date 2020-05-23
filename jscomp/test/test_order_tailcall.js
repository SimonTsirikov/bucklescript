'use strict';


function f(_x, _y) do
  while(true) do
    var y = _y;
    var x = _x;
    _y = x;
    _x = y;
    continue ;
  end;
end

function f1(_x, _y, _z) do
  while(true) do
    var z = _z;
    var y = _y;
    var x = _x;
    console.log(z);
    _z = x;
    _y = z;
    _x = y;
    continue ;
  end;
end

function f2(x, _y) do
  while(true) do
    var y = _y;
    _y = y + 10 | 0;
    continue ;
  end;
end

function f3(_x, _y) do
  while(true) do
    var y = _y;
    var x = _x;
    _y = x + 10 | 0;
    _x = y;
    continue ;
  end;
end

function f4(_x, _y) do
  while(true) do
    var y = _y;
    var x = _x;
    _y = y + x | 0;
    _x = x + 10 | 0;
    continue ;
  end;
end

function f5(_x, _y, z) do
  while(true) do
    var y = _y;
    _y = z + 20 | 0;
    _x = y + 10 | 0;
    continue ;
  end;
end

function f6(b) do
  while(true) do
    if (b) then do
      continue ;
    end else do
      return false;
    end end 
  end;
end

function f7(b) do
  while(true) do
    if (b) then do
      return true;
    end else do
      continue ;
    end end 
  end;
end

function f8(_x, _y) do
  while(true) do
    var y = _y;
    var x = _x;
    if (x > 10) then do
      _y = y + 1 | 0;
      continue ;
    end else if (x < 5) then do
      _x = x - 1 | 0;
      continue ;
    end else if (x > 6) then do
      _x = x - 2 | 0;
      continue ;
    end else do
      return f8(x, y + 1 | 0) + f8(x - 1 | 0, y) | 0;
    end end  end  end 
  end;
end

exports.f = f;
exports.f1 = f1;
exports.f2 = f2;
exports.f3 = f3;
exports.f4 = f4;
exports.f5 = f5;
exports.f6 = f6;
exports.f7 = f7;
exports.f8 = f8;
--[ No side effect ]--
