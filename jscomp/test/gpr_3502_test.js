'use strict';


function toString(param) do
  return "a";
end

function name(param) do
  return 2;
end

var Language = do
  toString: toString,
  name: name
end;

var language = "a";

var shortName = "a";

var name$1 = 2;

exports.Language = Language;
exports.language = language;
exports.shortName = shortName;
exports.name = name$1;
--[ No side effect ]--
