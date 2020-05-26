'use strict';

var Mt = require("./mt.js");
var Block = require("../../lib/js/block.js");
var Bytes = require("../../lib/js/bytes.js");
var $$Buffer = require("../../lib/js/buffer.js");
var Caml_bytes = require("../../lib/js/caml_bytes.js");

var v = "gso";

var suites_000 = --[ tuple ]--[
  "equal",
  (function (param) do
      return --[ Eq ]--Block.__(0, [
                --[ tuple ]--[
                  Caml_bytes.get(Bytes.make(3, --[ "a" ]--97), 0),
                  Bytes.make(3, --[ "a" ]--97)[0]
                ],
                --[ tuple ]--[
                  --[ "a" ]--97,
                  --[ "a" ]--97
                ]
              ]);
    end)
];

var suites_001 = --[ :: ]--[
  --[ tuple ]--[
    "equal2",
    (function (param) do
        var u = Bytes.make(3, --[ "a" ]--97);
        u[0] = --[ "b" ]--98;
        return --[ Eq ]--Block.__(0, [
                  --[ tuple ]--[
                    u[0],
                    --[ "g" ]--103
                  ],
                  --[ tuple ]--[
                    --[ "b" ]--98,
                    --[ "g" ]--103
                  ]
                ]);
      end)
  ],
  --[ :: ]--[
    --[ tuple ]--[
      "buffer",
      (function (param) do
          var v = $$Buffer.create(30);
          for var i = 0 , 10 , 1 do
            $$Buffer.add_string(v, String(i));
          end
          return --[ Eq ]--Block.__(0, [
                    $$Buffer.contents(v),
                    "012345678910"
                  ]);
        end)
    ],
    --[ [] ]--0
  ]
];

var suites = --[ :: ]--[
  suites_000,
  suites_001
];

Mt.from_pair_suites("Buffer_test", suites);

exports.v = v;
exports.suites = suites;
--[  Not a pure module ]--
