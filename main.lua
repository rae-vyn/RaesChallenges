---Levels up hand (with proper animation) [from JoyousSpring]
---@param card Card|table
---@param hand_key string
---@param instant boolean?
---@param amount integer?
function rae_level_up_hand(card, hand_key, instant, amount)
	if not instant then
		update_hand_text({ sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 }, {
			handname = localize(hand_key, "poker_hands"),
			chips = G.GAME.hands[hand_key].chips,
			mult = G.GAME.hands[hand_key].mult,
			level = G.GAME.hands[hand_key].level,
		})
	end
	level_up_hand(card, hand_key, instant, amount)
	if not instant then
		update_hand_text(
			{ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
			{ mult = 0, chips = 0, handname = "", level = "" }
		)
	end
end

function values(tbl)
	local vals = {}
	for _, v in pairs(tbl) do
		vals[#vals + 1] = v
	end

	return vals
end

function mod_mult(_mult)
	if G.GAME.modifiers.mult_dollar_cap then
		return math.min(_mult, math.max(2 * G.GAME.dollars, 0))
	elseif G.GAME.modifiers.no_mult then
		return 1
	elseif G.GAME.modifiers.mult_chip_cap then
		return math.min(_mult, hand_chips)
	end
	return _mult
end

local evaluate_poker_hand_ref = evaluate_poker_hand
function evaluate_poker_hand(hand)
	local ret = evaluate_poker_hand_ref(hand)
	if G.GAME.modifiers.only_hand then
		for k, v in pairs(ret) do
			if (k ~= "High Card") and (k ~= G.GAME.modifiers.only_hand) then
				ret[k] = {}
			end
		end
	end
	return ret
end

SMODS.Challenge({ -- Splash I
	key = "splash_i",
	jokers = {
		{ id = "j_splash", edition = "negative", eternal = true },
	},
	rules = {
		custom = {
			{ id = "hand_level", value = { hand = "High Card", level = 6 } },
			{ id = "only_hand", value = "High Card" },
		},
	},
	restrictions = {
		banned_other = { { id = "bl_eye", type = "blind" }, { id = "bl_ox", type = "blind" } },
	},
})

SMODS.Challenge({ -- Mono Mult
	key = "monopoly_mult",
	vouchers = {
		{ id = "v_directors_cut" },
	},
	rules = {
		custom = {
			{ id = "mult_dollar_cap" },
		},
		modifiers = {
			{ id = "dollars", value = 30 },
		},
	},
	restrictions = {
		banned_other = { { id = "bl_ox", type = "blind" } },
	},
})

SMODS.Challenge({ -- Spaceman
	key = "spaced_out",
	jokers = {
		{ id = "j_space", eternal = true },
		{ id = "j_oops" },
	},
	rules = {
		custom = {
			{ id = "no_shop_jokers" },
		},
	},
	restrictions = {
		banned_cards = {
			{ id = "c_mercury" },
			{ id = "c_venus" },
			{ id = "c_earth" },
			{ id = "c_mars" },
			{ id = "c_jupiter" },
			{ id = "c_saturn" },
			{ id = "c_uranus" },
			{ id = "c_neptune" },
			{ id = "c_eris" },
			{ id = "c_ceres" },
			{ id = "c_planet_x" },
			{
				id = "p_celestial_normal_1",
				ids = {
					"p_celestial_normal_2",
					"p_celestial_normal_3",
					"p_celestial_normal_4",
					"p_celestial_jumbo_1",
					"p_celestial_jumbo_2",
					"p_celestial_mega_1",
					"p_celestial_mega_2",
				},
			},
			{ id = "c_high_priestess" },
			{ id = "j_burnt" },
		},
		banned_tags = {
			{ id = "tag_meteor" },
		},
		banned_other = { { id = "bl_ox", type = "blind" } },
	},
})

SMODS.Challenge({ -- Chips
	key = "chip_in",
	jokers = {
		{ id = "j_blue_joker", edition = "foil" },
	},
	rules = {
		custom = {
			{ id = "no_mult" },
		},
	},
	restrictions = {
		banned_other = { { id = "bl_ox", type = "blind" } },
	},
	deck = {
		type = "Challenge Deck",
		enhancement = "m_bonus",
	},
})
--[[
SMODS.Challenge({
    key = "splash_ii",
    jokers = {
        {id = "j_splash", edition = "negative", eternal = true}
    },
    rules = {
        custom = {
            {id = "hand_level", value = {hand = "High Card", level = 6}},
            {id = "only_hand", value = "High Card"},
        },
        modifiers = {
            {id = "hands", value = 3},
            {id = "hand_size", value = 6}
        }
    },
    restrictions = {
        banned_other = {{id = "bl_eye", type = "blind"}, {id = "bl_ox", type = "blind"}}
    }
})

SMODS.Challenge({
    key = "splash_iii",
    jokers = {
        {id = "j_splash", edition = "negative", eternal = true}
    },
    rules = {
        custom = {
            {id = "hand_level", value = {hand = "High Card", level = 6}},
            {id = "only_hand", value = "High Card"},
            {id = "faceless"},
        },
        modifiers = {
            {id = "hands", value = 2},
            {id = "hand_size", value = 5}
        }
    },
    restrictions = {
        banned_other = {{id = "bl_eye", type = "blind"}, {id = "bl_ox", type = "blind"}}
    },
    deck = {
        type = "Challenge Deck",
        no_ranks = {
            K = true,
            Q = true,
            J = true
        }
    }
})]]

SMODS.Challenge({ -- Truthers
	key = "truthers",
	jokers = {
		{ id = "j_tribe", edition = "negative", eternal = true },
		{ id = "j_devious" },
	},
	rules = {
		custom = {
			{ id = "only_hand", value = "Straight Flush" },
			{ id = "faceless" },
		},
		modifiers = {
			{ id = "hand_size", value = 10 },
		},
	},
	restrictions = {
		banned_other = { { id = "bl_eye", type = "blind" }, { id = "bl_ox", type = "blind" } },
	},
	deck = {
		type = "Challenge Deck",
		no_ranks = {
			K = true,
			Q = true,
			J = true,
		},
	},
})

SMODS.Challenge({ -- Mult Mogul
	key = "mult_mogul",
	vouchers = {
		{ id = "v_directors_cut" },
	},
	rules = {
		custom = {
			{ id = "mult_chip_cap" },
		},
	},
	restrictions = {
		banned_other = { { id = "bl_ox", type = "blind" }, { id = "bl_flint", type = "blind" } },
	},
})

SMODS.Challenge({ -- P2W
	key = "pair_to_win",
	rules = {
		custom = {
            { id = "only_hand", value = "Pair" },
            { id = "hand_level", value = {hand = "Pair", level = 6}},
			{ id = "pair_tax" },
		},
        modifiers = {
            { id = "dollars", value = 22 }
        },
	},
	restrictions = {
		banned_other = { { id = "bl_ox", type = "blind" }, { id = "bl_club", type = "blind" }, { id = "bl_window", type = "blind" },},
	},
	deck = {
		type = "Challenge Deck",
		cards = { -- Pairs of Diamonds and Clubs
			{ s = "D", r = "2" },
			{ s = "D", r = "3" },
			{ s = "D", r = "4" },
			{ s = "D", r = "5" },
			{ s = "D", r = "6" },
			{ s = "D", r = "7" },
			{ s = "D", r = "8" },
			{ s = "D", r = "9" },
			{ s = "D", r = "T" },
			{ s = "D", r = "J" },
			{ s = "D", r = "Q" },
			{ s = "D", r = "K" },
			{ s = "D", r = "A" },
			{ s = "C", r = "2" },
			{ s = "C", r = "3" },
			{ s = "C", r = "4" },
			{ s = "C", r = "5" },
			{ s = "C", r = "6" },
			{ s = "C", r = "7" },
			{ s = "C", r = "8" },
			{ s = "C", r = "9" },
			{ s = "C", r = "T" },
			{ s = "C", r = "J" },
			{ s = "C", r = "Q" },
			{ s = "C", r = "K" },
			{ s = "C", r = "A" },
			{ s = "D", r = "2" },
			{ s = "D", r = "3" },
			{ s = "D", r = "4" },
			{ s = "D", r = "5" },
			{ s = "D", r = "6" },
			{ s = "D", r = "7" },
			{ s = "D", r = "8" },
			{ s = "D", r = "9" },
			{ s = "D", r = "T" },
			{ s = "D", r = "J" },
			{ s = "D", r = "Q" },
			{ s = "D", r = "K" },
			{ s = "D", r = "A" },
			{ s = "C", r = "2" },
			{ s = "C", r = "3" },
			{ s = "C", r = "4" },
			{ s = "C", r = "5" },
			{ s = "C", r = "6" },
			{ s = "C", r = "7" },
			{ s = "C", r = "8" },
			{ s = "C", r = "9" },
			{ s = "C", r = "T" },
			{ s = "C", r = "J" },
			{ s = "C", r = "Q" },
			{ s = "C", r = "K" },
			{ s = "C", r = "A" },
		},
	},
})

SMODS.Challenge({ -- Economist
	key = "economist",
	vouchers = {
		{ id = "v_seed_money" },
        { id = "v_money_tree" },
	},
	rules = {
		custom = {
			{ id = "all_rental" },
		},
        modifiers = {
            { id = "dollars", value = 25 }
        },
	},
})

SMODS.Challenge({ -- Splash II
	key = "splash_light",
	jokers = {
		{ id = "j_splash", edition = "negative", eternal = true },
	},
	rules = {
		custom = {
			{ id = "hand_level", value = { hand = "High Card", level = 5 } },
			{ id = "only_hand", value = "High Card" },
			{ id = "faceless" },
			{ id = "harold" },
		},
		modifiers = {
			{ id = "hands", value = 2 },
			{ id = "discards", value = 1 },
			{ id = "hand_size", value = 3 },
		},
	},
	restrictions = {
		banned_other = { { id = "bl_eye", type = "blind" }, { id = "bl_ox", type = "blind" } },
	},
	deck = {
		type = "Challenge Deck",
		no_ranks = {
			K = true,
			Q = true,
			J = true,
		},
	},
})

SMODS.Challenge({ -- Economist
	key = "sorry_doc",
	vouchers = {
		{ id = "v_seed_money" },
        { id = "v_money_tree" },
	},
    jokers = {
      {id = "j_mail", edition = "polychrome"},
    },
	rules = {
		custom = {
			{ id = "all_rental" },
            { id = "all_eternal"}
		},
        modifiers = {
            { id = "dollars", value = 25 }
        },
	},
})
--[[
SMODS.Challenge({ -- Truthers II
	key = "truthers_ii",
	jokers = {
		{ id = "j_tribe", edition = "negative", eternal = true },
		{ id = "j_crafty" },
	},
	rules = {
		custom = {
			{ id = "only_hand", value = "Flush" },
			{ id = "faceless" },
		},
		modifiers = {
			{ id = "hand_size", value = 10 },
		},
	},
	restrictions = {
		banned_cards = {
			{ id = "j_greedy_joker" },
			{ id = "j_lusty_joker" },
			{ id = "j_wrathful_joker" },
			{ id = "j_gluttenous_joker" },
			{ id = "j_droll" },
			{ id = "j_crafty" },
			{ id = "j_smeared" },
			{ id = "j_rough_gem" },
			{ id = "j_bloodstone" },
			{ id = "j_arrowhead" },
			{ id = "j_onyx_agate" },
		},
		banned_other = { { id = "bl_eye", type = "blind" }, { id = "bl_ox", type = "blind" } },
	},
	deck = {
		type = "Challenge Deck",
		no_ranks = {
			K = true,
			Q = true,
			J = true,
		},
	},
})
]]
SMODS.Keybind({
	key_pressed = "delete",
	action = function(self)
		SMODS.restart_game()
	end,
})
