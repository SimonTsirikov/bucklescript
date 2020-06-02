--[['use strict';]]

Caml_oo_curry = require "../../lib/js/caml_oo_curry.lua";
CamlinternalOO = require "../../lib/js/camlinternalOO.lua";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions.lua";

shared = {"add"};

__class = CamlinternalOO.create_table({
      "hi",
      "id1",
      "id2",
      "hello"
    });

ids = CamlinternalOO.get_method_labels(__class, {
      "id2",
      "id1",
      "hi",
      "hello"
    });

id2 = ids[0];

id1 = ids[1];

hi = ids[2];

hello = ids[3];

CamlinternalOO.set_methods(__class, {
      hi,
      (function (self$1, v, z) do
          return v + z | 0;
        end end),
      id1,
      (function (self$1) do
          return 3;
        end end),
      id2,
      (function (self$1) do
          return 4;
        end end),
      hello,
      (function (self$1, v) do
          return v;
        end end)
    });

CamlinternalOO.init_class(__class);

u = CamlinternalOO.create_object_opt(0, __class);

__class$1 = CamlinternalOO.create_table({"id"});

id = CamlinternalOO.get_method_label(__class$1, "id");

CamlinternalOO.set_method(__class$1, id, (function (self$2) do
        return "uu";
      end end));

CamlinternalOO.init_class(__class$1);

uu = CamlinternalOO.create_object_opt(0, __class$1);

__class$2 = CamlinternalOO.create_table(shared);

add = CamlinternalOO.get_method_label(__class$2, "add");

CamlinternalOO.set_method(__class$2, add, (function (self$3, x, y) do
        return x + y | 0;
      end end));

CamlinternalOO.init_class(__class$2);

uuu = CamlinternalOO.create_object_opt(0, __class$2);

__class$3 = CamlinternalOO.create_table(shared);

add$1 = CamlinternalOO.get_method_label(__class$3, "add");

CamlinternalOO.set_method(__class$3, add$1, (function (self$4, x, y) do
        return x + y | 0;
      end end));

CamlinternalOO.init_class(__class$3);

v = CamlinternalOO.create_object_opt(0, __class$3);

function test(param) do
  if (Caml_oo_curry.js1(23515, 1, uu) ~= "uu") then do
    throw {
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]]{
            "test_simple_obj.ml",
            21,
            4
          }
        };
  end
   end 
  if (Caml_oo_curry.js3(4846113, 2, uuu, 1, 20) ~= 21) then do
    throw {
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]]{
            "test_simple_obj.ml",
            22,
            4
          }
        };
  end
   end 
  if (Caml_oo_curry.js3(4846113, 3, v, 3, 7) ~= 10) then do
    throw {
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]]{
            "test_simple_obj.ml",
            23,
            4
          }
        };
  end
   end 
  if (Caml_oo_curry.js1(5243894, 4, u) ~= 3) then do
    throw {
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]]{
            "test_simple_obj.ml",
            25,
            4
          }
        };
  end
   end 
  if (Caml_oo_curry.js1(5243895, 5, u) ~= 4) then do
    throw {
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]]{
            "test_simple_obj.ml",
            26,
            4
          }
        };
  end
   end 
  if (Caml_oo_curry.js3(23297, 6, u, 1, 2) ~= 3) then do
    throw {
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]]{
            "test_simple_obj.ml",
            27,
            4
          }
        };
  end
   end 
  if (Caml_oo_curry.js2(616641298, 7, u, 32) == 32) then do
    return 0;
  end else do
    throw {
          Caml_builtin_exceptions.assert_failure,
          --[[ tuple ]]{
            "test_simple_obj.ml",
            28,
            4
          }
        };
  end end 
end end

exports.u = u;
exports.uu = uu;
exports.uuu = uuu;
exports.v = v;
exports.test = test;
--[[ class Not a pure module ]]
