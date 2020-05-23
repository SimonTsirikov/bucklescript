'use strict';


function f(param) do
  var n = 0;
  while((function () do
          var fib = function (n) do
            if (n == 0 or n == 1) do
              return 1;
            end else do
              return fib(n - 1 | 0) + fib(n - 2 | 0) | 0;
            end
          end;
          return fib(n) > 10;
        end)()) do
    console.log(String(n));
    n = n + 1 | 0;
  end;
  return --[ () ]--0;
end

function ff(param) do
  while((function () do
          var b = 9;
          return (3 + b | 0) > 10;
        end)()) do
    
  end;
  return --[ () ]--0;
end

exports.f = f;
exports.ff = ff;
--[ No side effect ]--
