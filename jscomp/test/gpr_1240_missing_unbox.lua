console.log = print;


function f(x, y) do
  x_1 = x;
  y_1 = y;
  return --[[ tuple ]]{
          x_1,
          y_1
        };
end end

exports.f = f;
--[[ No side effect ]]
