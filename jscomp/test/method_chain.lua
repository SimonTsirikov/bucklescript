console.log = print;


function f(obj, x, y) do
  return obj.paint(x, y).draw(x, y).bark(x, y);
end end

exports.f = f;
--[[ No side effect ]]
