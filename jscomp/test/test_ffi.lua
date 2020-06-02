console.log = print;


function v(u) do
  console.log(u);
  return u;
end end

exports.v = v;
--[[ No side effect ]]
