'use strict';

Mt = require("./mt.js");
List = require("../../lib/js/list.js");
Block = require("../../lib/js/block.js");
Bytes = require("../../lib/js/bytes.js");
Caml_char = require("../../lib/js/caml_char.js");
Caml_bytes = require("../../lib/js/caml_bytes.js");

suites_000 = --[ tuple ]--[
  "caml_is_printable",
  (function (param) do
      return --[ Eq ]--Block.__(0, [
                Caml_char.caml_is_printable(--[ "a" ]--97),
                true
              ]);
    end)
];

suites_001 = --[ :: ]--[
  --[ tuple ]--[
    "caml_string_of_bytes",
    (function (param) do
        match = List.split(List.map((function (x) do
                    len = x;
                    b = Caml_bytes.caml_create_bytes(1000);
                    Caml_bytes.caml_fill_bytes(b, 0, len, --[ "c" ]--99);
                    return --[ tuple ]--[
                            Caml_bytes.bytes_to_string(b),
                            Caml_bytes.bytes_to_string(Bytes.init(len, (function (param) do
                                        return --[ "c" ]--99;
                                      end)))
                          ];
                  end), --[ :: ]--[
                  1000,
                  --[ :: ]--[
                    1024,
                    --[ :: ]--[
                      1025,
                      --[ :: ]--[
                        4095,
                        --[ :: ]--[
                          4096,
                          --[ :: ]--[
                            5000,
                            --[ :: ]--[
                              10000,
                              --[ [] ]--0
                            ]
                          ]
                        ]
                      ]
                    ]
                  ]
                ]));
        return --[ Eq ]--Block.__(0, [
                  match[0],
                  match[1]
                ]);
      end)
  ],
  --[ [] ]--0
];

suites = --[ :: ]--[
  suites_000,
  suites_001
];

Mt.from_pair_suites("String_runtime_test", suites);

S = --[ alias ]--0;

B = --[ alias ]--0;

exports.S = S;
exports.B = B;
exports.suites = suites;
--[  Not a pure module ]--
