


function caml_gc_counters(param) do
  return --[ tuple ]--[
          0,
          0,
          0
        ];
end

function caml_gc_set(param) do
  return --[ () ]--0;
end

function caml_gc_minor(param) do
  return --[ () ]--0;
end

function caml_gc_major_slice(param) do
  return 0;
end

function caml_gc_major(param) do
  return --[ () ]--0;
end

function caml_gc_full_major(param) do
  return --[ () ]--0;
end

function caml_gc_compaction(param) do
  return --[ () ]--0;
end

function caml_final_register(param, param$1) do
  return --[ () ]--0;
end

function caml_final_release(param) do
  return --[ () ]--0;
end

export do
  caml_gc_counters ,
  caml_gc_set ,
  caml_gc_minor ,
  caml_gc_major_slice ,
  caml_gc_major ,
  caml_gc_full_major ,
  caml_gc_compaction ,
  caml_final_register ,
  caml_final_release ,
  
end
--[ No side effect ]--
