

import * as Caml_int32 from "./caml_int32.js";

function rotl32(x, n) do
  return (x << n) | (x >>> (32 - n | 0));
end

function caml_hash_mix_int(h, d) do
  var d$1 = d;
  d$1 = Caml_int32.imul(d$1, 3432918353);
  d$1 = rotl32(d$1, 15);
  d$1 = Caml_int32.imul(d$1, 461845907);
  var h$1 = h ^ d$1;
  h$1 = rotl32(h$1, 13);
  return (h$1 + (h$1 << 2) | 0) + 3864292196 | 0;
end

function caml_hash_final_mix(h) do
  var h$1 = h ^ (h >>> 16);
  h$1 = Caml_int32.imul(h$1, 2246822507);
  h$1 = h$1 ^ (h$1 >>> 13);
  h$1 = Caml_int32.imul(h$1, 3266489909);
  return h$1 ^ (h$1 >>> 16);
end

function caml_hash_mix_string(h, s) do
  var len = #s;
  var block = (len / 4 | 0) - 1 | 0;
  var hash = h;
  for(var i = 0; i <= block; ++i)do
    var j = (i << 2);
    var w = s.charCodeAt(j) | (s.charCodeAt(j + 1 | 0) << 8) | (s.charCodeAt(j + 2 | 0) << 16) | (s.charCodeAt(j + 3 | 0) << 24);
    hash = caml_hash_mix_int(hash, w);
  end
  var modulo = len & 3;
  if (modulo ~= 0) then do
    var w$1 = modulo == 3 ? (s.charCodeAt(len - 1 | 0) << 16) | (s.charCodeAt(len - 2 | 0) << 8) | s.charCodeAt(len - 3 | 0) : (
        modulo == 2 ? (s.charCodeAt(len - 1 | 0) << 8) | s.charCodeAt(len - 2 | 0) : s.charCodeAt(len - 1 | 0)
      );
    hash = caml_hash_mix_int(hash, w$1);
  end
   end 
  hash = hash ^ len;
  return hash;
end

export do
  caml_hash_mix_int ,
  caml_hash_mix_string ,
  caml_hash_final_mix ,
  
end
--[ No side effect ]--
