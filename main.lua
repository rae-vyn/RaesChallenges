---Levels up hand (with proper animation) [from JoyousSpring]
---@param card Card|table
---@param hand_key string
---@param instant boolean?
---@param amount integer?
function rae_level_up_hand(card, hand_key, instant, amount)
    if not instant then
        update_hand_text({ sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3 },
            {
                handname = localize(hand_key, 'poker_hands'),
                chips = G.GAME.hands[hand_key].chips,
                mult = G.GAME.hands[hand_key].mult,
                level = G.GAME.hands[hand_key].level
            })
    end
    level_up_hand(card, hand_key, instant, amount)
    if not instant then
        update_hand_text({ sound = 'button', volume = 0.7, pitch = 1.1, delay = 0 },
            { mult = 0, chips = 0, handname = '', level = '' })
    end
end

local evaluate_poker_hand_ref = evaluate_poker_hand
function evaluate_poker_hand(hand)
    local ret = evaluate_poker_hand_ref(hand)
    if G.GAME.modifiers.only_high_card == true then
        for k, v in pairs(ret) do
            if k ~= "High Card" then
                ret[k] = {}
            end
        end
    end
    return ret
end

SMODS.Challenge({
    key = "splash_i",
    jokers = {
        {id = "j_splash", edition = "negative", eternal = true}
    },
    rules = {
        custom = {
            {id = "high_level", value = 3},
            {id = "only_high_card"},
        }
    },
    restrictions = {
        banned_other = {{id = "bl_eye", type = "blind"}, {id = "bl_ox", type = "blind"}}
    }
})

SMODS.Challenge({
    key = "splash_ii",
    jokers = {
        {id = "j_splash", edition = "negative", eternal = true}
    },
    rules = {
        custom = {
            {id = "high_level", value = 3},
            {id = "only_high_card"},
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
            {id = "high_level", value = 6},
            {id = "only_high_card"},
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
})

SMODS.Challenge({
    key = "splash_light",
    jokers = {
        {id = "j_splash", edition = "negative", eternal = true}
    },
    rules = {
        custom = {
            {id = "high_level", value = 5},
            {id = "only_high_card"},
            {id = "faceless"},
            {id = "harold"}
        },
        modifiers = {
            {id = "hands", value = 1},
            {id = "discards", value = 1},
            {id = "hand_size", value = 3}
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
})

SMODS.Keybind({
    key_pressed = "delete",
    action = function (self)
        SMODS.restart_game()
    end
})
