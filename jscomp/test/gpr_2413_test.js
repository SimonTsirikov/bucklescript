'use strict';

var Caml_int32 = require("../../lib/js/caml_int32.js");

function f(param) do
  switch (param.tag | 0) do
    case --[ A ]--0 :
        var match = param[0];
        if (match.tag) do
          var a = match[0];
          return a - a | 0;
        end else do
          var a$1 = match[0];
          return a$1 + a$1 | 0;
        end
    case --[ B ]--1 :
    case --[ C ]--2 :
        break;
    
  end
  var a$2 = param[0][0];
  return Caml_int32.imul(a$2, a$2);
end

function ff(c) do
  c.contents = c.contents + 1 | 0;
  var match = (1 + c.contents | 0) + 1 | 0;
  if (match > 3 or match < 0) do
    return 0;
  end else do
    return match + 1 | 0;
  end
end

exports.f = f;
exports.ff = ff;
--[ No side effect ]--
