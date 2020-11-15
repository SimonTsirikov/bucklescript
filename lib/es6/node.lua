


function test(x) do
  if (type(x) == "string") then do
    return --[[ tuple ]]{
            --[[ String ]]0,
            x
          };
  end else do
    return --[[ tuple ]]{
            --[[ Buffer ]]1,
            x
          };
  end end 
end end

Path = --[[ alias ]]0;

Fs = --[[ alias ]]0;

Process = --[[ alias ]]0;

Module = --[[ alias ]]0;

__Buffer = --[[ alias ]]0;

Child_process = --[[ alias ]]0;

export do
  Path ,
  Fs ,
  Process ,
  Module ,
  __Buffer ,
  Child_process ,
  test ,
  
end
--[[ No side effect ]]
