--[['use strict';]]

Curry = require "../../lib/js/curry";

v = do
  contents: 0
end;

function f(x, x$1) do
  v.contents = v.contents + 1 | 0;
  return x$1 + x$1 | 0;
end end

function __return(param) do
  return v.contents;
end end

function Make(U) do
  h = function (x, x$1) do
    console.log(f(x$1, x$1));
    return Curry._2(U.say, x$1, x$1);
  end end;
  return do
          h: h
        end;
end end

exports.v = v;
exports.f = f;
exports.__return = __return;
exports.Make = Make;
--[[ No side effect ]]
