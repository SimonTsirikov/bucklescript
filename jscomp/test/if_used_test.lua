console = {log = print};

Curry = require "../../lib/js/curry";
CamlinternalOO = require "../../lib/js/camlinternalOO";

shared = {
  "move",
  "get_x"
};

function point_init(__class) do
  x_init = CamlinternalOO.new_variable(__class, "");
  ids = CamlinternalOO.new_methods_variables(__class, shared, {"x"});
  move = ids[0];
  get_x = ids[1];
  x = ids[2];
  CamlinternalOO.set_methods(__class, {
        get_x,
        (function(self$1) do
            return self$1[x];
          end end),
        move,
        (function(self$1, d) do
            self$1[x] = self$1[x] + d | 0;
            return --[[ () ]]0;
          end end)
      });
  return (function(env, self, x_init_1) do
      self_1 = CamlinternalOO.create_object_opt(self, __class);
      self_1[x_init] = x_init_1;
      self_1[x] = x_init_1;
      return self_1;
    end end);
end end

point = CamlinternalOO.make_class(shared, point_init);

p = Curry._2(point[0], 0, 7);

exports = {}
exports.point = point;
exports.p = p;
--[[ point Not a pure module ]]
