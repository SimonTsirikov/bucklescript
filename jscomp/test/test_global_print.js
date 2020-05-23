'use strict';


var List = do
  u: 3
end;

var X = do
  List: List
end;

var Hashtbl = --[ alias ]--0;

var V = --[ alias ]--0;

exports.X = X;
exports.Hashtbl = Hashtbl;
exports.V = V;
--[ No side effect ]--
