'use strict';

var Mt = require("./mt.js");
var Caml_option = require("../../lib/js/caml_option.js");

var suites = do
  contents: --[ [] ]--0
end;

var test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end

function b(loc, b$1) do
  return Mt.bool_suites(test_id, suites, loc, b$1);
end

function makeWrapper(foo, param) do
  var tmp = { };
  if (foo ~= undefined) do
    tmp.foo = (function () do
          switch (Caml_option.valFromOption(foo)) do
            case 97 :
                return "a";
            case 98 :
                return "b";
            
          end
        end)();
  end
  console.log(tmp);
  return --[ () ]--0;
end

function makeWrapper2(foo, param) do
  console.log(do
        foo: (function () do
              switch (foo) do
                case 97 :
                    return "a";
                case 98 :
                    return "b";
                
              end
            end)()
      end);
  return --[ () ]--0;
end

makeWrapper2(--[ a ]--97, --[ () ]--0);

function makeWrapper3(foo, param) do
  console.log(2);
  var tmp = { };
  if (foo ~= undefined) do
    tmp.foo = (function () do
          switch (Caml_option.valFromOption(foo)) do
            case 97 :
                return "a";
            case 98 :
                return "b";
            
          end
        end)();
  end
  return tmp;
end

function makeWrapper4(foo, param) do
  console.log(2);
  var tmp = { };
  var tmp$1 = foo > 100 ? undefined : (
      foo > 10 ? --[ b ]--98 : --[ a ]--97
    );
  if (tmp$1 ~= undefined) do
    tmp.foo = (function () do
          switch (Caml_option.valFromOption(tmp$1)) do
            case 97 :
                return "a";
            case 98 :
                return "b";
            
          end
        end)();
  end
  return tmp;
end

b("File \"gpr_2503_test.ml\", line 31, characters 5-12", "a" == makeWrapper3(--[ a ]--97, --[ () ]--0).foo);

b("File \"gpr_2503_test.ml\", line 34, characters 5-12", undefined == makeWrapper3(undefined, --[ () ]--0).foo);

b("File \"gpr_2503_test.ml\", line 37, characters 5-12", "a" == makeWrapper4(1, --[ () ]--0).foo);

b("File \"gpr_2503_test.ml\", line 40, characters 5-12", "b" == makeWrapper4(11, --[ () ]--0).foo);

b("File \"gpr_2503_test.ml\", line 43, characters 5-12", undefined == makeWrapper4(111, --[ () ]--0).foo);

Mt.from_pair_suites("Gpr_2503_test", suites.contents);

exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.b = b;
exports.makeWrapper = makeWrapper;
exports.makeWrapper2 = makeWrapper2;
exports.makeWrapper3 = makeWrapper3;
exports.makeWrapper4 = makeWrapper4;
--[  Not a pure module ]--
