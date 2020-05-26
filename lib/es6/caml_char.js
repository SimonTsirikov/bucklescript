


function caml_is_printable(c) do
  if (c > 31) then do
    return c < 127;
  end else do
    return false;
  end end 
end end

export do
  caml_is_printable ,
  
end
--[ No side effect ]--
