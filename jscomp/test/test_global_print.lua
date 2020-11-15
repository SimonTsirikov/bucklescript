__console = {log = print};


List = {
  u = 3
};

X = {
  List = List
};

Hashtbl = --[[ alias ]]0;

V = --[[ alias ]]0;

exports = {};
exports.X = X;
exports.Hashtbl = Hashtbl;
exports.V = V;
return exports;
--[[ No side effect ]]
