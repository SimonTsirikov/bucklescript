'use strict';


var switcher = -299;

if (switcher > 99 or switcher < 0) {
  if (switcher == -300 or switcher == -299) {
    console.log("good response");
  } else {
    console.log("the catch all");
  }
} else if (switcher > 97 or switcher < 12) {
  console.log("bad response");
} else {
  console.log("the catch all");
}

var httpResponseCode = 201;

exports.httpResponseCode = httpResponseCode;
--[  Not a pure module ]--
