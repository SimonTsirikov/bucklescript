console = {log = print};


function sum(a,b)do 
  return a + b
end;

v = sum(1, 2);

function f(a) do
  return a + 3 | 0;
end end

b = f(1);

c = f(2);

function forIn(o,foo)do
  for (var i in o){
    foo(o)
  }
  end;

function log(x) do
  console.log(x);
  return --[[ () ]]0;
end end

N = {
  log2 = log
};

forIn({
      x = 3
    }, (function(x) do
        console.log(x);
        return --[[ () ]]0;
      end end));

forIn({
      x = 3,
      y = 3
    }, (function(x) do
        console.log(x);
        return --[[ () ]]0;
      end end));

function f3()doreturn trueend;

bbbb = f3();

exports = {}
exports.sum = sum;
exports.v = v;
exports.f = f;
exports.b = b;
exports.c = c;
exports.forIn = forIn;
exports.N = N;
exports.f3 = f3;
exports.bbbb = bbbb;
--[[ v Not a pure module ]]
