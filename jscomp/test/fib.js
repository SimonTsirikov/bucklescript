'use strict';


function fib(n) do
  if (n == 0 or n == 1) then do
    return 1;
  end else do
    return fib(n - 1 | 0) + fib(n - 2 | 0) | 0;
  end end 
end

function fib2(n) do
  var _a = 1;
  var _b = 1;
  var _i = 0;
  while(true) do
    var i = _i;
    var b = _b;
    var a = _a;
    if (n == i) then do
      return a;
    end else do
      _i = i + 1 | 0;
      _b = a + b | 0;
      _a = b;
      continue ;
    end end 
  end;
end

function fib3(n) do
  var a = 1;
  var b = 1;
  for(var i = 1; i <= n; ++i)do
    var tmp = a;
    a = b;
    b = b + tmp | 0;
  end
  return a;
end

exports.fib = fib;
exports.fib2 = fib2;
exports.fib3 = fib3;
--[ No side effect ]--
