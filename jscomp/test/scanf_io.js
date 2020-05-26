'use strict';

List = require("../../lib/js/list.js");
Block = require("../../lib/js/block.js");
Bytes = require("../../lib/js/bytes.js");
Curry = require("../../lib/js/curry.js");
Scanf = require("../../lib/js/scanf.js");
$$Buffer = require("../../lib/js/buffer.js");
Digest = require("../../lib/js/digest.js");
Printf = require("../../lib/js/printf.js");
Caml_io = require("../../lib/js/caml_io.js");
Caml_obj = require("../../lib/js/caml_obj.js");
Caml_bytes = require("../../lib/js/caml_bytes.js");
Pervasives = require("../../lib/js/pervasives.js");
Caml_js_exceptions = require("../../lib/js/caml_js_exceptions.js");
Caml_external_polyfill = require("../../lib/js/caml_external_polyfill.js");
Caml_builtin_exceptions = require("../../lib/js/caml_builtin_exceptions.js");

tscanf_data_file = "tscanf_data";

tscanf_data_file_lines = --[ :: ]--[
  --[ tuple ]--[
    "Objective",
    "Caml"
  ],
  --[ [] ]--0
];

function create_tscanf_data(ob, lines) do
  add_line = function (param) do
    $$Buffer.add_string(ob, Curry._1(Printf.sprintf(--[ Format ]--[
                  --[ Caml_string ]--Block.__(3, [
                      --[ No_padding ]--0,
                      --[ End_of_format ]--0
                    ]),
                  "%S"
                ]), param[0]));
    $$Buffer.add_string(ob, " -> ");
    $$Buffer.add_string(ob, Curry._1(Printf.sprintf(--[ Format ]--[
                  --[ Caml_string ]--Block.__(3, [
                      --[ No_padding ]--0,
                      --[ End_of_format ]--0
                    ]),
                  "%S"
                ]), param[1]));
    return $$Buffer.add_string(ob, ";\n");
  end end;
  return List.iter(add_line, lines);
end end

function write_tscanf_data_file(fname, lines) do
  oc = Pervasives.open_out(fname);
  ob = $$Buffer.create(42);
  create_tscanf_data(ob, lines);
  $$Buffer.output_buffer(oc, ob);
  Caml_io.caml_ml_flush(oc);
  return Caml_external_polyfill.resolve("caml_ml_close_channel")(oc);
end end

function get_lines(fname) do
  ib = Scanf.Scanning.from_file(fname);
  l = do
    contents: --[ [] ]--0
  end;
  try do
    while(!Scanf.Scanning.end_of_input(ib)) do
      Curry._1(Scanf.bscanf(ib, --[ Format ]--[
                --[ Char_literal ]--Block.__(12, [
                    --[ " " ]--32,
                    --[ Caml_string ]--Block.__(3, [
                        --[ No_padding ]--0,
                        --[ String_literal ]--Block.__(11, [
                            " -> ",
                            --[ Caml_string ]--Block.__(3, [
                                --[ No_padding ]--0,
                                --[ String_literal ]--Block.__(11, [
                                    "; ",
                                    --[ End_of_format ]--0
                                  ])
                              ])
                          ])
                      ])
                  ]),
                " %S -> %S; "
              ]), (function (x, y) do
              l.contents = --[ :: ]--[
                --[ tuple ]--[
                  x,
                  y
                ],
                l.contents
              ];
              return --[ () ]--0;
            end end));
    end;
    return List.rev(l.contents);
  end
  catch (raw_exn)do
    exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
    if (exn[0] == Scanf.Scan_failure) then do
      s = Curry._2(Printf.sprintf(--[ Format ]--[
                --[ String_literal ]--Block.__(11, [
                    "in file ",
                    --[ String ]--Block.__(2, [
                        --[ No_padding ]--0,
                        --[ String_literal ]--Block.__(11, [
                            ", ",
                            --[ String ]--Block.__(2, [
                                --[ No_padding ]--0,
                                --[ End_of_format ]--0
                              ])
                          ])
                      ])
                  ]),
                "in file %s, %s"
              ]), fname, exn[1]);
      throw [
            Caml_builtin_exceptions.failure,
            s
          ];
    end else if (exn == Caml_builtin_exceptions.end_of_file) then do
      s$1 = Curry._1(Printf.sprintf(--[ Format ]--[
                --[ String_literal ]--Block.__(11, [
                    "in file ",
                    --[ String ]--Block.__(2, [
                        --[ No_padding ]--0,
                        --[ String_literal ]--Block.__(11, [
                            ", unexpected end of file",
                            --[ End_of_format ]--0
                          ])
                      ])
                  ]),
                "in file %s, unexpected end of file"
              ]), fname);
      throw [
            Caml_builtin_exceptions.failure,
            s$1
          ];
    end else do
      throw exn;
    end end  end 
  end
end end

function add_digest_ib(ob, ib) do
  scan_line = function (ib, f) do
    return Curry._1(Scanf.bscanf(ib, --[ Format ]--[
                    --[ Scan_char_set ]--Block.__(20, [
                        undefined,
                        "\xff\xdb\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff",
                        --[ Char_literal ]--Block.__(12, [
                            --[ "\n" ]--10,
                            --[ End_of_format ]--0
                          ])
                      ]),
                    "%[^\n\r]\n"
                  ]), f);
  end end;
  output_line_digest = function (s) do
    $$Buffer.add_string(ob, s);
    $$Buffer.add_char(ob, --[ "#" ]--35);
    s$1 = Digest.to_hex(Digest.string(s));
    $$Buffer.add_string(ob, Caml_bytes.bytes_to_string(Bytes.uppercase(Caml_bytes.bytes_of_string(s$1))));
    return $$Buffer.add_char(ob, --[ "\n" ]--10);
  end end;
  try do
    while(true) do
      scan_line(ib, output_line_digest);
    end;
    return --[ () ]--0;
  end
  catch (exn)do
    if (exn == Caml_builtin_exceptions.end_of_file) then do
      return --[ () ]--0;
    end else do
      throw exn;
    end end 
  end
end end

function digest_file(fname) do
  ib = Scanf.Scanning.from_file(fname);
  ob = $$Buffer.create(42);
  add_digest_ib(ob, ib);
  return $$Buffer.contents(ob);
end end

function test54(param) do
  return Caml_obj.caml_equal(get_lines(tscanf_data_file), tscanf_data_file_lines);
end end

function test55(param) do
  ob = $$Buffer.create(42);
  create_tscanf_data(ob, tscanf_data_file_lines);
  s = $$Buffer.contents(ob);
  ob.position = 0;
  ib = Scanf.Scanning.from_string(s);
  add_digest_ib(ob, ib);
  tscanf_data_file_lines_digest = $$Buffer.contents(ob);
  return digest_file(tscanf_data_file) == tscanf_data_file_lines_digest;
end end

exports.tscanf_data_file = tscanf_data_file;
exports.tscanf_data_file_lines = tscanf_data_file_lines;
exports.create_tscanf_data = create_tscanf_data;
exports.write_tscanf_data_file = write_tscanf_data_file;
exports.get_lines = get_lines;
exports.add_digest_ib = add_digest_ib;
exports.digest_file = digest_file;
exports.test54 = test54;
exports.test55 = test55;
--[ Scanf Not a pure module ]--
