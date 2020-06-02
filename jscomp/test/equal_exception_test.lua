console = {log = print};

Mt = require "./mt";
Bytes = require "../../lib/js/bytes";
Caml_bytes = require "../../lib/js/caml_bytes";
Caml_exceptions = require "../../lib/js/caml_exceptions";
Caml_js_exceptions = require "../../lib/js/caml_js_exceptions";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

v = "gso";

function is_equal(param) do
  if (Caml_bytes.get(Bytes.make(3, --[[ "a" ]]97), 0) ~= --[[ "a" ]]97) then do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "equal_exception_test.ml",
        9,
        4
      }
    })
  end
   end 
  if (Bytes.make(3, --[[ "a" ]]97)[0] ~= --[[ "a" ]]97) then do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "equal_exception_test.ml",
        10,
        4
      }
    })
  end
   end 
  u = Bytes.make(3, --[[ "a" ]]97);
  u[0] = --[[ "b" ]]98;
  if (u[0] ~= --[[ "b" ]]98) then do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "equal_exception_test.ml",
        13,
        4
      }
    })
  end
   end 
  return 0;
end end

function is_exception(param) do
  xpcall(function() do
    error(Caml_builtin_exceptions.not_found)
  end end,function(exn) do
    if (exn == Caml_builtin_exceptions.not_found) then do
      return --[[ () ]]0;
    end else do
      error(exn)
    end end 
  end end)
end end

function is_normal_exception(_x) do
  A = Caml_exceptions.create("A");
  v = {
    A,
    3
  };
  xpcall(function() do
    error(v)
  end end,function(raw_exn) do
    exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == A) then do
      if (exn[1] ~= 3) then do
        error(exn)
      end else do
        return --[[ () ]]0;
      end end 
    end else do
      error(exn)
    end end 
  end end)
end end

function is_arbitrary_exception(param) do
  A = Caml_exceptions.create("A");
  xpcall(function() do
    error(A)
  end end,function(exn) do
    return --[[ () ]]0;
  end end)
end end

suites_000 = --[[ tuple ]]{
  "is_equal",
  is_equal
};

suites_001 = --[[ :: ]]{
  --[[ tuple ]]{
    "is_exception",
    is_exception
  },
  --[[ :: ]]{
    --[[ tuple ]]{
      "is_normal_exception",
      is_normal_exception
    },
    --[[ :: ]]{
      --[[ tuple ]]{
        "is_arbitrary_exception",
        is_arbitrary_exception
      },
      --[[ [] ]]0
    }
  }
};

suites = --[[ :: ]]{
  suites_000,
  suites_001
};

Mt.from_suites("exception", suites);

exports = {}
exports.v = v;
exports.is_equal = is_equal;
exports.is_exception = is_exception;
exports.is_normal_exception = is_normal_exception;
exports.is_arbitrary_exception = is_arbitrary_exception;
exports.suites = suites;
--[[  Not a pure module ]]