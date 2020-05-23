'use strict';


function test3(_n) do
  while(true) do
    var n = _n;
    if (n == 0) do
      return (n + 5 | 0) + 4 | 0;
    end else do
      _n = n - 1 | 0;
      continue ;
    end
  end;
end

function test2(_n) do
  while(true) do
    var n = _n;
    if (n == 0) do
      return test3(n) + 3 | 0;
    end else do
      _n = n - 1 | 0;
      continue ;
    end
  end;
end

function test0(_n) do
  while(true) do
    var n = _n;
    if (n == 0) do
      var _n$1 = n;
      while(true) do
        var n$1 = _n$1;
        if (n$1 == 0) do
          return test2(n$1) + 2 | 0;
        end else do
          _n$1 = n$1 - 1 | 0;
          continue ;
        end
      end;
    end else do
      _n = n - 1 | 0;
      continue ;
    end
  end;
end

var v = test0(10);

test0(10) + 2 | 0;

exports.v = v;
--[ v Not a pure module ]--
