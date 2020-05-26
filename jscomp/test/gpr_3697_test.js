'use strict';

Caml_obj = require("../../lib/js/caml_obj.js");
CamlinternalLazy = require("../../lib/js/camlinternalLazy.js");

function fix(param) do
  return --[ Fix ]--[Caml_obj.caml_lazy_make((function (param) do
                  return fix(--[ () ]--0);
                end end))];
end end

function unfixLeak(_param) do
  while(true) do
    param = _param;
    _param = CamlinternalLazy.force(param[0]);
    continue ;
  end;
end end

function unfix(p) do
  while(true) do
    match = p.contents;
    p.contents = CamlinternalLazy.force(match[0]);
  end;
  return --[ () ]--0;
end end

exports.fix = fix;
exports.unfixLeak = unfixLeak;
exports.unfix = unfix;
--[ No side effect ]--
