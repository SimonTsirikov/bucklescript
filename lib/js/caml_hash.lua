console = {log = print};

Caml_hash_primitive = require "./caml_hash_primitive";
Caml_builtin_exceptions = require "./caml_builtin_exceptions";

function push_back(q, v) do
  cell = {
    content = v,
    next = nil
  };
  match = q.last;
  if (match ~= nil) then do
    q.length = q.length + 1 | 0;
    match.next = cell;
    q.last = cell;
    return --[[ () ]]0;
  end else do
    q.length = 1;
    q.first = cell;
    q.last = cell;
    return --[[ () ]]0;
  end end 
end end

function unsafe_pop(q) do
  cell = q.first;
  next = cell.next;
  if (next == nil) then do
    q.length = 0;
    q.first = nil;
    q.last = nil;
  end else do
    q.length = q.length - 1 | 0;
    q.first = next;
  end end 
  return cell.content;
end end

function caml_hash(count, _limit, seed, obj) do
  hash = seed;
  if (typeof obj == "number") then do
    u = obj | 0;
    hash = Caml_hash_primitive.caml_hash_mix_int(hash, (u + u | 0) + 1 | 0);
    return Caml_hash_primitive.caml_hash_final_mix(hash);
  end else if (typeof obj == "string") then do
    hash = Caml_hash_primitive.caml_hash_mix_string(hash, obj);
    return Caml_hash_primitive.caml_hash_final_mix(hash);
  end else do
    queue = {
      length = 0,
      first = nil,
      last = nil
    };
    num = count;
    push_back(queue, obj);
    num = num - 1 | 0;
    while(queue.length ~= 0 and num > 0) do
      obj_1 = unsafe_pop(queue);
      if (typeof obj_1 == "number") then do
        u_1 = obj_1 | 0;
        hash = Caml_hash_primitive.caml_hash_mix_int(hash, (u_1 + u_1 | 0) + 1 | 0);
        num = num - 1 | 0;
      end else if (typeof obj_1 == "string") then do
        hash = Caml_hash_primitive.caml_hash_mix_string(hash, obj_1);
        num = num - 1 | 0;
      end else if (typeof obj_1 ~= "boolean" and typeof obj_1 ~= "undefined") then do
        if (typeof obj_1 == "symbol") then do
          error({
            Caml_builtin_exceptions.assert_failure,
            --[[ tuple ]]{
              "caml_hash.ml",
              128,
              8
            }
          })
        end
         end 
        if (typeof obj_1 ~= "function") then do
          size = obj_1.length;
          if (size ~= nil) then do
            obj_tag = obj_1.tag | 0;
            tag = (size << 10) | obj_tag;
            if (tag == 248) then do
              hash = Caml_hash_primitive.caml_hash_mix_int(hash, obj_1[1]);
            end else do
              hash = Caml_hash_primitive.caml_hash_mix_int(hash, tag);
              v = size - 1 | 0;
              block = v < num and v or num;
              for i = 0 , block , 1 do
                push_back(queue, obj_1[i]);
              end
            end end 
          end
           end 
        end
         end 
      end
       end  end  end 
    end;
    return Caml_hash_primitive.caml_hash_final_mix(hash);
  end end  end 
end end

exports = {}
exports.caml_hash = caml_hash;
--[[ No side effect ]]
