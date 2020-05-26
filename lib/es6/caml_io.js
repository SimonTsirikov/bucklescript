

import * as Curry from "./curry.js";

stdout = do
  buffer: "",
  output: (function (param, s) do
      v = #s - 1 | 0;
      if (((typeof process !== "undefined") && process.stdout && process.stdout.write)) then do
        return process.stdout.write(s);
      end else if (s[v] == "\n") then do
        console.log(s.slice(0, v));
        return --[ () ]--0;
      end else do
        console.log(s);
        return --[ () ]--0;
      end end  end 
    end)
end;

stderr = do
  buffer: "",
  output: (function (param, s) do
      v = #s - 1 | 0;
      if (s[v] == "\n") then do
        console.log(s.slice(0, v));
        return --[ () ]--0;
      end else do
        console.log(s);
        return --[ () ]--0;
      end end 
    end)
end;

function caml_ml_flush(oc) do
  if (oc.buffer ~= "") then do
    Curry._2(oc.output, oc, oc.buffer);
    oc.buffer = "";
    return --[ () ]--0;
  end else do
    return 0;
  end end 
end

function caml_ml_output(oc, str, offset, len) do
  str$1 = offset == 0 and len == #str and str or str.slice(offset, len);
  if (((typeof process !== "undefined") && process.stdout && process.stdout.write) and oc == stdout) then do
    return process.stdout.write(str$1);
  end else do
    id = str$1.lastIndexOf("\n");
    if (id < 0) then do
      oc.buffer = oc.buffer .. str$1;
      return --[ () ]--0;
    end else do
      oc.buffer = oc.buffer .. str$1.slice(0, id + 1 | 0);
      caml_ml_flush(oc);
      oc.buffer = oc.buffer .. str$1.slice(id + 1 | 0);
      return --[ () ]--0;
    end end 
  end end 
end

function caml_ml_output_char(oc, $$char) do
  return caml_ml_output(oc, String.fromCharCode($$char), 0, 1);
end

function caml_ml_out_channels_list(param) do
  return --[ :: ]--[
          stdout,
          --[ :: ]--[
            stderr,
            --[ [] ]--0
          ]
        ];
end

stdin = undefined;

export do
  stdin ,
  stdout ,
  stderr ,
  caml_ml_flush ,
  caml_ml_output ,
  caml_ml_output_char ,
  caml_ml_out_channels_list ,
  
end
--[ No side effect ]--
