--- STEAMODDED HEADER
--- MOD_NAME: BBBalatro
--- MOD_ID: BBBalatro
--- MOD_AUTHOR: [B]
--- MOD_DESCRIPTION: The Jonkler collection

----------------------------------------------
------------MOD CODE -------------------------

local jokers = {
    baldjoker = {                                           --slug used by the joker.
        name = "Bald Joker",                                --name used by the joker
        text = {
            "{C:mult}+2 mult{} for every scored card",             --description text.		
            "without an {C:attention}enhancement{}",         --you can add as many lines as you want
            "{C:inactive}(jonkler){}"                       --more than 5 lines look odd
        },
        config = { extra = { mult = 0, x_mult = 0 } }, --variables used for abilities and effects.
        pos = { x = 0, y = 0 },                             --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
        rarity = 1,                                         --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
        cost = 5,                                           --cost to buy the joker in shops
        blueprint_compat = true,                            --does joker work with blueprint
        eternal_compat = true,                              --can joker be eternal
        unlocked = true,                                    --joker is unlocked by default
        discovered = true,                                  --joker is discovered by default
        effect = 'Mult',                                    --you can specify an effect here eg. 'Mult'
        atlas = nil,                                        --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
        soul_pos = nil,                                     --pos of a soul sprite.

        calculate = function(self, context)                 --define calculate functions here
            if context.individual and context.cardarea == G.play then
                if context.other_card.ability.effect ~= 'Mult Card' and context.other_card.ability.effect ~= 'Bonus Card' and context.other_card.ability.effect ~= 'Wild Card' and context.other_card.ability.effect ~= 'Glass Card' and context.other_card.ability.effect ~= 'Steel Card' and context.other_card.ability.effect ~= 'Gold Card' and context.other_card.ability.effect ~= 'Lucky Card' and context.other_card.ability.effect ~= 'Stone Card' then
                    return {
                        mult = 2,
                        card = self,
                        message = localize { type = 'variable', key = 'a_mult', vars = { self.ability.extra.mult } },
                    }
                end
            end
        end,

        loc_def = function(self) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
            return { self.ability.extra.mult, self.ability.extra.x_mult }
        end,
    },

    --[add more jokers here]

    wokerjoker = {                                 --slug used by the joker.
        name = "Woker",                            --name used by the joker
        text = {
            "All scored {C:attention}Face{} cards", --description text.		
            "become {C:attention}Queens{}",        --you can add as many lines as you want
            "{C:inactive}(jonkler){}"              --more than 5 lines look odd
        },
        config = { extra = { mult = 0, x_mult = 0 } }, --variables used for abilities and effects.
        pos = { x = 0, y = 0 },                    --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
        rarity = 3,                                --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
        cost = 7,                                  --cost to buy the joker in shops
        blueprint_compat = false,                  --does joker work with blueprint
        eternal_compat = true,                     --can joker be eternal
        unlocked = true,                           --joker is unlocked by default
        discovered = true,                         --joker is discovered by default
        atlas = nil,                               --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
        soul_pos = nil,                            --pos of a soul sprite.

        calculate = function(self, context)        --define calculate functions here
            if context.individual and context.cardarea == G.play then
                if context.other_card:get_id() == 11 or context.other_card:get_id() == 13 or next(find_joker("Pareidolia")) then
                    local suit_prefix = string.sub(context.other_card.base.suit, 1, 1) .. '_'
                    context.other_card:set_base(G.P_CARDS[suit_prefix .. 'Q'])
                    return {
                        message = localize { "Wokified" }
                    }
                end
            end
        end,

        loc_def = function(self) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
            return { self.ability.extra.mult, self.ability.extra.x_mult }
        end,
    },

    brokejoker = {                                     --slug used by the joker.
        name = "Broker",                                --name used by the joker
        text = {
            "gives {X:red,C:white}X2 Mult{} if",               --description text.		
            "you have {C:money}0${} or less", --you can add as many lines as you want
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        },
        config = { extra = { mult = 0, x_mult = 2 } },  --variables used for abilities and effects.
        pos = { x = 0, y = 0 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
        rarity = 2,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
        cost = 6,                                       --cost to buy the joker in shops
        blueprint_compat = true,                        --doses joker work with blueprint
        eternal_compat = true,                          --can joker be eternal
        unlocked = true,                                --joker is unlocked by default
        discovered = true,                              --joker is discovered by default
        atlas = nil,                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
        soul_pos = nil,                                 --pos of a soul sprite.

        calculate = function(self, context)             --define calculate functions here
            if SMODS.end_calculate_context(context) then
                if G.GAME.dollars <= 0 then
                    return {
                        Xmult_mod = self.ability.extra.x_mult,
                        card = self,
                        message = localize { type = 'variable', key = 'a_xmult', vars = { self.ability.extra.x_mult } }
                    }
                end
            end
        end,

        loc_def = function(self) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
            return { self.ability.extra.mult, self.ability.extra.xmult }
        end
    },

    blokejoker = {                                     --slug used by the joker.
        name = "Bloker",                                --name used by the joker
        text = {
            "{C:mult}+1 mult{} for each scored with a {C:attention}suit{}",               --description text.		
            "and/or {C:attention}rank{} thats contains a {C:attention}T{}", --you can add as many lines as you want
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        },
        config = { extra = { mult = 0, x_mult = 0, min = 0.5, max = 2 } },  --variables used for abilities and effects.
        pos = { x = 0, y = 0 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
        rarity = 1,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
        cost = 4,                                       --cost to buy the joker in shops
        blueprint_compat = true,                        --doses joker work with blueprint
        eternal_compat = true,                          --can joker be eternal
        unlocked = true,                                --joker is unlocked by default
        discovered = true,                              --joker is discovered by default
        atlas = nil,                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
        soul_pos = nil,                                 --pos of a soul sprite.

        calculate = function(self, context)             --define calculate functions here
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

        loc_def = function(self) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
            return { self.ability.extra.mult, self.ability.extra.xmult }
        end
    },

    strokejoker = {                                     --slug used by the joker.
        name = "Stroker",                                --name used by the joker
        text = {
            "{X:red,C:white}X0.5-2 mult{}",               --description text.		
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        },
        config = { extra = { mult = 0, x_mult = 0, min = 5, max = 20 } },  --variables used for abilities and effects.
        pos = { x = 0, y = 0 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
        rarity = 1,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
        cost = 3,                                       --cost to buy the joker in shops
        blueprint_compat = true,                        --doses joker work with blueprint
        eternal_compat = true,                          --can joker be eternal
        unlocked = true,                                --joker is unlocked by default
        discovered = true,                              --joker is discovered by default
        atlas = nil,                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
        soul_pos = nil,                                 --pos of a soul sprite.

        calculate = function(self, context)             --define calculate functions here   
            if SMODS.end_calculate_context(context) then
                return {
                    Xmult_mod = pseudorandom('strokejoker', self.ability.extra.min, self.ability.extra.max)*0.1,
                    message = localize { "Stroked" }
                }
            end
        end,

        loc_def = function(self) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
            return { self.ability.extra.mult, self.ability.extra.xmult, self.ability.extra.min, self.ability.extra.max }
        end
    },

    binaryjoker = {                                     --slug used by the joker.
        name = "Binary",                                --name used by the joker
        text = {
            "{C:green}#4# in #3#{} chance of",               --description text.		
            "{X:red,C:white}X2 mult{} whenever a {C:attention}10{} is played", --you can add as many lines as you want
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        },
        config = { extra = { mult = 0, x_mult = 2, odds = 2, normal = 1 } },  --variables used for abilities and effects.
        pos = { x = 0, y = 0 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
        rarity = 3,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
        cost = 10,                                       --cost to buy the joker in shops
        blueprint_compat = true,                        --doses joker work with blueprint
        eternal_compat = true,                          --can joker be eternal
        unlocked = true,                                --joker is unlocked by default
        discovered = true,                              --joker is discovered by default
        atlas = nil,                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
        soul_pos = nil,                                 --pos of a soul sprite.

        calculate = function(self, context)             --define calculate functions here   
            if context.individual and context.cardarea == G.play then
                if context.other_card:get_id() == 10 then
                    if pseudorandom('binaryjoker') < G.GAME.probabilities.normal/self.ability.extra.odds then
                        return {
                            x_mult = self.ability.extra.x_mult,
                            card = self
                        }
                    end
                end
            end     
        end,

        loc_def = function(self) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
            return { self.ability.extra.mult, self.ability.extra.xmult, self.ability.extra.odds, G.GAME and G.GAME.probabilities.normal or 1  }
        end
    },

    blindjoker = {                                     --slug used by the joker.
        name = "Blind Joker",                                --name used by the joker
        text = {
            "{C:mult}+Y mult{} every time you choose a blind",               --description text.	
            "{C:inactive}(Y = ante, currently gives #1#){}", --you can add as many lines as you want
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        },
        config = { extra = { mult = 0, x_mult = 2 } },  --variables used for abilities and effects.
        pos = { x = 0, y = 0 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
        rarity = 2,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
        cost = 4,                                       --cost to buy the joker in shops
        blueprint_compat = true,                        --doses joker work with blueprint
        eternal_compat = true,                          --can joker be eternal
        unlocked = true,                                --joker is unlocked by default
        discovered = true,                              --joker is discovered by default
        atlas = nil,                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
        soul_pos = nil,                                 --pos of a soul sprite.

        calculate = function(self, context)             --define calculate functions here
            if context.setting_blind and not self.getting_sliced then
                self.ability.extra.mult = self.ability.extra.mult + G.GAME.round_resets.ante
            end
            if SMODS.end_calculate_context(context) then
                return {
                    mult_mod = self.ability.extra.mult,
                    card = self,
                    message = localize { type = 'variable', key = 'a_mult', vars = { self.ability.extra.mult } }
                }
            end
        end,

        loc_def = function(self) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
            return { self.ability.extra.mult, self.ability.extra.xmult, G.GAME.round_resets.ante  }
        end
    },

    brailjoker = {                                     --slug used by the joker.
        name = "Braille Joker",                                --name used by the joker
        text = {
            "lowers {C:chips}blind{} by {C:attention}25%{}",               --description text.	
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        },
        config = { extra = { mult = 0, x_mult = 2 } },  --variables used for abilities and effects.
        pos = { x = 0, y = 0 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
        rarity = 3,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
        cost = 6,                                       --cost to buy the joker in shops
        blueprint_compat = false,                        --doses joker work with blueprint
        eternal_compat = true,                          --can joker be eternal
        unlocked = true,                                --joker is unlocked by default
        discovered = true,                              --joker is discovered by default
        atlas = nil,                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
        soul_pos = nil,                                 --pos of a soul sprite.

        calculate = function(self, context)             --define calculate functions here
            if context.setting_blind and not self.getting_sliced then
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

        loc_def = function(self) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
            return { self.ability.extra.mult, self.ability.extra.xmult }
        end
    },

    deafjoker = {                                     --slug used by the joker.
        name = "Deaf Joker",                                --name used by the joker
        text = {
            "{C:mult}+5 mult{} for each {C:chips}hand{} played this round",               --description text.	
            "{C:inactive}(currently gives +#1# mult){}", --you can add as many lines as you want
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        },
        config = { extra = { mult = 5, x_mult = 2 } },  --variables used for abilities and effects.
        pos = { x = 0, y = 0 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
        rarity = 1,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
        cost = 5,                                       --cost to buy the joker in shops
        blueprint_compat = true,                        --doses joker work with blueprint
        eternal_compat = true,                          --can joker be eternal
        unlocked = true,                                --joker is unlocked by default
        discovered = true,                              --joker is discovered by default
        atlas = nil,                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
        soul_pos = nil,                                 --pos of a soul sprite.

        calculate = function(self, context)             --define calculate functions here
            if SMODS.end_calculate_context(context) then
                self.ability.extra.mult = (self.ability.extra.mult + 5) or 0
                return {
                    mult_mod = (self.ability.extra.mult - 5) or 0,
                    card = self,
                    message = localize { type = 'variable', key = 'a_mult', vars = { (self.ability.extra.mult - 5) or 0 } },
                }
            elseif context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
                self.ability.extra.mult = 5
            end
        end,
    },

    diamondskyjoker = {                                     --slug used by the joker.
        name = "Joker in the Sky with Diamonds",                                --name used by the joker
        text = {
            "{C:money}1${} per each",               --description text.	
            "{C:attention}diamond{} card held in hand", --you can add as many lines as you want
            "{C:inactive}(jonkler made by alr alr alr bye){}"                   --more than 5 lines look odd
        },
        config = { extra = { mult = 5, x_mult = 2 } },  --variables used for abilities and effects.
        pos = { x = 0, y = 0 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
        rarity = 2,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
        cost = 6,                                       --cost to buy the joker in shops
        blueprint_compat = false,                        --doses joker work with blueprint
        eternal_compat = true,                          --can joker be eternal
        unlocked = true,                                --joker is unlocked by default
        discovered = true,                              --joker is discovered by default
        atlas = nil,                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
        soul_pos = nil,                                 --pos of a soul sprite.

        calculate = function(self, context)             --define calculate functions here
            if context.individual and context.cardarea == G.hand then
                if context.other_card.base.suit == 'Diamonds' then
                    ease_dollars(1)
                end
            end
        end,

        loc_def = function(self) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
            return { self.ability.extra.mult, self.ability.extra.xmult }
        end,
    },

    zipperjoker = {                                     --slug used by the joker.
        name = "Split joker",                                --name used by the joker
        text = {
            "played {C:attention}pairs{}, {C:attention}two pairs{} and {C:attention}4 of a kinds{}",               --description text.	
            "split into the {C:attention}2{} closest numbers", --you can add as many lines as you want
            "{C:inactive}(ie. pair of 9s would turn into 8 and 10){}",
            "{C:inactive}(jonkler made by alr alr alr bye){}"                   --more than 5 lines look odd
        },
        config = { extra = { mult = 5, x_mult = 2, flip = 1 } },  --variables used for abilities and effects.
        pos = { x = 0, y = 0 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
        rarity = 2,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
        cost = 5,                                       --cost to buy the joker in shops
        blueprint_compat = false,                        --doses joker work with blueprint
        eternal_compat = true,                          --can joker be eternal
        unlocked = true,                                --joker is unlocked by default
        discovered = true,                              --joker is discovered by default
        atlas = nil,                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
        soul_pos = nil,                                 --pos of a soul sprite.

        calculate = function(self, context)             --define calculate functions here
            if self.ability.extra.flip == nil then
                self.ability.extra.flip = 1
            end
            if context.individual and context.cardarea == G.play then
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
                    if self.ability.extra.flip > 0 then
                        self.ability.extra.flip = self.ability.extra.flip - 2
                    else
                        self.ability.extra.flip = self.ability.extra.flip + 2
                    end
                    return {
                        message = localize { "Split!" }
                    }
                end
            end
        end,

        loc_def = function(self) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
            return { self.ability.extra.mult, self.ability.extra.xmult, self.ability.extra.flip }
        end,
    },

    stonerjoker = { --slug used by the joker.
       name = "Stoner",--name used by the joker
       text = {
           "{C:green}#3# in #4#{} chance of {C:mult}+1 discard{}",--description text.		
           "if you discard exactly {C:attention}5 cards{}",--you can add as many lines as you want
           "{C:inactive}(jonkler made by agentcheese){}"
       },
       config = {extra={mult=5, x_mult=2, odds = 3, discard_tally = 0, card_tally = 0}}, --variables used for abilities and effects.
       pos = { x = 0, y = 0 }, --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
       rarity=1, --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
       cost = 4, --cost to buy the joker in shops
       blueprint_compat=false, --does joker work with blueprint
       eternal_compat=true, --can joker be eternal
       unlocked=true, --joker is unlocked by default
       discovered=true, --joker is discovered by default
       effect=nil, --you can specify an effect here eg. 'Mult'
       atlas=nil, --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
       soul_pos=nil, --pos of a soul sprite.

       calculate = function(self,context) --define calculate functions here\
            if self.ability.card_tally == nil then
                self.ability.card_tally = 0
            end
            if context.discard and context.other_card == context.full_hand[#context.full_hand] then --Example calculate: If not debuffed cards are discarded, gain 1$ for every card
                for k, v in ipairs(context.full_hand) do
                    self.ability.extra.card_tally = self.ability.extra.card_tally + 1
                end
                if self.ability.extra.card_tally == 5 and pseudorandom('stoner') < G.GAME.probabilities.normal/self.ability.extra.odds then
                    ease_discard(1)
                    self.ability.extra.card_tally = 0
                end
            end
        end,

       loc_def = function(self) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
           return { self.ability.extra.mult, self.ability.extra.x_mult, G.GAME.probabilities.normal, self.ability.extra.odds, self.ability.extra.card_tally }
       end, 
    },

    thiefjoker = {                                     --slug used by the joker.
        name = "Thief",                                --name used by the joker
        text = {
            "gains {X:red,C:white}+X0.2 mult{} every played hand",               --description text.	
            "{C:money}-3${} every played hand", --you can add as many lines as you want
            "{C:inactive}(currently gives X#2# mult){}",
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        },
        config = { extra = { mult = 0, x_mult = 1.2 } },  --variables used for abilities and effects.
        pos = { x = 0, y = 0 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
        rarity = 3,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
        cost = 2,                                       --cost to buy the joker in shops
        blueprint_compat = true,                        --doses joker work with blueprint
        eternal_compat = true,                          --can joker be eternal
        unlocked = true,                                --joker is unlocked by default
        discovered = true,                              --joker is discovered by default
        atlas = nil,                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
        soul_pos = nil,                                 --pos of a soul sprite.

        calculate = function(self, context)             --define calculate functions here
            if SMODS.end_calculate_context(context) then
                ease_dollars(-3)
                self.ability.extra.x_mult = self.ability.extra.x_mult + 0.2
                return {
                    Xmult_mod = self.ability.extra.x_mult-0.2,
                    card = self,
                    message = localize { type = 'variable', key = 'a_xmult', vars = { self.ability.extra.x_mult-0.2 } }
                }
            end
        end,

        loc_def = function(self) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
            return { self.ability.extra.mult, self.ability.extra.x_mult }
        end
    },

    realsquarejoker = {                                     --slug used by the joker.
        name = "Actually square joker",                                --name used by the joker
        text = {
            "Multiplies {C:chips}chips{} by itself",               --description text.	
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        },
        config = { extra = { mult = 0, x_mult = 1.2 } },  --variables used for abilities and effects.
        pos = { x = 0, y = 0 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
        rarity = 3,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
        cost = 16,                                       --cost to buy the joker in shops
        blueprint_compat = true,                        --doses joker work with blueprint
        eternal_compat = true,                          --can joker be eternal
        unlocked = true,                                --joker is unlocked by default
        discovered = true,                              --joker is discovered by default
        atlas = nil,                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
        soul_pos = nil,                                 --pos of a soul sprite.

        calculate = function(self, context)             --define calculate functions here
            if SMODS.end_calculate_context(context) then
                self.ability.extra.chips = hand_chips or 0
                return {
                    chip_mod = (self.ability.extra.chips*self.ability.extra.chips - hand_chips) or 0,
                    card = self,
                    message = localize { type = 'variable', key = 'a_chips_minus', vars = { (self.ability.extra.chips*self.ability.extra.chips) or 0 } }
                }
            end
        end,

        loc_def = function(self) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
            return { self.ability.extra.mult, self.ability.extra.x_mult, self.ability.extra.chips }
        end
    },

    outlinejoker = {                                     --slug used by the joker.
        name = "Outline",                                --name used by the joker
        text = {
            "If played hand is 1 {C:attention}wild{} card,",               --description text.	
            "{C:attention}split{} it into the {C:attention}4{} suits",
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        },
        config = { extra = { mult = 0, x_mult = 1.2, card_tally = 0 } },  --variables used for abilities and effects.
        pos = { x = 0, y = 0 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
        rarity = 2,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
        cost = 5,                                       --cost to buy the joker in shops
        blueprint_compat = false,                        --doses joker work with blueprint
        eternal_compat = true,                          --can joker be eternal
        unlocked = true,                                --joker is unlocked by default
        discovered = true,                              --joker is discovered by default
        atlas = nil,                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
        soul_pos = nil,                                 --pos of a soul sprite.

        calculate = function(self, context)             --define calculate functions here
            if context.individual and context.cardarea == G.play then
                for k, v in ipairs(context.full_hand) do
                    self.ability.extra.card_tally = self.ability.extra.card_tally + 1
                end
                if self.ability.extra.card_tally == 1 and context.other_card.ability.effect == 'Wild Card' then
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
                            self.ability.extra.card_tally = 0
                end
            end
        end,

        loc_def = function(self) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
            return { self.ability.extra.mult, self.ability.extra.x_mult, self.ability.extra.card_tally }
        end
    }
}

function SMODS.INIT.BBBalatro()
    --localization for the info queue key
    G.localization.descriptions.Other["your_key"] = {
        name = "Example", --tooltip name
        text = {
            "TEXT L1",   --tooltip text.		
            "TEXT L2",   --you can add as many lines as you want
            "TEXT L3"    --more than 5 lines look odd
        }
    }
    init_localization()

    --Create and register jokers
    for k, v in pairs(jokers) do --for every object in 'jokers'
        local joker = SMODS.Joker:new(v.name, k, v.config, v.pos, { name = v.name, text = v.text }, v.rarity, v.cost,
            v.unlocked, v.discovered, v.blueprint_compat, v.eternal_compat, v.effect, v.atlas, v.soul_pos)
        joker:register()

        if not v.atlas then --if atlas=nil then use single sprites. In this case you have to save your sprite as slug.png (for example j_examplejoker.png)
            SMODS.Sprite:new("j_" .. k, SMODS.findModByID("BBBalatro").path, "j_" .. k .. ".png", 71, 95, "asset_atli")
                :register()
        end

        --add jokers calculate function:
        SMODS.Jokers[joker.slug].calculate = v.calculate
        --add jokers loc_def:
        SMODS.Jokers[joker.slug].loc_def = v.loc_def
        --if tooltip is present, add jokers tooltip
        if (v.tooltip ~= nil) then
            SMODS.Jokers[joker.slug].tooltip = v.tooltip
        end
    end
    --Create sprite atlas
    SMODS.Sprite:new("youratlasname", SMODS.findModByID("BBBalatro").path, "example.png", 71, 95, "asset_atli")
        :register()
end

----------------------------------------------
------------MOD CODE END----------------------
