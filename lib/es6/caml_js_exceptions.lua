

import * as Caml_option from "./caml_option.lua";
import * as Caml_exceptions from "./caml_exceptions.lua";

__Error = Caml_exceptions.create("Caml_js_exceptions.Error");

function internalToOCamlException(e) do
  if (Caml_exceptions.caml_is_extension(e)) then do
    return e;
  end else do
    return [
            __Error,
            e
          ];
  end end 
end end

function caml_as_js_exn(exn) do
  if (exn[0] == __Error) then do
    return Caml_option.some(exn[1]);
  end
   end 
end end

export do
  __Error ,
  internalToOCamlException ,
  caml_as_js_exn ,
  
end
--[[ No side effect ]]
