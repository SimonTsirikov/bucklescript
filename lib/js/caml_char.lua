console.log = print;


function caml_is_printable(c) do
  if (c > 31) then do
    return c < 127;
  end else do
    return false;
  end end 
end end

exports.caml_is_printable = caml_is_printable;
--[[ No side effect ]]
