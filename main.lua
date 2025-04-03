if not next(SMODS.find_mod("ChDp")) then
    assert(false, "This mod requires Challenger Deep to run!")
end

---Levels up hand (with proper animation) [from JoyousSpring]
---@param card Card|table
---@param hand_key string
---@param instant boolean?
---@param amount integer?
function rae_level_up_hand(card, hand_key, instant, amount)
    if not instant then
        update_hand_text({
            sound = "button",
            volume = 0.7,
            pitch = 0.8,
            delay = 0.3
        }, {
            handname = localize(hand_key, "poker_hands"),
            chips = G.GAME.hands[hand_key].chips,
            mult = G.GAME.hands[hand_key].mult,
            level = G.GAME.hands[hand_key].level
        })
    end
    level_up_hand(card, hand_key, instant, amount)
    if not instant then
        update_hand_text({
            sound = "button",
            volume = 0.7,
            pitch = 1.1,
            delay = 0
        }, {mult = 0, chips = 0, handname = "", level = ""})
    end
end

function mod_mult(_mult)
    if G.GAME.modifiers.mult_dollar_cap then
        return math.min(_mult, math.max(G.GAME.dollars, 0))
    elseif G.GAME.modifiers.no_mult then
        return math.min(_mult, G.GAME.modifiers.no_mult)
    elseif G.GAME.modifiers.mult_chip_cap then
        return math.min(_mult, hand_chips)
    end
    return _mult
end

SMODS.Challenge({ -- Splash I
    key = "splash_i",
    jokers = {{id = "j_splash", edition = "negative", eternal = true}},
    rules = {
        custom = {
            {id = "hand_level", value = {hand = "High Card", level = 6}},
            {id = 'whitelist_hand', value = "High Card", hand = "High Card"},
            {id = 'whitelist_info'}

        }
    },
    restrictions = {
        banned_other = {
            {id = "bl_eye", type = "blind"}, {id = "bl_ox", type = "blind"}
        }
    },
    unlocked = function(self) return true end
})

SMODS.Challenge({ -- Mono Mult
    key = "monopoly_mult",
    vouchers = {{id = "v_directors_cut"}},
    rules = {
        custom = {{id = "mult_dollar_cap"}},
        modifiers = {{id = "dollars", value = 30}}
    },
    restrictions = {banned_other = {{id = "bl_ox", type = "blind"}}}
})

SMODS.Challenge({ -- Spaceman
    key = "spaced_out",
    jokers = {{id = "j_space", eternal = true}, {id = "j_oops"}},
    rules = {custom = {{id = "no_shop_jokers"}}},
    restrictions = {
        banned_cards = {
            {id = "c_mercury"}, {id = "c_venus"}, {id = "c_earth"},
            {id = "c_mars"}, {id = "c_jupiter"}, {id = "c_saturn"},
            {id = "c_uranus"}, {id = "c_neptune"}, {id = "c_eris"},
            {id = "c_ceres"}, {id = "c_planet_x"}, {
                id = "p_celestial_normal_1",
                ids = {
                    "p_celestial_normal_2", "p_celestial_normal_3",
                    "p_celestial_normal_4", "p_celestial_jumbo_1",
                    "p_celestial_jumbo_2", "p_celestial_mega_1",
                    "p_celestial_mega_2"
                }
            }, {id = "c_high_priestess"}, {id = "j_burnt"}
        },
        banned_tags = {{id = "tag_meteor"}},
        banned_other = {{id = "bl_ox", type = "blind"}}
    }
})

SMODS.Challenge({ -- Chips
    key = "chip_in",
    jokers = {{id = "j_blue_joker", edition = "foil"}},
    rules = {custom = {{id = "no_mult", value = 5}}},
    restrictions = {banned_other = {{id = "bl_ox", type = "blind"}, {id="bl_flint", type="blind"}}},
    deck = {type = "Challenge Deck", enhancement = "m_bonus"}
})

SMODS.Challenge({ -- Truthers
    key = "truthers",
    jokers = {
        {id = "j_tribe", edition = "negative", eternal = true},
        {id = "j_devious"}
    },
    rules = {
        custom = {
            {id = "faceless"},
            {
                id = 'whitelist_hand',
                value = "Straight Flush",
                hand = "Straight Flush"
            }, {id = 'whitelist_info'}

        },
        modifiers = {{id = "hand_size", value = 10}}
    },
    restrictions = {
        banned_other = {
            {id = "bl_eye", type = "blind"}, {id = "bl_ox", type = "blind"}
        }
    },
    deck = {type = "Challenge Deck", no_ranks = {K = true, Q = true, J = true}}
})

SMODS.Challenge({ -- Mult Mogul
    key = "mult_mogul",
    vouchers = {{id = "v_directors_cut"}},
    rules = {custom = {{id = "mult_chip_cap"}}},
    restrictions = {
        banned_other = {
            {id = "bl_ox", type = "blind"}, {id = "bl_flint", type = "blind"}
        }
    }
})

SMODS.Challenge({ -- P2W
    key = "pair_to_win",
    rules = {
        custom = {
            {id = "hand_level", value = {hand = "Pair", level = 6}},
            {id = "pair_tax"},
            {id = 'whitelist_hand', value = "Pair", hand = "Pair"},
            {id = 'whitelist_info'}
        },
        modifiers = {{id = "dollars", value = 22}}
    },
    restrictions = {
        banned_other = {
            {id = "bl_ox", type = "blind"}, {id = "bl_club", type = "blind"},
            {id = "bl_window", type = "blind"}, {id = "bl_eye", type = "blind"}
        }
    },
    deck = {
        type = "Challenge Deck",
        cards = { -- Pairs of Diamonds and Clubs
            {s = "D", r = "2"}, {s = "D", r = "3"}, {s = "D", r = "4"},
            {s = "D", r = "5"}, {s = "D", r = "6"}, {s = "D", r = "7"},
            {s = "D", r = "8"}, {s = "D", r = "9"}, {s = "D", r = "T"},
            {s = "D", r = "J"}, {s = "D", r = "Q"}, {s = "D", r = "K"},
            {s = "D", r = "A"}, {s = "C", r = "2"}, {s = "C", r = "3"},
            {s = "C", r = "4"}, {s = "C", r = "5"}, {s = "C", r = "6"},
            {s = "C", r = "7"}, {s = "C", r = "8"}, {s = "C", r = "9"},
            {s = "C", r = "T"}, {s = "C", r = "J"}, {s = "C", r = "Q"},
            {s = "C", r = "K"}, {s = "C", r = "A"}, {s = "D", r = "2"},
            {s = "D", r = "3"}, {s = "D", r = "4"}, {s = "D", r = "5"},
            {s = "D", r = "6"}, {s = "D", r = "7"}, {s = "D", r = "8"},
            {s = "D", r = "9"}, {s = "D", r = "T"}, {s = "D", r = "J"},
            {s = "D", r = "Q"}, {s = "D", r = "K"}, {s = "D", r = "A"},
            {s = "C", r = "2"}, {s = "C", r = "3"}, {s = "C", r = "4"},
            {s = "C", r = "5"}, {s = "C", r = "6"}, {s = "C", r = "7"},
            {s = "C", r = "8"}, {s = "C", r = "9"}, {s = "C", r = "T"},
            {s = "C", r = "J"}, {s = "C", r = "Q"}, {s = "C", r = "K"},
            {s = "C", r = "A"}
        }
    }
})

SMODS.Challenge({ -- Economist
    key = "economist",
    vouchers = {{id = "v_seed_money"}, {id = "v_money_tree"}},
    rules = {
        custom = {{id = "all_rental_jokers"}},
        modifiers = {{id = "dollars", value = 25}}
    }
})

SMODS.Challenge({ -- Sorry, Doc
    key = "sorry_doc",
    vouchers = {{id = "v_seed_money"}, {id = "v_money_tree"}},
    jokers = {{id = "j_mail", edition = "polychrome"}},
    rules = {
        custom = {{id = "all_rental_jokers"}, {id = "all_eternal"}},
        modifiers = {{id = "dollars", value = 25}}
    }
})

SMODS.Challenge({ -- Splash II
    key = "splash_light",
    jokers = {{id = "j_splash", edition = "negative", eternal = true}},
    rules = {
        custom = {
            {id = "hand_level", value = {hand = "High Card", level = 5}},
            {id = 'whitelist_hand', value = "High Card", hand = "High Card"},
            {id = 'whitelist_info'}, {id = "faceless"}, {id = "harold"}
        },
        modifiers = {
            {id = "hands", value = 2}, {id = "discards", value = 1},
            {id = "hand_size", value = 3}
        }
    },
    restrictions = {
        banned_other = {
            {id = "bl_eye", type = "blind"}, {id = "bl_ox", type = "blind"}
        }
    },
    deck = {type = "Challenge Deck", no_ranks = {K = true, Q = true, J = true}}
})

SMODS.Challenge({ -- Curse Of Jimbo
    key = "curse_of_jimbo",
    rules = {
        custom = {{id = "forced_joker_all", value = "Jimbo", card = "j_joker"}}
    }
})

SMODS.Challenge({ -- Broad Spectrum
    key = "broad_spectrum",
    jokers = {{id = "j_smeared"}},
    rules = {
        custom = {
            {
                id = "forced_joker_pool",
                value = "Suits",
                pool = {
                    "j_wrathful_joker", "j_gluttenous_joker", "j_greedy_joker",
                    "j_lusty_joker", "j_flower_pot", "j_smeared"
                }
            }
        }
    }
})

SMODS.Challenge({ -- Have fun!
    key = "have_fun",
    jokers = {{id = "j_blueprint", edition = "negative"}},
    vouchers = {
        {id = "v_directors_cut"}, {id = "v_retcon"}, {id = "v_seed_money"}
    },
    rules = {
        custom = {{id = "win_ante", value = 29}},
        modifiers = {{id = "dollars", value = 45}}
    }
})

SMODS.Keybind({
    key_pressed = "delete",
    action = function(self) SMODS.restart_game() end
})
