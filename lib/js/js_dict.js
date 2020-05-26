'use strict';

var Caml_option = require("./caml_option.js");

function get(dict, k) do
  if ((k in dict)) then do
    return Caml_option.some(dict[k]);
  end
   end 
end

var unsafeDeleteKey = (function (dict,key){
     delete dict[key];
     return 0
     });

function entries(dict) do
  var keys = Object.keys(dict);
  var l = keys.length;
  var values = new Array(l);
  for var i = 0 , l - 1 | 0 , 1 do
    var key = keys[i];
    values[i] = --[ tuple ]--[
      key,
      dict[key]
    ];
  end
  return values;
end

function values(dict) do
  var keys = Object.keys(dict);
  var l = keys.length;
  var values$1 = new Array(l);
  for var i = 0 , l - 1 | 0 , 1 do
    values$1[i] = dict[keys[i]];
  end
  return values$1;
end

function fromList(entries) do
  var dict = { };
  var _param = entries;
  while(true) do
    var param = _param;
    if (param) then do
      var match = param[0];
      dict[match[0]] = match[1];
      _param = param[1];
      continue ;
    end else do
      return dict;
    end end 
  end;
end

function fromArray(entries) do
  var dict = { };
  var l = entries.length;
  for var i = 0 , l - 1 | 0 , 1 do
    var match = entries[i];
    dict[match[0]] = match[1];
  end
  return dict;
end

function map(f, source) do
  var target = { };
  var keys = Object.keys(source);
  var l = keys.length;
  for var i = 0 , l - 1 | 0 , 1 do
    var key = keys[i];
    target[key] = f(source[key]);
  end
  return target;
end

exports.get = get;
exports.unsafeDeleteKey = unsafeDeleteKey;
exports.entries = entries;
exports.values = values;
exports.fromList = fromList;
exports.fromArray = fromArray;
exports.map = map;
--[ No side effect ]--
