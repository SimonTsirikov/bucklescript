console.log = print;

Caml_array = require "./caml_array";
Caml_builtin_exceptions = require "./caml_builtin_exceptions";

caml_methods_cache = Caml_array.caml_make_vect(1000, 0);

function caml_get_public_method(obj, tag, cacheid) do
  meths = obj[0];
  offs = caml_methods_cache[cacheid];
  if (meths[offs] == tag) then do
    return meths[offs - 1 | 0];
  end else do
    aux = function (_i) do
      while(true) do
        i = _i;
        if (i < 3) then do
          error({
            Caml_builtin_exceptions.assert_failure,
            --[[ tuple ]]{
              "caml_oo.ml",
              62,
              20
            }
          })
        end
         end 
        if (meths[i] == tag) then do
          caml_methods_cache[cacheid] = i;
          return i;
        end else do
          _i = i - 2 | 0;
          ::continue:: ;
        end end 
      end;
    end end;
    return meths[aux((meths[0] << 1) + 1 | 0) - 1 | 0];
  end end 
end end

exports.caml_get_public_method = caml_get_public_method;
--[[ No side effect ]]
