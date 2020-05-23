'use strict';


function f0(x) do
  return x;
end

function f1(x) do
  return 2;
end

function f3(x) do
  if (x ~= undefined) do
    return x;
  end else do
    return --[ A ]--0;
  end
end

var v0 = --[ () ]--0;

exports.f0 = f0;
exports.f1 = f1;
exports.f3 = f3;
exports.v0 = v0;
--[ No side effect ]--
