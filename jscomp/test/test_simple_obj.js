'use strict';

var Caml_oo_curry = require("../../lib/js/caml_oo_curry.js");
var CamlinternalOO = require("../../lib/js/camlinternalOO.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

var shared = ["add"];

var $$class = CamlinternalOO.create_table([
      "hi",
      "id1",
      "id2",
      "hello"
    ]);

var ids = CamlinternalOO.get_method_labels($$class, [
      "id2",
      "id1",
      "hi",
      "hello"
    ]);

var id2 = ids[0];

var id1 = ids[1];

var hi = ids[2];

var hello = ids[3];

CamlinternalOO.set_methods($$class, [
      hi,
      (function (self$1, v, z) do
          return v + z | 0;
        end),
      id1,
      (function (self$1) do
          return 3;
        end),
      id2,
      (function (self$1) do
          return 4;
        end),
      hello,
      (function (self$1, v) do
          return v;
        end)
    ]);

CamlinternalOO.init_class($$class);

var u = CamlinternalOO.create_object_opt(0, $$class);

var $$class$1 = CamlinternalOO.create_table(["id"]);

var id = CamlinternalOO.get_method_label($$class$1, "id");

CamlinternalOO.set_method($$class$1, id, (function (self$2) do
        return "uu";
      end));

CamlinternalOO.init_class($$class$1);

var uu = CamlinternalOO.create_object_opt(0, $$class$1);

var $$class$2 = CamlinternalOO.create_table(shared);

var add = CamlinternalOO.get_method_label($$class$2, "add");

CamlinternalOO.set_method($$class$2, add, (function (self$3, x, y) do
        return x + y | 0;
      end));

CamlinternalOO.init_class($$class$2);

var uuu = CamlinternalOO.create_object_opt(0, $$class$2);

var $$class$3 = CamlinternalOO.create_table(shared);

var add$1 = CamlinternalOO.get_method_label($$class$3, "add");

CamlinternalOO.set_method($$class$3, add$1, (function (self$4, x, y) do
        return x + y | 0;
      end));

CamlinternalOO.init_class($$class$3);

var v = CamlinternalOO.create_object_opt(0, $$class$3);

function test(param) do
  if (Caml_oo_curry.js1(23515, 1, uu) ~= "uu") then do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "test_simple_obj.ml",
            21,
            4
          ]
        ];
  end
   end 
  if (Caml_oo_curry.js3(4846113, 2, uuu, 1, 20) ~= 21) then do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "test_simple_obj.ml",
            22,
            4
          ]
        ];
  end
   end 
  if (Caml_oo_curry.js3(4846113, 3, v, 3, 7) ~= 10) then do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "test_simple_obj.ml",
            23,
            4
          ]
        ];
  end
   end 
  if (Caml_oo_curry.js1(5243894, 4, u) ~= 3) then do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "test_simple_obj.ml",
            25,
            4
          ]
        ];
  end
   end 
  if (Caml_oo_curry.js1(5243895, 5, u) ~= 4) then do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "test_simple_obj.ml",
            26,
            4
          ]
        ];
  end
   end 
  if (Caml_oo_curry.js3(23297, 6, u, 1, 2) ~= 3) then do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "test_simple_obj.ml",
            27,
            4
          ]
        ];
  end
   end 
  if (Caml_oo_curry.js2(616641298, 7, u, 32) == 32) then do
    return 0;
  end else do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "test_simple_obj.ml",
            28,
            4
          ]
        ];
  end end 
end

exports.u = u;
exports.uu = uu;
exports.uuu = uuu;
exports.v = v;
exports.test = test;
--[ class Not a pure module ]--
