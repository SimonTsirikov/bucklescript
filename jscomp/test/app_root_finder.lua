--[['use strict';]]

Fs = require "";
Path = require "";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

package_json = "package.json";

function find_package_json(_dir) do
  while(true) do
    dir = _dir;
    if (Fs.existsSync(Path.join(dir, package_json))) then do
      return dir;
    end else do
      new_dir = Path.dirname(dir);
      if (new_dir == dir) then do
        error(Caml_builtin_exceptions.not_found)
      end
       end 
      _dir = new_dir;
      ::continue:: ;
    end end 
  end;
end end

match = typeof __dirname == "undefined" and undefined or __dirname;

if (match ~= undefined) then do
  console.log(find_package_json(match));
end
 end 

exports.package_json = package_json;
exports.find_package_json = find_package_json;
--[[ match Not a pure module ]]
