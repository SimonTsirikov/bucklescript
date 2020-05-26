

import * as Obj from "./obj.js";

function register(name, v) do
  return --[ () ]--0;
end

function register_exception(name, exn) do
  (exn.tag | 0) == Obj.object_tag and exn or exn[0];
  return --[ () ]--0;
end

export do
  register ,
  register_exception ,
  
end
--[ No side effect ]--
