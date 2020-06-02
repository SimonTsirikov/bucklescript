--[['use strict';]]


function f(param) do
  n = 0;
  while((function () do
          fib = function (n) do
            if (n == 0 or n == 1) then do
              return 1;
            end else do
              return fib(n - 1 | 0) + fib(n - 2 | 0) | 0;
            end end 
          end end;
          return fib(n) > 10;
        end end)()) do
    console.log(String(n));
    n = n + 1 | 0;
  end;
  return --[[ () ]]0;
end end

function ff(param) do
  while((function () do
          b = 9;
          return (3 + b | 0) > 10;
        end end)()) do
    
  end;
  return --[[ () ]]0;
end end

exports.f = f;
exports.ff = ff;
--[[ No side effect ]]
