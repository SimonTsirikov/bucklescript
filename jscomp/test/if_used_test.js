'use strict';

Curry = require("../../lib/js/curry.js");
CamlinternalOO = require("../../lib/js/camlinternalOO.js");

shared = [
  "move",
  "get_x"
];

function point_init($$class) do
  x_init = CamlinternalOO.new_variable($$class, "");
  ids = CamlinternalOO.new_methods_variables($$class, shared, ["x"]);
  move = ids[0];
  get_x = ids[1];
  x = ids[2];
  CamlinternalOO.set_methods($$class, [
        get_x,
        (function (self$1) do
            return self$1[x];
          end end),
        move,
        (function (self$1, d) do
            self$1[x] = self$1[x] + d | 0;
            return --[[ () ]]0;
          end end)
      ]);
  return (function (env, self, x_init$1) do
      self$1 = CamlinternalOO.create_object_opt(self, $$class);
      self$1[x_init] = x_init$1;
      self$1[x] = x_init$1;
      return self$1;
    end end);
end end

point = CamlinternalOO.make_class(shared, point_init);

p = Curry._2(point[0], 0, 7);

exports.point = point;
exports.p = p;
--[[ point Not a pure module ]]
