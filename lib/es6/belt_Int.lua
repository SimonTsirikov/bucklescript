


function fromString(i) do
  i_1 = parseInt(i, 10);
  if (isNaN(i_1)) then do
    return ;
  end else do
    return i_1;
  end end 
end end

export do
  fromString ,
  
end
--[[ No side effect ]]
