'use strict';

Sys = require("./sys.js");
$$Array = require("./array.js");
Caml_array = require("./caml_array.js");
Caml_int32 = require("./caml_int32.js");
Caml_external_polyfill = require("./caml_external_polyfill.js");
Caml_builtin_exceptions = require("./caml_builtin_exceptions.js");

function kind_size_in_bytes(param) do
  local ___conditional___=(param);
  do
     if ___conditional___ = 4--[[ Int16_signed ]]
     or ___conditional___ = 5--[[ Int16_unsigned ]] then do
        return 2;end end end 
     if ___conditional___ = 0--[[ Float32 ]]
     or ___conditional___ = 6--[[ Int32 ]] then do
        return 4;end end end 
     if ___conditional___ = 8--[[ Int ]]
     or ___conditional___ = 9--[[ Nativeint ]] then do
        return Sys.word_size / 8 | 0;end end end 
     if ___conditional___ = 1--[[ Float64 ]]
     or ___conditional___ = 7--[[ Int64 ]]
     or ___conditional___ = 10--[[ Complex32 ]] then do
        return 8;end end end 
     if ___conditional___ = 11--[[ Complex64 ]] then do
        return 16;end end end 
     if ___conditional___ = 2--[[ Int8_signed ]]
     or ___conditional___ = 3--[[ Int8_unsigned ]]
     or ___conditional___ = 12--[[ Char ]] then do
        return 1;end end end 
     do
    
  end
end end

function dims(a) do
  n = Caml_external_polyfill.resolve("caml_ba_num_dims")(a);
  d = Caml_array.caml_make_vect(n, 0);
  for i = 0 , n - 1 | 0 , 1 do
    Caml_array.caml_array_set(d, i, Caml_external_polyfill.resolve("caml_ba_dim")(a, i));
  end
  return d;
end end

function size_in_bytes(arr) do
  return Caml_int32.imul(kind_size_in_bytes(Caml_external_polyfill.resolve("caml_ba_kind")(arr)), $$Array.fold_left(Caml_int32.imul, 1, dims(arr)));
end end

function map_file(fd, posOpt, kind, layout, shared, dims) do
  pos = posOpt ~= undefined and posOpt or --[[ int64 ]][
      --[[ hi ]]0,
      --[[ lo ]]0
    ];
  return Caml_external_polyfill.resolve("caml_ba_map_file_bytecode")(fd, kind, layout, shared, dims, pos);
end end

Genarray = do
  dims: dims,
  size_in_bytes: size_in_bytes,
  map_file: map_file
end;

function create(kind, layout) do
  return Caml_external_polyfill.resolve("caml_ba_create")(kind, layout, []);
end end

function get(arr) do
  return Caml_external_polyfill.resolve("caml_ba_get_generic")(arr, []);
end end

function set(arr) do
  partial_arg = [];
  return (function (param) do
      return Caml_external_polyfill.resolve("caml_ba_set_generic")(arr, partial_arg, param);
    end end);
end end

function size_in_bytes$1(arr) do
  return kind_size_in_bytes(Caml_external_polyfill.resolve("caml_ba_kind")(arr));
end end

function of_value(kind, layout, v) do
  a = create(kind, layout);
  set(a)(v);
  return a;
end end

function create$1(kind, layout, dim) do
  return Caml_external_polyfill.resolve("caml_ba_create")(kind, layout, [dim]);
end end

function size_in_bytes$2(arr) do
  return Caml_int32.imul(kind_size_in_bytes(Caml_external_polyfill.resolve("caml_ba_kind")(arr)), Caml_external_polyfill.resolve("caml_ba_dim_1")(arr));
end end

function slice(a, n) do
  Caml_external_polyfill.resolve("caml_ba_layout")(a);
  return Caml_external_polyfill.resolve("caml_ba_slice")(a, [n]);
end end

function of_array(kind, layout, data) do
  ba = create$1(kind, layout, #data);
  ofs = layout and 1 or 0;
  for i = 0 , #data - 1 | 0 , 1 do
    Caml_external_polyfill.resolve("caml_ba_set_1")(ba, i + ofs | 0, Caml_array.caml_array_get(data, i));
  end
  return ba;
end end

function map_file$1(fd, pos, kind, layout, shared, dim) do
  return map_file(fd, pos, kind, layout, shared, [dim]);
end end

function create$2(kind, layout, dim1, dim2) do
  return Caml_external_polyfill.resolve("caml_ba_create")(kind, layout, [
              dim1,
              dim2
            ]);
end end

function size_in_bytes$3(arr) do
  return Caml_int32.imul(Caml_int32.imul(kind_size_in_bytes(Caml_external_polyfill.resolve("caml_ba_kind")(arr)), Caml_external_polyfill.resolve("caml_ba_dim_1")(arr)), Caml_external_polyfill.resolve("caml_ba_dim_2")(arr));
end end

function slice_left(a, n) do
  return Caml_external_polyfill.resolve("caml_ba_slice")(a, [n]);
end end

function slice_right(a, n) do
  return Caml_external_polyfill.resolve("caml_ba_slice")(a, [n]);
end end

function of_array$1(kind, layout, data) do
  dim1 = #data;
  dim2 = dim1 == 0 and 0 or #Caml_array.caml_array_get(data, 0);
  ba = create$2(kind, layout, dim1, dim2);
  ofs = layout and 1 or 0;
  for i = 0 , dim1 - 1 | 0 , 1 do
    row = Caml_array.caml_array_get(data, i);
    if (#row ~= dim2) then do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "Bigarray.Array2.of_array: non-rectangular data"
          ];
    end
     end 
    for j = 0 , dim2 - 1 | 0 , 1 do
      Caml_external_polyfill.resolve("caml_ba_set_2")(ba, i + ofs | 0, j + ofs | 0, Caml_array.caml_array_get(row, j));
    end
  end
  return ba;
end end

function map_file$2(fd, pos, kind, layout, shared, dim1, dim2) do
  return map_file(fd, pos, kind, layout, shared, [
              dim1,
              dim2
            ]);
end end

function create$3(kind, layout, dim1, dim2, dim3) do
  return Caml_external_polyfill.resolve("caml_ba_create")(kind, layout, [
              dim1,
              dim2,
              dim3
            ]);
end end

function size_in_bytes$4(arr) do
  return Caml_int32.imul(Caml_int32.imul(Caml_int32.imul(kind_size_in_bytes(Caml_external_polyfill.resolve("caml_ba_kind")(arr)), Caml_external_polyfill.resolve("caml_ba_dim_1")(arr)), Caml_external_polyfill.resolve("caml_ba_dim_2")(arr)), Caml_external_polyfill.resolve("caml_ba_dim_3")(arr));
end end

function slice_left_1(a, n, m) do
  return Caml_external_polyfill.resolve("caml_ba_slice")(a, [
              n,
              m
            ]);
end end

function slice_right_1(a, n, m) do
  return Caml_external_polyfill.resolve("caml_ba_slice")(a, [
              n,
              m
            ]);
end end

function slice_left_2(a, n) do
  return Caml_external_polyfill.resolve("caml_ba_slice")(a, [n]);
end end

function slice_right_2(a, n) do
  return Caml_external_polyfill.resolve("caml_ba_slice")(a, [n]);
end end

function of_array$2(kind, layout, data) do
  dim1 = #data;
  dim2 = dim1 == 0 and 0 or #Caml_array.caml_array_get(data, 0);
  dim3 = dim2 == 0 and 0 or #Caml_array.caml_array_get(Caml_array.caml_array_get(data, 0), 0);
  ba = create$3(kind, layout, dim1, dim2, dim3);
  ofs = layout and 1 or 0;
  for i = 0 , dim1 - 1 | 0 , 1 do
    row = Caml_array.caml_array_get(data, i);
    if (#row ~= dim2) then do
      throw [
            Caml_builtin_exceptions.invalid_argument,
            "Bigarray.Array3.of_array: non-cubic data"
          ];
    end
     end 
    for j = 0 , dim2 - 1 | 0 , 1 do
      col = Caml_array.caml_array_get(row, j);
      if (#col ~= dim3) then do
        throw [
              Caml_builtin_exceptions.invalid_argument,
              "Bigarray.Array3.of_array: non-cubic data"
            ];
      end
       end 
      for k = 0 , dim3 - 1 | 0 , 1 do
        Caml_external_polyfill.resolve("caml_ba_set_3")(ba, i + ofs | 0, j + ofs | 0, k + ofs | 0, Caml_array.caml_array_get(col, k));
      end
    end
  end
  return ba;
end end

function map_file$3(fd, pos, kind, layout, shared, dim1, dim2, dim3) do
  return map_file(fd, pos, kind, layout, shared, [
              dim1,
              dim2,
              dim3
            ]);
end end

function array0_of_genarray(a) do
  if (Caml_external_polyfill.resolve("caml_ba_num_dims")(a) == 0) then do
    return a;
  end else do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Bigarray.array0_of_genarray"
        ];
  end end 
end end

function array1_of_genarray(a) do
  if (Caml_external_polyfill.resolve("caml_ba_num_dims")(a) == 1) then do
    return a;
  end else do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Bigarray.array1_of_genarray"
        ];
  end end 
end end

function array2_of_genarray(a) do
  if (Caml_external_polyfill.resolve("caml_ba_num_dims")(a) == 2) then do
    return a;
  end else do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Bigarray.array2_of_genarray"
        ];
  end end 
end end

function array3_of_genarray(a) do
  if (Caml_external_polyfill.resolve("caml_ba_num_dims")(a) == 3) then do
    return a;
  end else do
    throw [
          Caml_builtin_exceptions.invalid_argument,
          "Bigarray.array3_of_genarray"
        ];
  end end 
end end

function reshape_0(a) do
  return Caml_external_polyfill.resolve("caml_ba_reshape")(a, []);
end end

function reshape_1(a, dim1) do
  return Caml_external_polyfill.resolve("caml_ba_reshape")(a, [dim1]);
end end

function reshape_2(a, dim1, dim2) do
  return Caml_external_polyfill.resolve("caml_ba_reshape")(a, [
              dim1,
              dim2
            ]);
end end

function reshape_3(a, dim1, dim2, dim3) do
  return Caml_external_polyfill.resolve("caml_ba_reshape")(a, [
              dim1,
              dim2,
              dim3
            ]);
end end

float32 = --[[ Float32 ]]0;

float64 = --[[ Float64 ]]1;

complex32 = --[[ Complex32 ]]10;

complex64 = --[[ Complex64 ]]11;

int8_signed = --[[ Int8_signed ]]2;

int8_unsigned = --[[ Int8_unsigned ]]3;

int16_signed = --[[ Int16_signed ]]4;

int16_unsigned = --[[ Int16_unsigned ]]5;

$$int = --[[ Int ]]8;

int32 = --[[ Int32 ]]6;

int64 = --[[ Int64 ]]7;

nativeint = --[[ Nativeint ]]9;

$$char = --[[ Char ]]12;

c_layout = --[[ C_layout ]]0;

fortran_layout = --[[ Fortran_layout ]]1;

function Array0_change_layout(prim, prim$1) do
  return Caml_external_polyfill.resolve("caml_ba_change_layout")(prim, prim$1);
end end

Array0 = do
  create: create,
  change_layout: Array0_change_layout,
  size_in_bytes: size_in_bytes$1,
  get: get,
  set: set,
  of_value: of_value
end;

function Array1_change_layout(prim, prim$1) do
  return Caml_external_polyfill.resolve("caml_ba_change_layout")(prim, prim$1);
end end

Array1 = do
  create: create$1,
  change_layout: Array1_change_layout,
  size_in_bytes: size_in_bytes$2,
  slice: slice,
  of_array: of_array,
  map_file: map_file$1
end;

function Array2_change_layout(prim, prim$1) do
  return Caml_external_polyfill.resolve("caml_ba_change_layout")(prim, prim$1);
end end

Array2 = do
  create: create$2,
  change_layout: Array2_change_layout,
  size_in_bytes: size_in_bytes$3,
  slice_left: slice_left,
  slice_right: slice_right,
  of_array: of_array$1,
  map_file: map_file$2
end;

function Array3_change_layout(prim, prim$1) do
  return Caml_external_polyfill.resolve("caml_ba_change_layout")(prim, prim$1);
end end

Array3 = do
  create: create$3,
  change_layout: Array3_change_layout,
  size_in_bytes: size_in_bytes$4,
  slice_left_1: slice_left_1,
  slice_right_1: slice_right_1,
  slice_left_2: slice_left_2,
  slice_right_2: slice_right_2,
  of_array: of_array$2,
  map_file: map_file$3
end;

function reshape(prim, prim$1) do
  return Caml_external_polyfill.resolve("caml_ba_reshape")(prim, prim$1);
end end

exports.float32 = float32;
exports.float64 = float64;
exports.complex32 = complex32;
exports.complex64 = complex64;
exports.int8_signed = int8_signed;
exports.int8_unsigned = int8_unsigned;
exports.int16_signed = int16_signed;
exports.int16_unsigned = int16_unsigned;
exports.$$int = $$int;
exports.int32 = int32;
exports.int64 = int64;
exports.nativeint = nativeint;
exports.$$char = $$char;
exports.kind_size_in_bytes = kind_size_in_bytes;
exports.c_layout = c_layout;
exports.fortran_layout = fortran_layout;
exports.Genarray = Genarray;
exports.Array0 = Array0;
exports.Array1 = Array1;
exports.Array2 = Array2;
exports.Array3 = Array3;
exports.array0_of_genarray = array0_of_genarray;
exports.array1_of_genarray = array1_of_genarray;
exports.array2_of_genarray = array2_of_genarray;
exports.array3_of_genarray = array3_of_genarray;
exports.reshape = reshape;
exports.reshape_0 = reshape_0;
exports.reshape_1 = reshape_1;
exports.reshape_2 = reshape_2;
exports.reshape_3 = reshape_3;
--[[ No side effect ]]
