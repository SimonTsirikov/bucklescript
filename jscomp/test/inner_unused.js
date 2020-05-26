'use strict';


function f(x) do
  return x + 3 | 0;
end

function M(S) do
  f = function (x) do
    return x;
  end;
  return do
          f: f
        end;
end

function fff(param, param$1) do
  return 3;
end

exports.f = f;
exports.M = M;
exports.fff = fff;
--[ No side effect ]--
