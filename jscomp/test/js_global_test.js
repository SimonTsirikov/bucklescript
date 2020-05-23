'use strict';

var Mt = require("./mt.js");
var Block = require("../../lib/js/block.js");

var suites_000 = --[ tuple ]--[
  "setTimeout/clearTimeout sanity check",
  (function (param) do
      var handle = setTimeout((function (param) do
              return --[ () ]--0;
            end), 0);
      clearTimeout(handle);
      return --[ Ok ]--Block.__(4, [true]);
    end)
];

var suites_001 = --[ :: ]--[
  --[ tuple ]--[
    "setInerval/clearInterval sanity check",
    (function (param) do
        var handle = setInterval((function (param) do
                return --[ () ]--0;
              end), 0);
        clearInterval(handle);
        return --[ Ok ]--Block.__(4, [true]);
      end)
  ],
  --[ :: ]--[
    --[ tuple ]--[
      "encodeURI",
      (function (param) do
          return --[ Eq ]--Block.__(0, [
                    encodeURI("[-=-]"),
                    "%5B-=-%5D"
                  ]);
        end)
    ],
    --[ :: ]--[
      --[ tuple ]--[
        "decodeURI",
        (function (param) do
            return --[ Eq ]--Block.__(0, [
                      decodeURI("%5B-=-%5D"),
                      "[-=-]"
                    ]);
          end)
      ],
      --[ :: ]--[
        --[ tuple ]--[
          "encodeURIComponent",
          (function (param) do
              return --[ Eq ]--Block.__(0, [
                        encodeURIComponent("[-=-]"),
                        "%5B-%3D-%5D"
                      ]);
            end)
        ],
        --[ :: ]--[
          --[ tuple ]--[
            "decodeURIComponent",
            (function (param) do
                return --[ Eq ]--Block.__(0, [
                          decodeURIComponent("%5B-%3D-%5D"),
                          "[-=-]"
                        ]);
              end)
          ],
          --[ [] ]--0
        ]
      ]
    ]
  ]
];

var suites = --[ :: ]--[
  suites_000,
  suites_001
];

Mt.from_pair_suites("Js_global_test", suites);

exports.suites = suites;
--[  Not a pure module ]--
