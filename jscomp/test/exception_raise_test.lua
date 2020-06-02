--[['use strict';]]

Mt = require "./mt";
List = require "../../lib/js/list";
Block = require "../../lib/js/block";
Curry = require "../../lib/js/curry";
Js_exn = require "../../lib/js/js_exn";
Pervasives = require "../../lib/js/pervasives";
Caml_exceptions = require "../../lib/js/caml_exceptions";
Caml_js_exceptions = require "../../lib/js/caml_js_exceptions";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

Local = Caml_exceptions.create("Exception_raise_test.Local");

B = Caml_exceptions.create("Exception_raise_test.B");

C = Caml_exceptions.create("Exception_raise_test.C");

D = Caml_exceptions.create("Exception_raise_test.D");

function appf(g, x) do
  A = Caml_exceptions.create("A");
  xpcall(function() do
    return Curry._1(g, x);
  end end,function(raw_exn) return do
    exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn == Local) then do
      return 3;
    end else if (exn == Caml_builtin_exceptions.not_found) then do
      return 2;
    end else if (exn[0] == A) then do
      return 3;
    end else if (exn[0] == B) then do
      match = exn[1];
      if (match) then do
        match$1 = match[1];
        if (match$1) then do
          match$2 = match$1[1];
          if (match$2) then do
            return match$2[0];
          end else do
            return 4;
          end end 
        end else do
          return 4;
        end end 
      end else do
        return 4;
      end end 
    end else if (exn[0] == C) then do
      return exn[1];
    end else if (exn[0] == D) then do
      return exn[1][0];
    end else do
      return 4;
    end end  end  end  end  end  end 
  end end)
end end

A = Caml_exceptions.create("Exception_raise_test.A");

f;

xpcall(function() do
  f = (function () {throw (new Error ("x"))} ());
end end,function(raw_exn) return do
  exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
  f = exn[0] == A and exn[1] or 2;
end end)

ff;

xpcall(function() do
  ff = (function () {throw 3} ());
end end,function(raw_exn$1) return do
  exn$1 = Caml_js_exceptions.internalToOCamlException(raw_exn$1);
  ff = exn$1[0] == A and exn$1[1] or 2;
end end)

fff;

xpcall(function() do
  fff = (function () {throw 2} ());
end end,function(raw_exn$2) return do
  exn$2 = Caml_js_exceptions.internalToOCamlException(raw_exn$2);
  fff = exn$2[0] == A and exn$2[1] or 2;
end end)

a0;

xpcall(function() do
  a0 = (function (){throw 2} ());
end end,function(raw_exn$3) return do
  exn$3 = Caml_js_exceptions.internalToOCamlException(raw_exn$3);
  if (exn$3[0] == A or exn$3[0] == Js_exn.__Error) then do
    a0 = exn$3[1];
  end else do
    error ({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "exception_raise_test.ml",
        102,
        9
      }
    })
  end end 
end end)

a1;

xpcall(function() do
  a1 = (function (){throw 2} ());
end end,function(raw_e) return do
  a1 = Caml_js_exceptions.internalToOCamlException(raw_e);
end end)

a2;

xpcall(function() do
  a2 = (function (){throw (new Error("x"))} ());
end end,function(raw_e$1) return do
  a2 = Caml_js_exceptions.internalToOCamlException(raw_e$1);
end end)

suites = do
  contents: --[[ :: ]]{
    --[[ tuple ]]{
      "File \"exception_raise_test.ml\", line 114, characters 4-11",
      (function (param) do
          return --[[ Eq ]]Block.__(0, {
                    --[[ tuple ]]{
                      f,
                      ff,
                      fff,
                      a0
                    },
                    --[[ tuple ]]{
                      2,
                      2,
                      2,
                      2
                    }
                  });
        end end)
    },
    --[[ :: ]]{
      --[[ tuple ]]{
        "File \"exception_raise_test.ml\", line 116, characters 4-11",
        (function (param) do
            if (a1[0] == Js_exn.__Error) then do
              return --[[ Eq ]]Block.__(0, {
                        a1[1],
                        2
                      });
            end else do
              error ({
                Caml_builtin_exceptions.assert_failure,
                --[[ tuple ]]{
                  "exception_raise_test.ml",
                  119,
                  15
                }
              })
            end end 
          end end)
      },
      --[[ [] ]]0
    }
  }
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

xpcall(function() do
  (function (_)dothrow 2end(--[[ () ]]0));
end end,function(raw_e$2) return do
  e = Caml_js_exceptions.internalToOCamlException(raw_e$2);
  eq("File \"exception_raise_test.ml\", line 131, characters 7-14", Caml_js_exceptions.caml_as_js_exn(e) ~= undefined, true);
end end)

xpcall(function() do
  error (Caml_builtin_exceptions.not_found)
end end,function(raw_e$3) return do
  e$1 = Caml_js_exceptions.internalToOCamlException(raw_e$3);
  eq("File \"exception_raise_test.ml\", line 138, characters 7-14", Caml_js_exceptions.caml_as_js_exn(e$1) ~= undefined, false);
end end)

function fff0(x, g) do
  val;
  xpcall(function() do
    val = Curry._1(x, --[[ () ]]0);
  end end,function(exn) return do
    return 1;
  end end)
  return Curry._1(g, --[[ () ]]0);
end end

function input_lines(ic, _acc) do
  while(true) do
    acc = _acc;
    line;
    xpcall(function() do
      line = Pervasives.input_line(ic);
    end end,function(exn) return do
      return List.rev(acc);
    end end)
    _acc = --[[ :: ]]{
      line,
      acc
    };
    ::continue:: ;
  end;
end end

eq("File \"exception_raise_test.ml\", line 150, characters 5-12", function (a,b,c,_)doreturn a + b + c end(1, 2, 3, 4), 6);

Mt.from_pair_suites("Exception_raise_test", suites.contents);

exports.Local = Local;
exports.B = B;
exports.C = C;
exports.D = D;
exports.appf = appf;
exports.A = A;
exports.f = f;
exports.ff = ff;
exports.fff = fff;
exports.a0 = a0;
exports.a1 = a1;
exports.a2 = a2;
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
exports.fff0 = fff0;
exports.input_lines = input_lines;
--[[ f Not a pure module ]]
