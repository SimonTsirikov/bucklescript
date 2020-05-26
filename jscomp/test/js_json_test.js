'use strict';

Mt = require("./mt.js");
$$Array = require("../../lib/js/array.js");
Block = require("../../lib/js/block.js");
Js_dict = require("../../lib/js/js_dict.js");
Js_json = require("../../lib/js/js_json.js");
Caml_array = require("../../lib/js/caml_array.js");
Caml_option = require("../../lib/js/caml_option.js");
Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

suites = do
  contents: --[ [] ]--0
end;

counter = do
  contents: 0
end;

function add_test(loc, test) do
  counter.contents = counter.contents + 1 | 0;
  id = loc .. (" id " .. String(counter.contents));
  suites.contents = --[ :: ]--[
    --[ tuple ]--[
      id,
      test
    ],
    suites.contents
  ];
  return --[ () ]--0;
end

function eq(loc, x, y) do
  return add_test(loc, (function (param) do
                return --[ Eq ]--Block.__(0, [
                          x,
                          y
                        ]);
              end));
end

function false_(loc) do
  return add_test(loc, (function (param) do
                return --[ Ok ]--Block.__(4, [false]);
              end));
end

function true_(loc) do
  return add_test(loc, (function (param) do
                return --[ Ok ]--Block.__(4, [true]);
              end));
end

v = JSON.parse(" { \"x\" : [1, 2, 3 ] } ");

add_test("File \"js_json_test.ml\", line 23, characters 11-18", (function (param) do
        ty = Js_json.classify(v);
        if (typeof ty == "number" or ty.tag ~= --[ JSONObject ]--2) then do
          return --[ Ok ]--Block.__(4, [false]);
        end else do
          match = Js_dict.get(ty[0], "x");
          if (match ~= undefined) then do
            ty2 = Js_json.classify(Caml_option.valFromOption(match));
            if (typeof ty2 == "number" or ty2.tag ~= --[ JSONArray ]--3) then do
              return --[ Ok ]--Block.__(4, [false]);
            end else do
              ty2[0].forEach((function (x) do
                      ty3 = Js_json.classify(x);
                      if (typeof ty3 == "number") then do
                        throw [
                              Caml_builtin_exceptions.assert_failure,
                              --[ tuple ]--[
                                "js_json_test.ml",
                                37,
                                21
                              ]
                            ];
                      end else if (ty3.tag == --[ JSONNumber ]--1) then do
                        return --[ () ]--0;
                      end else do
                        throw [
                              Caml_builtin_exceptions.assert_failure,
                              --[ tuple ]--[
                                "js_json_test.ml",
                                37,
                                21
                              ]
                            ];
                      end end  end 
                    end));
              return --[ Ok ]--Block.__(4, [true]);
            end end 
          end else do
            return --[ Ok ]--Block.__(4, [false]);
          end end 
        end end 
      end));

eq("File \"js_json_test.ml\", line 48, characters 5-12", Js_json.test(v, --[ Object ]--2), true);

json = JSON.parse(JSON.stringify(null));

ty = Js_json.classify(json);

if (typeof ty == "number") then do
  if (ty >= 2) then do
    add_test("File \"js_json_test.ml\", line 54, characters 30-37", (function (param) do
            return --[ Ok ]--Block.__(4, [true]);
          end));
  end else do
    console.log(ty);
    add_test("File \"js_json_test.ml\", line 55, characters 27-34", (function (param) do
            return --[ Ok ]--Block.__(4, [false]);
          end));
  end end 
end else do
  console.log(ty);
  add_test("File \"js_json_test.ml\", line 55, characters 27-34", (function (param) do
          return --[ Ok ]--Block.__(4, [false]);
        end));
end end 

json$1 = JSON.parse(JSON.stringify("test string"));

ty$1 = Js_json.classify(json$1);

if (typeof ty$1 == "number") then do
  add_test("File \"js_json_test.ml\", line 65, characters 16-23", (function (param) do
          return --[ Ok ]--Block.__(4, [false]);
        end));
end else if (ty$1.tag) then do
  add_test("File \"js_json_test.ml\", line 65, characters 16-23", (function (param) do
          return --[ Ok ]--Block.__(4, [false]);
        end));
end else do
  eq("File \"js_json_test.ml\", line 64, characters 31-38", ty$1[0], "test string");
end end  end 

json$2 = JSON.parse(JSON.stringify(1.23456789));

ty$2 = Js_json.classify(json$2);

exit = 0;

if (typeof ty$2 == "number" or ty$2.tag ~= --[ JSONNumber ]--1) then do
  exit = 1;
end else do
  eq("File \"js_json_test.ml\", line 74, characters 31-38", ty$2[0], 1.23456789);
end end 

if (exit == 1) then do
  add_test("File \"js_json_test.ml\", line 75, characters 18-25", (function (param) do
          return --[ Ok ]--Block.__(4, [false]);
        end));
end
 end 

json$3 = JSON.parse(JSON.stringify(-1347440721));

ty$3 = Js_json.classify(json$3);

exit$1 = 0;

if (typeof ty$3 == "number" or ty$3.tag ~= --[ JSONNumber ]--1) then do
  exit$1 = 1;
end else do
  eq("File \"js_json_test.ml\", line 84, characters 31-38", ty$3[0] | 0, -1347440721);
end end 

if (exit$1 == 1) then do
  add_test("File \"js_json_test.ml\", line 85, characters 18-25", (function (param) do
          return --[ Ok ]--Block.__(4, [false]);
        end));
end
 end 

function test(v) do
  json = JSON.parse(JSON.stringify(v));
  ty = Js_json.classify(json);
  if (typeof ty == "number") then do
    local ___conditional___=(ty);
    do
       if ___conditional___ = 0--[ JSONFalse ]-- then do
          return eq("File \"js_json_test.ml\", line 95, characters 31-38", false, v);end end end 
       if ___conditional___ = 1--[ JSONTrue ]-- then do
          return eq("File \"js_json_test.ml\", line 94, characters 30-37", true, v);end end end 
       if ___conditional___ = 2--[ JSONNull ]-- then do
          return add_test("File \"js_json_test.ml\", line 96, characters 18-25", (function (param) do
                        return --[ Ok ]--Block.__(4, [false]);
                      end));end end end 
       do
      
    end
  end else do
    return add_test("File \"js_json_test.ml\", line 96, characters 18-25", (function (param) do
                  return --[ Ok ]--Block.__(4, [false]);
                end));
  end end 
end

test(true);

test(false);

function option_get(param) do
  if (param ~= undefined) then do
    return Caml_option.valFromOption(param);
  end else do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "js_json_test.ml",
            102,
            36
          ]
        ];
  end end 
end

dict = { };

dict["a"] = "test string";

dict["b"] = 123.0;

json$4 = JSON.parse(JSON.stringify(dict));

ty$4 = Js_json.classify(json$4);

if (typeof ty$4 == "number") then do
  add_test("File \"js_json_test.ml\", line 134, characters 16-23", (function (param) do
          return --[ Ok ]--Block.__(4, [false]);
        end));
end else if (ty$4.tag == --[ JSONObject ]--2) then do
  x = ty$4[0];
  ta = Js_json.classify(option_get(Js_dict.get(x, "a")));
  if (typeof ta == "number") then do
    add_test("File \"js_json_test.ml\", line 132, characters 18-25", (function (param) do
            return --[ Ok ]--Block.__(4, [false]);
          end));
  end else if (ta.tag) then do
    add_test("File \"js_json_test.ml\", line 132, characters 18-25", (function (param) do
            return --[ Ok ]--Block.__(4, [false]);
          end));
  end else if (ta[0] ~= "test string") then do
    add_test("File \"js_json_test.ml\", line 123, characters 18-25", (function (param) do
            return --[ Ok ]--Block.__(4, [false]);
          end));
  end else do
    ty$5 = Js_json.classify(option_get(Js_dict.get(x, "b")));
    if (typeof ty$5 == "number") then do
      add_test("File \"js_json_test.ml\", line 130, characters 22-29", (function (param) do
              return --[ Ok ]--Block.__(4, [false]);
            end));
    end else if (ty$5.tag == --[ JSONNumber ]--1) then do
      b = ty$5[0];
      add_test("File \"js_json_test.ml\", line 129, characters 19-26", (function (param) do
              return --[ Approx ]--Block.__(5, [
                        123.0,
                        b
                      ]);
            end));
    end else do
      add_test("File \"js_json_test.ml\", line 130, characters 22-29", (function (param) do
              return --[ Ok ]--Block.__(4, [false]);
            end));
    end end  end 
  end end  end  end 
end else do
  add_test("File \"js_json_test.ml\", line 134, characters 16-23", (function (param) do
          return --[ Ok ]--Block.__(4, [false]);
        end));
end end  end 

function eq_at_i(loc, json, i, kind, expected) do
  ty = Js_json.classify(json);
  if (typeof ty == "number") then do
    return add_test(loc, (function (param) do
                  return --[ Ok ]--Block.__(4, [false]);
                end));
  end else if (ty.tag == --[ JSONArray ]--3) then do
    ty$1 = Js_json.classify(Caml_array.caml_array_get(ty[0], i));
    local ___conditional___=(kind);
    do
       if ___conditional___ = 0--[ String ]-- then do
          if (typeof ty$1 == "number") then do
            return add_test(loc, (function (param) do
                          return --[ Ok ]--Block.__(4, [false]);
                        end));
          end else if (ty$1.tag) then do
            return add_test(loc, (function (param) do
                          return --[ Ok ]--Block.__(4, [false]);
                        end));
          end else do
            return eq(loc, ty$1[0], expected);
          end end  end end end end 
       if ___conditional___ = 1--[ Number ]-- then do
          if (typeof ty$1 == "number") then do
            return add_test(loc, (function (param) do
                          return --[ Ok ]--Block.__(4, [false]);
                        end));
          end else if (ty$1.tag == --[ JSONNumber ]--1) then do
            return eq(loc, ty$1[0], expected);
          end else do
            return add_test(loc, (function (param) do
                          return --[ Ok ]--Block.__(4, [false]);
                        end));
          end end  end end end end 
       if ___conditional___ = 2--[ Object ]-- then do
          if (typeof ty$1 == "number") then do
            return add_test(loc, (function (param) do
                          return --[ Ok ]--Block.__(4, [false]);
                        end));
          end else if (ty$1.tag == --[ JSONObject ]--2) then do
            return eq(loc, ty$1[0], expected);
          end else do
            return add_test(loc, (function (param) do
                          return --[ Ok ]--Block.__(4, [false]);
                        end));
          end end  end end end end 
       if ___conditional___ = 3--[ Array ]-- then do
          if (typeof ty$1 == "number") then do
            return add_test(loc, (function (param) do
                          return --[ Ok ]--Block.__(4, [false]);
                        end));
          end else if (ty$1.tag == --[ JSONArray ]--3) then do
            return eq(loc, ty$1[0], expected);
          end else do
            return add_test(loc, (function (param) do
                          return --[ Ok ]--Block.__(4, [false]);
                        end));
          end end  end end end end 
       if ___conditional___ = 4--[ Boolean ]-- then do
          if (typeof ty$1 == "number") then do
            local ___conditional___=(ty$1);
            do
               if ___conditional___ = 0--[ JSONFalse ]-- then do
                  return eq(loc, false, expected);end end end 
               if ___conditional___ = 1--[ JSONTrue ]-- then do
                  return eq(loc, true, expected);end end end 
               if ___conditional___ = 2--[ JSONNull ]-- then do
                  return add_test(loc, (function (param) do
                                return --[ Ok ]--Block.__(4, [false]);
                              end));end end end 
               do
              
            end
          end else do
            return add_test(loc, (function (param) do
                          return --[ Ok ]--Block.__(4, [false]);
                        end));
          end end end end end 
       if ___conditional___ = 5--[ Null ]-- then do
          if (typeof ty$1 == "number") then do
            if (ty$1 >= 2) then do
              return add_test(loc, (function (param) do
                            return --[ Ok ]--Block.__(4, [true]);
                          end));
            end else do
              return add_test(loc, (function (param) do
                            return --[ Ok ]--Block.__(4, [false]);
                          end));
            end end 
          end else do
            return add_test(loc, (function (param) do
                          return --[ Ok ]--Block.__(4, [false]);
                        end));
          end end end end end 
       do
      
    end
  end else do
    return add_test(loc, (function (param) do
                  return --[ Ok ]--Block.__(4, [false]);
                end));
  end end  end 
end

json$5 = JSON.parse(JSON.stringify($$Array.map((function (prim) do
                return prim;
              end), [
              "string 0",
              "string 1",
              "string 2"
            ])));

eq_at_i("File \"js_json_test.ml\", line 193, characters 10-17", json$5, 0, --[ String ]--0, "string 0");

eq_at_i("File \"js_json_test.ml\", line 194, characters 10-17", json$5, 1, --[ String ]--0, "string 1");

eq_at_i("File \"js_json_test.ml\", line 195, characters 10-17", json$5, 2, --[ String ]--0, "string 2");

json$6 = JSON.parse(JSON.stringify([
          "string 0",
          "string 1",
          "string 2"
        ]));

eq_at_i("File \"js_json_test.ml\", line 205, characters 10-17", json$6, 0, --[ String ]--0, "string 0");

eq_at_i("File \"js_json_test.ml\", line 206, characters 10-17", json$6, 1, --[ String ]--0, "string 1");

eq_at_i("File \"js_json_test.ml\", line 207, characters 10-17", json$6, 2, --[ String ]--0, "string 2");

a = [
  1.0000001,
  10000000000.1,
  123.0
];

json$7 = JSON.parse(JSON.stringify(a));

eq_at_i("File \"js_json_test.ml\", line 219, characters 10-17", json$7, 0, --[ Number ]--1, Caml_array.caml_array_get(a, 0));

eq_at_i("File \"js_json_test.ml\", line 220, characters 10-17", json$7, 1, --[ Number ]--1, Caml_array.caml_array_get(a, 1));

eq_at_i("File \"js_json_test.ml\", line 221, characters 10-17", json$7, 2, --[ Number ]--1, Caml_array.caml_array_get(a, 2));

a$1 = [
  0,
  -1347440721,
  -268391749
];

json$8 = JSON.parse(JSON.stringify($$Array.map((function (prim) do
                return prim;
              end), a$1)));

eq_at_i("File \"js_json_test.ml\", line 234, characters 10-17", json$8, 0, --[ Number ]--1, Caml_array.caml_array_get(a$1, 0));

eq_at_i("File \"js_json_test.ml\", line 235, characters 10-17", json$8, 1, --[ Number ]--1, Caml_array.caml_array_get(a$1, 1));

eq_at_i("File \"js_json_test.ml\", line 236, characters 10-17", json$8, 2, --[ Number ]--1, Caml_array.caml_array_get(a$1, 2));

a$2 = [
  true,
  false,
  true
];

json$9 = JSON.parse(JSON.stringify(a$2));

eq_at_i("File \"js_json_test.ml\", line 248, characters 10-17", json$9, 0, --[ Boolean ]--4, Caml_array.caml_array_get(a$2, 0));

eq_at_i("File \"js_json_test.ml\", line 249, characters 10-17", json$9, 1, --[ Boolean ]--4, Caml_array.caml_array_get(a$2, 1));

eq_at_i("File \"js_json_test.ml\", line 250, characters 10-17", json$9, 2, --[ Boolean ]--4, Caml_array.caml_array_get(a$2, 2));

function make_d(s, i) do
  d = { };
  d["a"] = s;
  d["b"] = i;
  return d;
end

a$3 = [
  make_d("aaa", 123),
  make_d("bbb", 456)
];

json$10 = JSON.parse(JSON.stringify(a$3));

ty$6 = Js_json.classify(json$10);

if (typeof ty$6 == "number") then do
  add_test("File \"js_json_test.ml\", line 282, characters 16-23", (function (param) do
          return --[ Ok ]--Block.__(4, [false]);
        end));
end else if (ty$6.tag == --[ JSONArray ]--3) then do
  ty$7 = Js_json.classify(Caml_array.caml_array_get(ty$6[0], 1));
  if (typeof ty$7 == "number") then do
    add_test("File \"js_json_test.ml\", line 280, characters 18-25", (function (param) do
            return --[ Ok ]--Block.__(4, [false]);
          end));
  end else if (ty$7.tag == --[ JSONObject ]--2) then do
    ty$8 = Js_json.classify(option_get(Js_dict.get(ty$7[0], "a")));
    if (typeof ty$8 == "number") then do
      add_test("File \"js_json_test.ml\", line 278, characters 20-27", (function (param) do
              return --[ Ok ]--Block.__(4, [false]);
            end));
    end else if (ty$8.tag) then do
      add_test("File \"js_json_test.ml\", line 278, characters 20-27", (function (param) do
              return --[ Ok ]--Block.__(4, [false]);
            end));
    end else do
      eq("File \"js_json_test.ml\", line 277, characters 40-47", ty$8[0], "bbb");
    end end  end 
  end else do
    add_test("File \"js_json_test.ml\", line 280, characters 18-25", (function (param) do
            return --[ Ok ]--Block.__(4, [false]);
          end));
  end end  end 
end else do
  add_test("File \"js_json_test.ml\", line 282, characters 16-23", (function (param) do
          return --[ Ok ]--Block.__(4, [false]);
        end));
end end  end 

try do
  JSON.parse("{{ A}");
  add_test("File \"js_json_test.ml\", line 288, characters 11-18", (function (param) do
          return --[ Ok ]--Block.__(4, [false]);
        end));
end
catch (exn)do
  add_test("File \"js_json_test.ml\", line 291, characters 10-17", (function (param) do
          return --[ Ok ]--Block.__(4, [true]);
        end));
end

eq("File \"js_json_test.ml\", line 295, characters 12-19", JSON.stringify([
          1,
          2,
          3
        ]), "[1,2,3]");

eq("File \"js_json_test.ml\", line 299, characters 2-9", JSON.stringify(do
          foo: 1,
          bar: "hello",
          baz: do
            baaz: 10
          end
        end), "{\"foo\":1,\"bar\":\"hello\",\"baz\":{\"baaz\":10}}");

eq("File \"js_json_test.ml\", line 303, characters 12-19", JSON.stringify(null), "null");

eq("File \"js_json_test.ml\", line 305, characters 12-19", JSON.stringify(undefined), undefined);

eq("File \"js_json_test.ml\", line 308, characters 5-12", Js_json.decodeString("test"), "test");

eq("File \"js_json_test.ml\", line 310, characters 5-12", Js_json.decodeString(true), undefined);

eq("File \"js_json_test.ml\", line 312, characters 5-12", Js_json.decodeString([]), undefined);

eq("File \"js_json_test.ml\", line 314, characters 5-12", Js_json.decodeString(null), undefined);

eq("File \"js_json_test.ml\", line 316, characters 5-12", Js_json.decodeString({ }), undefined);

eq("File \"js_json_test.ml\", line 318, characters 5-12", Js_json.decodeString(1.23), undefined);

eq("File \"js_json_test.ml\", line 322, characters 5-12", Js_json.decodeNumber("test"), undefined);

eq("File \"js_json_test.ml\", line 324, characters 5-12", Js_json.decodeNumber(true), undefined);

eq("File \"js_json_test.ml\", line 326, characters 5-12", Js_json.decodeNumber([]), undefined);

eq("File \"js_json_test.ml\", line 328, characters 5-12", Js_json.decodeNumber(null), undefined);

eq("File \"js_json_test.ml\", line 330, characters 5-12", Js_json.decodeNumber({ }), undefined);

eq("File \"js_json_test.ml\", line 332, characters 5-12", Js_json.decodeNumber(1.23), 1.23);

eq("File \"js_json_test.ml\", line 336, characters 5-12", Js_json.decodeObject("test"), undefined);

eq("File \"js_json_test.ml\", line 338, characters 5-12", Js_json.decodeObject(true), undefined);

eq("File \"js_json_test.ml\", line 340, characters 5-12", Js_json.decodeObject([]), undefined);

eq("File \"js_json_test.ml\", line 342, characters 5-12", Js_json.decodeObject(null), undefined);

eq("File \"js_json_test.ml\", line 344, characters 5-12", Js_json.decodeObject({ }), { });

eq("File \"js_json_test.ml\", line 347, characters 5-12", Js_json.decodeObject(1.23), undefined);

eq("File \"js_json_test.ml\", line 351, characters 5-12", Js_json.decodeArray("test"), undefined);

eq("File \"js_json_test.ml\", line 353, characters 5-12", Js_json.decodeArray(true), undefined);

eq("File \"js_json_test.ml\", line 355, characters 5-12", Js_json.decodeArray([]), []);

eq("File \"js_json_test.ml\", line 357, characters 5-12", Js_json.decodeArray(null), undefined);

eq("File \"js_json_test.ml\", line 359, characters 5-12", Js_json.decodeArray({ }), undefined);

eq("File \"js_json_test.ml\", line 361, characters 5-12", Js_json.decodeArray(1.23), undefined);

eq("File \"js_json_test.ml\", line 365, characters 5-12", Js_json.decodeBoolean("test"), undefined);

eq("File \"js_json_test.ml\", line 367, characters 5-12", Js_json.decodeBoolean(true), true);

eq("File \"js_json_test.ml\", line 369, characters 5-12", Js_json.decodeBoolean([]), undefined);

eq("File \"js_json_test.ml\", line 371, characters 5-12", Js_json.decodeBoolean(null), undefined);

eq("File \"js_json_test.ml\", line 373, characters 5-12", Js_json.decodeBoolean({ }), undefined);

eq("File \"js_json_test.ml\", line 375, characters 5-12", Js_json.decodeBoolean(1.23), undefined);

eq("File \"js_json_test.ml\", line 379, characters 5-12", Js_json.decodeNull("test"), undefined);

eq("File \"js_json_test.ml\", line 381, characters 5-12", Js_json.decodeNull(true), undefined);

eq("File \"js_json_test.ml\", line 383, characters 5-12", Js_json.decodeNull([]), undefined);

eq("File \"js_json_test.ml\", line 385, characters 5-12", Js_json.decodeNull(null), null);

eq("File \"js_json_test.ml\", line 387, characters 5-12", Js_json.decodeNull({ }), undefined);

eq("File \"js_json_test.ml\", line 389, characters 5-12", Js_json.decodeNull(1.23), undefined);

Mt.from_pair_suites("Js_json_test", suites.contents);

exports.suites = suites;
exports.add_test = add_test;
exports.eq = eq;
exports.false_ = false_;
exports.true_ = true_;
exports.option_get = option_get;
exports.eq_at_i = eq_at_i;
--[ v Not a pure module ]--
