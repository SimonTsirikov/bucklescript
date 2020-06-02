--[['use strict';]]

Mt = require "./mt";
Block = require "../../lib/js/block";
Caml_obj = require "../../lib/js/caml_obj";
Caml_js_exceptions = require "../../lib/js/caml_js_exceptions";
Caml_builtin_exceptions = require "../../lib/js/caml_builtin_exceptions";

function_equal_test;

xpcall(function() do
  function_equal_test = Caml_obj.caml_equal((function (x) do
          return x + 1 | 0;
        end end), (function (x) do
          return x + 2 | 0;
        end end));
end end,function(raw_exn) return do
  exn = Caml_js_exceptions.internalToOCamlException(raw_exn);
  function_equal_test = exn[0] == Caml_builtin_exceptions.invalid_argument and exn[1] == "equal: functional value" and true or false;
end end)

suites = do
  contents: --[[ :: ]]{
    --[[ tuple ]]{
      "File \"caml_compare_test.ml\", line 9, characters 4-11",
      (function (param) do
          return --[[ Eq ]]Block.__(0, {
                    true,
                    Caml_obj.caml_lessthan(undefined, 1)
                  });
        end end)
    },
    --[[ :: ]]{
      --[[ tuple ]]{
        "option2",
        (function (param) do
            return --[[ Eq ]]Block.__(0, {
                      true,
                      Caml_obj.caml_lessthan(1, 2)
                    });
          end end)
      },
      --[[ :: ]]{
        --[[ tuple ]]{
          "File \"caml_compare_test.ml\", line 11, characters 4-11",
          (function (param) do
              return --[[ Eq ]]Block.__(0, {
                        true,
                        Caml_obj.caml_greaterthan(--[[ :: ]]{
                              1,
                              --[[ [] ]]0
                            }, --[[ [] ]]0)
                      });
            end end)
        },
        --[[ :: ]]{
          --[[ tuple ]]{
            "listeq",
            (function (param) do
                return --[[ Eq ]]Block.__(0, {
                          true,
                          Caml_obj.caml_equal(--[[ :: ]]{
                                1,
                                --[[ :: ]]{
                                  2,
                                  --[[ :: ]]{
                                    3,
                                    --[[ [] ]]0
                                  }
                                }
                              }, --[[ :: ]]{
                                1,
                                --[[ :: ]]{
                                  2,
                                  --[[ :: ]]{
                                    3,
                                    --[[ [] ]]0
                                  }
                                }
                              })
                        });
              end end)
          },
          --[[ :: ]]{
            --[[ tuple ]]{
              "listneq",
              (function (param) do
                  return --[[ Eq ]]Block.__(0, {
                            true,
                            Caml_obj.caml_greaterthan(--[[ :: ]]{
                                  1,
                                  --[[ :: ]]{
                                    2,
                                    --[[ :: ]]{
                                      3,
                                      --[[ [] ]]0
                                    }
                                  }
                                }, --[[ :: ]]{
                                  1,
                                  --[[ :: ]]{
                                    2,
                                    --[[ :: ]]{
                                      2,
                                      --[[ [] ]]0
                                    }
                                  }
                                })
                          });
                end end)
            },
            --[[ :: ]]{
              --[[ tuple ]]{
                "custom_u",
                (function (param) do
                    return --[[ Eq ]]Block.__(0, {
                              true,
                              Caml_obj.caml_greaterthan(--[[ tuple ]]{
                                    --[[ A ]]Block.__(0, {3}),
                                    --[[ B ]]Block.__(1, {
                                        2,
                                        false
                                      }),
                                    --[[ C ]]Block.__(2, {1})
                                  }, --[[ tuple ]]{
                                    --[[ A ]]Block.__(0, {3}),
                                    --[[ B ]]Block.__(1, {
                                        2,
                                        false
                                      }),
                                    --[[ C ]]Block.__(2, {0})
                                  })
                            });
                  end end)
              },
              --[[ :: ]]{
                --[[ tuple ]]{
                  "custom_u2",
                  (function (param) do
                      return --[[ Eq ]]Block.__(0, {
                                true,
                                Caml_obj.caml_equal(--[[ tuple ]]{
                                      --[[ A ]]Block.__(0, {3}),
                                      --[[ B ]]Block.__(1, {
                                          2,
                                          false
                                        }),
                                      --[[ C ]]Block.__(2, {1})
                                    }, --[[ tuple ]]{
                                      --[[ A ]]Block.__(0, {3}),
                                      --[[ B ]]Block.__(1, {
                                          2,
                                          false
                                        }),
                                      --[[ C ]]Block.__(2, {1})
                                    })
                              });
                    end end)
                },
                --[[ :: ]]{
                  --[[ tuple ]]{
                    "function",
                    (function (param) do
                        return --[[ Eq ]]Block.__(0, {
                                  true,
                                  function_equal_test
                                });
                      end end)
                  },
                  --[[ :: ]]{
                    --[[ tuple ]]{
                      "File \"caml_compare_test.ml\", line 17, characters 4-11",
                      (function (param) do
                          return --[[ Eq ]]Block.__(0, {
                                    true,
                                    Caml_obj.caml_lessthan(undefined, 1)
                                  });
                        end end)
                    },
                    --[[ :: ]]{
                      --[[ tuple ]]{
                        "File \"caml_compare_test.ml\", line 28, characters 4-11",
                        (function (param) do
                            return --[[ Eq ]]Block.__(0, {
                                      true,
                                      Caml_obj.caml_lessthan(undefined, {
                                            1,
                                            30
                                          })
                                    });
                          end end)
                      },
                      --[[ :: ]]{
                        --[[ tuple ]]{
                          "File \"caml_compare_test.ml\", line 31, characters 4-11",
                          (function (param) do
                              return --[[ Eq ]]Block.__(0, {
                                        true,
                                        Caml_obj.caml_greaterthan({
                                              1,
                                              30
                                            }, undefined)
                                      });
                            end end)
                        },
                        --[[ :: ]]{
                          --[[ tuple ]]{
                            "File \"caml_compare_test.ml\", line 34, characters 4-11",
                            (function (param) do
                                return --[[ Eq ]]Block.__(0, {
                                          true,
                                          Caml_obj.caml_lessthan(--[[ :: ]]{
                                                2,
                                                --[[ :: ]]{
                                                  6,
                                                  --[[ :: ]]{
                                                    1,
                                                    --[[ :: ]]{
                                                      1,
                                                      --[[ :: ]]{
                                                        2,
                                                        --[[ :: ]]{
                                                          1,
                                                          --[[ :: ]]{
                                                            4,
                                                            --[[ :: ]]{
                                                              2,
                                                              --[[ :: ]]{
                                                                1,
                                                                --[[ [] ]]0
                                                              }
                                                            }
                                                          }
                                                        }
                                                      }
                                                    }
                                                  }
                                                }
                                              }, --[[ :: ]]{
                                                2,
                                                --[[ :: ]]{
                                                  6,
                                                  --[[ :: ]]{
                                                    1,
                                                    --[[ :: ]]{
                                                      1,
                                                      --[[ :: ]]{
                                                        2,
                                                        --[[ :: ]]{
                                                          1,
                                                          --[[ :: ]]{
                                                            4,
                                                            --[[ :: ]]{
                                                              2,
                                                              --[[ :: ]]{
                                                                1,
                                                                --[[ :: ]]{
                                                                  409,
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
                                              })
                                        });
                              end end)
                          },
                          --[[ :: ]]{
                            --[[ tuple ]]{
                              "File \"caml_compare_test.ml\", line 37, characters 4-11",
                              (function (param) do
                                  return --[[ Eq ]]Block.__(0, {
                                            true,
                                            Caml_obj.caml_lessthan(--[[ :: ]]{
                                                  1,
                                                  --[[ [] ]]0
                                                }, --[[ :: ]]{
                                                  1,
                                                  --[[ :: ]]{
                                                    409,
                                                    --[[ [] ]]0
                                                  }
                                                })
                                          });
                                end end)
                            },
                            --[[ :: ]]{
                              --[[ tuple ]]{
                                "File \"caml_compare_test.ml\", line 40, characters 4-11",
                                (function (param) do
                                    return --[[ Eq ]]Block.__(0, {
                                              true,
                                              Caml_obj.caml_lessthan(--[[ [] ]]0, --[[ :: ]]{
                                                    409,
                                                    --[[ [] ]]0
                                                  })
                                            });
                                  end end)
                              },
                              --[[ :: ]]{
                                --[[ tuple ]]{
                                  "File \"caml_compare_test.ml\", line 43, characters 4-11",
                                  (function (param) do
                                      return --[[ Eq ]]Block.__(0, {
                                                true,
                                                Caml_obj.caml_greaterthan(--[[ :: ]]{
                                                      2,
                                                      --[[ :: ]]{
                                                        6,
                                                        --[[ :: ]]{
                                                          1,
                                                          --[[ :: ]]{
                                                            1,
                                                            --[[ :: ]]{
                                                              2,
                                                              --[[ :: ]]{
                                                                1,
                                                                --[[ :: ]]{
                                                                  4,
                                                                  --[[ :: ]]{
                                                                    2,
                                                                    --[[ :: ]]{
                                                                      1,
                                                                      --[[ :: ]]{
                                                                        409,
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
                                                    }, --[[ :: ]]{
                                                      2,
                                                      --[[ :: ]]{
                                                        6,
                                                        --[[ :: ]]{
                                                          1,
                                                          --[[ :: ]]{
                                                            1,
                                                            --[[ :: ]]{
                                                              2,
                                                              --[[ :: ]]{
                                                                1,
                                                                --[[ :: ]]{
                                                                  4,
                                                                  --[[ :: ]]{
                                                                    2,
                                                                    --[[ :: ]]{
                                                                      1,
                                                                      --[[ [] ]]0
                                                                    }
                                                                  }
                                                                }
                                                              }
                                                            }
                                                          }
                                                        }
                                                      }
                                                    })
                                              });
                                    end end)
                                },
                                --[[ :: ]]{
                                  --[[ tuple ]]{
                                    "File \"caml_compare_test.ml\", line 47, characters 4-11",
                                    (function (param) do
                                        return --[[ Eq ]]Block.__(0, {
                                                  false,
                                                  false
                                                });
                                      end end)
                                  },
                                  --[[ :: ]]{
                                    --[[ tuple ]]{
                                      "File \"caml_compare_test.ml\", line 50, characters 4-11",
                                      (function (param) do
                                          return --[[ Eq ]]Block.__(0, {
                                                    false,
                                                    false
                                                  });
                                        end end)
                                    },
                                    --[[ :: ]]{
                                      --[[ tuple ]]{
                                        "File \"caml_compare_test.ml\", line 53, characters 4-11",
                                        (function (param) do
                                            return --[[ Eq ]]Block.__(0, {
                                                      false,
                                                      Caml_obj.caml_equal(--[[ :: ]]{
                                                            2,
                                                            --[[ :: ]]{
                                                              6,
                                                              --[[ :: ]]{
                                                                1,
                                                                --[[ :: ]]{
                                                                  1,
                                                                  --[[ :: ]]{
                                                                    2,
                                                                    --[[ :: ]]{
                                                                      1,
                                                                      --[[ :: ]]{
                                                                        4,
                                                                        --[[ :: ]]{
                                                                          2,
                                                                          --[[ :: ]]{
                                                                            1,
                                                                            --[[ [] ]]0
                                                                          }
                                                                        }
                                                                      }
                                                                    }
                                                                  }
                                                                }
                                                              }
                                                            }
                                                          }, --[[ :: ]]{
                                                            2,
                                                            --[[ :: ]]{
                                                              6,
                                                              --[[ :: ]]{
                                                                1,
                                                                --[[ :: ]]{
                                                                  1,
                                                                  --[[ :: ]]{
                                                                    2,
                                                                    --[[ :: ]]{
                                                                      1,
                                                                      --[[ :: ]]{
                                                                        4,
                                                                        --[[ :: ]]{
                                                                          2,
                                                                          --[[ :: ]]{
                                                                            1,
                                                                            --[[ :: ]]{
                                                                              409,
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
                                                          })
                                                    });
                                          end end)
                                      },
                                      --[[ :: ]]{
                                        --[[ tuple ]]{
                                          "File \"caml_compare_test.ml\", line 56, characters 4-11",
                                          (function (param) do
                                              return --[[ Eq ]]Block.__(0, {
                                                        false,
                                                        Caml_obj.caml_equal(--[[ :: ]]{
                                                              2,
                                                              --[[ :: ]]{
                                                                6,
                                                                --[[ :: ]]{
                                                                  1,
                                                                  --[[ :: ]]{
                                                                    1,
                                                                    --[[ :: ]]{
                                                                      2,
                                                                      --[[ :: ]]{
                                                                        1,
                                                                        --[[ :: ]]{
                                                                          4,
                                                                          --[[ :: ]]{
                                                                            2,
                                                                            --[[ :: ]]{
                                                                              1,
                                                                              --[[ :: ]]{
                                                                                409,
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
                                                            }, --[[ :: ]]{
                                                              2,
                                                              --[[ :: ]]{
                                                                6,
                                                                --[[ :: ]]{
                                                                  1,
                                                                  --[[ :: ]]{
                                                                    1,
                                                                    --[[ :: ]]{
                                                                      2,
                                                                      --[[ :: ]]{
                                                                        1,
                                                                        --[[ :: ]]{
                                                                          4,
                                                                          --[[ :: ]]{
                                                                            2,
                                                                            --[[ :: ]]{
                                                                              1,
                                                                              --[[ [] ]]0
                                                                            }
                                                                          }
                                                                        }
                                                                      }
                                                                    }
                                                                  }
                                                                }
                                                              }
                                                            })
                                                      });
                                            end end)
                                        },
                                        --[[ :: ]]{
                                          --[[ tuple ]]{
                                            "cmp_id",
                                            (function (param) do
                                                return --[[ Eq ]]Block.__(0, {
                                                          Caml_obj.caml_compare(do
                                                                x: 1,
                                                                y: 2
                                                              end, do
                                                                x: 1,
                                                                y: 2
                                                              end),
                                                          0
                                                        });
                                              end end)
                                          },
                                          --[[ :: ]]{
                                            --[[ tuple ]]{
                                              "cmp_val",
                                              (function (param) do
                                                  return --[[ Eq ]]Block.__(0, {
                                                            Caml_obj.caml_compare(do
                                                                  x: 1
                                                                end, do
                                                                  x: 2
                                                                end),
                                                            -1
                                                          });
                                                end end)
                                            },
                                            --[[ :: ]]{
                                              --[[ tuple ]]{
                                                "cmp_val2",
                                                (function (param) do
                                                    return --[[ Eq ]]Block.__(0, {
                                                              Caml_obj.caml_compare(do
                                                                    x: 2
                                                                  end, do
                                                                    x: 1
                                                                  end),
                                                              1
                                                            });
                                                  end end)
                                              },
                                              --[[ :: ]]{
                                                --[[ tuple ]]{
                                                  "cmp_empty",
                                                  (function (param) do
                                                      return --[[ Eq ]]Block.__(0, {
                                                                Caml_obj.caml_compare(({}), ({})),
                                                                0
                                                              });
                                                    end end)
                                                },
                                                --[[ :: ]]{
                                                  --[[ tuple ]]{
                                                    "cmp_empty2",
                                                    (function (param) do
                                                        return --[[ Eq ]]Block.__(0, {
                                                                  Caml_obj.caml_compare(({}), ({x:1})),
                                                                  -1
                                                                });
                                                      end end)
                                                  },
                                                  --[[ :: ]]{
                                                    --[[ tuple ]]{
                                                      "cmp_swap",
                                                      (function (param) do
                                                          return --[[ Eq ]]Block.__(0, {
                                                                    Caml_obj.caml_compare(do
                                                                          x: 1,
                                                                          y: 2
                                                                        end, do
                                                                          y: 2,
                                                                          x: 1
                                                                        end),
                                                                    0
                                                                  });
                                                        end end)
                                                    },
                                                    --[[ :: ]]{
                                                      --[[ tuple ]]{
                                                        "cmp_size",
                                                        (function (param) do
                                                            return --[[ Eq ]]Block.__(0, {
                                                                      Caml_obj.caml_compare(({x:1}), ({x:1, y:2})),
                                                                      -1
                                                                    });
                                                          end end)
                                                      },
                                                      --[[ :: ]]{
                                                        --[[ tuple ]]{
                                                          "cmp_size2",
                                                          (function (param) do
                                                              return --[[ Eq ]]Block.__(0, {
                                                                        Caml_obj.caml_compare(({x:1, y:2}), ({x:1})),
                                                                        1
                                                                      });
                                                            end end)
                                                        },
                                                        --[[ :: ]]{
                                                          --[[ tuple ]]{
                                                            "cmp_order",
                                                            (function (param) do
                                                                return --[[ Eq ]]Block.__(0, {
                                                                          Caml_obj.caml_compare(do
                                                                                x: 0,
                                                                                y: 1
                                                                              end, do
                                                                                x: 1,
                                                                                y: 0
                                                                              end),
                                                                          -1
                                                                        });
                                                              end end)
                                                          },
                                                          --[[ :: ]]{
                                                            --[[ tuple ]]{
                                                              "cmp_order2",
                                                              (function (param) do
                                                                  return --[[ Eq ]]Block.__(0, {
                                                                            Caml_obj.caml_compare(do
                                                                                  x: 1,
                                                                                  y: 0
                                                                                end, do
                                                                                  x: 0,
                                                                                  y: 1
                                                                                end),
                                                                            1
                                                                          });
                                                                end end)
                                                            },
                                                            --[[ :: ]]{
                                                              --[[ tuple ]]{
                                                                "cmp_in_list",
                                                                (function (param) do
                                                                    return --[[ Eq ]]Block.__(0, {
                                                                              Caml_obj.caml_compare(--[[ :: ]]{
                                                                                    do
                                                                                      x: 1
                                                                                    end,
                                                                                    --[[ [] ]]0
                                                                                  }, --[[ :: ]]{
                                                                                    do
                                                                                      x: 2
                                                                                    end,
                                                                                    --[[ [] ]]0
                                                                                  }),
                                                                              -1
                                                                            });
                                                                  end end)
                                                              },
                                                              --[[ :: ]]{
                                                                --[[ tuple ]]{
                                                                  "cmp_in_list2",
                                                                  (function (param) do
                                                                      return --[[ Eq ]]Block.__(0, {
                                                                                Caml_obj.caml_compare(--[[ :: ]]{
                                                                                      do
                                                                                        x: 2
                                                                                      end,
                                                                                      --[[ [] ]]0
                                                                                    }, --[[ :: ]]{
                                                                                      do
                                                                                        x: 1
                                                                                      end,
                                                                                      --[[ [] ]]0
                                                                                    }),
                                                                                1
                                                                              });
                                                                    end end)
                                                                },
                                                                --[[ :: ]]{
                                                                  --[[ tuple ]]{
                                                                    "cmp_with_list",
                                                                    (function (param) do
                                                                        return --[[ Eq ]]Block.__(0, {
                                                                                  Caml_obj.caml_compare(do
                                                                                        x: --[[ :: ]]{
                                                                                          0,
                                                                                          --[[ [] ]]0
                                                                                        }
                                                                                      end, do
                                                                                        x: --[[ :: ]]{
                                                                                          1,
                                                                                          --[[ [] ]]0
                                                                                        }
                                                                                      end),
                                                                                  -1
                                                                                });
                                                                      end end)
                                                                  },
                                                                  --[[ :: ]]{
                                                                    --[[ tuple ]]{
                                                                      "cmp_with_list2",
                                                                      (function (param) do
                                                                          return --[[ Eq ]]Block.__(0, {
                                                                                    Caml_obj.caml_compare(do
                                                                                          x: --[[ :: ]]{
                                                                                            1,
                                                                                            --[[ [] ]]0
                                                                                          }
                                                                                        end, do
                                                                                          x: --[[ :: ]]{
                                                                                            0,
                                                                                            --[[ [] ]]0
                                                                                          }
                                                                                        end),
                                                                                    1
                                                                                  });
                                                                        end end)
                                                                    },
                                                                    --[[ :: ]]{
                                                                      --[[ tuple ]]{
                                                                        "eq_id",
                                                                        (function (param) do
                                                                            return --[[ Ok ]]Block.__(4, {Caml_obj.caml_equal(do
                                                                                            x: 1,
                                                                                            y: 2
                                                                                          end, do
                                                                                            x: 1,
                                                                                            y: 2
                                                                                          end)});
                                                                          end end)
                                                                      },
                                                                      --[[ :: ]]{
                                                                        --[[ tuple ]]{
                                                                          "eq_val",
                                                                          (function (param) do
                                                                              return --[[ Eq ]]Block.__(0, {
                                                                                        Caml_obj.caml_equal(do
                                                                                              x: 1
                                                                                            end, do
                                                                                              x: 2
                                                                                            end),
                                                                                        false
                                                                                      });
                                                                            end end)
                                                                        },
                                                                        --[[ :: ]]{
                                                                          --[[ tuple ]]{
                                                                            "eq_val2",
                                                                            (function (param) do
                                                                                return --[[ Eq ]]Block.__(0, {
                                                                                          Caml_obj.caml_equal(do
                                                                                                x: 2
                                                                                              end, do
                                                                                                x: 1
                                                                                              end),
                                                                                          false
                                                                                        });
                                                                              end end)
                                                                          },
                                                                          --[[ :: ]]{
                                                                            --[[ tuple ]]{
                                                                              "eq_empty",
                                                                              (function (param) do
                                                                                  return --[[ Eq ]]Block.__(0, {
                                                                                            Caml_obj.caml_equal(({}), ({})),
                                                                                            true
                                                                                          });
                                                                                end end)
                                                                            },
                                                                            --[[ :: ]]{
                                                                              --[[ tuple ]]{
                                                                                "eq_empty2",
                                                                                (function (param) do
                                                                                    return --[[ Eq ]]Block.__(0, {
                                                                                              Caml_obj.caml_equal(({}), ({x:1})),
                                                                                              false
                                                                                            });
                                                                                  end end)
                                                                              },
                                                                              --[[ :: ]]{
                                                                                --[[ tuple ]]{
                                                                                  "eq_swap",
                                                                                  (function (param) do
                                                                                      return --[[ Ok ]]Block.__(4, {Caml_obj.caml_equal(do
                                                                                                      x: 1,
                                                                                                      y: 2
                                                                                                    end, do
                                                                                                      y: 2,
                                                                                                      x: 1
                                                                                                    end)});
                                                                                    end end)
                                                                                },
                                                                                --[[ :: ]]{
                                                                                  --[[ tuple ]]{
                                                                                    "eq_size",
                                                                                    (function (param) do
                                                                                        return --[[ Eq ]]Block.__(0, {
                                                                                                  Caml_obj.caml_equal(({x:1}), ({x:1, y:2})),
                                                                                                  false
                                                                                                });
                                                                                      end end)
                                                                                  },
                                                                                  --[[ :: ]]{
                                                                                    --[[ tuple ]]{
                                                                                      "eq_size2",
                                                                                      (function (param) do
                                                                                          return --[[ Eq ]]Block.__(0, {
                                                                                                    Caml_obj.caml_equal(({x:1, y:2}), ({x:1})),
                                                                                                    false
                                                                                                  });
                                                                                        end end)
                                                                                    },
                                                                                    --[[ :: ]]{
                                                                                      --[[ tuple ]]{
                                                                                        "eq_in_list",
                                                                                        (function (param) do
                                                                                            return --[[ Eq ]]Block.__(0, {
                                                                                                      Caml_obj.caml_equal(--[[ :: ]]{
                                                                                                            do
                                                                                                              x: 1
                                                                                                            end,
                                                                                                            --[[ [] ]]0
                                                                                                          }, --[[ :: ]]{
                                                                                                            do
                                                                                                              x: 2
                                                                                                            end,
                                                                                                            --[[ [] ]]0
                                                                                                          }),
                                                                                                      false
                                                                                                    });
                                                                                          end end)
                                                                                      },
                                                                                      --[[ :: ]]{
                                                                                        --[[ tuple ]]{
                                                                                          "eq_in_list2",
                                                                                          (function (param) do
                                                                                              return --[[ Eq ]]Block.__(0, {
                                                                                                        Caml_obj.caml_equal(--[[ :: ]]{
                                                                                                              do
                                                                                                                x: 2
                                                                                                              end,
                                                                                                              --[[ [] ]]0
                                                                                                            }, --[[ :: ]]{
                                                                                                              do
                                                                                                                x: 2
                                                                                                              end,
                                                                                                              --[[ [] ]]0
                                                                                                            }),
                                                                                                        true
                                                                                                      });
                                                                                            end end)
                                                                                        },
                                                                                        --[[ :: ]]{
                                                                                          --[[ tuple ]]{
                                                                                            "eq_with_list",
                                                                                            (function (param) do
                                                                                                return --[[ Eq ]]Block.__(0, {
                                                                                                          Caml_obj.caml_equal(do
                                                                                                                x: --[[ :: ]]{
                                                                                                                  0,
                                                                                                                  --[[ [] ]]0
                                                                                                                }
                                                                                                              end, do
                                                                                                                x: --[[ :: ]]{
                                                                                                                  0,
                                                                                                                  --[[ [] ]]0
                                                                                                                }
                                                                                                              end),
                                                                                                          true
                                                                                                        });
                                                                                              end end)
                                                                                          },
                                                                                          --[[ :: ]]{
                                                                                            --[[ tuple ]]{
                                                                                              "eq_with_list2",
                                                                                              (function (param) do
                                                                                                  return --[[ Eq ]]Block.__(0, {
                                                                                                            Caml_obj.caml_equal(do
                                                                                                                  x: --[[ :: ]]{
                                                                                                                    0,
                                                                                                                    --[[ [] ]]0
                                                                                                                  }
                                                                                                                end, do
                                                                                                                  x: --[[ :: ]]{
                                                                                                                    1,
                                                                                                                    --[[ [] ]]0
                                                                                                                  }
                                                                                                                end),
                                                                                                            false
                                                                                                          });
                                                                                                end end)
                                                                                            },
                                                                                            --[[ :: ]]{
                                                                                              --[[ tuple ]]{
                                                                                                "File \"caml_compare_test.ml\", line 87, characters 4-11",
                                                                                                (function (param) do
                                                                                                    return --[[ Eq ]]Block.__(0, {
                                                                                                              Caml_obj.caml_compare(nil, --[[ :: ]]{
                                                                                                                    3,
                                                                                                                    --[[ [] ]]0
                                                                                                                  }),
                                                                                                              -1
                                                                                                            });
                                                                                                  end end)
                                                                                              },
                                                                                              --[[ :: ]]{
                                                                                                --[[ tuple ]]{
                                                                                                  "File \"caml_compare_test.ml\", line 90, characters 4-11",
                                                                                                  (function (param) do
                                                                                                      return --[[ Eq ]]Block.__(0, {
                                                                                                                Caml_obj.caml_compare(--[[ :: ]]{
                                                                                                                      3,
                                                                                                                      --[[ [] ]]0
                                                                                                                    }, nil),
                                                                                                                1
                                                                                                              });
                                                                                                    end end)
                                                                                                },
                                                                                                --[[ :: ]]{
                                                                                                  --[[ tuple ]]{
                                                                                                    "File \"caml_compare_test.ml\", line 93, characters 4-11",
                                                                                                    (function (param) do
                                                                                                        return --[[ Eq ]]Block.__(0, {
                                                                                                                  Caml_obj.caml_compare(nil, 0),
                                                                                                                  -1
                                                                                                                });
                                                                                                      end end)
                                                                                                  },
                                                                                                  --[[ :: ]]{
                                                                                                    --[[ tuple ]]{
                                                                                                      "File \"caml_compare_test.ml\", line 96, characters 4-11",
                                                                                                      (function (param) do
                                                                                                          return --[[ Eq ]]Block.__(0, {
                                                                                                                    Caml_obj.caml_compare(0, nil),
                                                                                                                    1
                                                                                                                  });
                                                                                                        end end)
                                                                                                    },
                                                                                                    --[[ :: ]]{
                                                                                                      --[[ tuple ]]{
                                                                                                        "File \"caml_compare_test.ml\", line 99, characters 4-11",
                                                                                                        (function (param) do
                                                                                                            return --[[ Eq ]]Block.__(0, {
                                                                                                                      Caml_obj.caml_compare(undefined, 0),
                                                                                                                      -1
                                                                                                                    });
                                                                                                          end end)
                                                                                                      },
                                                                                                      --[[ :: ]]{
                                                                                                        --[[ tuple ]]{
                                                                                                          "File \"caml_compare_test.ml\", line 102, characters 4-11",
                                                                                                          (function (param) do
                                                                                                              return --[[ Eq ]]Block.__(0, {
                                                                                                                        Caml_obj.caml_compare(0, undefined),
                                                                                                                        1
                                                                                                                      });
                                                                                                            end end)
                                                                                                        },
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
                                                                                    }
                                                                                  }
                                                                                }
                                                                              }
                                                                            }
                                                                          }
                                                                        }
                                                                      }
                                                                    }
                                                                  }
                                                                }
                                                              }
                                                            }
                                                          }
                                                        }
                                                      }
                                                    }
                                                  }
                                                }
                                              }
                                            }
                                          }
                                        }
                                      }
                                    }
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
end;

test_id = do
  contents: 0
end;

function eq(loc, x, y) do
  return Mt.eq_suites(test_id, suites, loc, x, y);
end end

eq("File \"caml_compare_test.ml\", line 112, characters 6-13", true, Caml_obj.caml_greaterthan(1, undefined));

eq("File \"caml_compare_test.ml\", line 113, characters 6-13", true, Caml_obj.caml_lessthan(--[[ [] ]]0, --[[ :: ]]{
          1,
          --[[ [] ]]0
        }));

eq("File \"caml_compare_test.ml\", line 114, characters 6-13", false, Caml_obj.caml_greaterthan(undefined, 1));

eq("File \"caml_compare_test.ml\", line 115, characters 6-13", false, Caml_obj.caml_greaterthan(undefined, {
          1,
          30
        }));

eq("File \"caml_compare_test.ml\", line 116, characters 6-13", false, Caml_obj.caml_lessthan({
          1,
          30
        }, undefined));

Mt.from_pair_suites("Caml_compare_test", suites.contents);

exports.function_equal_test = function_equal_test;
exports.suites = suites;
exports.test_id = test_id;
exports.eq = eq;
--[[ function_equal_test Not a pure module ]]
