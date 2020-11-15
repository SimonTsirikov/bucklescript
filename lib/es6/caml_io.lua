

local Curry = require "..curry.lua";

stdout = {
  buffer = "",
  output = (function(param, s) do
      v = #s - 1 | 0;
      if (((typeof process !== "undefined") && process.stdout && process.stdout.write)) then do
        return process.stdout.write(s);
      end else if (string.sub(s, v, v) == "\n") then do
        __console.log(s.slice(0, v));
        return --[[ () ]]0;
      end else do
        __console.log(s);
        return --[[ () ]]0;
      end end  end 
    end end)
};

stderr = {
  buffer = "",
  output = (function(param, s) do
      v = #s - 1 | 0;
      if (string.sub(s, v, v) == "\n") then do
        __console.log(s.slice(0, v));
        return --[[ () ]]0;
      end else do
        __console.log(s);
        return --[[ () ]]0;
      end end 
    end end)
};

function caml_ml_flush(oc) do
  if (oc.buffer ~= "") then do
    Curry._2(oc.output, oc, oc.buffer);
    oc.buffer = "";
    return --[[ () ]]0;
  end else do
    return 0;
  end end 
end end

function caml_ml_output(oc, str, offset, len) do
  str_1 = offset == 0 and len == #str and str or str.slice(offset, len);
  if (((typeof process !== "undefined") && process.stdout && process.stdout.write) and oc == stdout) then do
    return process.stdout.write(str_1);
  end else do
    id = str_1.lastIndexOf("\n");
    if (id < 0) then do
      oc.buffer = oc.buffer .. str_1;
      return --[[ () ]]0;
    end else do
      oc.buffer = oc.buffer .. str_1.slice(0, id + 1 | 0);
      caml_ml_flush(oc);
      oc.buffer = oc.buffer .. str_1.slice(id + 1 | 0);
      return --[[ () ]]0;
    end end 
  end end 
end end

function caml_ml_output_char(oc, __char) do
  return caml_ml_output(oc, __String.fromCharCode(__char), 0, 1);
end end

function caml_ml_out_channels_list(param) do
  return --[[ :: ]]{
          stdout,
          --[[ :: ]]{
            stderr,
            --[[ [] ]]0
          }
        };
end end

stdin = nil;

export do
  stdin ,
  stdout ,
  stderr ,
  caml_ml_flush ,
  caml_ml_output ,
  caml_ml_output_char ,
  caml_ml_out_channels_list ,
  
end
--[[ No side effect ]]
