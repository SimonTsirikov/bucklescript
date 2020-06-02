console = {log = print};

List = require "../../lib/js/list";
Curry = require "../../lib/js/curry";
Queue = require "../../lib/js/queue";
Caml_obj = require "../../lib/js/caml_obj";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

function to_list(q) do
  return List.rev(Queue.fold((function(l, x) do
                    return --[[ :: ]]{
                            x,
                            l
                          };
                  end end), --[[ [] ]]0, q));
end end

Q = do
  Empty: Queue.Empty,
  create: Queue.create,
  add: Queue.add,
  push: Queue.push,
  take: Queue.take,
  pop: Queue.pop,
  peek: Queue.peek,
  top: Queue.top,
  clear: Queue.clear,
  copy: Queue.copy,
  is_empty: Queue.is_empty,
  length: Queue.length,
  iter: Queue.iter,
  fold: Queue.fold,
  transfer: Queue.transfer,
  to_list: to_list
end;

function does_raise(f, q) do
  xpcall(function() do
    Curry._1(f, q);
    return false;
  end end,function(exn) do
    if (exn == Queue.Empty) then do
      return true;
    end else do
      error(exn)
    end end 
  end end)
end end

q = do
  length: 0,
  first: --[[ Nil ]]0,
  last: --[[ Nil ]]0
end;

if (not (to_list(q) == --[[ [] ]]0 and q.length == 0)) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      28,
      25
    }
  })
end
 end 

Queue.add(1, q);

if (not (Caml_obj.caml_equal(to_list(q), --[[ :: ]]{
          1,
          --[[ [] ]]0
        }) and q.length == 1)) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      29,
      25
    }
  })
end
 end 

Queue.add(2, q);

if (not (Caml_obj.caml_equal(to_list(q), --[[ :: ]]{
          1,
          --[[ :: ]]{
            2,
            --[[ [] ]]0
          }
        }) and q.length == 2)) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      30,
      25
    }
  })
end
 end 

Queue.add(3, q);

if (not (Caml_obj.caml_equal(to_list(q), --[[ :: ]]{
          1,
          --[[ :: ]]{
            2,
            --[[ :: ]]{
              3,
              --[[ [] ]]0
            }
          }
        }) and q.length == 3)) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      31,
      25
    }
  })
end
 end 

Queue.add(4, q);

if (not (Caml_obj.caml_equal(to_list(q), --[[ :: ]]{
          1,
          --[[ :: ]]{
            2,
            --[[ :: ]]{
              3,
              --[[ :: ]]{
                4,
                --[[ [] ]]0
              }
            }
          }
        }) and q.length == 4)) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      32,
      25
    }
  })
end
 end 

if (Queue.take(q) ~= 1) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      33,
      2
    }
  })
end
 end 

if (not (Caml_obj.caml_equal(to_list(q), --[[ :: ]]{
          2,
          --[[ :: ]]{
            3,
            --[[ :: ]]{
              4,
              --[[ [] ]]0
            }
          }
        }) and q.length == 3)) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      33,
      25
    }
  })
end
 end 

if (Queue.take(q) ~= 2) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      34,
      2
    }
  })
end
 end 

if (not (Caml_obj.caml_equal(to_list(q), --[[ :: ]]{
          3,
          --[[ :: ]]{
            4,
            --[[ [] ]]0
          }
        }) and q.length == 2)) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      34,
      25
    }
  })
end
 end 

if (Queue.take(q) ~= 3) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      35,
      2
    }
  })
end
 end 

if (not (Caml_obj.caml_equal(to_list(q), --[[ :: ]]{
          4,
          --[[ [] ]]0
        }) and q.length == 1)) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      35,
      25
    }
  })
end
 end 

if (Queue.take(q) ~= 4) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      36,
      2
    }
  })
end
 end 

if (not (to_list(q) == --[[ [] ]]0 and q.length == 0)) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      36,
      25
    }
  })
end
 end 

if (not does_raise(Queue.take, q)) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      37,
      2
    }
  })
end
 end 

q_1 = do
  length: 0,
  first: --[[ Nil ]]0,
  last: --[[ Nil ]]0
end;

Queue.add(1, q_1);

if (Queue.take(q_1) ~= 1) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      42,
      13
    }
  })
end
 end 

if (not does_raise(Queue.take, q_1)) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      42,
      36
    }
  })
end
 end 

Queue.add(2, q_1);

if (Queue.take(q_1) ~= 2) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      43,
      13
    }
  })
end
 end 

if (not does_raise(Queue.take, q_1)) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      43,
      36
    }
  })
end
 end 

if (q_1.length ~= 0) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      44,
      2
    }
  })
end
 end 

q_2 = do
  length: 0,
  first: --[[ Nil ]]0,
  last: --[[ Nil ]]0
end;

Queue.add(1, q_2);

if (Queue.peek(q_2) ~= 1) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      49,
      13
    }
  })
end
 end 

Queue.add(2, q_2);

if (Queue.peek(q_2) ~= 1) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      50,
      13
    }
  })
end
 end 

Queue.add(3, q_2);

if (Queue.peek(q_2) ~= 1) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      51,
      13
    }
  })
end
 end 

if (Queue.peek(q_2) ~= 1) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      52,
      2
    }
  })
end
 end 

if (Queue.take(q_2) ~= 1) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      52,
      25
    }
  })
end
 end 

if (Queue.peek(q_2) ~= 2) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      53,
      2
    }
  })
end
 end 

if (Queue.take(q_2) ~= 2) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      53,
      25
    }
  })
end
 end 

if (Queue.peek(q_2) ~= 3) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      54,
      2
    }
  })
end
 end 

if (Queue.take(q_2) ~= 3) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      54,
      25
    }
  })
end
 end 

if (not does_raise(Queue.peek, q_2)) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      55,
      2
    }
  })
end
 end 

if (not does_raise(Queue.peek, q_2)) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      56,
      2
    }
  })
end
 end 

q_3 = do
  length: 0,
  first: --[[ Nil ]]0,
  last: --[[ Nil ]]0
end;

for i = 1 , 10 , 1 do
  Queue.add(i, q_3);
end

Queue.clear(q_3);

if (q_3.length ~= 0) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      63,
      2
    }
  })
end
 end 

if (not does_raise(Queue.take, q_3)) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      64,
      2
    }
  })
end
 end 

if (not Caml_obj.caml_equal(q_3, do
        length: 0,
        first: --[[ Nil ]]0,
        last: --[[ Nil ]]0
      end)) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      65,
      2
    }
  })
end
 end 

Queue.add(42, q_3);

if (Queue.take(q_3) ~= 42) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      67,
      2
    }
  })
end
 end 

q1 = do
  length: 0,
  first: --[[ Nil ]]0,
  last: --[[ Nil ]]0
end;

for i_1 = 1 , 10 , 1 do
  Queue.add(i_1, q1);
end

q2 = Queue.copy(q1);

if (not Caml_obj.caml_equal(to_list(q1), --[[ :: ]]{
        1,
        --[[ :: ]]{
          2,
          --[[ :: ]]{
            3,
            --[[ :: ]]{
              4,
              --[[ :: ]]{
                5,
                --[[ :: ]]{
                  6,
                  --[[ :: ]]{
                    7,
                    --[[ :: ]]{
                      8,
                      --[[ :: ]]{
                        9,
                        --[[ :: ]]{
                          10,
                          --[[ [] ]]0
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      })) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      74,
      2
    }
  })
end
 end 

if (not Caml_obj.caml_equal(to_list(q2), --[[ :: ]]{
        1,
        --[[ :: ]]{
          2,
          --[[ :: ]]{
            3,
            --[[ :: ]]{
              4,
              --[[ :: ]]{
                5,
                --[[ :: ]]{
                  6,
                  --[[ :: ]]{
                    7,
                    --[[ :: ]]{
                      8,
                      --[[ :: ]]{
                        9,
                        --[[ :: ]]{
                          10,
                          --[[ [] ]]0
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      })) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      75,
      2
    }
  })
end
 end 

if (q1.length ~= 10) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      76,
      2
    }
  })
end
 end 

if (q2.length ~= 10) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      77,
      2
    }
  })
end
 end 

for i_2 = 1 , 10 , 1 do
  if (Queue.take(q1) ~= i_2) then do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "libqueue_test.ml",
        79,
        4
      }
    })
  end
   end 
end

for i_3 = 1 , 10 , 1 do
  if (Queue.take(q2) ~= i_3) then do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "libqueue_test.ml",
        82,
        4
      }
    })
  end
   end 
end

q_4 = do
  length: 0,
  first: --[[ Nil ]]0,
  last: --[[ Nil ]]0
end;

if (q_4.length ~= 0) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      88,
      2
    }
  })
end
 end 

for i_4 = 1 , 10 , 1 do
  Queue.add(i_4, q_4);
  if (q_4.length ~= i_4) then do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "libqueue_test.ml",
        91,
        4
      }
    })
  end
   end 
  if (q_4.length == 0) then do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "libqueue_test.ml",
        92,
        4
      }
    })
  end
   end 
end

for i_5 = 10 , 1 , -1 do
  if (q_4.length ~= i_5) then do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "libqueue_test.ml",
        95,
        4
      }
    })
  end
   end 
  if (q_4.length == 0) then do
    error({
      Caml_builtin_exceptions.assert_failure,
      --[[ tuple ]]{
        "libqueue_test.ml",
        96,
        4
      }
    })
  end
   end 
  Queue.take(q_4);
end

if (q_4.length ~= 0) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      99,
      2
    }
  })
end
 end 

if (q_4.length ~= 0) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      100,
      2
    }
  })
end
 end 

q_5 = do
  length: 0,
  first: --[[ Nil ]]0,
  last: --[[ Nil ]]0
end;

for i_6 = 1 , 10 , 1 do
  Queue.add(i_6, q_5);
end

i_7 = do
  contents: 1
end;

Queue.iter((function(j) do
        if (i_7.contents ~= j) then do
          error({
            Caml_builtin_exceptions.assert_failure,
            --[[ tuple ]]{
              "libqueue_test.ml",
              107,
              19
            }
          })
        end
         end 
        i_7.contents = i_7.contents + 1 | 0;
        return --[[ () ]]0;
      end end), q_5);

q1_1 = do
  length: 0,
  first: --[[ Nil ]]0,
  last: --[[ Nil ]]0
end;

q2_1 = do
  length: 0,
  first: --[[ Nil ]]0,
  last: --[[ Nil ]]0
end;

if (q1_1.length ~= 0) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      112,
      2
    }
  })
end
 end 

if (to_list(q1_1) ~= --[[ [] ]]0) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      112,
      28
    }
  })
end
 end 

if (q2_1.length ~= 0) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      113,
      2
    }
  })
end
 end 

if (to_list(q2_1) ~= --[[ [] ]]0) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      113,
      28
    }
  })
end
 end 

Queue.transfer(q1_1, q2_1);

if (q1_1.length ~= 0) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      115,
      2
    }
  })
end
 end 

if (to_list(q1_1) ~= --[[ [] ]]0) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      115,
      28
    }
  })
end
 end 

if (q2_1.length ~= 0) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      116,
      2
    }
  })
end
 end 

if (to_list(q2_1) ~= --[[ [] ]]0) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      116,
      28
    }
  })
end
 end 

q1_2 = do
  length: 0,
  first: --[[ Nil ]]0,
  last: --[[ Nil ]]0
end;

q2_2 = do
  length: 0,
  first: --[[ Nil ]]0,
  last: --[[ Nil ]]0
end;

for i_8 = 1 , 4 , 1 do
  Queue.add(i_8, q1_2);
end

if (q1_2.length ~= 4) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      122,
      2
    }
  })
end
 end 

if (not Caml_obj.caml_equal(to_list(q1_2), --[[ :: ]]{
        1,
        --[[ :: ]]{
          2,
          --[[ :: ]]{
            3,
            --[[ :: ]]{
              4,
              --[[ [] ]]0
            }
          }
        }
      })) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      122,
      28
    }
  })
end
 end 

if (q2_2.length ~= 0) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      123,
      2
    }
  })
end
 end 

if (to_list(q2_2) ~= --[[ [] ]]0) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      123,
      28
    }
  })
end
 end 

Queue.transfer(q1_2, q2_2);

if (q1_2.length ~= 0) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      125,
      2
    }
  })
end
 end 

if (to_list(q1_2) ~= --[[ [] ]]0) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      125,
      28
    }
  })
end
 end 

if (q2_2.length ~= 4) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      126,
      2
    }
  })
end
 end 

if (not Caml_obj.caml_equal(to_list(q2_2), --[[ :: ]]{
        1,
        --[[ :: ]]{
          2,
          --[[ :: ]]{
            3,
            --[[ :: ]]{
              4,
              --[[ [] ]]0
            }
          }
        }
      })) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      126,
      28
    }
  })
end
 end 

q1_3 = do
  length: 0,
  first: --[[ Nil ]]0,
  last: --[[ Nil ]]0
end;

q2_3 = do
  length: 0,
  first: --[[ Nil ]]0,
  last: --[[ Nil ]]0
end;

for i_9 = 5 , 8 , 1 do
  Queue.add(i_9, q2_3);
end

if (q1_3.length ~= 0) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      132,
      2
    }
  })
end
 end 

if (to_list(q1_3) ~= --[[ [] ]]0) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      132,
      28
    }
  })
end
 end 

if (q2_3.length ~= 4) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      133,
      2
    }
  })
end
 end 

if (not Caml_obj.caml_equal(to_list(q2_3), --[[ :: ]]{
        5,
        --[[ :: ]]{
          6,
          --[[ :: ]]{
            7,
            --[[ :: ]]{
              8,
              --[[ [] ]]0
            }
          }
        }
      })) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      133,
      28
    }
  })
end
 end 

Queue.transfer(q1_3, q2_3);

if (q1_3.length ~= 0) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      135,
      2
    }
  })
end
 end 

if (to_list(q1_3) ~= --[[ [] ]]0) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      135,
      28
    }
  })
end
 end 

if (q2_3.length ~= 4) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      136,
      2
    }
  })
end
 end 

if (not Caml_obj.caml_equal(to_list(q2_3), --[[ :: ]]{
        5,
        --[[ :: ]]{
          6,
          --[[ :: ]]{
            7,
            --[[ :: ]]{
              8,
              --[[ [] ]]0
            }
          }
        }
      })) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      136,
      28
    }
  })
end
 end 

q1_4 = do
  length: 0,
  first: --[[ Nil ]]0,
  last: --[[ Nil ]]0
end;

q2_4 = do
  length: 0,
  first: --[[ Nil ]]0,
  last: --[[ Nil ]]0
end;

for i_10 = 1 , 4 , 1 do
  Queue.add(i_10, q1_4);
end

for i_11 = 5 , 8 , 1 do
  Queue.add(i_11, q2_4);
end

if (q1_4.length ~= 4) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      143,
      2
    }
  })
end
 end 

if (not Caml_obj.caml_equal(to_list(q1_4), --[[ :: ]]{
        1,
        --[[ :: ]]{
          2,
          --[[ :: ]]{
            3,
            --[[ :: ]]{
              4,
              --[[ [] ]]0
            }
          }
        }
      })) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      143,
      28
    }
  })
end
 end 

if (q2_4.length ~= 4) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      144,
      2
    }
  })
end
 end 

if (not Caml_obj.caml_equal(to_list(q2_4), --[[ :: ]]{
        5,
        --[[ :: ]]{
          6,
          --[[ :: ]]{
            7,
            --[[ :: ]]{
              8,
              --[[ [] ]]0
            }
          }
        }
      })) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      144,
      28
    }
  })
end
 end 

Queue.transfer(q1_4, q2_4);

if (q1_4.length ~= 0) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      146,
      2
    }
  })
end
 end 

if (to_list(q1_4) ~= --[[ [] ]]0) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      146,
      28
    }
  })
end
 end 

if (q2_4.length ~= 8) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      147,
      2
    }
  })
end
 end 

if (not Caml_obj.caml_equal(to_list(q2_4), --[[ :: ]]{
        5,
        --[[ :: ]]{
          6,
          --[[ :: ]]{
            7,
            --[[ :: ]]{
              8,
              --[[ :: ]]{
                1,
                --[[ :: ]]{
                  2,
                  --[[ :: ]]{
                    3,
                    --[[ :: ]]{
                      4,
                      --[[ [] ]]0
                    }
                  }
                }
              }
            }
          }
        }
      })) then do
  error({
    Caml_builtin_exceptions.assert_failure,
    --[[ tuple ]]{
      "libqueue_test.ml",
      147,
      28
    }
  })
end
 end 

console.log("OK");

exports = {}
exports.Q = Q;
exports.does_raise = does_raise;
--[[ q Not a pure module ]]
