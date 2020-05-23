'use strict';

var Fs = require("fs");
var Path = require("path");
var Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

var package_json = "package.json";

function find_package_json(_dir) do
  while(true) do
    var dir = _dir;
    if (Fs.existsSync(Path.join(dir, package_json))) do
      return dir;
    end else do
      var new_dir = Path.dirname(dir);
      if (new_dir == dir) do
        throw Caml_builtin_exceptions.not_found;
      end
      _dir = new_dir;
      continue ;
    end
  end;
end

var match = typeof __dirname == "undefined" ? undefined : __dirname;

if (match ~= undefined) do
  console.log(find_package_json(match));
end

exports.package_json = package_json;
exports.find_package_json = find_package_json;
--[ match Not a pure module ]--
