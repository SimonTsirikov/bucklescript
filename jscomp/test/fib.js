'use strict';


function fib(n) do
  if (n == 0 or n == 1) then do
    return 1;
  end else do
    return fib(n - 1 | 0) + fib(n - 2 | 0) | 0;
  end end 
end end

function fib2(n) do
  _a = 1;
  _b = 1;
  _i = 0;
  while(true) do
    i = _i;
    b = _b;
    a = _a;
    if (n == i) then do
      return a;
    end else do
      _i = i + 1 | 0;
      _b = a + b | 0;
      _a = b;
      continue ;
    end end 
  end;
end end

function fib3(n) do
  a = 1;
  b = 1;
  for i = 1 , n , 1 do
    tmp = a;
    a = b;
    b = b + tmp | 0;
  end
  return a;
end end

exports.fib = fib;
exports.fib2 = fib2;
exports.fib3 = fib3;
--[ No side effect ]--
