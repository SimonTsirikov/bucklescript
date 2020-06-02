console = {log = print};


List = do
  u: 3
end;

X = do
  List: List
end;

Hashtbl = --[[ alias ]]0;

V = --[[ alias ]]0;

exports = {}
exports.X = X;
exports.Hashtbl = Hashtbl;
exports.V = V;
--[[ No side effect ]]
