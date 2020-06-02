console = {log = print};


v = do
  contents: 0
end;

while(console.log(String(v.contents)), v.contents = v.contents + 1 | 0, v.contents < 10) do
  
end;

function fib(n) do
  if (n == 0 or n == 1) then do
    return 1;
  end else do
    return fib(n - 1 | 0) + fib(n - 2 | 0) | 0;
  end end 
end end

x = do
  contents: 3
end;

while((function() do
        y = 3;
        console.log(String(x.contents));
        y = y + 1 | 0;
        x.contents = x.contents + 1 | 0;
        return (fib(x.contents) + fib(x.contents) | 0) < 20;
      end end)()) do
  console.log(String(3));
end;

exports = {}
exports.v = v;
exports.fib = fib;
exports.x = x;
--[[  Not a pure module ]]
