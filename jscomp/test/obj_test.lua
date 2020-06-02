--[['use strict';]]

Mt = require "./mt";
Block = require "../../lib/js/block";
Curry = require "../../lib/js/curry";
Caml_oo_curry = require "../../lib/js/caml_oo_curry";
CamlinternalOO = require "../../lib/js/camlinternalOO";

shared = {
  "hi",
  "hello"
};

shared_1 = {
  "hi",
  "add"
};

__class = CamlinternalOO.create_table(shared);

ids = CamlinternalOO.get_method_labels(__class, shared);

hi = ids[0];

hello = ids[1];

CamlinternalOO.set_methods(__class, {
      hi,
      (function (self$1, x, y) do
          return x + y | 0;
        end end),
      hello,
      (function (self$1, z) do
          return Curry._3(self$1[0][hi], self$1, 10, z);
        end end)
    });

CamlinternalOO.init_class(__class);

vv = CamlinternalOO.create_object_opt(0, __class);

__class_1 = CamlinternalOO.create_table({
      "x",
      "y"
    });

ids_1 = CamlinternalOO.get_method_labels(__class_1, {
      "y",
      "x"
    });

y = ids_1[0];

x = ids_1[1];

CamlinternalOO.set_methods(__class_1, {
      x,
      (function (self$2) do
          return 3;
        end end),
      y,
      (function (self$2) do
          return 32;
        end end)
    });

CamlinternalOO.init_class(__class_1);

v = CamlinternalOO.create_object_opt(0, __class_1);

__class_2 = CamlinternalOO.create_table({
      "hi",
      "id1",
      "id2",
      "hello"
    });

ids_2 = CamlinternalOO.get_method_labels(__class_2, {
      "id2",
      "id1",
      "hi",
      "hello"
    });

id2 = ids_2[0];

id1 = ids_2[1];

hi_1 = ids_2[2];

hello_1 = ids_2[3];

CamlinternalOO.set_methods(__class_2, {
      hi_1,
      (function (self$3, v, z) do
          return v + z | 0;
        end end),
      id1,
      (function (self$3) do
          return 3;
        end end),
      id2,
      (function (self$3) do
          return 4;
        end end),
      hello_1,
      (function (self$3, v) do
          return v;
        end end)
    });

CamlinternalOO.init_class(__class_2);

u = CamlinternalOO.create_object_opt(0, __class_2);

__class_3 = CamlinternalOO.create_table({"id"});

id = CamlinternalOO.get_method_label(__class_3, "id");

CamlinternalOO.set_method(__class_3, id, (function (self$4) do
        return "uu";
      end end));

CamlinternalOO.init_class(__class_3);

uu = CamlinternalOO.create_object_opt(0, __class_3);

__class_4 = CamlinternalOO.create_table({"add"});

add = CamlinternalOO.get_method_label(__class_4, "add");

CamlinternalOO.set_method(__class_4, add, (function (self$5, x, y) do
        return x + y | 0;
      end end));

CamlinternalOO.init_class(__class_4);

uuu = CamlinternalOO.create_object_opt(0, __class_4);

__class_5 = CamlinternalOO.create_table(shared_1);

ids_3 = CamlinternalOO.get_method_labels(__class_5, shared_1);

hi_2 = ids_3[0];

add_1 = ids_3[1];

CamlinternalOO.set_methods(__class_5, {
      add_1,
      (function (self$6, x, y) do
          return x + y | 0;
        end end),
      hi_2,
      (function (self$6, x) do
          return Curry._3(self$6[0][add_1], self$6, x, 32);
        end end)
    });

CamlinternalOO.init_class(__class_5);

vvvv = CamlinternalOO.create_object_opt(0, __class_5);

suites_000 = --[[ tuple ]]{
  "single_obj",
  (function (param) do
      return --[[ Eq ]]Block.__(0, {
                {
                  3,
                  32
                },
                {
                  Caml_oo_curry.js1(120, 1, v),
                  Caml_oo_curry.js1(121, 2, v)
                }
              });
    end end)
};

suites_001 = --[[ :: ]]{
  --[[ tuple ]]{
    "single_obj_cache",
    (function (param) do
        return --[[ Eq ]]Block.__(0, {
                  {
                    3,
                    32
                  },
                  {
                    Caml_oo_curry.js1(120, 3, v),
                    Caml_oo_curry.js1(121, 4, v)
                  }
                });
      end end)
  },
  --[[ :: ]]{
    --[[ tuple ]]{
      "self_obj",
      (function (param) do
          return --[[ Eq ]]Block.__(0, {
                    13,
                    Caml_oo_curry.js2(616641298, 5, vv, 3)
                  });
        end end)
    },
    --[[ :: ]]{
      --[[ tuple ]]{
        "uu_id",
        (function (param) do
            return --[[ Eq ]]Block.__(0, {
                      "uu",
                      Caml_oo_curry.js1(23515, 6, uu)
                    });
          end end)
      },
      --[[ :: ]]{
        --[[ tuple ]]{
          "uu_add",
          (function (param) do
              return --[[ Eq ]]Block.__(0, {
                        Caml_oo_curry.js3(4846113, 7, uuu, 1, 20),
                        21
                      });
            end end)
        },
        --[[ :: ]]{
          --[[ tuple ]]{
            "v_add",
            (function (param) do
                return --[[ Eq ]]Block.__(0, {
                          Caml_oo_curry.js3(4846113, 8, vvvv, 3, 7),
                          10
                        });
              end end)
          },
          --[[ :: ]]{
            --[[ tuple ]]{
              "u_id1",
              (function (param) do
                  return --[[ Eq ]]Block.__(0, {
                            Caml_oo_curry.js1(5243894, 9, u),
                            3
                          });
                end end)
            },
            --[[ :: ]]{
              --[[ tuple ]]{
                "u_id2",
                (function (param) do
                    return --[[ Eq ]]Block.__(0, {
                              Caml_oo_curry.js1(5243895, 10, u),
                              4
                            });
                  end end)
              },
              --[[ :: ]]{
                --[[ tuple ]]{
                  "u hi",
                  (function (param) do
                      return --[[ Eq ]]Block.__(0, {
                                Caml_oo_curry.js3(23297, 11, u, 1, 2),
                                3
                              });
                    end end)
                },
                --[[ :: ]]{
                  --[[ tuple ]]{
                    "u hello",
                    (function (param) do
                        return --[[ Eq ]]Block.__(0, {
                                  Caml_oo_curry.js2(616641298, 12, u, 32),
                                  32
                                });
                      end end)
                  },
                  --[[ :: ]]{
                    --[[ tuple ]]{
                      "v hi",
                      (function (param) do
                          return --[[ Eq ]]Block.__(0, {
                                    Caml_oo_curry.js2(23297, 13, vvvv, 31),
                                    63
                                  });
                        end end)
                    },
                    --[[ :: ]]{
                      --[[ tuple ]]{
                        "uuu add",
                        (function (param) do
                            return --[[ Eq ]]Block.__(0, {
                                      Caml_oo_curry.js3(4846113, 14, uuu, 3, 4),
                                      7
                                    });
                          end end)
                      },
                      --[[ :: ]]{
                        --[[ tuple ]]{
                          "v x",
                          (function (param) do
                              return --[[ Eq ]]Block.__(0, {
                                        Caml_oo_curry.js1(120, 15, v),
                                        3
                                      });
                            end end)
                        },
                        --[[ [] ]]0
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
};

suites = --[[ :: ]]{
  suites_000,
  suites_001
};

Mt.from_pair_suites("Obj_test", suites);

exports.vv = vv;
exports.v = v;
exports.u = u;
exports.uu = uu;
exports.uuu = uuu;
exports.vvvv = vvvv;
exports.suites = suites;
--[[ class Not a pure module ]]
