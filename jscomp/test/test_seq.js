'use strict';

var Block = require("../../lib/js/block.js");
var Curry = require("../../lib/js/curry.js");
var Caml_obj = require("../../lib/js/caml_obj.js");
var Pervasives = require("../../lib/js/pervasives.js");
var Caml_exceptions = require("../../lib/js/caml_exceptions.js");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

var Bad = Caml_exceptions.create("Test_seq.Bad");

var Help = Caml_exceptions.create("Test_seq.Help");

var Stop = Caml_exceptions.create("Test_seq.Stop");

function assoc3(x, _l) do
  while(true) do
    var l = _l;
    if (l) do
      var match = l[0];
      if (Caml_obj.caml_equal(match[0], x)) do
        return match[1];
      end else do
        _l = l[1];
        continue ;
      end
    end else do
      throw Caml_builtin_exceptions.not_found;
    end
  end;
end

function help_action(param) do
  throw [
        Stop,
        --[ Unknown ]--Block.__(0, ["-help"])
      ];
end

function v(speclist) do
  assoc3("-help", speclist);
  return --[ [] ]--0;
end

function f(g, speclist) do
  return Curry._1(g, assoc3("-help", speclist));
end

function add_help(speclist) do
  var add1;
  try do
    assoc3("-help", speclist);
    add1 = --[ [] ]--0;
  end
  catch (exn)do
    if (exn == Caml_builtin_exceptions.not_found) do
      add1 = --[ :: ]--[
        --[ tuple ]--[
          "-help",
          --[ Unit ]--Block.__(0, [help_action]),
          " Display this list of options"
        ],
        --[ [] ]--0
      ];
    end else do
      throw exn;
    end
  end
  var add2;
  try do
    assoc3("--help", speclist);
    add2 = --[ [] ]--0;
  end
  catch (exn$1)do
    if (exn$1 == Caml_builtin_exceptions.not_found) do
      add2 = --[ :: ]--[
        --[ tuple ]--[
          "--help",
          --[ Unit ]--Block.__(0, [help_action]),
          " Display this list of options"
        ],
        --[ [] ]--0
      ];
    end else do
      throw exn$1;
    end
  end
  return Pervasives.$at(speclist, Pervasives.$at(add1, add2));
end

exports.Bad = Bad;
exports.Help = Help;
exports.Stop = Stop;
exports.assoc3 = assoc3;
exports.help_action = help_action;
exports.v = v;
exports.f = f;
exports.add_help = add_help;
--[ No side effect ]--
