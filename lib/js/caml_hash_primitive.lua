console.log = print;

Caml_int32 = require "./caml_int32";

function rotl32(x, n) do
  return (x << n) | (x >>> (32 - n | 0));
end end

function caml_hash_mix_int(h, d) do
  d_1 = d;
  d_1 = Caml_int32.imul(d_1, 3432918353);
  d_1 = rotl32(d_1, 15);
  d_1 = Caml_int32.imul(d_1, 461845907);
  h_1 = h ^ d_1;
  h_1 = rotl32(h_1, 13);
  return (h_1 + (h_1 << 2) | 0) + 3864292196 | 0;
end end

function caml_hash_final_mix(h) do
  h_1 = h ^ (h >>> 16);
  h_1 = Caml_int32.imul(h_1, 2246822507);
  h_1 = h_1 ^ (h_1 >>> 13);
  h_1 = Caml_int32.imul(h_1, 3266489909);
  return h_1 ^ (h_1 >>> 16);
end end

function caml_hash_mix_string(h, s) do
  len = #s;
  block = (len / 4 | 0) - 1 | 0;
  hash = h;
  for i = 0 , block , 1 do
    j = (i << 2);
    w = s.charCodeAt(j) | (s.charCodeAt(j + 1 | 0) << 8) | (s.charCodeAt(j + 2 | 0) << 16) | (s.charCodeAt(j + 3 | 0) << 24);
    hash = caml_hash_mix_int(hash, w);
  end
  modulo = len & 3;
  if (modulo ~= 0) then do
    w_1 = modulo == 3 and (s.charCodeAt(len - 1 | 0) << 16) | (s.charCodeAt(len - 2 | 0) << 8) | s.charCodeAt(len - 3 | 0) or (
        modulo == 2 and (s.charCodeAt(len - 1 | 0) << 8) | s.charCodeAt(len - 2 | 0) or s.charCodeAt(len - 1 | 0)
      );
    hash = caml_hash_mix_int(hash, w_1);
  end
   end 
  hash = hash ^ len;
  return hash;
end end

exports.caml_hash_mix_int = caml_hash_mix_int;
exports.caml_hash_mix_string = caml_hash_mix_string;
exports.caml_hash_final_mix = caml_hash_final_mix;
--[[ No side effect ]]
