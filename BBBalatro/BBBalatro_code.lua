--- STEAMODDED HEADER

--- MOD_NAME: BBBalatro
--- MOD_ID: BBBalatro
--- MOD_AUTHOR: [B]
--- MOD_DESCRIPTION: The Jonkler collection
--- PRIORITY: -69
--- BADGE_COLOR: 529df2
--- PREFIX: bbb
--- VERSION: 1.2.0
--- LOADER_VERSION_GEQ: 1.0.0

----------------------------------------------
------------MOD CODE -------------------------

SMODS.Atlas {  
    key = 'jokersheet',
    px = 71,
    py = 95,
    path = 'example.png'
}

SMODS.Joker {
    key = 'baldjoker',
    loc_txt = {
        name = "Bald Joker",                                --name used by the joker
        text = {
            "{C:mult}+2 mult{} for every scored card",             --description text.		
            "without an {C:attention}enhancement{}",         --you can add as many lines as you want
            "{C:inactive}(jonkler){}"                       --more than 5 lines look odd
        }
    },
    config = { extra = { mult = 0, x_mult = 0 } }, --variables used for abilities and effects.
    rarity = 1,                                         --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    pos = { x = 0, y = 0 },                             --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
    atlas = 'jokersheet',                                        --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
    cost = 5,                                           --cost to buy the joker in shops
    unlocked = true,                                    --joker is unlocked by default
    discovered = true,                                  --joker is discovered by default
    blueprint_compat = true,                            --does joker work with blueprint
    eternal_compat = true,                              --can joker be eternal
    soul_pos = nil,                            --pos of a soul sprite.

    calculate = function(self, context, card)                 --define calculate functions here
        if context.individual and context.cardarea == G.play then
            if context.other_card.ability.effect ~= 'Mult Card' and context.other_card.ability.effect ~= 'Bonus Card' and context.other_card.ability.effect ~= 'Wild Card' and context.other_card.ability.effect ~= 'Glass Card' and context.other_card.ability.effect ~= 'Steel Card' and context.other_card.ability.effect ~= 'Gold Card' and context.other_card.ability.effect ~= 'Lucky Card' and context.other_card.ability.effect ~= 'Stone Card' then
                return {
                    mult = 2,
                    card = self,
                    message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                }
            end
        end
    end,

    loc_vars = function(self,info_queue,center) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
        return { vars = {center.ability.extra.mult, center.ability.extra.x_mult} }
    end,
}

    --[add more jokers here]

SMODS.Joker {
    key = 'wokerjoker',
    loc_txt = {
        name = "Woker",                            --name used by the joker
        text = {
            "All scored {C:attention}Face{} cards", --description text.		
            "become {C:attention}Queens{}",        --you can add as many lines as you want
            "{C:inactive}(jonkler){}"              --more than 5 lines look odd
        }
    },
    config = { extra = { mult = 0, x_mult = 0 } }, --variables used for abilities and effects.
    pos = { x = 1, y = 0 },                    --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
    rarity = 3,                                --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 7,                                  --cost to buy the joker in shops
    blueprint_compat = false,                  --does joker work with blueprint
    eternal_compat = true,                     --can joker be eternal
    unlocked = true,                           --joker is unlocked by default
    discovered = true,                         --joker is discovered by default
    atlas = 'jokersheet',                               --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
    soul_pos = nil,                            --pos of a soul sprite.

    calculate = function(self, context, card)        --define calculate functions here
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if context.other_card:get_id() == 11 or context.other_card:get_id() == 13 or next(find_joker("Pareidolia")) then
                local suit_prefix = string.sub(context.other_card.base.suit, 1, 1) .. '_'
                context.other_card:set_base(G.P_CARDS[suit_prefix .. 'Q'])
                return {
                    message = localize { "Wokified" }
                }
            end
        end
    end,

    loc_vars = function(self,info_queue,center) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
        return { vars = {center.ability.extra.mult, center.ability.extra.x_mult} }
    end,
}

SMODS.Joker {
    key = "brokejoker",
    loc_txt = {
        name = "Broker",                                --name used by the joker
        text = {
            "gives {X:red,C:white}X2{} mult if",               --description text.		
            "you have {C:money}0${} or less", --you can add as many lines as you want
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        }
    },
    config = { extra = { mult = 0, x_mult = 2 } },  --variables used for abilities and effects.
    pos = { x = 2, y = 0 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
    rarity = 2,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 6,                                       --cost to buy the joker in shops
    blueprint_compat = true,                        --doses joker work with blueprint
    eternal_compat = true,                          --can joker be eternal
    unlocked = true,                                --joker is unlocked by default
    discovered = true,                              --joker is discovered by default
    atlas = 'jokersheet',                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
    soul_pos = nil,                                 --pos of a soul sprite.

    calculate = function(self, context, card)             --define calculate functions here
        if SMODS.end_calculate_context(context) then
            if G.GAME.dollars <= 0 then
                return {
                    Xmult_mod = card.ability.extra.x_mult,
                    card = self,
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
                }
            end
        end
    end,

    loc_vars = function(self,info_queue,center) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
        return { vars = {center.ability.extra.mult, center.ability.extra.xmult} }
    end
}

SMODS.Joker {
    key = "blokejoker",
    loc_txt = {
        name = "Bloker",                                --name used by the joker
        text = {
            "{C:mult}+1 mult{} for each scored with a {C:attention}suit{}",               --description text.		
            "and/or {C:attention}rank{} thats contains a {C:attention}T{}", --you can add as many lines as you want
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        }
    },
    config = { extra = { mult = 0, x_mult = 0 } },  --variables used for abilities and effects.
    pos = { x = 3, y = 0 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
    rarity = 1,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 4,                                       --cost to buy the joker in shops
    blueprint_compat = true,                        --doses joker work with blueprint
    eternal_compat = true,                          --can joker be eternal
    unlocked = true,                                --joker is unlocked by default
    discovered = true,                              --joker is discovered by default
    atlas = 'jokersheet',                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
    soul_pos = nil,                                 --pos of a soul sprite.

    calculate = function(self, context, card)             --define calculate functions here
        if context.individual and context.cardarea == G.play then
            if context.other_card.base.suit == ("Hearts") and context.other_card.ability.effect ~= 'Stone Card' then
                if context.other_card:get_id() == 2 or context.other_card:get_id() == 3 or context.other_card:get_id() == 8 or context.other_card:get_id() == 10 then
                    return {
                        mult = 2,
                        card = self
                    }
                else
                    return {
                        mult = 1,
                        card = self
                    }
                end
            elseif context.other_card:get_id() == 2 or context.other_card:get_id() == 3 or context.other_card:get_id() == 8 or context.other_card:get_id() == 10 and context.other_card.ability.effect ~= 'Stone Card' then
                return {
                    mult = 1,
                    card = self
                }
            end
        end
    end,

    loc_vars = function(self,info_queue,center) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
        return { vars = {center.ability.extra.mult, center.ability.extra.xmult} }
    end
}

SMODS.Joker {
    key = 'strokejoker',
    loc_txt = {
        name = "Stroker",                                --name used by the joker
        text = {
            "{X:red,C:white}X0.5-2{} mult",               --description text.		
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        }
    },
    config = { extra = { mult = 0, x_mult = 0 } },  --variables used for abilities and effects.
    pos = { x = 4, y = 0 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
    rarity = 1,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 3,                                       --cost to buy the joker in shops
    blueprint_compat = true,                        --doses joker work with blueprint
    eternal_compat = true,                          --can joker be eternal
    unlocked = true,                                --joker is unlocked by default
    discovered = true,                              --joker is discovered by default
    atlas = 'jokersheet',                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
    soul_pos = nil,                                 --pos of a soul sprite.

    calculate = function(self, context, card)             --define calculate functions here   
        if SMODS.end_calculate_context(context) then
            return {
                Xmult_mod = pseudorandom('strokejoker', 0.5, 2)*0.1,
                message = localize { "Stroked" }
            }
        end
    end,

    loc_vars = function(self,info_queue,center) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
        return { vars = {center.ability.extra.mult, center.ability.extra.xmult} }
    end
}

SMODS.Joker {
    key = "binaryjoker",
    loc_txt = {
        name = "Binary",                                --name used by the joker
        text = {
            "{C:green}#4# in #3#{} chance of",               --description text.		
            "{X:red,C:white}X2 mult{} whenever a {C:attention}10{} is played", --you can add as many lines as you want
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        }
    },
    config = { extra = { mult = 0, x_mult = 2 } },  --variables used for abilities and effects.
    pos = { x = 5, y = 0 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
    rarity = 3,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 10,                                       --cost to buy the joker in shops
    blueprint_compat = true,                        --doses joker work with blueprint
    eternal_compat = true,                          --can joker be eternal
    unlocked = true,                                --joker is unlocked by default
    discovered = true,                              --joker is discovered by default
    atlas = 'jokersheet',                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
    soul_pos = nil,                                 --pos of a soul sprite.

    calculate = function(self, context, card)             --define calculate functions here   
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 10 then
                if pseudorandom('binaryjoker') < G.GAME.probabilities.normal/2 then
                    return {
                        x_mult = card.ability.extra.x_mult,
                        card = self
                    }
                end
            end
        end     
    end,

    loc_vars = function(self,info_queue,center) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
        return { vars = {center.ability.extra.mult, center.ability.extra.xmult, G.GAME and G.GAME.probabilities.normal or 1}  }
    end
}

SMODS.Joker {
    key = "blindjoker",
    loc_txt = {
        name = "Blind Joker",                                --name used by the joker
        text = {
            "{C:mult}+Y mult{} every time you choose a blind",               --description text.	
            "{C:inactive}(Y = ante, currently gives #1#){}", --you can add as many lines as you want
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        }
    },
    config = { extra = { mult = 0, x_mult = 2 } },  --variables used for abilities and effects.
    pos = { x = 6, y = 0 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
    rarity = 2,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 4,                                       --cost to buy the joker in shops
    blueprint_compat = true,                        --doses joker work with blueprint
    eternal_compat = true,                          --can joker be eternal
    unlocked = true,                                --joker is unlocked by default
    discovered = true,                              --joker is discovered by default
    atlas = 'jokersheet',                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
    soul_pos = nil,                                 --pos of a soul sprite.

    calculate = function(self, context, card)             --define calculate functions here
        if context.setting_blind and not self.getting_sliced and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + G.GAME.round_resets.ante
        end
        if SMODS.end_calculate_context(context) then
            return {
                mult_mod = card.ability.extra.mult,
                card = self,
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
            }
        end
    end,

    loc_vars = function(self,info_queue,center) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
        return { vars = {center.ability.extra.mult, center.ability.extra.xmult, G.GAME.round_resets.ante} }
    end
}

SMODS.Joker {
    key = "brailjoker",
    loc_txt = {
        name = "Braille Joker",                                --name used by the joker
        text = {
            "lowers {C:chips}blind{} by {C:attention}25%{}",               --description text.	
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        }
    },
    config = { extra = { mult = 0, x_mult = 2 } },  --variables used for abilities and effects.
    pos = { x = 7, y = 0 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
    rarity = 3,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 6,                                       --cost to buy the joker in shops
    blueprint_compat = false,                        --doses joker work with blueprint
    eternal_compat = true,                          --can joker be eternal
    unlocked = true,                                --joker is unlocked by default
    discovered = true,                              --joker is discovered by default
    atlas = 'jokersheet',                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
    soul_pos = nil,                                 --pos of a soul sprite.

    calculate = function(self, context, card)             --define calculate functions here
        if context.setting_blind and not self.getting_sliced and not context.blueprint then
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                G.GAME.blind.chips = math.floor(G.GAME.blind.chips * 0.75)
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                    
                local chips_UI = G.hand_text_area.blind_chips
                G.FUNCS.blind_chip_UI_scale(G.hand_text_area.blind_chips)
                G.HUD_blind:recalculate() 
                chips_UI:juice_up()
            
                if not silent then play_sound('chips2') end
                return true end }))
        end
    end,

    loc_vars = function(self,info_queue,center) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
        return { vars = {center.ability.extra.mult, center.ability.extra.xmult} }
    end
}

SMODS.Joker {
    key = "deafjoker",
    loc_txt = {
        name = "Deaf Joker",                                --name used by the joker
        text = {
            "{C:mult}+5 mult{} for each {C:chips}hand{} played this round",               --description text.	
            "{C:inactive}(currently gives +#1# mult){}", --you can add as many lines as you want
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        }
    },
    config = { extra = { mult = 5, x_mult = 2 } },  --variables used for abilities and effects.
    pos = { x = 8, y = 0 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
    rarity = 1,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 5,                                       --cost to buy the joker in shops
    blueprint_compat = true,                        --doses joker work with blueprint
    eternal_compat = true,                          --can joker be eternal
    unlocked = true,                                --joker is unlocked by default
    discovered = true,                              --joker is discovered by default
    atlas = 'jokersheet',                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
    soul_pos = nil,                                 --pos of a soul sprite.

    calculate = function(self, context, card)             --define calculate functions here
        if card.ability.extra.mult == nil then
            card.ability.extra.mult = 0
        end
        if SMODS.end_calculate_context(context) then
            card.ability.extra.mult = (card.ability.extra.mult + 5) or 0
            return {
                mult_mod = (card.ability.extra.mult - 5) or 0,
                card = self,
                message = localize { type = 'variable', key = 'a_mult', vars = { (card.ability.extra.mult - 5) or 0 } },
            }
        elseif context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
            card.ability.extra.mult = 5
        end
    end,

    loc_vars = function(self,info_queue,center) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
        return { vars = {center.ability.extra.mult, center.ability.extra.xmult} }
    end,
}

SMODS.Joker {
    key = "diamondskyjoker",
    loc_txt = {
        name = "Joker in the Sky with Diamonds",                                --name used by the joker
        text = {
            "{C:money}1${} per each",               --description text.	
            "{C:attention}diamond{} card held in hand", --you can add as many lines as you want
            "{C:inactive}(jonkler made by alr alr alr bye){}"                   --more than 5 lines look odd
        }
    },
    config = { extra = { mult = 5, x_mult = 2 } },  --variables used for abilities and effects.
    pos = { x = 9, y = 0 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
    rarity = 2,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 6,                                       --cost to buy the joker in shops
    blueprint_compat = true,                        --doses joker work with blueprint
    eternal_compat = true,                          --can joker be eternal
    unlocked = true,                                --joker is unlocked by default
    discovered = true,                              --joker is discovered by default
    atlas = 'jokersheet',                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
    soul_pos = nil,                                 --pos of a soul sprite.

    calculate = function(self, context, card)             --define calculate functions here
        if context.individual and context.cardarea == G.hand then
            if context.other_card.base.suit == 'Diamonds' then
                ease_dollars(1)
            end
        end
    end,

    loc_vars = function(self,info_queue,center) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
        return { vars = {center.ability.extra.mult, center.ability.extra.xmult} }
    end,
}

SMODS.Joker {
    key = "zipperjoker",
    loc_txt = {
        name = "Split joker",                                --name used by the joker
        text = {
            "played {C:attention}pairs{}, {C:attention}two pairs{} and {C:attention}4 of a kinds{}",               --description text.	
            "split into the {C:attention}2{} closest numbers", --you can add as many lines as you want
            "{C:inactive}(ie. pair of 9s would turn into 8 and 10){}",
            "{C:inactive}(jonkler made by alr alr alr bye){}"                   --more than 5 lines look odd
        }
    },
    config = { extra = { mult = 5, x_mult = 2 } },  --variables used for abilities and effects.
    pos = { x = 10, y = 0 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
    rarity = 2,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 5,                                       --cost to buy the joker in shops
    blueprint_compat = false,                        --doses joker work with blueprint
    eternal_compat = true,                          --can joker be eternal
    unlocked = true,                                --joker is unlocked by default
    discovered = true,                              --joker is discovered by default
    atlas = 'jokersheet',                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
    soul_pos = nil,                                 --pos of a soul sprite.

    calculate = function(self, context, card)             --define calculate functions here
        local flip
        if flip == nil then
            flip = 1
        end
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if next(context.poker_hands["Pair"]) or next(context.poker_hands["Four Of A Kind"]) or next(context.poker_hands["Two Pair"]) then
                local suit_prefix = string.sub(context.other_card.base.suit, 1, 1) .. '_'
                local rank_prefix = context.other_card:get_id() + self.ability.extra.flip
                if rank_prefix > 10 then
                    if rank_prefix > 11 then
                        if rank_prefix > 12 then
                            if rank_prefix > 13 then
                                if rank_prefix > 14 then
                                    rank_prefix = '2'
                                else
                                    rank_prefix = 'A'
                                end
                            else
                                rank_prefix = 'K'
                            end
                        else
                            rank_prefix = 'Q'
                        end
                    else
                        rank_prefix = 'J'
                    end
                elseif rank_prefix <= 1 then
                    rank_prefix = 'A'
                end
                context.other_card:set_base(G.P_CARDS[suit_prefix .. rank_prefix])
                if flip > 0 then
                    flip = -1
                else
                    flip = 1
                end
                return {
                    message = localize { "Split!" }
                }
            end
        end
    end,

    loc_vars = function(self,info_queue,center) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
        return { vars = {center.ability.extra.mult, center.ability.extra.xmult} }
    end,
}

SMODS.Joker {
    key = "stonerjoker",
    loc_txt = {
       name = "Stoner",--name used by the joker
       text = {
           "{C:green}#3# in 3{} chance of {C:mult}+1 discard{}",--description text.		
           "if you discard exactly {C:attention}5 cards{}",--you can add as many lines as you want
           "{C:inactive}(jonkler made by agentcheese){}"
       }
    },
    config = {extra={mult=5, x_mult=2}}, --variables used for abilities and effects.
    pos = { x = 11, y = 0 }, --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
    rarity=1, --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 4, --cost to buy the joker in shops
    blueprint_compat=false, --does joker work with blueprint
    eternal_compat=true, --can joker be eternal
    unlocked=true, --joker is unlocked by default
    discovered=true, --joker is discovered by default
    effect=nil, --you can specify an effect here eg. 'Mult'
    atlas='jokersheet', --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
    soul_pos=nil, --pos of a soul sprite.

    calculate = function(self,context) --define calculate functions here
        local card_tally
        if card_tally == nil then
            card_tally = 0
        end
        if context.discard and context.other_card == context.full_hand[#context.full_hand] and not context.blueprint then --Example calculate: If not debuffed cards are discarded, gain 1$ for every card
            for k, v in ipairs(context.full_hand) do
                card_tally = card_tally + 1
            end
            if card_tally == 5 and pseudorandom('stoner') < G.GAME.probabilities.normal/3 then
                ease_discard(1)
                card_tally = 0
            end
        end
    end,

    loc_vars = function(self,info_queue,center) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
       return { vars = {center.ability.extra.mult, center.ability.extra.x_mult, G.GAME.probabilities.normal or 1} }
    end, 
}

SMODS.Joker {
    key = "theifjoker",
    loc_txt = {
        name = "Thief",                                --name used by the joker
        text = {
            "gains {X:red,C:white}+X0.2{} mult every played hand",               --description text.	
            "{C:money}-3${} every played hand", --you can add as many lines as you want
            "{C:inactive}(currently gives {}{X:red,C:white}X#2#{}{C:inactive} mult){}",
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        }
    },
    config = { extra = { mult = 0, x_mult = 1.2 } },  --variables used for abilities and effects.
    pos = { x = 12, y = 0 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
    rarity = 2,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 1,                                       --cost to buy the joker in shops
    blueprint_compat = true,                        --doses joker work with blueprint
    eternal_compat = true,                          --can joker be eternal
    unlocked = true,                                --joker is unlocked by default
    discovered = true,                              --joker is discovered by default
    atlas = 'jokersheet',                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
    soul_pos = nil,                                 --pos of a soul sprite.

    calculate = function(self, context, card)             --define calculate functions here
        if SMODS.end_calculate_context(context) then
            ease_dollars(-3)
            card.ability.extra.x_mult = card.ability.extra.x_mult + 0.2
            return {
                Xmult_mod = card.ability.extra.x_mult-0.2,
                card = self,
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult-0.2 } }
            }
        end
    end,

    loc_vars = function(self,info_queue,center) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
        return { vars = {center.ability.extra.mult, center.ability.extra.x_mult} }
    end
}

SMODS.Joker {
    key = "realsquarejoker",
    loc_txt = {
        name = "Actually square joker",                                --name used by the joker
        text = {
            "Multiplies {C:chips}chips{} by itself",               --description text.	
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        }
    },
    config = { extra = { mult = 0, x_mult = 1.2, chips = 0 } },  --variables used for abilities and effects.
    pos = { x = 13, y = 0 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
    rarity = 3,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 16,                                       --cost to buy the joker in shops
    blueprint_compat = true,                        --doses joker work with blueprint
    eternal_compat = true,                          --can joker be eternal
    unlocked = true,                                --joker is unlocked by default
    discovered = true,                              --joker is discovered by default
    atlas = 'jokersheet',                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
    soul_pos = nil,                                 --pos of a soul sprite.

    calculate = function(self, context, card)             --define calculate functions here
        if SMODS.end_calculate_context(context) then
            hand_chips = hand_chips*hand_chips
        end
    end,

    loc_vars = function(self,info_queue,center) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
        return { vars = {center.ability.extra.mult, center.ability.extra.x_mult, center.ability.extra.chips} }
    end    
}

SMODS.Joker {
    key = "outlinejoker",
    loc_txt = {
        name = "Outline",                                --name used by the joker
        text = {
            "If played hand is 1 {C:attention}wild{} card,",               --description text.	
            "{C:attention}split{} it into the {C:attention}4{} suits",
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        }
    },
    config = { extra = { mult = 0, x_mult = 1.2 } },  --variables used for abilities and effects.
    pos = { x = 14, y = 0 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
    rarity = 2,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 5,                                       --cost to buy the joker in shops
    blueprint_compat = true,                        --doses joker work with blueprint
    eternal_compat = true,                          --can joker be eternal
    unlocked = true,                                --joker is unlocked by default
    discovered = true,                              --joker is discovered by default
    atlas = 'jokersheet',                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
    soul_pos = nil,                                 --pos of a soul sprite.

    calculate = function(self, context, card)             --define calculate functions here
        local card_tally = 0
        if context.individual and context.cardarea == G.play then
            for k, v in ipairs(context.full_hand) do
                card_tally = card_tally + 1
            end
            if card_tally == 1 and context.other_card.ability.effect == 'Wild Card' then
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                        local _card = copy_card(context.full_hand[1], nil, nil, G.playing_card )
                        _card:set_ability(G.P_CENTERS.c_base, nil, false)
                        _card:change_suit('Hearts')
                        _card:add_to_deck()
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        table.insert(G.playing_cards, _card)
                        G.hand:emplace(_card)
                        _card.states.visible = nil

                        G.E_MANAGER:add_event(Event({
                            func = function()
                                _card:start_materialize()
                                return true
                            end
                        })) 
                        
                        local _card2 = copy_card(context.full_hand[1], nil, nil, G.playing_card )
                        _card2:set_ability(G.P_CENTERS.c_base, nil, false)
                        _card2:change_suit('Diamonds')
                        _card2:add_to_deck()
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        table.insert(G.playing_cards, _card2)
                        G.hand:emplace(_card2)
                        _card2.states.visible = nil

                        G.E_MANAGER:add_event(Event({
                            func = function()
                                _card2:start_materialize()
                                return true
                            end
                        })) 

                        local _card3 = copy_card(context.full_hand[1], nil, nil, G.playing_card )
                        _card3:set_ability(G.P_CENTERS.c_base, nil, false)
                        _card3:change_suit('Clubs')
                        _card3:add_to_deck()
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        table.insert(G.playing_cards, _card3)
                        G.hand:emplace(_card3)
                        _card3.states.visible = nil

                        G.E_MANAGER:add_event(Event({
                            func = function()
                                _card3:start_materialize()
                                return true
                            end
                        })) 

                        local _card4 = copy_card(context.full_hand[1], nil, nil, G.playing_card )
                        _card4:set_ability(G.P_CENTERS.c_base, nil, false)
                        _card4:change_suit('Spades')
                        _card4:add_to_deck()
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        table.insert(G.playing_cards, _card4)
                        G.hand:emplace(_card4)
                        _card4.states.visible = nil

                        G.E_MANAGER:add_event(Event({
                            func = function()
                                _card4:start_materialize()
                                return true
                            end
                        })) 

                        context.other_card:start_dissolve()
                        card_tally = 0
            end
        end
    end,

    loc_vars = function(self,info_queue,center) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
        return { vars = {center.ability.extra.mult, center.ability.extra.x_mult} }
    end
}

SMODS.Joker {
    key = "rajoker",
    loc_txt = {
        name = "Ra",                                --name used by the joker
        text = {
            "Gives {C:chips}chip{} value as {C:mult}mult{}",               --description text.	
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        }
    },
    config = { extra = { mult = 0, x_mult = 1.2 } },  --variables used for abilities and effects.
    pos = { x = 0, y = 1 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
    rarity = 3,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 6,                                       --cost to buy the joker in shops
    blueprint_compat = true,                        --doses joker work with blueprint
    eternal_compat = true,                          --can joker be eternal
    unlocked = true,                                --joker is unlocked by default
    discovered = true,                              --joker is discovered by default
    atlas = 'jokersheet',                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
    soul_pos = nil,                                 --pos of a soul sprite.

    calculate = function(self, context, card)             --define calculate functions here
        if SMODS.end_calculate_context(context) then
            return {
                mult_mod = hand_chips,
                card = self,
                message = localize { type = 'variable', key = 'a_chips_minus', vars = { hand_chips } }
            }
        end
    end,

    loc_vars = function(self,info_queue,center) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
        return { vars = {center.ability.extra.mult, center.ability.extra.x_mult} }
    end
}

SMODS.Joker {
    key = "sandjoker",
    loc_txt = {
        name = "Hot sand",                                --name used by the joker
        text = {
            "gains {C:mult}4 mult{} every {C:blue}hand{} played,",               --description text.	
            "{C:inactive}(currently gives #1# mult){}",
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        }
    },
    config = { extra = { mult = -20, x_mult = 1.2 } },  --variables used for abilities and effects.
    pos = { x = 1, y = 1 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
    rarity = 1,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 1,                                       --cost to buy the joker in shops
    blueprint_compat = true,                        --doses joker work with blueprint
    eternal_compat = true,                          --can joker be eternal
    unlocked = true,                                --joker is unlocked by default
    discovered = true,                              --joker is discovered by default
    atlas = 'jokersheet',                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
    soul_pos = nil,                                 --pos of a soul sprite.

    calculate = function(self, context, card)             --define calculate functions here
        if SMODS.end_calculate_context(context) then
            card.ability.extra.mult = card.ability.extra.mult + 4
            return {
                mult_mod = card.ability.extra.mult-4,
                card = self,
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult-4 } }
            }
        end
    end,

    loc_vars = function(self,info_queue,center) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
        return { vars = {center.ability.extra.mult, center.ability.extra.x_mult} }
    end
}

SMODS.Joker {
    key = "sphinxjoker",
    loc_txt = {
        name = "Sphinx",                                --name used by the joker
        text = {
            "{C:attention}Stone{} cards retrigger",               --description text.	
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        }
    },
    config = { extra = { mult = -20, x_mult = 1.2 } },  --variables used for abilities and effects.
    pos = { x = 2, y = 1 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
    rarity = 2,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 5,                                       --cost to buy the joker in shops
    blueprint_compat = true,                        --doses joker work with blueprint
    eternal_compat = true,                          --can joker be eternal
    unlocked = true,                                --joker is unlocked by default
    discovered = true,                              --joker is discovered by default
    atlas = 'jokersheet',                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
    soul_pos = nil,                                 --pos of a soul sprite.

    calculate = function(self, context, card)             --define calculate functions here
        if context.repetition then
             if context.cardarea == G.play then
                if context.other_card.ability.effect == "Stone Card" then
                    return {
                        message = localize('k_again_ex'),
                        repetitions = 1,
                        card = card
                    }
                end
            end
        end
    end,

    loc_vars = function(self,info_queue,center) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
        return { vars = {center.ability.extra.mult, center.ability.extra.x_mult} }
    end
}

SMODS.Joker {
    key = "yellowjoker",
    loc_txt = {
        name = "Yellow joker",                                --name used by the joker
        text = {
            "after each {C:attention}blind{}, set money to {C:money}14${}",               --description text.	
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        }
    },
    config = { extra = { mult = -20, x_mult = 1.2 } },  --variables used for abilities and effects.
    pos = { x = 3, y = 1 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
    rarity = 2,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 14,                                       --cost to buy the joker in shops
    blueprint_compat = false,                        --doses joker work with blueprint
    eternal_compat = true,                          --can joker be eternal
    unlocked = true,                                --joker is unlocked by default
    discovered = true,                              --joker is discovered dby default
    atlas = 'jokersheet',                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
    soul_pos = nil,                                 --pos of a soul sprite.

    calculate = function(self, context, card)             --define calculate functions here
        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
            G.GAME.dollars = 14
            return {
                message = localize { "Reset" }
            }
        end
    end,

    loc_vars = function(self,info_queue,center) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
        return { vars = {center.ability.extra.mult, center.ability.extra.x_mult} }
    end
}

SMODS.Joker {
    key = "sunjoker",
    loc_txt = {
        name = "The sun",                                --name used by the joker
        text = {
            "If your first hand is 1 {C:attention}Hearts{} card,",               --description text.	
            "Create a {C:attention}'The sun'{} tarot card",
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        }
    },
    config = { extra = { mult = -20, x_mult = 1.2 } },  --variables used for abilities and effects.
    pos = { x = 4, y = 1 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
    rarity = 2,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 6,                                       --cost to buy the joker in shops
    blueprint_compat = true,                        --doses joker work with blueprint
    eternal_compat = true,                          --can joker be eternal
    unlocked = true,                                --joker is unlocked by default
    discovered = true,                              --joker is discovered dby default
    atlas = 'jokersheet',                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
    soul_pos = nil,                                 --pos of a soul sprite.

    calculate = function(self, context, card)             --define calculate functions here
        local card_tally = 0
        if context.individual and context.cardarea == G.play and G.GAME.current_round.hands_played == 0 and not context.blueprint then
            for k, v in ipairs(context.full_hand) do
                if v.base.suit == 'Hearts' then card_tally = card_tally + 1 end
            end
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit and card_tally == 1 then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.2,
                    func = (function()
                        local card = create_card(nil,G.consumeables, nil, nil, nil, nil, 'c_sun', 'sup')
                        card:add_to_deck()
                            G.consumeables:emplace(card)
                            G.GAME.consumeable_buffer = 0
                        return true
                    end)}))
                card_eval_status_text(self, 'extra', nil, nil, nil, {message = "SUN", colour = G.C.PURPLE})
            end
            card_tally = 0
        end
    end,

    loc_vars = function(self,info_queue,center) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
        return { vars = {center.ability.extra.mult, center.ability.extra.x_mult} }
    end
}

SMODS.Joker {
    key = "hieroglyphjoker",
    loc_txt = {
        name = "Hieroglyph",                                --name used by the joker
        text = {
            "Gains {C:mult}+2 mult{} per each {C:attention}ace{} played",               --description text.	
            "{C:inactive}(currently gives #1# mult){}",
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        }
    },
    config = { extra = { mult = 0, x_mult = 1.2 } },  --variables used for abilities and effects.
    pos = { x = 5, y = 1 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
    rarity = 2,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 5,                                       --cost to buy the joker in shops
    blueprint_compat = true,                        --doses joker work with blueprint
    eternal_compat = true,                          --can joker be eternal
    unlocked = true,                                --joker is unlocked by default
    discovered = true,                              --joker is discovered dby default
    atlas = 'jokersheet',                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
    soul_pos = nil,                                 --pos of a soul sprite.

    calculate = function(self, context, card)             --define calculate functions here
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if context.other_card:get_id() == 14 then
                card.ability.extra.mult = card.ability.extra.mult + 2
            end
        end
        if SMODS.end_calculate_context(context) then
            return {
                mult_mod = card.ability.extra.mult,
                card = self,
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
            }
        end
    end,

    loc_vars = function(self,info_queue,center) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
        return { vars = {center.ability.extra.mult, center.ability.extra.x_mult} }
    end
}

SMODS.Joker {
    key = "mummyjoker",
    loc_txt = {
        name = "Mummy",                                --name used by the joker
        text = {
            "{C:mult}-1 Mult{} for every card scored",               --description text.	
            "{C:inactive}(currently gives #1# mult){}",
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        }
    },
    config = { extra = { mult = 20, x_mult = 1.2 } },  --variables used for abilities and effects.
    pos = { x = 6, y = 1 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
    rarity = 1,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 4,                                       --cost to buy the joker in shops
    blueprint_compat = true,                        --doses joker work with blueprint
    eternal_compat = true,                          --can joker be eternal
    unlocked = true,                                --joker is unlocked by default
    discovered = true,                              --joker is discovered dby default
    atlas = 'jokersheet',                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
    soul_pos = nil,                                 --pos of a soul sprite.

    calculate = function(self, context, card)             --define calculate functions here
        if card.ability.extra.mult == nil then
            card.ability.extra.mult = 0
        end
        if card.ability.extra.mult <= 0 then
            play_sound('tarot1')
            self.T.r = -0.2
            self:juice_up(0.3, 0.4)
            self.states.drag.is = true
            self.children.center.pinch.x = true
            delay(0.3)
            G.jokers:remove_card(self)
            self:remove()
            self = nil
        end
        if context.individual and context.cardarea == G.play then
            card.ability.extra.mult = (card.ability.extra.mult - 1)
        end
        if SMODS.end_calculate_context(context) then
            return {
                mult_mod = card.ability.extra.mult,
                card = self,
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
            }
        end
    end,

    loc_vars = function(self,info_queue,center) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
        return { vars = {center.ability.extra.mult, center.ability.extra.x_mult} }
    end
}

SMODS.Joker {
    key = "pyramidjoker",
    loc_txt = {
        name = "Pyramid Joker",                                --name used by the joker
        text = {
            "Scored {C:attention}3{} cards {C:attention}retrigger{} 3 times",               --description text.	
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        }
    },
    config = { extra = { mult = 20, x_mult = 1.2, repetitions = 3 } },  --variables used for abilities and effects.
    pos = { x = 7, y = 1 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
    rarity = 1,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 5,                                       --cost to buy the joker in shops
    blueprint_compat = true,                        --doses joker work with blueprint
    eternal_compat = true,                          --can joker be eternal
    unlocked = true,                                --joker is unlocked by default
    discovered = true,                              --joker is discovered dby default
    atlas = 'jokersheet',                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
    soul_pos = nil,                                 --pos of a soul sprite.

    calculate = function(self,card, context)             --define calculate functions here
        if context.repetition then
            if context.cardarea == G.play then
                if context.other_card:get_id() == 3 then
                    return {
                        message = localize('k_again_ex'),
                        repetitions = card.ability.extra.repetitions,
                        card = card
                    }
                end
            end
        end
    end,

    loc_vars = function(self,info_queue,center) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
        return { vars = {center.ability.extra.mult, center.ability.extra.x_mult,center.ability.extra.repetitions} }
    end
}

SMODS.Joker {
    key = "stormjoker",
    loc_txt = {
        name = "Stormy Seas",                                --name used by the joker
        text = {
            "{C:mult}+1 mult{} for every untriggered/disabled card played",
            "{C:inactive}(currently gives #1# mult){}",               --description text.	
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        }
    },
    config = { extra = { mult = 0, x_mult = 2 } },  --variables used for abilities and effects.
    pos = { x = 8, y = 1 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
    rarity = 2,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 5,                                       --cost to buy the joker in shops
    blueprint_compat = true,                        --doses joker work with blueprint
    eternal_compat = true,                          --can joker be eternal
    unlocked = true,                                --joker is unlocked by default
    discovered = true,                              --joker is discovered dby default
    atlas = 'jokersheet',                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
    soul_pos = nil,                                 --pos of a soul sprite.

    calculate = function(self, context, card)             --define calculate functions here
        local card_tally = 0
        local scored_tally = 0
        if context.individual and context.cardarea == G.play then
            scored_tally = scored_tally + 1
        end
        if SMODS.end_calculate_context(context) then
            for k, v in ipairs(context.full_hand) do
                card_tally = card_tally + 1
            end
            card.ability.extra.mult = card.ability.extra.mult + (card_tally - scored_tally)
            card_tally = 0
            scored_tally = 0
            return {
                mult_mod = card.ability.extra.mult,
                card = self,
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
            }
        end
    end,

    loc_vars = function(self,info_queue,center) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
        return { vars = {center.ability.extra.mult, center.ability.extra.x_mult} }
    end
}

SMODS.Joker {
    key = "mermaidjoker",
    loc_txt = {
        name = "Mermaid",                                --name used by the joker
        text = {
            "swaps between giving you",
            "{C:mult}+4 mult{} and {C:chips}+40 chips",
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        }
    },
    config = { extra = { mult = 4, x_mult = 0, chips = 40} },  --variables used for abilities and effects.
    pos = { x = 9, y = 1 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
    rarity = 1,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 2,                                       --cost to buy the joker in shops
    blueprint_compat = true,                        --doses joker work with blueprint
    eternal_compat = true,                          --can joker be eternal
    unlocked = true,                                --joker is unlocked by default
    discovered = true,                              --joker is discovered dby default
    atlas = 'jokersheet',                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
    soul_pos = nil,                                 --pos of a soul sprite.

    calculate = function(self, context, card)             --define calculate functions here
        local swap
        if swap == nil then
            swap = 0
        end
        if SMODS.end_calculate_context(context) then
            if swap == 0 then
                swap = 1
                return {
                    mult_mod = card.ability.extra.mult,
                    card = self,
                    message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
                }
            else
                swap = 0
                return {
                    chip_mod = self.ability.extra.chips,
                    card = self,
                    message = localize { type = 'variable', key = 'a_mult', vars = { self.ability.extra.chips } }
                }
            end
        end
    end,

    loc_vars = function(self,info_queue,center) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
        return { vars = {center.ability.extra.mult, center.ability.extra.x_mult, center.ability.extra.chips} }
    end
}

SMODS.Joker {
    key = "decorationjoker",
    loc_txt = {
        name = "Figurehead",                                --name used by the joker
        text = {
            "{X:red,C:white}X2{} mult on the first hand",
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        }
    },
    config = { extra = { mult = 4, x_mult = 2 } },  --variables used for abilities and effects.
    pos = { x = 10, y = 1 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
    rarity = 3,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 5,                                       --cost to buy the joker in shops
    blueprint_compat = true,                        --doses joker work with blueprint
    eternal_compat = true,                          --can joker be eternal
    unlocked = true,                                --joker is unlocked by default
    discovered = true,                              --joker is discovered dby default
    atlas = 'jokersheet',                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
    soul_pos = nil,                                 --pos of a soul sprite.

    calculate = function(self, context, card)             --define calculate functions here
        if SMODS.end_calculate_context(context) and G.GAME.current_round.hands_played == 0 then
            return{
                Xmult_mod = card.ability.extra.x_mult,
                card = self,
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } }
            }
        end
    end,

    loc_vars = function(self,info_queue,center) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
        return { vars = {center.ability.extra.mult, center.ability.extra.x_mult} }
    end
}

SMODS.Joker {
    key = "rumjoker",
    loc_txt = {
        name = "Rum",                                --name used by the joker
        text = {
            "does nothing{C:inactive}?{}",
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        }
    },
    config = { extra = { mult = 4, x_mult = 2 } },  --variables used for abilities and effects.
    pos = { x = 11, y = 1 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
    rarity = 3,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 1,                                       --cost to buy the joker in shops
    blueprint_compat = true,                        --doses joker work with blueprint
    eternal_compat = true,                          --can joker be eternal
    unlocked = true,                                --joker is unlocked by default
    discovered = true,                              --joker is discovered dby default
    atlas = 'jokersheet',                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
    soul_pos = nil,                                 --pos of a soul sprite.

    calculate = function(self, context, card)             --define calculate functions here

    end,

    loc_vars = function(self,info_queue,center) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
        return { vars = {center.ability.extra.mult, center.ability.extra.x_mult} }
    end
}

SMODS.Joker {
    key = "islandjoker",
    loc_txt = {
        name = "Island",                                --name used by the joker
        text = {
            "{C:attention}retrigger{} all cards based on how many cards were scored so far",
            "{C:inactive}(ie if 3 cards scored, the first will retrigger once{}",
            "{C:inactive}the second will retrigger twice, the third will retrigger thrice)",
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        }
    },
    config = { extra = { mult = 4, x_mult = 2 } },  --variables used for abilities and effects.
    pos = { x = 12, y = 1 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
    rarity = 3,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 8,                                       --cost to buy the joker in shops
    blueprint_compat = true,                        --doses joker work with blueprint
    eternal_compat = true,                          --can joker be eternal
    unlocked = true,                                --joker is unlocked by default
    discovered = true,                              --joker is discovered dby default
    atlas = 'jokersheet',                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
    soul_pos = nil,                                 --pos of a soul sprite.

    calculate = function(self,card, context)             --define calculate functions here
        local scored_tally = 0
        if context.repetition then
            if context.cardarea == G.play then
                scored_tally = scored_tally + 1
                return {
                    message = localize('k_again_ex'),
                    repetitions = scored_tally,
                    card = card
                }
            end
        end
        if SMODS.end_calculate_context(context) then
            scored_tally = 0
        end
    end,

    loc_vars = function(self,info_queue,center) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
        return { vars = {center.ability.extra.mult, center.ability.extra.x_mult,center.ability.extra.repetitions} }
    end
}

SMODS.Joker {
    key = "flagjoker",
    loc_txt = {
        name = "Flag",                                --name used by the joker
        text = {
            "{C:mult}1 mult{} per each 5 cards remaining in {C:attention}deck{}",
            "{C:inactive}(currently gives #1# mult){}",
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        }
    },
    config = { extra = { mult = 0, x_mult = 2 } },  --variables used for abilities and effects.
    pos = { x = 13, y = 1 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
    rarity = 2,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 6,                                       --cost to buy the joker in shops
    blueprint_compat = true,                        --doses joker work with blueprint
    eternal_compat = true,                          --can joker be eternal
    unlocked = true,                                --joker is unlocked by default
    discovered = true,                              --joker is discovered dby default
    atlas = 'jokersheet',                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
    soul_pos = nil,                                 --pos of a soul sprite.

    calculate = function(self, context, card)             --define calculate functions here
        card.ability.extra.mult = math.floor(#G.deck.cards / 5)
        if SMODS.end_calculate_context(context) then
            return{
                mult_mod = card.ability.extra.mult,
                card = self,
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
            }
        end
    end,

    loc_vars = function(self,info_queue,center) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
        return { vars = {center.ability.extra.mult, center.ability.extra.x_mult} }
    end
}

SMODS.Joker {
    key = "jbeardjoker",
    loc_txt = {
        name = "Cap'n J-Beard",                                --name used by the joker
        text = {
            "{X:red,C:white}+X0.2{} mult per each {C:attention}joker{}",
            "{C:inactive}(currently gives {}{X:red,C:white}X#2#{}{C:inactive} mult){}",
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        }
    },
    config = { extra = { mult = 0, x_mult = 1 } },  --variables used for abilities and effects.
    pos = { x = 14, y = 1 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
    rarity = 3,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
    cost = 7,                                       --cost to buy the joker in shops
    blueprint_compat = true,                        --doses joker work with blueprint
    eternal_compat = true,                          --can joker be eternal
    unlocked = true,                                --joker is unlocked by default
    discovered = true,                              --joker is discovered dby default
    atlas = 'jokersheet',                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
    soul_pos = nil,                                 --pos of a soul sprite.

    calculate = function(self, context, card)             --define calculate functions here
        card.ability.extra.x_mult = 1
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].ability.set == 'Joker' then card.ability.extra.x_mult = card.ability.extra.x_mult + 0.2 end
        end
        if SMODS.end_calculate_context(context) then
            return{
                Xmult_mod = card.ability.extra.x_mult,
                card = self,
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.x_mult } }
            }
        end
    end,

    loc_vars = function(self,info_queue,center) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
        return { vars = {center.ability.extra.mult, center.ability.extra.x_mult} }
    end
}

----------------------------------------------
------------MOD CODE END----------------------
