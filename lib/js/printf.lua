--[['use strict';]]

Curry = require "./curry";
__Buffer = require "./buffer";
Pervasives = require "./pervasives";
CamlinternalFormat = require "./camlinternalFormat";

function kfprintf(k, o, param) do
  return CamlinternalFormat.make_printf((function (o, acc) do
                CamlinternalFormat.output_acc(o, acc);
                return Curry._1(k, o);
              end end), o, --[[ End_of_acc ]]0, param[0]);
end end

function kbprintf(k, b, param) do
  return CamlinternalFormat.make_printf((function (b, acc) do
                CamlinternalFormat.bufput_acc(b, acc);
                return Curry._1(k, b);
              end end), b, --[[ End_of_acc ]]0, param[0]);
end end

function ikfprintf(k, oc, param) do
  return CamlinternalFormat.make_iprintf(k, oc, param[0]);
end end

function fprintf(oc, fmt) do
  return kfprintf((function (prim) do
                return --[[ () ]]0;
              end end), oc, fmt);
end end

function bprintf(b, fmt) do
  return kbprintf((function (prim) do
                return --[[ () ]]0;
              end end), b, fmt);
end end

function ifprintf(oc, fmt) do
  return ikfprintf((function (prim) do
                return --[[ () ]]0;
              end end), oc, fmt);
end end

function printf(fmt) do
  return fprintf(Pervasives.stdout, fmt);
end end

function eprintf(fmt) do
  return fprintf(Pervasives.stderr, fmt);
end end

function ksprintf(k, param) do
  k$prime = function (param, acc) do
    buf = __Buffer.create(64);
    CamlinternalFormat.strput_acc(buf, acc);
    return Curry._1(k, __Buffer.contents(buf));
  end end;
  return CamlinternalFormat.make_printf(k$prime, --[[ () ]]0, --[[ End_of_acc ]]0, param[0]);
end end

function sprintf(fmt) do
  return ksprintf((function (s) do
                return s;
              end end), fmt);
end end

kprintf = ksprintf;

exports.fprintf = fprintf;
exports.printf = printf;
exports.eprintf = eprintf;
exports.sprintf = sprintf;
exports.bprintf = bprintf;
exports.ifprintf = ifprintf;
exports.kfprintf = kfprintf;
exports.ikfprintf = ikfprintf;
exports.ksprintf = ksprintf;
exports.kbprintf = kbprintf;
exports.kprintf = kprintf;
--[[ No side effect ]]
