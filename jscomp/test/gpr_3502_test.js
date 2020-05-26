'use strict';


function toString(param) do
  return "a";
end end

function name(param) do
  return 2;
end end

Language = do
  toString: toString,
  name: name
end;

language = "a";

shortName = "a";

name$1 = 2;

exports.Language = Language;
exports.language = language;
exports.shortName = shortName;
exports.name = name$1;
--[ No side effect ]--
