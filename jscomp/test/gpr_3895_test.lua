console.log = print;


function f(re) do
  re.exec("banana");
  return 3;
end end

exports.f = f;
--[[ No side effect ]]
