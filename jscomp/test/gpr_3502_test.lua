console = {log = print};


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

name_1 = 2;

exports = {}
exports.Language = Language;
exports.language = language;
exports.shortName = shortName;
exports.name = name_1;
--[[ No side effect ]]
