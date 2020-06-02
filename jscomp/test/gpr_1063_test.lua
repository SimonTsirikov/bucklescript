console = {log = print};


function bla(foo, bar, baz) do
  return foo["##"](bar, baz);
end end

function bla2(foo, bar, baz) do
  return foo.bar.baz;
end end

function bla3(foo, bar, baz) do
  return foo["##"](bar, baz);
end end

function bla4(foo, x, y) do
  return foo.method1(x, y);
end end

function bla5(foo, x, y) do
  return foo.method1(x, y);
end end

exports = {}
exports.bla = bla;
exports.bla2 = bla2;
exports.bla3 = bla3;
exports.bla4 = bla4;
exports.bla5 = bla5;
--[[ No side effect ]]
