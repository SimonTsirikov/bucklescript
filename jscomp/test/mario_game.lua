--[['use strict';]]

List = require "../../lib/js/list";
Block = require "../../lib/js/block";
Curry = require "../../lib/js/curry";
Printf = require "../../lib/js/printf";
Random = require "../../lib/js/random";
Caml_obj = require "../../lib/js/caml_obj";
Caml_int32 = require "../../lib/js/caml_int32";
Pervasives = require "../../lib/js/pervasives";
Caml_option = require "../../lib/js/caml_option";
Caml_primitive = require "../../lib/js/caml_primitive";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

Actors = { };

Dom_html = { };

function setup_sprite(loopOpt, bbox_offsetOpt, bbox_sizeOpt, img_src, max_frames, max_ticks, frame_size, src_offset) do
  loop = loopOpt ~= undefined and loopOpt or true;
  bbox_offset = bbox_offsetOpt ~= undefined and bbox_offsetOpt or --[[ tuple ]]{
      0,
      0
    };
  bbox_size = bbox_sizeOpt ~= undefined and bbox_sizeOpt or --[[ tuple ]]{
      0,
      0
    };
  bbox_size$1 = Caml_obj.caml_equal(bbox_size, --[[ tuple ]]{
        0,
        0
      }) and frame_size or bbox_size;
  img_src$1 = "./sprites/" .. img_src;
  return do
          max_frames: max_frames,
          max_ticks: max_ticks,
          img_src: img_src$1,
          frame_size: frame_size,
          src_offset: src_offset,
          bbox_offset: bbox_offset,
          bbox_size: bbox_size$1,
          loop: loop
        end;
end end

function make_enemy(param) do
  dir = param[1];
  local ___conditional___=(param[0]);
  do
     if ___conditional___ = 0--[[ Goomba ]] then do
        return setup_sprite(undefined, --[[ tuple ]]{
                    1,
                    1
                  }, --[[ tuple ]]{
                    14,
                    14
                  }, "enemies.png", 2, 10, --[[ tuple ]]{
                    16,
                    16
                  }, --[[ tuple ]]{
                    0,
                    128
                  });end end end 
     if ___conditional___ = 1--[[ GKoopa ]] then do
        if (dir) then do
          return setup_sprite(undefined, --[[ tuple ]]{
                      1,
                      10
                    }, --[[ tuple ]]{
                      11,
                      16
                    }, "enemies.png", 2, 10, --[[ tuple ]]{
                      16,
                      27
                    }, --[[ tuple ]]{
                      32,
                      69
                    });
        end else do
          return setup_sprite(undefined, --[[ tuple ]]{
                      4,
                      10
                    }, --[[ tuple ]]{
                      11,
                      16
                    }, "enemies.png", 2, 10, --[[ tuple ]]{
                      16,
                      27
                    }, --[[ tuple ]]{
                      0,
                      69
                    });
        end end end end end 
     if ___conditional___ = 2--[[ RKoopa ]] then do
        if (dir) then do
          return setup_sprite(undefined, --[[ tuple ]]{
                      1,
                      10
                    }, --[[ tuple ]]{
                      11,
                      16
                    }, "enemies.png", 2, 10, --[[ tuple ]]{
                      16,
                      27
                    }, --[[ tuple ]]{
                      32,
                      5
                    });
        end else do
          return setup_sprite(undefined, --[[ tuple ]]{
                      4,
                      10
                    }, --[[ tuple ]]{
                      11,
                      16
                    }, "enemies.png", 2, 10, --[[ tuple ]]{
                      16,
                      27
                    }, --[[ tuple ]]{
                      0,
                      5
                    });
        end end end end end 
     if ___conditional___ = 3--[[ GKoopaShell ]] then do
        return setup_sprite(undefined, --[[ tuple ]]{
                    2,
                    2
                  }, --[[ tuple ]]{
                    12,
                    13
                  }, "enemies.png", 4, 10, --[[ tuple ]]{
                    16,
                    16
                  }, --[[ tuple ]]{
                    0,
                    96
                  });end end end 
     if ___conditional___ = 4--[[ RKoopaShell ]] then do
        return setup_sprite(undefined, --[[ tuple ]]{
                    2,
                    2
                  }, --[[ tuple ]]{
                    12,
                    13
                  }, "enemies.png", 4, 10, --[[ tuple ]]{
                    16,
                    16
                  }, --[[ tuple ]]{
                    0,
                    32
                  });end end end 
     do
    
  end
end end

function make_particle(param) do
  local ___conditional___=(param);
  do
     if ___conditional___ = 0--[[ GoombaSquish ]] then do
        return setup_sprite(undefined, undefined, undefined, "enemies.png", 1, 0, --[[ tuple ]]{
                    16,
                    16
                  }, --[[ tuple ]]{
                    0,
                    144
                  });end end end 
     if ___conditional___ = 1--[[ BrickChunkL ]] then do
        return setup_sprite(undefined, undefined, undefined, "chunks.png", 1, 0, --[[ tuple ]]{
                    8,
                    8
                  }, --[[ tuple ]]{
                    0,
                    0
                  });end end end 
     if ___conditional___ = 2--[[ BrickChunkR ]] then do
        return setup_sprite(undefined, undefined, undefined, "chunks.png", 1, 0, --[[ tuple ]]{
                    8,
                    8
                  }, --[[ tuple ]]{
                    8,
                    0
                  });end end end 
     if ___conditional___ = 3--[[ Score100 ]] then do
        return setup_sprite(undefined, undefined, undefined, "score.png", 1, 0, --[[ tuple ]]{
                    12,
                    8
                  }, --[[ tuple ]]{
                    0,
                    0
                  });end end end 
     if ___conditional___ = 4--[[ Score200 ]] then do
        return setup_sprite(undefined, undefined, undefined, "score.png", 1, 0, --[[ tuple ]]{
                    12,
                    9
                  }, --[[ tuple ]]{
                    0,
                    9
                  });end end end 
     if ___conditional___ = 5--[[ Score400 ]] then do
        return setup_sprite(undefined, undefined, undefined, "score.png", 1, 0, --[[ tuple ]]{
                    12,
                    9
                  }, --[[ tuple ]]{
                    0,
                    18
                  });end end end 
     if ___conditional___ = 6--[[ Score800 ]] then do
        return setup_sprite(undefined, undefined, undefined, "score.png", 1, 0, --[[ tuple ]]{
                    12,
                    9
                  }, --[[ tuple ]]{
                    0,
                    27
                  });end end end 
     if ___conditional___ = 7--[[ Score1000 ]] then do
        return setup_sprite(undefined, undefined, undefined, "score.png", 1, 0, --[[ tuple ]]{
                    14,
                    9
                  }, --[[ tuple ]]{
                    13,
                    0
                  });end end end 
     if ___conditional___ = 8--[[ Score2000 ]] then do
        return setup_sprite(undefined, undefined, undefined, "score.png", 1, 0, --[[ tuple ]]{
                    14,
                    9
                  }, --[[ tuple ]]{
                    13,
                    9
                  });end end end 
     if ___conditional___ = 9--[[ Score4000 ]] then do
        return setup_sprite(undefined, undefined, undefined, "score.png", 1, 0, --[[ tuple ]]{
                    14,
                    9
                  }, --[[ tuple ]]{
                    13,
                    18
                  });end end end 
     if ___conditional___ = 10--[[ Score8000 ]] then do
        return setup_sprite(undefined, undefined, undefined, "score.png", 1, 0, --[[ tuple ]]{
                    14,
                    9
                  }, --[[ tuple ]]{
                    13,
                    27
                  });end end end 
     do
    
  end
end end

function make_type(typ, dir) do
  local ___conditional___=(typ.tag | 0);
  do
     if ___conditional___ = 0--[[ SPlayer ]] then do
        pt = typ[0];
        spr_type = --[[ tuple ]]{
          typ[1],
          dir
        };
        if (pt) then do
          param = spr_type;
          typ$1 = param[0];
          if (param[1]) then do
            local ___conditional___=(typ$1);
            do
               if ___conditional___ = 0--[[ Standing ]] then do
                  return setup_sprite(undefined, --[[ tuple ]]{
                              1,
                              1
                            }, --[[ tuple ]]{
                              11,
                              15
                            }, "mario-small.png", 1, 0, --[[ tuple ]]{
                              16,
                              16
                            }, --[[ tuple ]]{
                              0,
                              32
                            });end end end 
               if ___conditional___ = 1--[[ Jumping ]] then do
                  return setup_sprite(undefined, --[[ tuple ]]{
                              2,
                              1
                            }, --[[ tuple ]]{
                              13,
                              15
                            }, "mario-small.png", 2, 10, --[[ tuple ]]{
                              16,
                              16
                            }, --[[ tuple ]]{
                              16,
                              48
                            });end end end 
               if ___conditional___ = 2--[[ Running ]] then do
                  return setup_sprite(undefined, --[[ tuple ]]{
                              2,
                              1
                            }, --[[ tuple ]]{
                              12,
                              15
                            }, "mario-small.png", 3, 5, --[[ tuple ]]{
                              16,
                              16
                            }, --[[ tuple ]]{
                              16,
                              32
                            });end end end 
               if ___conditional___ = 3--[[ Crouching ]] then do
                  return setup_sprite(undefined, --[[ tuple ]]{
                              1,
                              5
                            }, --[[ tuple ]]{
                              14,
                              10
                            }, "mario-small.png", 1, 0, --[[ tuple ]]{
                              16,
                              16
                            }, --[[ tuple ]]{
                              0,
                              64
                            });end end end 
               do
              
            end
          end else do
            local ___conditional___=(typ$1);
            do
               if ___conditional___ = 0--[[ Standing ]] then do
                  return setup_sprite(undefined, --[[ tuple ]]{
                              3,
                              1
                            }, --[[ tuple ]]{
                              11,
                              15
                            }, "mario-small.png", 1, 0, --[[ tuple ]]{
                              16,
                              16
                            }, --[[ tuple ]]{
                              0,
                              0
                            });end end end 
               if ___conditional___ = 1--[[ Jumping ]] then do
                  return setup_sprite(undefined, --[[ tuple ]]{
                              2,
                              1
                            }, --[[ tuple ]]{
                              13,
                              15
                            }, "mario-small.png", 2, 10, --[[ tuple ]]{
                              16,
                              16
                            }, --[[ tuple ]]{
                              16,
                              16
                            });end end end 
               if ___conditional___ = 2--[[ Running ]] then do
                  return setup_sprite(undefined, --[[ tuple ]]{
                              2,
                              1
                            }, --[[ tuple ]]{
                              12,
                              15
                            }, "mario-small.png", 3, 5, --[[ tuple ]]{
                              16,
                              16
                            }, --[[ tuple ]]{
                              16,
                              0
                            });end end end 
               if ___conditional___ = 3--[[ Crouching ]] then do
                  return setup_sprite(undefined, --[[ tuple ]]{
                              1,
                              5
                            }, --[[ tuple ]]{
                              14,
                              10
                            }, "mario-small.png", 1, 0, --[[ tuple ]]{
                              16,
                              16
                            }, --[[ tuple ]]{
                              0,
                              64
                            });end end end 
               do
              
            end
          end end 
        end else do
          param$1 = spr_type;
          typ$2 = param$1[0];
          if (param$1[1]) then do
            local ___conditional___=(typ$2);
            do
               if ___conditional___ = 0--[[ Standing ]] then do
                  return setup_sprite(undefined, --[[ tuple ]]{
                              1,
                              1
                            }, --[[ tuple ]]{
                              13,
                              25
                            }, "mario-big.png", 1, 0, --[[ tuple ]]{
                              16,
                              26
                            }, --[[ tuple ]]{
                              16,
                              69
                            });end end end 
               if ___conditional___ = 1--[[ Jumping ]] then do
                  return setup_sprite(undefined, --[[ tuple ]]{
                              2,
                              1
                            }, --[[ tuple ]]{
                              12,
                              25
                            }, "mario-big.png", 1, 0, --[[ tuple ]]{
                              16,
                              26
                            }, --[[ tuple ]]{
                              48,
                              70
                            });end end end 
               if ___conditional___ = 2--[[ Running ]] then do
                  return setup_sprite(undefined, --[[ tuple ]]{
                              2,
                              1
                            }, --[[ tuple ]]{
                              13,
                              25
                            }, "mario-big.png", 4, 10, --[[ tuple ]]{
                              16,
                              27
                            }, --[[ tuple ]]{
                              0,
                              101
                            });end end end 
               if ___conditional___ = 3--[[ Crouching ]] then do
                  return setup_sprite(undefined, --[[ tuple ]]{
                              2,
                              10
                            }, --[[ tuple ]]{
                              13,
                              17
                            }, "mario-big.png", 1, 0, --[[ tuple ]]{
                              16,
                              27
                            }, --[[ tuple ]]{
                              32,
                              69
                            });end end end 
               do
              
            end
          end else do
            local ___conditional___=(typ$2);
            do
               if ___conditional___ = 0--[[ Standing ]] then do
                  return setup_sprite(undefined, --[[ tuple ]]{
                              2,
                              1
                            }, --[[ tuple ]]{
                              13,
                              25
                            }, "mario-big.png", 1, 0, --[[ tuple ]]{
                              16,
                              27
                            }, --[[ tuple ]]{
                              16,
                              5
                            });end end end 
               if ___conditional___ = 1--[[ Jumping ]] then do
                  return setup_sprite(undefined, --[[ tuple ]]{
                              2,
                              1
                            }, --[[ tuple ]]{
                              12,
                              25
                            }, "mario-big.png", 1, 0, --[[ tuple ]]{
                              16,
                              26
                            }, --[[ tuple ]]{
                              48,
                              6
                            });end end end 
               if ___conditional___ = 2--[[ Running ]] then do
                  return setup_sprite(undefined, --[[ tuple ]]{
                              2,
                              1
                            }, --[[ tuple ]]{
                              13,
                              25
                            }, "mario-big.png", 4, 10, --[[ tuple ]]{
                              16,
                              27
                            }, --[[ tuple ]]{
                              0,
                              37
                            });end end end 
               if ___conditional___ = 3--[[ Crouching ]] then do
                  return setup_sprite(undefined, --[[ tuple ]]{
                              2,
                              10
                            }, --[[ tuple ]]{
                              13,
                              17
                            }, "mario-big.png", 1, 0, --[[ tuple ]]{
                              16,
                              27
                            }, --[[ tuple ]]{
                              32,
                              5
                            });end end end 
               do
              
            end
          end end 
        end end end end end 
     if ___conditional___ = 1--[[ SEnemy ]] then do
        return make_enemy(--[[ tuple ]]{
                    typ[0],
                    dir
                  });end end end 
     if ___conditional___ = 2--[[ SItem ]] then do
        param$2 = typ[0];
        local ___conditional___=(param$2);
        do
           if ___conditional___ = 0--[[ Mushroom ]] then do
              return setup_sprite(undefined, --[[ tuple ]]{
                          2,
                          0
                        }, --[[ tuple ]]{
                          12,
                          16
                        }, "items.png", 1, 0, --[[ tuple ]]{
                          16,
                          16
                        }, --[[ tuple ]]{
                          0,
                          0
                        });end end end 
           if ___conditional___ = 1--[[ FireFlower ]] then do
              return setup_sprite(undefined, undefined, undefined, "items.png", 1, 0, --[[ tuple ]]{
                          16,
                          16
                        }, --[[ tuple ]]{
                          0,
                          188
                        });end end end 
           if ___conditional___ = 2--[[ Star ]] then do
              return setup_sprite(undefined, undefined, undefined, "items.png", 1, 0, --[[ tuple ]]{
                          16,
                          16
                        }, --[[ tuple ]]{
                          16,
                          48
                        });end end end 
           if ___conditional___ = 3--[[ Coin ]] then do
              return setup_sprite(undefined, --[[ tuple ]]{
                          3,
                          0
                        }, --[[ tuple ]]{
                          12,
                          16
                        }, "items.png", 3, 15, --[[ tuple ]]{
                          16,
                          16
                        }, --[[ tuple ]]{
                          0,
                          80
                        });end end end 
           do
          
        endend end end 
     if ___conditional___ = 3--[[ SBlock ]] then do
        param$3 = typ[0];
        if (typeof param$3 == "number") then do
          local ___conditional___=(param$3);
          do
             if ___conditional___ = 0--[[ QBlockUsed ]] then do
                return setup_sprite(undefined, undefined, undefined, "blocks.png", 1, 0, --[[ tuple ]]{
                            16,
                            16
                          }, --[[ tuple ]]{
                            0,
                            32
                          });end end end 
             if ___conditional___ = 1--[[ Brick ]] then do
                return setup_sprite(undefined, undefined, undefined, "blocks.png", 5, 10, --[[ tuple ]]{
                            16,
                            16
                          }, --[[ tuple ]]{
                            0,
                            0
                          });end end end 
             if ___conditional___ = 2--[[ UnBBlock ]] then do
                return setup_sprite(undefined, undefined, undefined, "blocks.png", 1, 0, --[[ tuple ]]{
                            16,
                            16
                          }, --[[ tuple ]]{
                            0,
                            48
                          });end end end 
             if ___conditional___ = 3--[[ Cloud ]] then do
                return setup_sprite(undefined, undefined, undefined, "blocks.png", 1, 0, --[[ tuple ]]{
                            16,
                            16
                          }, --[[ tuple ]]{
                            0,
                            64
                          });end end end 
             if ___conditional___ = 4--[[ Panel ]] then do
                return setup_sprite(undefined, undefined, undefined, "panel.png", 3, 15, --[[ tuple ]]{
                            26,
                            26
                          }, --[[ tuple ]]{
                            0,
                            0
                          });end end end 
             if ___conditional___ = 5--[[ Ground ]] then do
                return setup_sprite(undefined, undefined, undefined, "ground.png", 1, 0, --[[ tuple ]]{
                            16,
                            16
                          }, --[[ tuple ]]{
                            0,
                            32
                          });end end end 
             do
            
          end
        end else do
          return setup_sprite(undefined, undefined, undefined, "blocks.png", 4, 15, --[[ tuple ]]{
                      16,
                      16
                    }, --[[ tuple ]]{
                      0,
                      16
                    });
        end end end end end 
     do
    
  end
end end

function make_from_params(params, context) do
  img = document.createElement("img");
  img.src = params.img_src;
  return do
          params: params,
          context: context,
          frame: do
            contents: 0
          end,
          ticks: do
            contents: 0
          end,
          img: img
        end;
end end

function make(spawn, dir, context) do
  params = make_type(spawn, dir);
  return make_from_params(params, context);
end end

function make_bgd(context) do
  params = setup_sprite(undefined, undefined, undefined, "bgd-1.png", 1, 0, --[[ tuple ]]{
        512,
        256
      }, --[[ tuple ]]{
        0,
        0
      });
  return make_from_params(params, context);
end end

function make_particle$1(ptyp, context) do
  params = make_particle(ptyp);
  return make_from_params(params, context);
end end

function transform_enemy(enemy_typ, spr, dir) do
  params = make_enemy(--[[ tuple ]]{
        enemy_typ,
        dir
      });
  img = document.createElement("img");
  img.src = params.img_src;
  spr.params = params;
  spr.img = img;
  return --[[ () ]]0;
end end

function update_animation(spr) do
  curr_ticks = spr.ticks.contents;
  if (curr_ticks >= spr.params.max_ticks) then do
    spr.ticks.contents = 0;
    if (spr.params.loop) then do
      spr.frame.contents = Caml_int32.mod_(spr.frame.contents + 1 | 0, spr.params.max_frames);
      return --[[ () ]]0;
    end else do
      return 0;
    end end 
  end else do
    spr.ticks.contents = curr_ticks + 1 | 0;
    return --[[ () ]]0;
  end end 
end end

Sprite = do
  setup_sprite: setup_sprite,
  make: make,
  make_bgd: make_bgd,
  make_particle: make_particle$1,
  transform_enemy: transform_enemy,
  update_animation: update_animation
end;

function pair_to_xy(pair) do
  return do
          x: pair[0],
          y: pair[1]
        end;
end end

function make_type$1(typ, ctx) do
  if (typ == 2 or typ == 1) then do
    return do
            sprite: make_particle$1(typ, ctx),
            rot: 0,
            lifetime: 300
          end;
  end else do
    return do
            sprite: make_particle$1(typ, ctx),
            rot: 0,
            lifetime: 30
          end;
  end end 
end end

function make$1(velOpt, accOpt, part_type, pos, ctx) do
  vel = velOpt ~= undefined and velOpt or --[[ tuple ]]{
      0,
      0
    };
  acc = accOpt ~= undefined and accOpt or --[[ tuple ]]{
      0,
      0
    };
  params = make_type$1(part_type, ctx);
  pos$1 = pair_to_xy(pos);
  vel$1 = pair_to_xy(vel);
  acc$1 = pair_to_xy(acc);
  return do
          params: params,
          part_type: part_type,
          pos: pos$1,
          vel: vel$1,
          acc: acc$1,
          kill: false,
          life: params.lifetime
        end;
end end

function make_score(score, pos, ctx) do
  t = score >= 801 and (
      score >= 2001 and (
          score ~= 4000 and (
              score ~= 8000 and --[[ Score100 ]]3 or --[[ Score8000 ]]10
            ) or --[[ Score4000 ]]9
        ) or (
          score ~= 1000 and (
              score >= 2000 and --[[ Score2000 ]]8 or --[[ Score100 ]]3
            ) or --[[ Score1000 ]]7
        )
    ) or (
      score >= 201 and (
          score ~= 400 and (
              score >= 800 and --[[ Score800 ]]6 or --[[ Score100 ]]3
            ) or --[[ Score400 ]]5
        ) or (
          score ~= 100 and score >= 200 and --[[ Score200 ]]4 or --[[ Score100 ]]3
        )
    );
  return make$1(--[[ tuple ]]{
              0.5,
              -0.7
            }, undefined, t, pos, ctx);
end end

function update_vel(part) do
  part.vel.x = part.vel.x + part.acc.x;
  part.vel.y = part.vel.y + part.acc.y;
  return --[[ () ]]0;
end end

function __process(part) do
  part.life = part.life - 1 | 0;
  if (part.life == 0) then do
    part.kill = true;
  end
   end 
  update_vel(part);
  part$1 = part;
  part$1.pos.x = part$1.vel.x + part$1.pos.x;
  part$1.pos.y = part$1.vel.y + part$1.pos.y;
  return --[[ () ]]0;
end end

Particle = do
  make: make$1,
  make_score: make_score,
  __process: __process
end;

id_counter = do
  contents: Pervasives.min_int
end;

function setup_obj(has_gravityOpt, speedOpt, param) do
  has_gravity = has_gravityOpt ~= undefined and has_gravityOpt or true;
  speed = speedOpt ~= undefined and speedOpt or 1;
  return do
          has_gravity: has_gravity,
          speed: speed
        end;
end end

function set_vel_to_speed(obj) do
  speed = obj.params.speed;
  match = obj.dir;
  if (match) then do
    obj.vel.x = speed;
    return --[[ () ]]0;
  end else do
    obj.vel.x = -speed;
    return --[[ () ]]0;
  end end 
end end

function make_type$2(param) do
  local ___conditional___=(param.tag | 0);
  do
     if ___conditional___ = 0--[[ SPlayer ]] then do
        return setup_obj(undefined, 2.8, --[[ () ]]0);end end end 
     if ___conditional___ = 1--[[ SEnemy ]] then do
        param$1 = param[0];
        if (param$1 >= 3) then do
          return setup_obj(undefined, 3, --[[ () ]]0);
        end else do
          return setup_obj(undefined, undefined, --[[ () ]]0);
        end end end end end 
     if ___conditional___ = 2--[[ SItem ]] then do
        param$2 = param[0];
        if (param$2 >= 3) then do
          return setup_obj(false, undefined, --[[ () ]]0);
        end else do
          return setup_obj(undefined, undefined, --[[ () ]]0);
        end end end end end 
     if ___conditional___ = 3--[[ SBlock ]] then do
        return setup_obj(false, undefined, --[[ () ]]0);end end end 
     do
    
  end
end end

function new_id(param) do
  id_counter.contents = id_counter.contents + 1 | 0;
  return id_counter.contents;
end end

function make$2($staropt$star, $staropt$star$1, spawnable, context, param) do
  id = $staropt$star ~= undefined and Caml_option.valFromOption($staropt$star) or undefined;
  dir = $staropt$star$1 ~= undefined and $staropt$star$1 or --[[ Left ]]0;
  spr = make(spawnable, dir, context);
  params = make_type$2(spawnable);
  id$1 = id ~= undefined and id or new_id(--[[ () ]]0);
  obj = do
    params: params,
    pos: do
      x: param[0],
      y: param[1]
    end,
    vel: do
      x: 0.0,
      y: 0.0
    end,
    id: id$1,
    jumping: false,
    grounded: false,
    dir: dir,
    invuln: 0,
    kill: false,
    health: 1,
    crouch: false,
    score: 0
  end;
  return --[[ tuple ]]{
          spr,
          obj
        };
end end

function spawn(spawnable, context, param) do
  match = make$2(undefined, undefined, spawnable, context, --[[ tuple ]]{
        param[0],
        param[1]
      });
  obj = match[1];
  spr = match[0];
  local ___conditional___=(spawnable.tag | 0);
  do
     if ___conditional___ = 0--[[ SPlayer ]] then do
        return --[[ Player ]]Block.__(0, {
                  spawnable[0],
                  spr,
                  obj
                });end end end 
     if ___conditional___ = 1--[[ SEnemy ]] then do
        set_vel_to_speed(obj);
        return --[[ Enemy ]]Block.__(1, {
                  spawnable[0],
                  spr,
                  obj
                });end end end 
     if ___conditional___ = 2--[[ SItem ]] then do
        return --[[ Item ]]Block.__(2, {
                  spawnable[0],
                  spr,
                  obj
                });end end end 
     if ___conditional___ = 3--[[ SBlock ]] then do
        return --[[ Block ]]Block.__(3, {
                  spawnable[0],
                  spr,
                  obj
                });end end end 
     do
    
  end
end end

function get_sprite(param) do
  return param[1];
end end

function get_obj(param) do
  return param[2];
end end

function is_player(param) do
  if (param.tag) then do
    return false;
  end else do
    return true;
  end end 
end end

function is_enemy(param) do
  if (param.tag == --[[ Enemy ]]1) then do
    return true;
  end else do
    return false;
  end end 
end end

function equals(col1, col2) do
  return col1[2].id == col2[2].id;
end end

function normalize_pos(pos, p1, p2) do
  match = p1.bbox_offset;
  match$1 = p2.bbox_offset;
  match$2 = p1.bbox_size;
  match$3 = p2.bbox_size;
  pos.x = pos.x - (match$3[0] + match$1[0]) + (match$2[0] + match[0]);
  pos.y = pos.y - (match$3[1] + match$1[1]) + (match$2[1] + match[1]);
  return --[[ () ]]0;
end end

function update_player(player, keys, context) do
  prev_jumping = player.jumping;
  prev_dir = player.dir;
  prev_vx = Math.abs(player.vel.x);
  List.iter((function (param) do
          player$1 = player;
          controls = param;
          lr_acc = player$1.vel.x * 0.2;
          local ___conditional___=(controls);
          do
             if ___conditional___ = 0--[[ CLeft ]] then do
                if (player$1.crouch) then do
                  return 0;
                end else do
                  if (player$1.vel.x > -player$1.params.speed) then do
                    player$1.vel.x = player$1.vel.x - (0.4 - lr_acc);
                  end
                   end 
                  player$1.dir = --[[ Left ]]0;
                  return --[[ () ]]0;
                end end end end end 
             if ___conditional___ = 1--[[ CRight ]] then do
                if (player$1.crouch) then do
                  return 0;
                end else do
                  if (player$1.vel.x < player$1.params.speed) then do
                    player$1.vel.x = player$1.vel.x + (0.4 + lr_acc);
                  end
                   end 
                  player$1.dir = --[[ Right ]]1;
                  return --[[ () ]]0;
                end end end end end 
             if ___conditional___ = 2--[[ CUp ]] then do
                if (not player$1.jumping and player$1.grounded) then do
                  player$1.jumping = true;
                  player$1.grounded = false;
                  player$1.vel.y = Caml_primitive.caml_float_max(player$1.vel.y - (5.7 + Math.abs(player$1.vel.x) * 0.25), -6);
                  return --[[ () ]]0;
                end else do
                  return 0;
                end end end end end 
             if ___conditional___ = 3--[[ CDown ]] then do
                if (not player$1.jumping and player$1.grounded) then do
                  player$1.crouch = true;
                  return --[[ () ]]0;
                end else do
                  return 0;
                end end end end end 
             do
            
          end
        end end), keys);
  v = player.vel.x * 0.9;
  vel_damped = Math.abs(v) < 0.1 and 0 or v;
  player.vel.x = vel_damped;
  pl_typ = player.health <= 1 and --[[ SmallM ]]1 or --[[ BigM ]]0;
  if (not prev_jumping and player.jumping) then do
    return --[[ tuple ]]{
            pl_typ,
            make(--[[ SPlayer ]]Block.__(0, {
                    pl_typ,
                    --[[ Jumping ]]1
                  }), player.dir, context)
          };
  end else if (prev_dir ~= player.dir or prev_vx == 0 and Math.abs(player.vel.x) > 0 and not player.jumping) then do
    return --[[ tuple ]]{
            pl_typ,
            make(--[[ SPlayer ]]Block.__(0, {
                    pl_typ,
                    --[[ Running ]]2
                  }), player.dir, context)
          };
  end else if (prev_dir ~= player.dir and player.jumping and prev_jumping) then do
    return --[[ tuple ]]{
            pl_typ,
            make(--[[ SPlayer ]]Block.__(0, {
                    pl_typ,
                    --[[ Jumping ]]1
                  }), player.dir, context)
          };
  end else if (player.vel.y == 0 and player.crouch) then do
    return --[[ tuple ]]{
            pl_typ,
            make(--[[ SPlayer ]]Block.__(0, {
                    pl_typ,
                    --[[ Crouching ]]3
                  }), player.dir, context)
          };
  end else if (player.vel.y == 0 and player.vel.x == 0) then do
    return --[[ tuple ]]{
            pl_typ,
            make(--[[ SPlayer ]]Block.__(0, {
                    pl_typ,
                    --[[ Standing ]]0
                  }), player.dir, context)
          };
  end else do
    return ;
  end end  end  end  end  end 
end end

function update_vel$1(obj) do
  if (obj.grounded) then do
    obj.vel.y = 0;
    return --[[ () ]]0;
  end else if (obj.params.has_gravity) then do
    obj.vel.y = Caml_primitive.caml_float_min(obj.vel.y + 0.2 + Math.abs(obj.vel.y) * 0.01, 4.5);
    return --[[ () ]]0;
  end else do
    return 0;
  end end  end 
end end

function update_pos(obj) do
  obj.pos.x = obj.vel.x + obj.pos.x;
  if (obj.params.has_gravity) then do
    obj.pos.y = obj.vel.y + obj.pos.y;
    return --[[ () ]]0;
  end else do
    return 0;
  end end 
end end

function process_obj(obj, mapy) do
  update_vel$1(obj);
  update_pos(obj);
  if (obj.pos.y > mapy) then do
    obj.kill = true;
    return --[[ () ]]0;
  end else do
    return 0;
  end end 
end end

function normalize_origin(pos, spr) do
  p = spr.params;
  match = p.bbox_offset;
  match$1 = p.bbox_size;
  pos.x = pos.x - match[0];
  pos.y = pos.y - (match[1] + match$1[1]);
  return --[[ () ]]0;
end end

function collide_block(check_xOpt, dir, obj) do
  check_x = check_xOpt ~= undefined and check_xOpt or true;
  if (dir ~= 1) then do
    if (dir ~= 0) then do
      if (check_x) then do
        obj.vel.x = 0;
        return --[[ () ]]0;
      end else do
        return 0;
      end end 
    end else do
      obj.vel.y = -0.001;
      return --[[ () ]]0;
    end end 
  end else do
    obj.vel.y = 0;
    obj.grounded = true;
    obj.jumping = false;
    return --[[ () ]]0;
  end end 
end end

function reverse_left_right(obj) do
  obj.vel.x = -obj.vel.x;
  obj.dir = obj.dir and --[[ Left ]]0 or --[[ Right ]]1;
  return --[[ () ]]0;
end end

function evolve_enemy(player_dir, typ, spr, obj, context) do
  local ___conditional___=(typ);
  do
     if ___conditional___ = 0--[[ Goomba ]] then do
        obj.kill = true;
        return ;end end end 
     if ___conditional___ = 1--[[ GKoopa ]] then do
        match = make$2(undefined, obj.dir, --[[ SEnemy ]]Block.__(1, {--[[ GKoopaShell ]]3}), context, --[[ tuple ]]{
              obj.pos.x,
              obj.pos.y
            });
        new_obj = match[1];
        new_spr = match[0];
        normalize_pos(new_obj.pos, spr.params, new_spr.params);
        return --[[ Enemy ]]Block.__(1, {
                  --[[ GKoopaShell ]]3,
                  new_spr,
                  new_obj
                });end end end 
     if ___conditional___ = 2--[[ RKoopa ]] then do
        match$1 = make$2(undefined, obj.dir, --[[ SEnemy ]]Block.__(1, {--[[ RKoopaShell ]]4}), context, --[[ tuple ]]{
              obj.pos.x,
              obj.pos.y
            });
        new_obj$1 = match$1[1];
        new_spr$1 = match$1[0];
        normalize_pos(new_obj$1.pos, spr.params, new_spr$1.params);
        return --[[ Enemy ]]Block.__(1, {
                  --[[ RKoopaShell ]]4,
                  new_spr$1,
                  new_obj$1
                });end end end 
     if ___conditional___ = 3--[[ GKoopaShell ]]
     or ___conditional___ = 4--[[ RKoopaShell ]]
     do
    
  end
  obj.dir = player_dir;
  if (obj.vel.x ~= 0) then do
    obj.vel.x = 0;
  end else do
    set_vel_to_speed(obj);
  end end 
  return ;
end end

function rev_dir(o, t, s) do
  reverse_left_right(o);
  old_params = s.params;
  transform_enemy(t, s, o.dir);
  return normalize_pos(o.pos, old_params, s.params);
end end

function dec_health(obj) do
  health = obj.health - 1 | 0;
  if (health == 0) then do
    obj.kill = true;
    return --[[ () ]]0;
  end else if (obj.invuln == 0) then do
    obj.health = health;
    return --[[ () ]]0;
  end else do
    return 0;
  end end  end 
end end

function evolve_block(obj, context) do
  dec_health(obj);
  match = make$2(undefined, undefined, --[[ SBlock ]]Block.__(3, {--[[ QBlockUsed ]]0}), context, --[[ tuple ]]{
        obj.pos.x,
        obj.pos.y
      });
  return --[[ Block ]]Block.__(3, {
            --[[ QBlockUsed ]]0,
            match[0],
            match[1]
          });
end end

function spawn_above(player_dir, obj, typ, context) do
  item = spawn(--[[ SItem ]]Block.__(2, {typ}), context, --[[ tuple ]]{
        obj.pos.x,
        obj.pos.y
      });
  item_obj = item[2];
  item_obj.pos.y = item_obj.pos.y - item[1].params.frame_size[1];
  item_obj.dir = player_dir and --[[ Left ]]0 or --[[ Right ]]1;
  set_vel_to_speed(item_obj);
  return item;
end end

function get_aabb(obj) do
  spr = obj[1].params;
  obj$1 = obj[2];
  match = spr.bbox_offset;
  box = obj$1.pos.x + match[0];
  boy = obj$1.pos.y + match[1];
  match$1 = spr.bbox_size;
  sy = match$1[1];
  sx = match$1[0];
  return do
          center: do
            x: box + sx / 2,
            y: boy + sy / 2
          end,
          half: do
            x: sx / 2,
            y: sy / 2
          end
        end;
end end

function col_bypass(c1, c2) do
  o1 = c1[2];
  o2 = c2[2];
  ctypes;
  local ___conditional___=(c1.tag | 0);
  do
     if ___conditional___ = 0--[[ Player ]] then do
        ctypes = c2.tag == --[[ Enemy ]]1 and c1[2].invuln > 0 or false;end else 
     if ___conditional___ = 1--[[ Enemy ]] then do
        ctypes = c2.tag == --[[ Item ]]2 and true or false;end else 
     if ___conditional___ = 2--[[ Item ]] then do
        local ___conditional___=(c2.tag | 0);
        do
           if ___conditional___ = 1--[[ Enemy ]]
           or ___conditional___ = 2--[[ Item ]] then do
              ctypes = true;end else 
           if ___conditional___ = 0--[[ Player ]]
           or ___conditional___ = 3--[[ Block ]] then do
              ctypes = false;end else 
           do end end end
          
        endend else 
     if ___conditional___ = 3--[[ Block ]] then do
        ctypes = false;end else 
     do end end end end end
    
  end
  if (o1.kill or o2.kill) then do
    return true;
  end else do
    return ctypes;
  end end 
end end

function check_collision(c1, c2) do
  b1 = get_aabb(c1);
  b2 = get_aabb(c2);
  o1 = c1[2];
  if (col_bypass(c1, c2)) then do
    return ;
  end else do
    vx = b1.center.x - b2.center.x;
    vy = b1.center.y - b2.center.y;
    hwidths = b1.half.x + b2.half.x;
    hheights = b1.half.y + b2.half.y;
    if (Math.abs(vx) < hwidths and Math.abs(vy) < hheights) then do
      ox = hwidths - Math.abs(vx);
      oy = hheights - Math.abs(vy);
      if (ox >= oy) then do
        if (vy > 0) then do
          o1.pos.y = o1.pos.y + oy;
          return --[[ North ]]0;
        end else do
          o1.pos.y = o1.pos.y - oy;
          return --[[ South ]]1;
        end end 
      end else if (vx > 0) then do
        o1.pos.x = o1.pos.x + ox;
        return --[[ West ]]3;
      end else do
        o1.pos.x = o1.pos.x - ox;
        return --[[ East ]]2;
      end end  end 
    end else do
      return ;
    end end 
  end end 
end end

function kill(collid, ctx) do
  local ___conditional___=(collid.tag | 0);
  do
     if ___conditional___ = 0--[[ Player ]] then do
        return --[[ [] ]]0;end end end 
     if ___conditional___ = 1--[[ Enemy ]] then do
        o = collid[2];
        pos_000 = o.pos.x;
        pos_001 = o.pos.y;
        pos = --[[ tuple ]]{
          pos_000,
          pos_001
        };
        score = o.score > 0 and --[[ :: ]]{
            make_score(o.score, pos, ctx),
            --[[ [] ]]0
          } or --[[ [] ]]0;
        remains = collid[0] ~= 0 and --[[ [] ]]0 or --[[ :: ]]{
            make$1(undefined, undefined, --[[ GoombaSquish ]]0, pos, ctx),
            --[[ [] ]]0
          };
        return Pervasives.$at(score, remains);end end end 
     if ___conditional___ = 2--[[ Item ]] then do
        o$1 = collid[2];
        if (collid[0] ~= 0) then do
          return --[[ [] ]]0;
        end else do
          return --[[ :: ]]{
                  make_score(o$1.score, --[[ tuple ]]{
                        o$1.pos.x,
                        o$1.pos.y
                      }, ctx),
                  --[[ [] ]]0
                };
        end end end end end 
     if ___conditional___ = 3--[[ Block ]] then do
        o$2 = collid[2];
        t = collid[0];
        if (typeof t == "number" and t == 1) then do
          pos_000$1 = o$2.pos.x;
          pos_001$1 = o$2.pos.y;
          pos$1 = --[[ tuple ]]{
            pos_000$1,
            pos_001$1
          };
          p1 = make$1(--[[ tuple ]]{
                -5,
                -5
              }, --[[ tuple ]]{
                0,
                0.2
              }, --[[ BrickChunkL ]]1, pos$1, ctx);
          p2 = make$1(--[[ tuple ]]{
                -3,
                -4
              }, --[[ tuple ]]{
                0,
                0.2
              }, --[[ BrickChunkL ]]1, pos$1, ctx);
          p3 = make$1(--[[ tuple ]]{
                3,
                -4
              }, --[[ tuple ]]{
                0,
                0.2
              }, --[[ BrickChunkR ]]2, pos$1, ctx);
          p4 = make$1(--[[ tuple ]]{
                5,
                -5
              }, --[[ tuple ]]{
                0,
                0.2
              }, --[[ BrickChunkR ]]2, pos$1, ctx);
          return --[[ :: ]]{
                  p1,
                  --[[ :: ]]{
                    p2,
                    --[[ :: ]]{
                      p3,
                      --[[ :: ]]{
                        p4,
                        --[[ [] ]]0
                      }
                    }
                  }
                };
        end else do
          return --[[ [] ]]0;
        end end end end end 
     do
    
  end
end end

__Object = do
  invuln: 60,
  dampen_jump: 4,
  get_sprite: get_sprite,
  get_obj: get_obj,
  spawn: spawn,
  equals: equals,
  is_player: is_player,
  is_enemy: is_enemy,
  normalize_origin: normalize_origin,
  normalize_pos: normalize_pos,
  kill: kill,
  process_obj: process_obj,
  update_player: update_player,
  check_collision: check_collision,
  evolve_enemy: evolve_enemy,
  evolve_block: evolve_block,
  dec_health: dec_health,
  rev_dir: rev_dir,
  reverse_left_right: reverse_left_right,
  collide_block: collide_block,
  spawn_above: spawn_above
end;

function render_bbox(sprite, param) do
  context = sprite.context;
  match = sprite.params.bbox_offset;
  match$1 = sprite.params.bbox_size;
  context.strokeStyle = "#FF0000";
  return context.strokeRect(param[0] + match[0], param[1] + match[1], match$1[0], match$1[1]);
end end

function render(sprite, param) do
  context = sprite.context;
  match = sprite.params.src_offset;
  match$1 = sprite.params.frame_size;
  sw = match$1[0];
  match$2 = sprite.params.frame_size;
  sx = match[0] + sprite.frame.contents * sw;
  return context.drawImage(sprite.img, sx, match[1], sw, match$1[1], param[0], param[1], match$2[0], match$2[1]);
end end

function draw_bgd(bgd, off_x) do
  render(bgd, --[[ tuple ]]{
        -off_x,
        0
      });
  return render(bgd, --[[ tuple ]]{
              bgd.params.frame_size[0] - off_x,
              0
            });
end end

function clear_canvas(canvas) do
  context = canvas.getContext("2d");
  cwidth = canvas.width;
  cheight = canvas.height;
  context.clearRect(0, 0, cwidth, cheight);
  return --[[ () ]]0;
end end

function hud(canvas, score, coins) do
  score_string = String(score);
  coin_string = String(coins);
  context = canvas.getContext("2d");
  context.font = "10px 'Press Start 2P'";
  context.fillText("Score: " .. score_string, canvas.width - 140, 18);
  context.fillText("Coins: " .. coin_string, 120, 18);
  return --[[ () ]]0;
end end

function fps(canvas, fps_val) do
  fps_str = String(fps_val | 0);
  context = canvas.getContext("2d");
  context.fillText(fps_str, 10, 18);
  return --[[ () ]]0;
end end

function game_win(ctx) do
  ctx.rect(0, 0, 512, 512);
  ctx.fillStyle = "black";
  ctx.fill();
  ctx.fillStyle = "white";
  ctx.font = "20px 'Press Start 2P'";
  ctx.fillText("You win!", 180, 128);
  error ({
    Caml_builtin_exceptions.failure,
    "Game over."
  })
end end

function game_loss(ctx) do
  ctx.rect(0, 0, 512, 512);
  ctx.fillStyle = "black";
  ctx.fill();
  ctx.fillStyle = "white";
  ctx.font = "20px 'Press Start 2P'";
  ctx.fillText("GAME OVER. You lose!", 60, 128);
  error ({
    Caml_builtin_exceptions.failure,
    "Game over."
  })
end end

Draw = do
  render: render,
  clear_canvas: clear_canvas,
  draw_bgd: draw_bgd,
  render_bbox: render_bbox,
  fps: fps,
  hud: hud,
  game_win: game_win,
  game_loss: game_loss
end;

function make$3(param, param$1) do
  return do
          pos: do
            x: 0,
            y: 0
          end,
          v_dim: do
            x: param[0],
            y: param[1]
          end,
          m_dim: do
            x: param$1[0],
            y: param$1[1]
          end
        end;
end end

function calc_viewport_point(cc, vc, mc) do
  vc_half = vc / 2;
  return Caml_primitive.caml_float_min(Caml_primitive.caml_float_max(cc - vc_half, 0), Caml_primitive.caml_float_min(mc - vc, Math.abs(cc - vc_half)));
end end

function in_viewport(v, pos) do
  v_min_x = v.pos.x - 32;
  v_max_x = v.pos.x + v.v_dim.x;
  v_min_y = v.pos.y - 32;
  v_max_y = v.pos.y + v.v_dim.y;
  x = pos.x;
  y = pos.y;
  if (x >= v_min_x and x <= v_max_x and y >= v_min_y) then do
    return y <= v_max_y;
  end else do
    return false;
  end end 
end end

function out_of_viewport_below(v, y) do
  v_max_y = v.pos.y + v.v_dim.y;
  return y >= v_max_y;
end end

function coord_to_viewport(viewport, coord) do
  return do
          x: coord.x - viewport.pos.x,
          y: coord.y - viewport.pos.y
        end;
end end

function update(vpt, ctr) do
  new_x = calc_viewport_point(ctr.x, vpt.v_dim.x, vpt.m_dim.x);
  new_y = calc_viewport_point(ctr.y, vpt.v_dim.y, vpt.m_dim.y);
  pos = do
    x: new_x,
    y: new_y
  end;
  return do
          pos: pos,
          v_dim: vpt.v_dim,
          m_dim: vpt.m_dim
        end;
end end

Viewport = do
  make: make$3,
  calc_viewport_point: calc_viewport_point,
  in_viewport: in_viewport,
  out_of_viewport_below: out_of_viewport_below,
  coord_to_viewport: coord_to_viewport,
  update: update
end;

pressed_keys = do
  left: false,
  right: false,
  up: false,
  down: false,
  bbox: 0
end;

collid_objs = do
  contents: --[[ [] ]]0
end;

particles = do
  contents: --[[ [] ]]0
end;

last_time = do
  contents: 0
end;

function calc_fps(t0, t1) do
  delta = (t1 - t0) / 1000;
  return 1 / delta;
end end

function update_score(state, i) do
  state.score = state.score + i | 0;
  return --[[ () ]]0;
end end

function process_collision(dir, c1, c2, state) do
  context = state.ctx;
  exit = 0;
  s1;
  o1;
  typ;
  s2;
  o2;
  s1$1;
  o1$1;
  t2;
  s2$1;
  o2$1;
  o1$2;
  t2$1;
  o2$2;
  local ___conditional___=(c1.tag | 0);
  do
     if ___conditional___ = 0--[[ Player ]] then do
        o1$3 = c1[2];
        s1$2 = c1[1];
        local ___conditional___=(c2.tag | 0);
        do
           if ___conditional___ = 0--[[ Player ]] then do
              return --[[ tuple ]]{
                      undefined,
                      undefined
                    };end end end 
           if ___conditional___ = 1--[[ Enemy ]] then do
              o2$3 = c2[2];
              s2$2 = c2[1];
              typ$1 = c2[0];
              if (dir ~= 1) then do
                s1$1 = s1$2;
                o1$1 = o1$3;
                t2 = typ$1;
                s2$1 = s2$2;
                o2$1 = o2$3;
                exit = 2;
              end else do
                s1 = s1$2;
                o1 = o1$3;
                typ = typ$1;
                s2 = s2$2;
                o2 = o2$3;
                exit = 1;
              end end end else 
           if ___conditional___ = 2--[[ Item ]] then do
              o1$2 = o1$3;
              t2$1 = c2[0];
              o2$2 = c2[2];
              exit = 3;end else 
           if ___conditional___ = 3--[[ Block ]] then do
              o2$4 = c2[2];
              t = c2[0];
              if (dir ~= 0) then do
                if (typeof t == "number" and t == 4) then do
                  game_win(state.ctx);
                  return --[[ tuple ]]{
                          undefined,
                          undefined
                        };
                end
                 end 
                if (dir ~= 1) then do
                  collide_block(undefined, dir, o1$3);
                  return --[[ tuple ]]{
                          undefined,
                          undefined
                        };
                end else do
                  state.multiplier = 1;
                  collide_block(undefined, dir, o1$3);
                  return --[[ tuple ]]{
                          undefined,
                          undefined
                        };
                end end 
              end else if (typeof t == "number") then do
                if (t ~= 1) then do
                  if (t ~= 4) then do
                    collide_block(undefined, dir, o1$3);
                    return --[[ tuple ]]{
                            undefined,
                            undefined
                          };
                  end else do
                    game_win(state.ctx);
                    return --[[ tuple ]]{
                            undefined,
                            undefined
                          };
                  end end 
                end else if (c1[0] == --[[ BigM ]]0) then do
                  collide_block(undefined, dir, o1$3);
                  dec_health(o2$4);
                  return --[[ tuple ]]{
                          undefined,
                          undefined
                        };
                end else do
                  collide_block(undefined, dir, o1$3);
                  return --[[ tuple ]]{
                          undefined,
                          undefined
                        };
                end end  end 
              end else do
                updated_block = evolve_block(o2$4, context);
                spawned_item = spawn_above(o1$3.dir, o2$4, t[0], context);
                collide_block(undefined, dir, o1$3);
                return --[[ tuple ]]{
                        spawned_item,
                        updated_block
                      };
              end end  end end else 
           do end end end
          
        endend else 
     if ___conditional___ = 1--[[ Enemy ]] then do
        o1$4 = c1[2];
        s1$3 = c1[1];
        t1 = c1[0];
        local ___conditional___=(c2.tag | 0);
        do
           if ___conditional___ = 0--[[ Player ]] then do
              o1$5 = c2[2];
              s1$4 = c2[1];
              if (dir ~= 0) then do
                s1$1 = s1$4;
                o1$1 = o1$5;
                t2 = t1;
                s2$1 = s1$3;
                o2$1 = o1$4;
                exit = 2;
              end else do
                s1 = s1$4;
                o1 = o1$5;
                typ = t1;
                s2 = s1$3;
                o2 = o1$4;
                exit = 1;
              end end end else 
           if ___conditional___ = 1--[[ Enemy ]] then do
              t1$1 = t1;
              s1$5 = s1$3;
              o1$6 = o1$4;
              t2$2 = c2[0];
              s2$3 = c2[1];
              o2$5 = c2[2];
              dir$1 = dir;
              if (t1$1 ~= 3) then do
                if (t1$1 >= 4) then do
                  if (t2$2 >= 3) then do
                    dec_health(o1$6);
                    dec_health(o2$5);
                    return --[[ tuple ]]{
                            undefined,
                            undefined
                          };
                  end
                   end 
                end else if (t2$2 >= 3) then do
                  if (o2$5.vel.x == 0) then do
                    rev_dir(o1$6, t1$1, s1$5);
                    return --[[ tuple ]]{
                            undefined,
                            undefined
                          };
                  end else do
                    dec_health(o1$6);
                    return --[[ tuple ]]{
                            undefined,
                            undefined
                          };
                  end end 
                end else if (dir$1 >= 2) then do
                  rev_dir(o1$6, t1$1, s1$5);
                  rev_dir(o2$5, t2$2, s2$3);
                  return --[[ tuple ]]{
                          undefined,
                          undefined
                        };
                end else do
                  return --[[ tuple ]]{
                          undefined,
                          undefined
                        };
                end end  end  end 
              end else if (t2$2 >= 3) then do
                dec_health(o1$6);
                dec_health(o2$5);
                return --[[ tuple ]]{
                        undefined,
                        undefined
                      };
              end
               end  end 
              if (o1$6.vel.x == 0) then do
                rev_dir(o2$5, t2$2, s2$3);
                return --[[ tuple ]]{
                        undefined,
                        undefined
                      };
              end else do
                dec_health(o2$5);
                return --[[ tuple ]]{
                        undefined,
                        undefined
                      };
              end end end end end 
           if ___conditional___ = 2--[[ Item ]] then do
              return --[[ tuple ]]{
                      undefined,
                      undefined
                    };end end end 
           if ___conditional___ = 3--[[ Block ]] then do
              o2$6 = c2[2];
              t2$3 = c2[0];
              if (dir >= 2) then do
                if (t1 >= 3) then do
                  if (typeof t2$3 == "number") then do
                    if (t2$3 ~= 1) then do
                      rev_dir(o1$4, t1, s1$3);
                      return --[[ tuple ]]{
                              undefined,
                              undefined
                            };
                    end else do
                      dec_health(o2$6);
                      reverse_left_right(o1$4);
                      return --[[ tuple ]]{
                              undefined,
                              undefined
                            };
                    end end 
                  end else do
                    updated_block$1 = evolve_block(o2$6, context);
                    spawned_item$1 = spawn_above(o1$4.dir, o2$6, t2$3[0], context);
                    rev_dir(o1$4, t1, s1$3);
                    return --[[ tuple ]]{
                            updated_block$1,
                            spawned_item$1
                          };
                  end end 
                end else do
                  rev_dir(o1$4, t1, s1$3);
                  return --[[ tuple ]]{
                          undefined,
                          undefined
                        };
                end end 
              end else do
                collide_block(undefined, dir, o1$4);
                return --[[ tuple ]]{
                        undefined,
                        undefined
                      };
              end end end end end 
           do
          
        endend else 
     if ___conditional___ = 2--[[ Item ]] then do
        o2$7 = c1[2];
        local ___conditional___=(c2.tag | 0);
        do
           if ___conditional___ = 0--[[ Player ]] then do
              o1$2 = c2[2];
              t2$1 = c1[0];
              o2$2 = o2$7;
              exit = 3;end else 
           if ___conditional___ = 1--[[ Enemy ]]
           or ___conditional___ = 2--[[ Item ]] then do
              return --[[ tuple ]]{
                      undefined,
                      undefined
                    };end end end 
           if ___conditional___ = 3--[[ Block ]] then do
              if (dir >= 2) then do
                reverse_left_right(o2$7);
                return --[[ tuple ]]{
                        undefined,
                        undefined
                      };
              end else do
                collide_block(undefined, dir, o2$7);
                return --[[ tuple ]]{
                        undefined,
                        undefined
                      };
              end end end end end 
           do
          
        endend else 
     if ___conditional___ = 3--[[ Block ]] then do
        return --[[ tuple ]]{
                undefined,
                undefined
              };end end end 
     do end end end
    
  end
  local ___conditional___=(exit);
  do
     if ___conditional___ = 1 then do
        o1$7 = o1;
        typ$2 = typ;
        s2$4 = s2;
        o2$8 = o2;
        state$1 = state;
        context$1 = context;
        o1$7.invuln = 10;
        o1$7.jumping = false;
        o1$7.grounded = true;
        if (typ$2 >= 3) then do
          r2 = evolve_enemy(o1$7.dir, typ$2, s2$4, o2$8, context$1);
          o1$7.vel.y = -4;
          o1$7.pos.y = o1$7.pos.y - 5;
          return --[[ tuple ]]{
                  undefined,
                  r2
                };
        end else do
          dec_health(o2$8);
          o1$7.vel.y = -4;
          if (state$1.multiplier == 8) then do
            update_score(state$1, 800);
            o2$8.score = 800;
            return --[[ tuple ]]{
                    undefined,
                    evolve_enemy(o1$7.dir, typ$2, s2$4, o2$8, context$1)
                  };
          end else do
            score = Caml_int32.imul(100, state$1.multiplier);
            update_score(state$1, score);
            o2$8.score = score;
            state$1.multiplier = (state$1.multiplier << 1);
            return --[[ tuple ]]{
                    undefined,
                    evolve_enemy(o1$7.dir, typ$2, s2$4, o2$8, context$1)
                  };
          end end 
        end end end end end 
     if ___conditional___ = 2 then do
        o1$8 = o1$1;
        t2$4 = t2;
        s2$5 = s2$1;
        o2$9 = o2$1;
        context$2 = context;
        if (t2$4 >= 3) then do
          r2$1 = o2$9.vel.x == 0 and evolve_enemy(o1$8.dir, t2$4, s2$5, o2$9, context$2) or (dec_health(o1$8), o1$8.invuln = 60, undefined);
          return --[[ tuple ]]{
                  undefined,
                  r2$1
                };
        end else do
          dec_health(o1$8);
          o1$8.invuln = 60;
          return --[[ tuple ]]{
                  undefined,
                  undefined
                };
        end end end end end 
     if ___conditional___ = 3 then do
        if (t2$1 ~= 0) then do
          if (t2$1 >= 3) then do
            state.coins = state.coins + 1 | 0;
            dec_health(o2$2);
            update_score(state, 100);
            return --[[ tuple ]]{
                    undefined,
                    undefined
                  };
          end else do
            dec_health(o2$2);
            update_score(state, 1000);
            return --[[ tuple ]]{
                    undefined,
                    undefined
                  };
          end end 
        end else do
          dec_health(o2$2);
          if (o1$2.health ~= 2) then do
            o1$2.health = o1$2.health + 1 | 0;
          end
           end 
          o1$2.vel.x = 0;
          o1$2.vel.y = 0;
          update_score(state, 1000);
          o2$2.score = 1000;
          return --[[ tuple ]]{
                  undefined,
                  undefined
                };
        end end end end end 
     do
    
  end
end end

function broad_phase(collid, all_collids, state) do
  obj = collid[2];
  return List.filter((function (c) do
                  if (in_viewport(state.vpt, obj.pos) or is_player(collid)) then do
                    return true;
                  end else do
                    return out_of_viewport_below(state.vpt, obj.pos.y);
                  end end 
                end end))(all_collids);
end end

function check_collisions(collid, all_collids, state) do
  if (collid.tag == --[[ Block ]]3) then do
    return --[[ [] ]]0;
  end else do
    broad = broad_phase(collid, all_collids, state);
    c = collid;
    cs = broad;
    state$1 = state;
    c$1 = c;
    _cs = cs;
    state$2 = state$1;
    _acc = --[[ [] ]]0;
    while(true) do
      acc = _acc;
      cs$1 = _cs;
      if (cs$1) then do
        h = cs$1[0];
        c_obj = c$1[2];
        new_objs;
        if (equals(c$1, h)) then do
          new_objs = --[[ tuple ]]{
            undefined,
            undefined
          };
        end else do
          match = check_collision(c$1, h);
          new_objs = match ~= undefined and h[2].id ~= c_obj.id and process_collision(match, c$1, h, state$2) or --[[ tuple ]]{
              undefined,
              undefined
            };
        end end 
        match$1 = new_objs[0];
        acc$1;
        if (match$1 ~= undefined) then do
          match$2 = new_objs[1];
          o = match$1;
          acc$1 = match$2 ~= undefined and --[[ :: ]]{
              o,
              --[[ :: ]]{
                match$2,
                acc
              }
            } or --[[ :: ]]{
              o,
              acc
            };
        end else do
          match$3 = new_objs[1];
          acc$1 = match$3 ~= undefined and --[[ :: ]]{
              match$3,
              acc
            } or acc;
        end end 
        _acc = acc$1;
        _cs = cs$1[1];
        ::continue:: ;
      end else do
        return acc;
      end end 
    end;
  end end 
end end

function update_collidable(state, collid, all_collids) do
  obj = collid[2];
  spr = collid[1];
  obj.invuln = obj.invuln > 0 and obj.invuln - 1 | 0 or 0;
  viewport_filter = in_viewport(state.vpt, obj.pos) or is_player(collid) or out_of_viewport_below(state.vpt, obj.pos.y);
  if (not obj.kill and viewport_filter) then do
    obj.grounded = false;
    process_obj(obj, state.map);
    evolved = check_collisions(collid, all_collids, state);
    vpt_adj_xy = coord_to_viewport(state.vpt, obj.pos);
    render(spr, --[[ tuple ]]{
          vpt_adj_xy.x,
          vpt_adj_xy.y
        });
    if (pressed_keys.bbox == 1) then do
      render_bbox(spr, --[[ tuple ]]{
            vpt_adj_xy.x,
            vpt_adj_xy.y
          });
    end
     end 
    if (obj.vel.x ~= 0 or not is_enemy(collid)) then do
      update_animation(spr);
    end
     end 
    return evolved;
  end else do
    return --[[ [] ]]0;
  end end 
end end

function translate_keys(param) do
  ctrls_000 = --[[ tuple ]]{
    pressed_keys.left,
    --[[ CLeft ]]0
  };
  ctrls_001 = --[[ :: ]]{
    --[[ tuple ]]{
      pressed_keys.right,
      --[[ CRight ]]1
    },
    --[[ :: ]]{
      --[[ tuple ]]{
        pressed_keys.up,
        --[[ CUp ]]2
      },
      --[[ :: ]]{
        --[[ tuple ]]{
          pressed_keys.down,
          --[[ CDown ]]3
        },
        --[[ [] ]]0
      }
    }
  };
  ctrls = --[[ :: ]]{
    ctrls_000,
    ctrls_001
  };
  return List.fold_left((function (a, x) do
                if (x[0]) then do
                  return --[[ :: ]]{
                          x[1],
                          a
                        };
                end else do
                  return a;
                end end 
              end end), --[[ [] ]]0, ctrls);
end end

function run_update_collid(state, collid, all_collids) do
  if (collid.tag) then do
    obj = collid[2];
    evolved = update_collidable(state, collid, all_collids);
    if (not obj.kill) then do
      collid_objs.contents = --[[ :: ]]{
        collid,
        Pervasives.$at(collid_objs.contents, evolved)
      };
    end
     end 
    new_parts = obj.kill and kill(collid, state.ctx) or --[[ [] ]]0;
    particles.contents = Pervasives.$at(particles.contents, new_parts);
    return collid;
  end else do
    o = collid[2];
    keys = translate_keys(--[[ () ]]0);
    o.crouch = false;
    match = update_player(o, keys, state.ctx);
    player;
    if (match ~= undefined) then do
      match$1 = match;
      new_spr = match$1[1];
      normalize_pos(o.pos, collid[1].params, new_spr.params);
      player = --[[ Player ]]Block.__(0, {
          match$1[0],
          new_spr,
          o
        });
    end else do
      player = collid;
    end end 
    evolved$1 = update_collidable(state, player, all_collids);
    collid_objs.contents = Pervasives.$at(collid_objs.contents, evolved$1);
    return player;
  end end 
end end

function update_loop(canvas, param, map_dim) do
  player = param[0];
  ctx = canvas.getContext("2d");
  cwidth = canvas.width / 1;
  cheight = canvas.height / 1;
  viewport = make$3(--[[ tuple ]]{
        cwidth,
        cheight
      }, map_dim);
  state = do
    bgd: make_bgd(ctx),
    ctx: ctx,
    vpt: update(viewport, player[2].pos),
    map: map_dim[1],
    score: 0,
    coins: 0,
    multiplier: 1,
    game_over: false
  end;
  state.ctx.scale(1, 1);
  update_helper = function (time, state, player, objs, parts) do
    if (state.game_over == true) then do
      return game_win(state.ctx);
    end else do
      collid_objs.contents = --[[ [] ]]0;
      particles.contents = --[[ [] ]]0;
      fps$1 = calc_fps(last_time.contents, time);
      last_time.contents = time;
      clear_canvas(canvas);
      vpos_x_int = state.vpt.pos.x / 5 | 0;
      bgd_width = state.bgd.params.frame_size[0] | 0;
      draw_bgd(state.bgd, Caml_int32.mod_(vpos_x_int, bgd_width));
      player$1 = run_update_collid(state, player, objs);
      if (player$1[2].kill == true) then do
        return game_loss(state.ctx);
      end else do
        state$1 = do
          bgd: state.bgd,
          ctx: state.ctx,
          vpt: update(state.vpt, player$1[2].pos),
          map: state.map,
          score: state.score,
          coins: state.coins,
          multiplier: state.multiplier,
          game_over: state.game_over
        end;
        List.iter((function (obj) do
                run_update_collid(state$1, obj, objs);
                return --[[ () ]]0;
              end end), objs);
        List.iter((function (part) do
                state$2 = state$1;
                part$1 = part;
                __process(part$1);
                x = part$1.pos.x - state$2.vpt.pos.x;
                y = part$1.pos.y - state$2.vpt.pos.y;
                render(part$1.params.sprite, --[[ tuple ]]{
                      x,
                      y
                    });
                if (part$1.kill) then do
                  return 0;
                end else do
                  particles.contents = --[[ :: ]]{
                    part$1,
                    particles.contents
                  };
                  return --[[ () ]]0;
                end end 
              end end), parts);
        fps(canvas, fps$1);
        hud(canvas, state$1.score, state$1.coins);
        requestAnimationFrame((function (t) do
                return update_helper(t, state$1, player$1, collid_objs.contents, particles.contents);
              end end));
        return --[[ () ]]0;
      end end 
    end end 
  end end;
  return update_helper(0, state, player, param[1], --[[ [] ]]0);
end end

function keydown(evt) do
  match = evt.keyCode;
  if (match >= 41) then do
    local ___conditional___=(match);
    do
       if ___conditional___ = 65 then do
          pressed_keys.left = true;end else 
       if ___conditional___ = 66 then do
          pressed_keys.bbox = (pressed_keys.bbox + 1 | 0) % 2;end else 
       if ___conditional___ = 68 then do
          pressed_keys.right = true;end else 
       if ___conditional___ = 83 then do
          pressed_keys.down = true;end else 
       if ___conditional___ = 67
       or ___conditional___ = 69
       or ___conditional___ = 70
       or ___conditional___ = 71
       or ___conditional___ = 72
       or ___conditional___ = 73
       or ___conditional___ = 74
       or ___conditional___ = 75
       or ___conditional___ = 76
       or ___conditional___ = 77
       or ___conditional___ = 78
       or ___conditional___ = 79
       or ___conditional___ = 80
       or ___conditional___ = 81
       or ___conditional___ = 82
       or ___conditional___ = 84
       or ___conditional___ = 85
       or ___conditional___ = 86
       or ___conditional___ = 87 then do
          pressed_keys.up = true;end else 
       do end end end end end end
      else do
        end end
        
    end
  end else if (match >= 32) then do
    local ___conditional___=(match - 32 | 0);
    do
       if ___conditional___ = 1
       or ___conditional___ = 2
       or ___conditional___ = 3
       or ___conditional___ = 4
       or ___conditional___ = 5 then do
          pressed_keys.left = true;end else 
       if ___conditional___ = 0
       or ___conditional___ = 6 then do
          pressed_keys.up = true;end else 
       if ___conditional___ = 7 then do
          pressed_keys.right = true;end else 
       if ___conditional___ = 8 then do
          pressed_keys.down = true;end else 
       do end end end end end
      
    end
  end
   end  end 
  return true;
end end

function keyup(evt) do
  match = evt.keyCode;
  if (match >= 68) then do
    if (match ~= 83) then do
      if (match ~= 87) then do
        if (match >= 69) then do
          
        end else do
          pressed_keys.right = false;
        end end 
      end else do
        pressed_keys.up = false;
      end end 
    end else do
      pressed_keys.down = false;
    end end 
  end else if (match >= 41) then do
    if (match == 65) then do
      pressed_keys.left = false;
    end
     end 
  end else if (match >= 32) then do
    local ___conditional___=(match - 32 | 0);
    do
       if ___conditional___ = 1
       or ___conditional___ = 2
       or ___conditional___ = 3
       or ___conditional___ = 4
       or ___conditional___ = 5 then do
          pressed_keys.left = false;end else 
       if ___conditional___ = 0
       or ___conditional___ = 6 then do
          pressed_keys.up = false;end else 
       if ___conditional___ = 7 then do
          pressed_keys.right = false;end else 
       if ___conditional___ = 8 then do
          pressed_keys.down = false;end else 
       do end end end end end
      
    end
  end
   end  end  end 
  return true;
end end

Director = do
  update_loop: update_loop,
  keydown: keydown,
  keyup: keyup
end;

function mem_loc(checkloc, _loclist) do
  while(true) do
    loclist = _loclist;
    if (loclist) then do
      if (Caml_obj.caml_equal(checkloc, loclist[0][1])) then do
        return true;
      end else do
        _loclist = loclist[1];
        ::continue:: ;
      end end 
    end else do
      return false;
    end end 
  end;
end end

function convert_list(lst) do
  if (lst) then do
    h = lst[0];
    return Pervasives.$at(--[[ :: ]]{
                --[[ tuple ]]{
                  h[0],
                  --[[ tuple ]]{
                    h[1][0] * 16,
                    h[1][1] * 16
                  }
                },
                --[[ [] ]]0
              }, convert_list(lst[1]));
  end else do
    return --[[ [] ]]0;
  end end 
end end

function choose_enemy_typ(typ) do
  local ___conditional___=(typ);
  do
     if ___conditional___ = 0 then do
        return --[[ RKoopa ]]2;end end end 
     if ___conditional___ = 1 then do
        return --[[ GKoopa ]]1;end end end 
     if ___conditional___ = 2 then do
        return --[[ Goomba ]]0;end end end 
     do
    else do
      error ({
        Caml_builtin_exceptions.failure,
        "Shouldn't reach here"
      })
      end end
      
  end
end end

function choose_sblock_typ(typ) do
  local ___conditional___=(typ);
  do
     if ___conditional___ = 0 then do
        return --[[ Brick ]]1;end end end 
     if ___conditional___ = 1 then do
        return --[[ UnBBlock ]]2;end end end 
     if ___conditional___ = 2 then do
        return --[[ Cloud ]]3;end end end 
     if ___conditional___ = 3 then do
        return --[[ QBlock ]]{--[[ Mushroom ]]0};end end end 
     if ___conditional___ = 4 then do
        return --[[ Ground ]]5;end end end 
     do
    else do
      error ({
        Caml_builtin_exceptions.failure,
        "Shouldn't reach here"
      })
      end end
      
  end
end end

function avoid_overlap(_lst, currentLst) do
  while(true) do
    lst = _lst;
    if (lst) then do
      t = lst[1];
      h = lst[0];
      if (mem_loc(h[1], currentLst)) then do
        _lst = t;
        ::continue:: ;
      end else do
        return Pervasives.$at(--[[ :: ]]{
                    h,
                    --[[ [] ]]0
                  }, avoid_overlap(t, currentLst));
      end end 
    end else do
      return --[[ [] ]]0;
    end end 
  end;
end end

function trim_edges(_lst, blockw, blockh) do
  while(true) do
    lst = _lst;
    if (lst) then do
      t = lst[1];
      h = lst[0];
      cx = h[1][0];
      cy = h[1][1];
      pixx = blockw * 16;
      pixy = blockh * 16;
      if (cx < 128 or pixx - cx < 528 or cy == 0 or pixy - cy < 48) then do
        _lst = t;
        ::continue:: ;
      end else do
        return Pervasives.$at(--[[ :: ]]{
                    h,
                    --[[ [] ]]0
                  }, trim_edges(t, blockw, blockh));
      end end 
    end else do
      return --[[ [] ]]0;
    end end 
  end;
end end

function generate_clouds(cbx, cby, typ, num) do
  if (num == 0) then do
    return --[[ [] ]]0;
  end else do
    return Pervasives.$at(--[[ :: ]]{
                --[[ tuple ]]{
                  typ,
                  --[[ tuple ]]{
                    cbx,
                    cby
                  }
                },
                --[[ [] ]]0
              }, generate_clouds(cbx + 1, cby, typ, num - 1 | 0));
  end end 
end end

function generate_coins(_block_coord) do
  while(true) do
    block_coord = _block_coord;
    place_coin = Random.__int(2);
    if (block_coord) then do
      t = block_coord[1];
      h = block_coord[0];
      if (place_coin == 0) then do
        xc = h[1][0];
        yc = h[1][1];
        return Pervasives.$at(--[[ :: ]]{
                    --[[ tuple ]]{
                      0,
                      --[[ tuple ]]{
                        xc,
                        yc - 16
                      }
                    },
                    --[[ [] ]]0
                  }, generate_coins(t));
      end else do
        _block_coord = t;
        ::continue:: ;
      end end 
    end else do
      return --[[ [] ]]0;
    end end 
  end;
end end

function choose_block_pattern(blockw, blockh, cbx, cby, prob) do
  if (cbx > blockw or cby > blockh) then do
    return --[[ [] ]]0;
  end else do
    block_typ = Random.__int(4);
    stair_typ = Random.__int(2);
    life_block_chance = Random.__int(5);
    middle_block = life_block_chance == 0 and 3 or stair_typ;
    local ___conditional___=(prob);
    do
       if ___conditional___ = 0 then do
          if (blockw - cbx > 2) then do
            return --[[ :: ]]{
                    --[[ tuple ]]{
                      stair_typ,
                      --[[ tuple ]]{
                        cbx,
                        cby
                      }
                    },
                    --[[ :: ]]{
                      --[[ tuple ]]{
                        middle_block,
                        --[[ tuple ]]{
                          cbx + 1,
                          cby
                        }
                      },
                      --[[ :: ]]{
                        --[[ tuple ]]{
                          stair_typ,
                          --[[ tuple ]]{
                            cbx + 2,
                            cby
                          }
                        },
                        --[[ [] ]]0
                      }
                    }
                  };
          end else if (blockw - cbx > 1) then do
            return --[[ :: ]]{
                    --[[ tuple ]]{
                      block_typ,
                      --[[ tuple ]]{
                        cbx,
                        cby
                      }
                    },
                    --[[ :: ]]{
                      --[[ tuple ]]{
                        block_typ,
                        --[[ tuple ]]{
                          cbx + 1,
                          cby
                        }
                      },
                      --[[ [] ]]0
                    }
                  };
          end else do
            return --[[ :: ]]{
                    --[[ tuple ]]{
                      block_typ,
                      --[[ tuple ]]{
                        cbx,
                        cby
                      }
                    },
                    --[[ [] ]]0
                  };
          end end  end end end end 
       if ___conditional___ = 1 then do
          num_clouds = Random.__int(5) + 5 | 0;
          if (cby < 5) then do
            return generate_clouds(cbx, cby, 2, num_clouds);
          end else do
            return --[[ [] ]]0;
          end end end end end 
       if ___conditional___ = 2 then do
          if (blockh - cby == 1) then do
            cbx$1 = cbx;
            cby$1 = cby;
            typ = stair_typ;
            four_000 = --[[ tuple ]]{
              typ,
              --[[ tuple ]]{
                cbx$1,
                cby$1
              }
            };
            four_001 = --[[ :: ]]{
              --[[ tuple ]]{
                typ,
                --[[ tuple ]]{
                  cbx$1 + 1,
                  cby$1
                }
              },
              --[[ :: ]]{
                --[[ tuple ]]{
                  typ,
                  --[[ tuple ]]{
                    cbx$1 + 2,
                    cby$1
                  }
                },
                --[[ :: ]]{
                  --[[ tuple ]]{
                    typ,
                    --[[ tuple ]]{
                      cbx$1 + 3,
                      cby$1
                    }
                  },
                  --[[ [] ]]0
                }
              }
            };
            four = --[[ :: ]]{
              four_000,
              four_001
            };
            three_000 = --[[ tuple ]]{
              typ,
              --[[ tuple ]]{
                cbx$1 + 1,
                cby$1 - 1
              }
            };
            three_001 = --[[ :: ]]{
              --[[ tuple ]]{
                typ,
                --[[ tuple ]]{
                  cbx$1 + 2,
                  cby$1 - 1
                }
              },
              --[[ :: ]]{
                --[[ tuple ]]{
                  typ,
                  --[[ tuple ]]{
                    cbx$1 + 3,
                    cby$1 - 1
                  }
                },
                --[[ [] ]]0
              }
            };
            three = --[[ :: ]]{
              three_000,
              three_001
            };
            two_000 = --[[ tuple ]]{
              typ,
              --[[ tuple ]]{
                cbx$1 + 2,
                cby$1 - 2
              }
            };
            two_001 = --[[ :: ]]{
              --[[ tuple ]]{
                typ,
                --[[ tuple ]]{
                  cbx$1 + 3,
                  cby$1 - 2
                }
              },
              --[[ [] ]]0
            };
            two = --[[ :: ]]{
              two_000,
              two_001
            };
            one_000 = --[[ tuple ]]{
              typ,
              --[[ tuple ]]{
                cbx$1 + 3,
                cby$1 - 3
              }
            };
            one = --[[ :: ]]{
              one_000,
              --[[ [] ]]0
            };
            return Pervasives.$at(four, Pervasives.$at(three, Pervasives.$at(two, one)));
          end else do
            return --[[ [] ]]0;
          end end end end end 
       if ___conditional___ = 3 then do
          if (stair_typ == 0 and blockh - cby > 3) then do
            cbx$2 = cbx;
            cby$2 = cby;
            typ$1 = stair_typ;
            three_000$1 = --[[ tuple ]]{
              typ$1,
              --[[ tuple ]]{
                cbx$2,
                cby$2
              }
            };
            three_001$1 = --[[ :: ]]{
              --[[ tuple ]]{
                typ$1,
                --[[ tuple ]]{
                  cbx$2 + 1,
                  cby$2
                }
              },
              --[[ :: ]]{
                --[[ tuple ]]{
                  typ$1,
                  --[[ tuple ]]{
                    cbx$2 + 2,
                    cby$2
                  }
                },
                --[[ [] ]]0
              }
            };
            three$1 = --[[ :: ]]{
              three_000$1,
              three_001$1
            };
            two_000$1 = --[[ tuple ]]{
              typ$1,
              --[[ tuple ]]{
                cbx$2 + 2,
                cby$2 + 1
              }
            };
            two_001$1 = --[[ :: ]]{
              --[[ tuple ]]{
                typ$1,
                --[[ tuple ]]{
                  cbx$2 + 3,
                  cby$2 + 1
                }
              },
              --[[ [] ]]0
            };
            two$1 = --[[ :: ]]{
              two_000$1,
              two_001$1
            };
            one_000$1 = --[[ tuple ]]{
              typ$1,
              --[[ tuple ]]{
                cbx$2 + 5,
                cby$2 + 2
              }
            };
            one_001 = --[[ :: ]]{
              --[[ tuple ]]{
                typ$1,
                --[[ tuple ]]{
                  cbx$2 + 6,
                  cby$2 + 2
                }
              },
              --[[ [] ]]0
            };
            one$1 = --[[ :: ]]{
              one_000$1,
              one_001
            };
            return Pervasives.$at(three$1, Pervasives.$at(two$1, one$1));
          end else if (blockh - cby > 2) then do
            cbx$3 = cbx;
            cby$3 = cby;
            typ$2 = stair_typ;
            one_000$2 = --[[ tuple ]]{
              typ$2,
              --[[ tuple ]]{
                cbx$3,
                cby$3
              }
            };
            one_001$1 = --[[ :: ]]{
              --[[ tuple ]]{
                typ$2,
                --[[ tuple ]]{
                  cbx$3 + 1,
                  cby$3
                }
              },
              --[[ [] ]]0
            };
            one$2 = --[[ :: ]]{
              one_000$2,
              one_001$1
            };
            two_000$2 = --[[ tuple ]]{
              typ$2,
              --[[ tuple ]]{
                cbx$3 + 3,
                cby$3 - 1
              }
            };
            two_001$2 = --[[ :: ]]{
              --[[ tuple ]]{
                typ$2,
                --[[ tuple ]]{
                  cbx$3 + 4,
                  cby$3 - 1
                }
              },
              --[[ [] ]]0
            };
            two$2 = --[[ :: ]]{
              two_000$2,
              two_001$2
            };
            three_000$2 = --[[ tuple ]]{
              typ$2,
              --[[ tuple ]]{
                cbx$3 + 4,
                cby$3 - 2
              }
            };
            three_001$2 = --[[ :: ]]{
              --[[ tuple ]]{
                typ$2,
                --[[ tuple ]]{
                  cbx$3 + 5,
                  cby$3 - 2
                }
              },
              --[[ :: ]]{
                --[[ tuple ]]{
                  typ$2,
                  --[[ tuple ]]{
                    cbx$3 + 6,
                    cby$3 - 2
                  }
                },
                --[[ [] ]]0
              }
            };
            three$2 = --[[ :: ]]{
              three_000$2,
              three_001$2
            };
            return Pervasives.$at(one$2, Pervasives.$at(two$2, three$2));
          end else do
            return --[[ :: ]]{
                    --[[ tuple ]]{
                      stair_typ,
                      --[[ tuple ]]{
                        cbx,
                        cby
                      }
                    },
                    --[[ [] ]]0
                  };
          end end  end end end end 
       if ___conditional___ = 4 then do
          if (cby + 3 - blockh == 2) then do
            return --[[ :: ]]{
                    --[[ tuple ]]{
                      stair_typ,
                      --[[ tuple ]]{
                        cbx,
                        cby
                      }
                    },
                    --[[ [] ]]0
                  };
          end else if (cby + 3 - blockh == 1) then do
            return --[[ :: ]]{
                    --[[ tuple ]]{
                      stair_typ,
                      --[[ tuple ]]{
                        cbx,
                        cby
                      }
                    },
                    --[[ :: ]]{
                      --[[ tuple ]]{
                        stair_typ,
                        --[[ tuple ]]{
                          cbx,
                          cby + 1
                        }
                      },
                      --[[ [] ]]0
                    }
                  };
          end else do
            return --[[ :: ]]{
                    --[[ tuple ]]{
                      stair_typ,
                      --[[ tuple ]]{
                        cbx,
                        cby
                      }
                    },
                    --[[ :: ]]{
                      --[[ tuple ]]{
                        stair_typ,
                        --[[ tuple ]]{
                          cbx,
                          cby + 1
                        }
                      },
                      --[[ :: ]]{
                        --[[ tuple ]]{
                          stair_typ,
                          --[[ tuple ]]{
                            cbx,
                            cby + 2
                          }
                        },
                        --[[ [] ]]0
                      }
                    }
                  };
          end end  end end end end 
       if ___conditional___ = 5 then do
          return --[[ :: ]]{
                  --[[ tuple ]]{
                    3,
                    --[[ tuple ]]{
                      cbx,
                      cby
                    }
                  },
                  --[[ [] ]]0
                };end end end 
       do
      else do
        error ({
          Caml_builtin_exceptions.failure,
          "Shouldn't reach here"
        })
        end end
        
    end
  end end 
end end

function generate_enemies(blockw, blockh, _cbx, _cby, acc) do
  while(true) do
    cby = _cby;
    cbx = _cbx;
    if (cbx > blockw - 32) then do
      return --[[ [] ]]0;
    end else if (cby > blockh - 1 or cbx < 15) then do
      _cby = 0;
      _cbx = cbx + 1;
      ::continue:: ;
    end else if (mem_loc(--[[ tuple ]]{
            cbx,
            cby
          }, acc) or cby == 0) then do
      _cby = cby + 1;
      ::continue:: ;
    end else do
      prob = Random.__int(30);
      if (prob < 3 and blockh - 1 == cby) then do
        enemy_000 = --[[ tuple ]]{
          prob,
          --[[ tuple ]]{
            cbx * 16,
            cby * 16
          }
        };
        enemy = --[[ :: ]]{
          enemy_000,
          --[[ [] ]]0
        };
        return Pervasives.$at(enemy, generate_enemies(blockw, blockh, cbx, cby + 1, acc));
      end else do
        _cby = cby + 1;
        ::continue:: ;
      end end 
    end end  end  end 
  end;
end end

function generate_block_enemies(_block_coord) do
  while(true) do
    block_coord = _block_coord;
    place_enemy = Random.__int(20);
    enemy_typ = Random.__int(3);
    if (block_coord) then do
      t = block_coord[1];
      h = block_coord[0];
      if (place_enemy == 0) then do
        xc = h[1][0];
        yc = h[1][1];
        return Pervasives.$at(--[[ :: ]]{
                    --[[ tuple ]]{
                      enemy_typ,
                      --[[ tuple ]]{
                        xc,
                        yc - 16
                      }
                    },
                    --[[ [] ]]0
                  }, generate_block_enemies(t));
      end else do
        _block_coord = t;
        ::continue:: ;
      end end 
    end else do
      return --[[ [] ]]0;
    end end 
  end;
end end

function generate_block_locs(blockw, blockh, _cbx, _cby, _acc) do
  while(true) do
    acc = _acc;
    cby = _cby;
    cbx = _cbx;
    if (blockw - cbx < 33) then do
      return acc;
    end else if (cby > blockh - 1) then do
      _cby = 0;
      _cbx = cbx + 1;
      ::continue:: ;
    end else if (mem_loc(--[[ tuple ]]{
            cbx,
            cby
          }, acc) or cby == 0) then do
      _cby = cby + 1;
      ::continue:: ;
    end else do
      prob = Random.__int(100);
      if (prob < 5) then do
        newacc = choose_block_pattern(blockw, blockh, cbx, cby, prob);
        undup_lst = avoid_overlap(newacc, acc);
        called_acc = Pervasives.$at(acc, undup_lst);
        _acc = called_acc;
        _cby = cby + 1;
        ::continue:: ;
      end else do
        _cby = cby + 1;
        ::continue:: ;
      end end 
    end end  end  end 
  end;
end end

function generate_panel(context, blockw, blockh) do
  return spawn(--[[ SBlock ]]Block.__(3, {--[[ Panel ]]4}), context, --[[ tuple ]]{
              blockw * 16 - 256,
              blockh * 16 * 2 / 3
            });
end end

function generate_ground(blockw, blockh, _inc, _acc) do
  while(true) do
    acc = _acc;
    inc = _inc;
    if (inc > blockw) then do
      return acc;
    end else if (inc > 10) then do
      skip = Random.__int(10);
      newacc = Pervasives.$at(acc, --[[ :: ]]{
            --[[ tuple ]]{
              4,
              --[[ tuple ]]{
                inc * 16,
                blockh * 16
              }
            },
            --[[ [] ]]0
          });
      if (skip == 7 and blockw - inc > 32) then do
        _inc = inc + 1;
        ::continue:: ;
      end else do
        _acc = newacc;
        _inc = inc + 1;
        ::continue:: ;
      end end 
    end else do
      newacc$1 = Pervasives.$at(acc, --[[ :: ]]{
            --[[ tuple ]]{
              4,
              --[[ tuple ]]{
                inc * 16,
                blockh * 16
              }
            },
            --[[ [] ]]0
          });
      _acc = newacc$1;
      _inc = inc + 1;
      ::continue:: ;
    end end  end 
  end;
end end

function convert_to_block_obj(lst, context) do
  if (lst) then do
    h = lst[0];
    sblock_typ = choose_sblock_typ(h[0]);
    ob = spawn(--[[ SBlock ]]Block.__(3, {sblock_typ}), context, h[1]);
    return Pervasives.$at(--[[ :: ]]{
                ob,
                --[[ [] ]]0
              }, convert_to_block_obj(lst[1], context));
  end else do
    return --[[ [] ]]0;
  end end 
end end

function convert_to_enemy_obj(lst, context) do
  if (lst) then do
    h = lst[0];
    senemy_typ = choose_enemy_typ(h[0]);
    ob = spawn(--[[ SEnemy ]]Block.__(1, {senemy_typ}), context, h[1]);
    return Pervasives.$at(--[[ :: ]]{
                ob,
                --[[ [] ]]0
              }, convert_to_enemy_obj(lst[1], context));
  end else do
    return --[[ [] ]]0;
  end end 
end end

function convert_to_coin_obj(lst, context) do
  if (lst) then do
    ob = spawn(--[[ SItem ]]Block.__(2, {--[[ Coin ]]3}), context, lst[0][1]);
    return Pervasives.$at(--[[ :: ]]{
                ob,
                --[[ [] ]]0
              }, convert_to_coin_obj(lst[1], context));
  end else do
    return --[[ [] ]]0;
  end end 
end end

function generate_helper(blockw, blockh, cx, cy, context) do
  block_locs = generate_block_locs(blockw, blockh, 0, 0, --[[ [] ]]0);
  converted_block_locs = trim_edges(convert_list(block_locs), blockw, blockh);
  obj_converted_block_locs = convert_to_block_obj(converted_block_locs, context);
  ground_blocks = generate_ground(blockw, blockh, 0, --[[ [] ]]0);
  obj_converted_ground_blocks = convert_to_block_obj(ground_blocks, context);
  block_locations = Pervasives.$at(block_locs, ground_blocks);
  all_blocks = Pervasives.$at(obj_converted_block_locs, obj_converted_ground_blocks);
  enemy_locs = generate_enemies(blockw, blockh, 0, 0, block_locations);
  obj_converted_enemies = convert_to_enemy_obj(enemy_locs, context);
  coin_locs = generate_coins(converted_block_locs);
  undup_coin_locs = trim_edges(avoid_overlap(coin_locs, converted_block_locs), blockw, blockh);
  converted_block_coin_locs = Pervasives.$at(converted_block_locs, coin_locs);
  enemy_block_locs = generate_block_enemies(converted_block_locs);
  undup_enemy_block_locs = avoid_overlap(enemy_block_locs, converted_block_coin_locs);
  obj_enemy_blocks = convert_to_enemy_obj(undup_enemy_block_locs, context);
  coin_objects = convert_to_coin_obj(undup_coin_locs, context);
  obj_panel = generate_panel(context, blockw, blockh);
  return Pervasives.$at(all_blocks, Pervasives.$at(obj_converted_enemies, Pervasives.$at(coin_objects, Pervasives.$at(obj_enemy_blocks, --[[ :: ]]{
                          obj_panel,
                          --[[ [] ]]0
                        }))));
end end

function generate(w, h, context) do
  blockw = w / 16;
  blockh = h / 16 - 1;
  collide_list = generate_helper(blockw, blockh, 0, 0, context);
  player = spawn(--[[ SPlayer ]]Block.__(0, {
          --[[ SmallM ]]1,
          --[[ Standing ]]0
        }), context, --[[ tuple ]]{
        100,
        224
      });
  return --[[ tuple ]]{
          player,
          collide_list
        };
end end

function init(param) do
  return Random.self_init(--[[ () ]]0);
end end

Procedural_generator = do
  init: init,
  generate: generate
end;

loadCount = do
  contents: 0
end;

function load(param) do
  Random.self_init(--[[ () ]]0);
  canvas_id = "canvas";
  match = document.getElementById(canvas_id);
  canvas;
  if (match ~= nil) then do
    canvas = match;
  end else do
    Curry._1(Printf.printf(--[[ Format ]]{
              --[[ String_literal ]]Block.__(11, {
                  "cant find canvas ",
                  --[[ String ]]Block.__(2, {
                      --[[ No_padding ]]0,
                      --[[ String_literal ]]Block.__(11, {
                          " \n",
                          --[[ End_of_format ]]0
                        })
                    })
                }),
              "cant find canvas %s \n"
            }), canvas_id);
    error ({
      Caml_builtin_exceptions.failure,
      "fail"
    })
  end end 
  context = canvas.getContext("2d");
  document.addEventListener("keydown", keydown, true);
  document.addEventListener("keyup", keyup, true);
  Random.self_init(--[[ () ]]0);
  update_loop(canvas, generate(2400, 256, context), --[[ tuple ]]{
        2400,
        256
      });
  console.log("asd");
  return --[[ () ]]0;
end end

function inc_counter(param) do
  loadCount.contents = loadCount.contents + 1 | 0;
  if (loadCount.contents == 4) then do
    return load(--[[ () ]]0);
  end else do
    return --[[ () ]]0;
  end end 
end end

function preload(param) do
  return List.map((function (img_src) do
                img_src$1 = "sprites/" .. img_src;
                img = document.createElement("img");
                img.src = img_src$1;
                img.addEventListener("load", (function (ev) do
                        inc_counter(--[[ () ]]0);
                        return true;
                      end end), true);
                return --[[ () ]]0;
              end end), --[[ :: ]]{
              "blocks.png",
              --[[ :: ]]{
                "items.png",
                --[[ :: ]]{
                  "enemies.png",
                  --[[ :: ]]{
                    "mario-small.png",
                    --[[ [] ]]0
                  }
                }
              }
            });
end end

window.onload = (function (param) do
    preload(--[[ () ]]0);
    return true;
  end end);

Main = do
  Html: --[[ alias ]]0,
  Pg: --[[ alias ]]0,
  loadCount: loadCount,
  imgsToLoad: 4,
  level_width: 2400,
  level_height: 256,
  load: load,
  inc_counter: inc_counter,
  preload: preload
end;

exports.Actors = Actors;
exports.Dom_html = Dom_html;
exports.Sprite = Sprite;
exports.Particle = Particle;
exports.__Object = __Object;
exports.Draw = Draw;
exports.Viewport = Viewport;
exports.Director = Director;
exports.Procedural_generator = Procedural_generator;
exports.Main = Main;
--[[  Not a pure module ]]
