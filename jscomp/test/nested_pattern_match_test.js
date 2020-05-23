'use strict';


function f_list(x) do
  if (x) do
    var match = x[1];
    if (match) do
      var match$1 = match[1];
      if (match$1) do
        var match$2 = match$1[1];
        if (match$2) do
          var match$3 = match$2[1];
          if (match$3) do
            var match$4 = match$3[1];
            if (match$4) do
              return ((((x[0] + match[0] | 0) + match$1[0] | 0) + match$2[0] | 0) + match$3[0] | 0) + match$4[0] | 0;
            end else do
              return 0;
            end
          end else do
            return 0;
          end
        end else do
          return 0;
        end
      end else do
        return 0;
      end
    end else do
      return 0;
    end
  end else do
    return 0;
  end
end

function f_arr(x) do
  if (#x ~= 6) do
    return 0;
  end else do
    var a0 = x[0];
    var a1 = x[1];
    var a2 = x[2];
    var a3 = x[3];
    var a4 = x[4];
    var a5 = x[5];
    return ((((a0 + a1 | 0) + a2 | 0) + a3 | 0) + a4 | 0) + a5 | 0;
  end
end

function f_opion(x) do
  var match = x.hi;
  if (match ~= 2) do
    if (match ~= 3) do
      return 0;
    end else do
      var match$1 = x.lo;
      if (match$1 and match$1[0] == undefined) do
        var match$2 = match$1[1];
        if (match$2 and match$2[0] == undefined) do
          var match$3 = match$2[1];
          if (match$3) do
            var match$4 = match$3[0];
            if (match$4 == 2) do
              var match$5 = match$3[1];
              if (match$5) do
                var match$6 = match$5[0];
                if (match$6 == 1) do
                  var match$7 = match$5[1];
                  if (match$7 and match$7[0] ~= undefined) do
                    return 2;
                  end else do
                    return 0;
                  end
                end else do
                  return 0;
                end
              end else do
                return 0;
              end
            end else do
              return 0;
            end
          end else do
            return 0;
          end
        end else do
          return 0;
        end
      end else do
        return 0;
      end
    end
  end else do
    var match$8 = x.lo;
    if (match$8 and match$8[0] == undefined) do
      var match$9 = match$8[1];
      if (match$9 and match$9[0] == undefined) do
        var match$10 = match$9[1];
        if (match$10) do
          var match$11 = match$10[0];
          if (match$11 == 2) do
            var match$12 = match$10[1];
            if (match$12) do
              var match$13 = match$12[0];
              if (match$13 == 1) do
                var match$14 = match$12[1];
                if (match$14 and match$14[0] ~= undefined) do
                  return 3;
                end else do
                  return 0;
                end
              end else do
                return 0;
              end
            end else do
              return 0;
            end
          end else do
            return 0;
          end
        end else do
          return 0;
        end
      end else do
        return 0;
      end
    end else do
      return 0;
    end
  end
end

exports.f_list = f_list;
exports.f_arr = f_arr;
exports.f_opion = f_opion;
--[ No side effect ]--
