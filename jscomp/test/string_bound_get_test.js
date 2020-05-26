'use strict';

Caml_bytes = require("../../lib/js/caml_bytes.js");
Caml_string = require("../../lib/js/caml_string.js");

v = "ghos";

u_a = --[ "g" ]--103;

function u_b(param) do
  return Caml_string.get(v, -1);
end

function u_d(param) do
  return Caml_string.get("ghos", -1);
end

u_e = Caml_bytes.caml_create_bytes(32);

u_f = Caml_bytes.get(u_e, 0);

function u_g(param) do
  return Caml_bytes.get(u_e, -1);
end

u_c = --[ "g" ]--103;

exports.v = v;
exports.u_a = u_a;
exports.u_b = u_b;
exports.u_c = u_c;
exports.u_d = u_d;
exports.u_e = u_e;
exports.u_f = u_f;
exports.u_g = u_g;
--[ No side effect ]--
