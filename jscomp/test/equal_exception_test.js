'use strict';

var Mt = require("./mt.js");
var Bytes = require("../../lib/js/bytes.js");
var Caml_bytes = require("../../lib/js/caml_bytes.js");
var Caml_exceptions = require("../../lib/js/caml_exceptions.js");
var Caml_js_exceptions = require("../../lib/js/caml_js_exceptions.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

var v = "gso";

function is_equal(param) do
  if (Caml_bytes.get(Bytes.make(3, --[ "a" ]--97), 0) ~= --[ "a" ]--97) then do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "equal_exception_test.ml",
            9,
            4
          ]
        ];
  end
   end 
  if (Bytes.make(3, --[ "a" ]--97)[0] ~= --[ "a" ]--97) then do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "equal_exception_test.ml",
            10,
            4
          ]
        ];
  end
   end 
  var u = Bytes.make(3, --[ "a" ]--97);
  u[0] = --[ "b" ]--98;
  if (u[0] ~= --[ "b" ]--98) then do
    throw [
          Caml_builtin_exceptions.assert_failure,
          --[ tuple ]--[
            "equal_exception_test.ml",
            13,
            4
          ]
        ];
  end
   end 
  return 0;
end

function is_exception(param) do
  try do
    throw Caml_builtin_exceptions.not_found;
  end
  catch (exn)do
    if (exn == Caml_builtin_exceptions.not_found) then do
      return --[ () ]--0;
    end else do
      throw exn;
    end end 
  end
end

function is_normal_exception(_x) do
  var A = Caml_exceptions.create("A");
  var v = [
    A,
    3
  ];
  try do
    throw v;
  end
  catch (raw_exn)do
    var exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == A) then do
      if (exn[1] ~= 3) then do
        throw exn;
      end else do
        return --[ () ]--0;
      end end 
    end else do
      throw exn;
    end end 
  end
end

function is_arbitrary_exception(param) do
  var A = Caml_exceptions.create("A");
  try do
    throw A;
  end
  catch (exn)do
    return --[ () ]--0;
  end
end

var suites_000 = --[ tuple ]--[
  "is_equal",
  is_equal
];

var suites_001 = --[ :: ]--[
  --[ tuple ]--[
    "is_exception",
    is_exception
  ],
  --[ :: ]--[
    --[ tuple ]--[
      "is_normal_exception",
      is_normal_exception
    ],
    --[ :: ]--[
      --[ tuple ]--[
        "is_arbitrary_exception",
        is_arbitrary_exception
      ],
      --[ [] ]--0
    ]
  ]
];

var suites = --[ :: ]--[
  suites_000,
  suites_001
];

Mt.from_suites("exception", suites);

exports.v = v;
exports.is_equal = is_equal;
exports.is_exception = is_exception;
exports.is_normal_exception = is_normal_exception;
exports.is_arbitrary_exception = is_arbitrary_exception;
exports.suites = suites;
--[  Not a pure module ]--
