console = {log = print};

Mt = require "./mt";
__Array = require "../../lib/js/array";
Block = require "../../lib/js/block";
Js_dict = require "../../lib/js/js_dict";
Js_json = require "../../lib/js/js_json";
Caml_array = require "../../lib/js/caml_array";
Caml_option = require "../../lib/js/caml_option";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

suites = {
  contents = --[[ [] ]]0
};

counter = {
  contents = 0
};

function add_test(loc, test) do
  counter.contents = counter.contents + 1 | 0;
  id = loc .. (" id " .. String(counter.contents));
  suites.contents = --[[ :: ]]{
    --[[ tuple ]]{
      id,
      test
    },
    suites.contents
  };
  return --[[ () ]]0;
end end

function eq(loc, x, y) do
  return add_test(loc, (function(param) do
                return --[[ Eq ]]Block.__(0, {
                          x,
                          y
                        });
              end end));
end end

function false_(loc) do
  return add_test(loc, (function(param) do
                return --[[ Ok ]]Block.__(4, {false});
              end end));
end end

function true_(loc) do
  return add_test(loc, (function(param) do
                return --[[ Ok ]]Block.__(4, {true});
              end end));
end end

v = JSON.parse(" { \"x\" : [1, 2, 3 ] } ");

add_test("File \"js_json_test.ml\", line 23, characters 11-18", (function(param) do
        ty = Js_json.classify(v);
        if (typeof ty == "number" or ty.tag ~= --[[ JSONObject ]]2) then do
          return --[[ Ok ]]Block.__(4, {false});
        end else do
          match = Js_dict.get(ty[0], "x");
          if (match ~= nil) then do
            ty2 = Js_json.classify(Caml_option.valFromOption(match));
            if (typeof ty2 == "number" or ty2.tag ~= --[[ JSONArray ]]3) then do
              return --[[ Ok ]]Block.__(4, {false});
            end else do
              ty2[0].forEach((function(x) do
                      ty3 = Js_json.classify(x);
                      if (typeof ty3 == "number") then do
                        error({
                          Caml_builtin_exceptions.assert_failure,
                          --[[ tuple ]]{
                            "js_json_test.ml",
                            37,
                            21
                          }
                        })
                      end else if (ty3.tag == --[[ JSONNumber ]]1) then do
                        return --[[ () ]]0;
                      end else do
                        error({
                          Caml_builtin_exceptions.assert_failure,
                          --[[ tuple ]]{
                            "js_json_test.ml",
                            37,
                            21
                          }
                        })
                      end end  end 
                    end end));
              return --[[ Ok ]]Block.__(4, {true});
            end end 
          end else do
            return --[[ Ok ]]Block.__(4, {false});
          end end 
        end end 
      end end));

eq("File \"js_json_test.ml\", line 48, characters 5-12", Js_json.test(v, --[[ Object ]]2), true);

json = JSON.parse(JSON.stringify(null));

ty = Js_json.classify(json);

if (typeof ty == "number") then do
  if (ty >= 2) then do
    add_test("File \"js_json_test.ml\", line 54, characters 30-37", (function(param) do
            return --[[ Ok ]]Block.__(4, {true});
          end end));
  end else do
    console.log(ty);
    add_test("File \"js_json_test.ml\", line 55, characters 27-34", (function(param) do
            return --[[ Ok ]]Block.__(4, {false});
          end end));
  end end 
end else do
  console.log(ty);
  add_test("File \"js_json_test.ml\", line 55, characters 27-34", (function(param) do
          return --[[ Ok ]]Block.__(4, {false});
        end end));
end end 

json_1 = JSON.parse(JSON.stringify("test string"));

ty_1 = Js_json.classify(json_1);

if (typeof ty_1 == "number") then do
  add_test("File \"js_json_test.ml\", line 65, characters 16-23", (function(param) do
          return --[[ Ok ]]Block.__(4, {false});
        end end));
end else if (ty_1.tag) then do
  add_test("File \"js_json_test.ml\", line 65, characters 16-23", (function(param) do
          return --[[ Ok ]]Block.__(4, {false});
        end end));
end else do
  eq("File \"js_json_test.ml\", line 64, characters 31-38", ty_1[0], "test string");
end end  end 

json_2 = JSON.parse(JSON.stringify(1.23456789));

ty_2 = Js_json.classify(json_2);

exit = 0;

if (typeof ty_2 == "number" or ty_2.tag ~= --[[ JSONNumber ]]1) then do
  exit = 1;
end else do
  eq("File \"js_json_test.ml\", line 74, characters 31-38", ty_2[0], 1.23456789);
end end 

if (exit == 1) then do
  add_test("File \"js_json_test.ml\", line 75, characters 18-25", (function(param) do
          return --[[ Ok ]]Block.__(4, {false});
        end end));
end
 end 

json_3 = JSON.parse(JSON.stringify(-1347440721));

ty_3 = Js_json.classify(json_3);

exit_1 = 0;

if (typeof ty_3 == "number" or ty_3.tag ~= --[[ JSONNumber ]]1) then do
  exit_1 = 1;
end else do
  eq("File \"js_json_test.ml\", line 84, characters 31-38", ty_3[0] | 0, -1347440721);
end end 

if (exit_1 == 1) then do
  add_test("File \"js_json_test.ml\", line 85, characters 18-25", (function(param) do
          return --[[ Ok ]]Block.__(4, {false});
        end end));
end
 end 

function test(v) do
  json = JSON.parse(JSON.stringify(v));
  ty = Js_json.classify(json);
  if (typeof ty == "number") then do
    local ___conditional___=(ty);
    do
       if ___conditional___ == 0--[[ JSONFalse ]] then do
          return eq("File \"js_json_test.ml\", line 95, characters 31-38", false, v); end end 
       if ___conditional___ == 1--[[ JSONTrue ]] then do
          return eq("File \"js_json_test.ml\", line 94, characters 30-37", true, v); end end 
       if ___conditional___ == 2--[[ JSONNull ]] then do
          return add_test("File \"js_json_test.ml\", line 96, characters 18-25", (function(param) do
                        return --[[ Ok ]]Block.__(4, {false});
                      end end)); end end 
      
    end
  end else do
    return add_test("File \"js_json_test.ml\", line 96, characters 18-25", (function(param) do
                  return --[[ Ok ]]Block.__(4, {false});
                end end));
  end end 
end end

test(true);

test(false);

function option_get(param) do
  if (param ~= nil) then do
    return Caml_option.valFromOption(param);
  end else do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "js_json_test.ml",
        102,
        36
      }
    })
  end end 
end end

dict = { };

dict["a"] = "test string";

dict["b"] = 123.0;

json_4 = JSON.parse(JSON.stringify(dict));

ty_4 = Js_json.classify(json_4);

if (typeof ty_4 == "number") then do
  add_test("File \"js_json_test.ml\", line 134, characters 16-23", (function(param) do
          return --[[ Ok ]]Block.__(4, {false});
        end end));
end else if (ty_4.tag == --[[ JSONObject ]]2) then do
  x = ty_4[0];
  ta = Js_json.classify(option_get(Js_dict.get(x, "a")));
  if (typeof ta == "number") then do
    add_test("File \"js_json_test.ml\", line 132, characters 18-25", (function(param) do
            return --[[ Ok ]]Block.__(4, {false});
          end end));
  end else if (ta.tag) then do
    add_test("File \"js_json_test.ml\", line 132, characters 18-25", (function(param) do
            return --[[ Ok ]]Block.__(4, {false});
          end end));
  end else if (ta[0] ~= "test string") then do
    add_test("File \"js_json_test.ml\", line 123, characters 18-25", (function(param) do
            return --[[ Ok ]]Block.__(4, {false});
          end end));
  end else do
    ty_5 = Js_json.classify(option_get(Js_dict.get(x, "b")));
    if (typeof ty_5 == "number") then do
      add_test("File \"js_json_test.ml\", line 130, characters 22-29", (function(param) do
              return --[[ Ok ]]Block.__(4, {false});
            end end));
    end else if (ty_5.tag == --[[ JSONNumber ]]1) then do
      b = ty_5[0];
      add_test("File \"js_json_test.ml\", line 129, characters 19-26", (function(param) do
              return --[[ Approx ]]Block.__(5, {
                        123.0,
                        b
                      });
            end end));
    end else do
      add_test("File \"js_json_test.ml\", line 130, characters 22-29", (function(param) do
              return --[[ Ok ]]Block.__(4, {false});
            end end));
    end end  end 
  end end  end  end 
end else do
  add_test("File \"js_json_test.ml\", line 134, characters 16-23", (function(param) do
          return --[[ Ok ]]Block.__(4, {false});
        end end));
end end  end 

function eq_at_i(loc, json, i, kind, expected) do
  ty = Js_json.classify(json);
  if (typeof ty == "number") then do
    return add_test(loc, (function(param) do
                  return --[[ Ok ]]Block.__(4, {false});
                end end));
  end else if (ty.tag == --[[ JSONArray ]]3) then do
    ty_1 = Js_json.classify(Caml_array.caml_array_get(ty[0], i));
    local ___conditional___=(kind);
    do
       if ___conditional___ == 0--[[ String ]] then do
          if (typeof ty_1 == "number") then do
            return add_test(loc, (function(param) do
                          return --[[ Ok ]]Block.__(4, {false});
                        end end));
          end else if (ty_1.tag) then do
            return add_test(loc, (function(param) do
                          return --[[ Ok ]]Block.__(4, {false});
                        end end));
          end else do
            return eq(loc, ty_1[0], expected);
          end end  end  end end 
       if ___conditional___ == 1--[[ Number ]] then do
          if (typeof ty_1 == "number") then do
            return add_test(loc, (function(param) do
                          return --[[ Ok ]]Block.__(4, {false});
                        end end));
          end else if (ty_1.tag == --[[ JSONNumber ]]1) then do
            return eq(loc, ty_1[0], expected);
          end else do
            return add_test(loc, (function(param) do
                          return --[[ Ok ]]Block.__(4, {false});
                        end end));
          end end  end  end end 
       if ___conditional___ == 2--[[ Object ]] then do
          if (typeof ty_1 == "number") then do
            return add_test(loc, (function(param) do
                          return --[[ Ok ]]Block.__(4, {false});
                        end end));
          end else if (ty_1.tag == --[[ JSONObject ]]2) then do
            return eq(loc, ty_1[0], expected);
          end else do
            return add_test(loc, (function(param) do
                          return --[[ Ok ]]Block.__(4, {false});
                        end end));
          end end  end  end end 
       if ___conditional___ == 3--[[ Array ]] then do
          if (typeof ty_1 == "number") then do
            return add_test(loc, (function(param) do
                          return --[[ Ok ]]Block.__(4, {false});
                        end end));
          end else if (ty_1.tag == --[[ JSONArray ]]3) then do
            return eq(loc, ty_1[0], expected);
          end else do
            return add_test(loc, (function(param) do
                          return --[[ Ok ]]Block.__(4, {false});
                        end end));
          end end  end  end end 
       if ___conditional___ == 4--[[ Boolean ]] then do
          if (typeof ty_1 == "number") then do
            local ___conditional___=(ty_1);
            do
               if ___conditional___ == 0--[[ JSONFalse ]] then do
                  return eq(loc, false, expected); end end 
               if ___conditional___ == 1--[[ JSONTrue ]] then do
                  return eq(loc, true, expected); end end 
               if ___conditional___ == 2--[[ JSONNull ]] then do
                  return add_test(loc, (function(param) do
                                return --[[ Ok ]]Block.__(4, {false});
                              end end)); end end 
              
            end
          end else do
            return add_test(loc, (function(param) do
                          return --[[ Ok ]]Block.__(4, {false});
                        end end));
          end end  end end 
       if ___conditional___ == 5--[[ Null ]] then do
          if (typeof ty_1 == "number") then do
            if (ty_1 >= 2) then do
              return add_test(loc, (function(param) do
                            return --[[ Ok ]]Block.__(4, {true});
                          end end));
            end else do
              return add_test(loc, (function(param) do
                            return --[[ Ok ]]Block.__(4, {false});
                          end end));
            end end 
          end else do
            return add_test(loc, (function(param) do
                          return --[[ Ok ]]Block.__(4, {false});
                        end end));
          end end  end end 
      
    end
  end else do
    return add_test(loc, (function(param) do
                  return --[[ Ok ]]Block.__(4, {false});
                end end));
  end end  end 
end end

json_5 = JSON.parse(JSON.stringify(__Array.map((function(prim) do
                return prim;
              end end), {
              "string 0",
              "string 1",
              "string 2"
            })));

eq_at_i("File \"js_json_test.ml\", line 193, characters 10-17", json_5, 0, --[[ String ]]0, "string 0");

eq_at_i("File \"js_json_test.ml\", line 194, characters 10-17", json_5, 1, --[[ String ]]0, "string 1");

eq_at_i("File \"js_json_test.ml\", line 195, characters 10-17", json_5, 2, --[[ String ]]0, "string 2");

json_6 = JSON.parse(JSON.stringify({
          "string 0",
          "string 1",
          "string 2"
        }));

eq_at_i("File \"js_json_test.ml\", line 205, characters 10-17", json_6, 0, --[[ String ]]0, "string 0");

eq_at_i("File \"js_json_test.ml\", line 206, characters 10-17", json_6, 1, --[[ String ]]0, "string 1");

eq_at_i("File \"js_json_test.ml\", line 207, characters 10-17", json_6, 2, --[[ String ]]0, "string 2");

a = {
  1.0000001,
  10000000000.1,
  123.0
};

json_7 = JSON.parse(JSON.stringify(a));

eq_at_i("File \"js_json_test.ml\", line 219, characters 10-17", json_7, 0, --[[ Number ]]1, Caml_array.caml_array_get(a, 0));

eq_at_i("File \"js_json_test.ml\", line 220, characters 10-17", json_7, 1, --[[ Number ]]1, Caml_array.caml_array_get(a, 1));

eq_at_i("File \"js_json_test.ml\", line 221, characters 10-17", json_7, 2, --[[ Number ]]1, Caml_array.caml_array_get(a, 2));

a_1 = {
  0,
  -1347440721,
  -268391749
};

json_8 = JSON.parse(JSON.stringify(__Array.map((function(prim) do
                return prim;
              end end), a_1)));

eq_at_i("File \"js_json_test.ml\", line 234, characters 10-17", json_8, 0, --[[ Number ]]1, Caml_array.caml_array_get(a_1, 0));

eq_at_i("File \"js_json_test.ml\", line 235, characters 10-17", json_8, 1, --[[ Number ]]1, Caml_array.caml_array_get(a_1, 1));

eq_at_i("File \"js_json_test.ml\", line 236, characters 10-17", json_8, 2, --[[ Number ]]1, Caml_array.caml_array_get(a_1, 2));

a_2 = {
  true,
  false,
  true
};

json_9 = JSON.parse(JSON.stringify(a_2));

eq_at_i("File \"js_json_test.ml\", line 248, characters 10-17", json_9, 0, --[[ Boolean ]]4, Caml_array.caml_array_get(a_2, 0));

eq_at_i("File \"js_json_test.ml\", line 249, characters 10-17", json_9, 1, --[[ Boolean ]]4, Caml_array.caml_array_get(a_2, 1));

eq_at_i("File \"js_json_test.ml\", line 250, characters 10-17", json_9, 2, --[[ Boolean ]]4, Caml_array.caml_array_get(a_2, 2));

function make_d(s, i) do
  d = { };
  d["a"] = s;
  d["b"] = i;
  return d;
end end

a_3 = {
  make_d("aaa", 123),
  make_d("bbb", 456)
};

json_10 = JSON.parse(JSON.stringify(a_3));

ty_6 = Js_json.classify(json_10);

if (typeof ty_6 == "number") then do
  add_test("File \"js_json_test.ml\", line 282, characters 16-23", (function(param) do
          return --[[ Ok ]]Block.__(4, {false});
        end end));
end else if (ty_6.tag == --[[ JSONArray ]]3) then do
  ty_7 = Js_json.classify(Caml_array.caml_array_get(ty_6[0], 1));
  if (typeof ty_7 == "number") then do
    add_test("File \"js_json_test.ml\", line 280, characters 18-25", (function(param) do
            return --[[ Ok ]]Block.__(4, {false});
          end end));
  end else if (ty_7.tag == --[[ JSONObject ]]2) then do
    ty_8 = Js_json.classify(option_get(Js_dict.get(ty_7[0], "a")));
    if (typeof ty_8 == "number") then do
      add_test("File \"js_json_test.ml\", line 278, characters 20-27", (function(param) do
              return --[[ Ok ]]Block.__(4, {false});
            end end));
    end else if (ty_8.tag) then do
      add_test("File \"js_json_test.ml\", line 278, characters 20-27", (function(param) do
              return --[[ Ok ]]Block.__(4, {false});
            end end));
    end else do
      eq("File \"js_json_test.ml\", line 277, characters 40-47", ty_8[0], "bbb");
    end end  end 
  end else do
    add_test("File \"js_json_test.ml\", line 280, characters 18-25", (function(param) do
            return --[[ Ok ]]Block.__(4, {false});
          end end));
  end end  end 
end else do
  add_test("File \"js_json_test.ml\", line 282, characters 16-23", (function(param) do
          return --[[ Ok ]]Block.__(4, {false});
        end end));
end end  end 

xpcall(function() do
  JSON.parse("{{ A}");
  add_test("File \"js_json_test.ml\", line 288, characters 11-18", (function(param) do
          return --[[ Ok ]]Block.__(4, {false});
        end end));
end end,function(exn) do
  add_test("File \"js_json_test.ml\", line 291, characters 10-17", (function(param) do
          return --[[ Ok ]]Block.__(4, {true});
        end end));
end end)

eq("File \"js_json_test.ml\", line 295, characters 12-19", JSON.stringify({
          1,
          2,
          3
        }), "[1,2,3]");

eq("File \"js_json_test.ml\", line 299, characters 2-9", JSON.stringify({
          foo = 1,
          bar = "hello",
          baz = {
            baaz = 10
          }
        }), "{\"foo\":1,\"bar\":\"hello\",\"baz\":{\"baaz\":10}}");

eq("File \"js_json_test.ml\", line 303, characters 12-19", JSON.stringify(nil), "null");

eq("File \"js_json_test.ml\", line 305, characters 12-19", JSON.stringify(nil), nil);

eq("File \"js_json_test.ml\", line 308, characters 5-12", Js_json.decodeString("test"), "test");

eq("File \"js_json_test.ml\", line 310, characters 5-12", Js_json.decodeString(true), nil);

eq("File \"js_json_test.ml\", line 312, characters 5-12", Js_json.decodeString({}), nil);

eq("File \"js_json_test.ml\", line 314, characters 5-12", Js_json.decodeString(null), nil);

eq("File \"js_json_test.ml\", line 316, characters 5-12", Js_json.decodeString({ }), nil);

eq("File \"js_json_test.ml\", line 318, characters 5-12", Js_json.decodeString(1.23), nil);

eq("File \"js_json_test.ml\", line 322, characters 5-12", Js_json.decodeNumber("test"), nil);

eq("File \"js_json_test.ml\", line 324, characters 5-12", Js_json.decodeNumber(true), nil);

eq("File \"js_json_test.ml\", line 326, characters 5-12", Js_json.decodeNumber({}), nil);

eq("File \"js_json_test.ml\", line 328, characters 5-12", Js_json.decodeNumber(null), nil);

eq("File \"js_json_test.ml\", line 330, characters 5-12", Js_json.decodeNumber({ }), nil);

eq("File \"js_json_test.ml\", line 332, characters 5-12", Js_json.decodeNumber(1.23), 1.23);

eq("File \"js_json_test.ml\", line 336, characters 5-12", Js_json.decodeObject("test"), nil);

eq("File \"js_json_test.ml\", line 338, characters 5-12", Js_json.decodeObject(true), nil);

eq("File \"js_json_test.ml\", line 340, characters 5-12", Js_json.decodeObject({}), nil);

eq("File \"js_json_test.ml\", line 342, characters 5-12", Js_json.decodeObject(null), nil);

eq("File \"js_json_test.ml\", line 344, characters 5-12", Js_json.decodeObject({ }), { });

eq("File \"js_json_test.ml\", line 347, characters 5-12", Js_json.decodeObject(1.23), nil);

eq("File \"js_json_test.ml\", line 351, characters 5-12", Js_json.decodeArray("test"), nil);

eq("File \"js_json_test.ml\", line 353, characters 5-12", Js_json.decodeArray(true), nil);

eq("File \"js_json_test.ml\", line 355, characters 5-12", Js_json.decodeArray({}), {});

eq("File \"js_json_test.ml\", line 357, characters 5-12", Js_json.decodeArray(null), nil);

eq("File \"js_json_test.ml\", line 359, characters 5-12", Js_json.decodeArray({ }), nil);

eq("File \"js_json_test.ml\", line 361, characters 5-12", Js_json.decodeArray(1.23), nil);

eq("File \"js_json_test.ml\", line 365, characters 5-12", Js_json.decodeBoolean("test"), nil);

eq("File \"js_json_test.ml\", line 367, characters 5-12", Js_json.decodeBoolean(true), true);

eq("File \"js_json_test.ml\", line 369, characters 5-12", Js_json.decodeBoolean({}), nil);

eq("File \"js_json_test.ml\", line 371, characters 5-12", Js_json.decodeBoolean(null), nil);

eq("File \"js_json_test.ml\", line 373, characters 5-12", Js_json.decodeBoolean({ }), nil);

eq("File \"js_json_test.ml\", line 375, characters 5-12", Js_json.decodeBoolean(1.23), nil);

eq("File \"js_json_test.ml\", line 379, characters 5-12", Js_json.decodeNull("test"), nil);

eq("File \"js_json_test.ml\", line 381, characters 5-12", Js_json.decodeNull(true), nil);

eq("File \"js_json_test.ml\", line 383, characters 5-12", Js_json.decodeNull({}), nil);

eq("File \"js_json_test.ml\", line 385, characters 5-12", Js_json.decodeNull(null), nil);

eq("File \"js_json_test.ml\", line 387, characters 5-12", Js_json.decodeNull({ }), nil);

eq("File \"js_json_test.ml\", line 389, characters 5-12", Js_json.decodeNull(1.23), nil);

Mt.from_pair_suites("Js_json_test", suites.contents);

exports = {}
exports.suites = suites;
exports.add_test = add_test;
exports.eq = eq;
exports.false_ = false_;
exports.true_ = true_;
exports.option_get = option_get;
exports.eq_at_i = eq_at_i;
--[[ v Not a pure module ]]
