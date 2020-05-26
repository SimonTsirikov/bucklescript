

import * as Curry from "./curry.js";
import * as $$Buffer from "./buffer.js";
import * as Pervasives from "./pervasives.js";
import * as CamlinternalFormat from "./camlinternalFormat.js";

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
    buf = $$Buffer.create(64);
    CamlinternalFormat.strput_acc(buf, acc);
    return Curry._1(k, $$Buffer.contents(buf));
  end end;
  return CamlinternalFormat.make_printf(k$prime, --[[ () ]]0, --[[ End_of_acc ]]0, param[0]);
end end

function sprintf(fmt) do
  return ksprintf((function (s) do
                return s;
              end end), fmt);
end end

kprintf = ksprintf;

export do
  fprintf ,
  printf ,
  eprintf ,
  sprintf ,
  bprintf ,
  ifprintf ,
  kfprintf ,
  ikfprintf ,
  ksprintf ,
  kbprintf ,
  kprintf ,
  
end
--[[ No side effect ]]
