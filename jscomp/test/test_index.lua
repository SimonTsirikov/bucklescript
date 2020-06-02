console = {log = print};


function ff(x) do
  x.case(3, 2);
  return x.case(3);
end end

function h(x) do
  return x.cse(3)(2);
end end

function f_ext(x) do
  x.cse(3, 2);
  return x.cse(3);
end end

function h_ext(x) do
  return x.cse(3)(2);
end end

exports = {}
exports.ff = ff;
exports.h = h;
exports.f_ext = f_ext;
exports.h_ext = h_ext;
--[[ No side effect ]]
