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
            "{C:mult}+#1# mult{} for every scored card",             --description text.		
            "without an {C:attention}enhancement{}",         --you can add as many lines as you want
            "{C:inactive}(jonkler){}"                       --more than 5 lines look odd
        },
        config = { extra = { mult = 2, x_mult = 0 } }, --variables used for abilities and effects.
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
                        mult = self.ability.extra.mult,
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
            if context.individual and context.cardarea == G.play and not context.blueprint then
                if context.other_card:get_id() == 11 or context.other_card:get_id() == 13 or next(find_joker("Pareidolia")) then
                    local suit_prefix = SMODS.Suits[context.other_card.base.suit].card_key .. '_'
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
            "gives {X:red,C:white}X#2#{} mult if",               --description text.		
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
            return { self.ability.extra.mult, self.ability.extra.x_mult }
        end
    },

    blokejoker = {                                     --slug used by the joker.
        name = "Bloker",                                --name used by the joker
        text = {
            "{C:mult}+#1# mult{} for each scored with a {C:attention}suit{}",               --description text.		
            "and/or {C:attention}rank{} thats contains a {C:attention}T{}", --you can add as many lines as you want
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        },
        config = { extra = { mult = 1, x_mult = 0, min = 0.5, max = 2 } },  --variables used for abilities and effects.
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
                            mult = self.ability.extra.mult*2,
                            card = self
                        }
                    else
                        return {
                            mult = self.ability.extra.mult,
                            card = self
                        }
                    end
                elseif context.other_card:get_id() == 2 or context.other_card:get_id() == 3 or context.other_card:get_id() == 8 or context.other_card:get_id() == 10 and context.other_card.ability.effect ~= 'Stone Card' then
                    return {
                        mult = self.ability.extra.mult,
                        card = self
                    }
                end
            end
        end,

        loc_def = function(self) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
            return { self.ability.extra.mult, self.ability.extra.x_mult }
        end
    },

    strokejoker = {                                     --slug used by the joker.
        name = "Stroker",                                --name used by the joker
        text = {
            "{X:red,C:white}X#3#-#4#{} mult",               --description text.		
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        },
        config = { extra = { mult = 0, x_mult = 0, min = 0.5, max = 2 } },  --variables used for abilities and effects.
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
                    Xmult_mod = pseudorandom('strokejoker', self.ability.extra.min, self.ability.extra.max),
                    message = localize { "Stroked" }
                }
            end
        end,

        loc_def = function(self) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
            return { self.ability.extra.mult, self.ability.extra.x_mult, self.ability.extra.min, self.ability.extra.max }
        end
    },

    binaryjoker = {                                     --slug used by the joker.
        name = "Binary",                                --name used by the joker
        text = {
            "{C:green}#4# in #3#{} chance of",               --description text.		
            "{X:red,C:white}X#2# mult{} whenever a {C:attention}10{} is played", --you can add as many lines as you want
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
            return { self.ability.extra.mult, self.ability.extra.x_mult, self.ability.extra.odds, G.GAME and G.GAME.probabilities.normal or 1  }
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
            if context.setting_blind and not self.getting_sliced and not context.blueprint then
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
            return { self.ability.extra.mult, self.ability.extra.x_mult, G.GAME.round_resets.ante  }
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

        loc_def = function(self) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
            return { self.ability.extra.mult, self.ability.extra.x_mult }
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
            if self.ability.extra.mult == nil then
                self.ability.extra.mult = 0
            end
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

        loc_def = function(self) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
            return { self.ability.extra.mult, self.ability.extra.x_mult }
        end,
    },

    diamondskyjoker = {                                     --slug used by the joker.
        name = "Joker in the Sky with Diamonds",                                --name used by the joker
        text = {
            "{C:money}#3#${} per each",               --description text.	
            "{C:attention}diamond{} card held in hand", --you can add as many lines as you want
            "{C:inactive}(jonkler made by alr alr alr bye){}"                   --more than 5 lines look odd
        },
        config = { extra = { mult = 5, x_mult = 2, cash = 1 } },  --variables used for abilities and effects.
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
            if context.individual and context.cardarea == G.hand then
                if context.other_card.base.suit == 'Diamonds' then
                    ease_dollars(self.ability.extra.cash)
                end
            end
        end,

        loc_def = function(self) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
            return { self.ability.extra.mult, self.ability.extra.x_mult, self.ability.extra.cash }
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
            if context.individual and context.cardarea == G.play and not context.blueprint then
                if next(context.poker_hands["Pair"]) or next(context.poker_hands["Four Of A Kind"]) or next(context.poker_hands["Two Pair"]) then
                    local suit_prefix = SMODS.Suits[context.other_card.base.suit].card_key .. '_'
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
            return { self.ability.extra.mult, self.ability.extra.x_mult, self.ability.extra.flip }
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
            if context.discard and context.other_card == context.full_hand[#context.full_hand] and not context.blueprint then --Example calculate: If not debuffed cards are discarded, gain 1$ for every card
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
            "gains {X:red,C:white}+X#3#{} mult every played hand",               --description text.	
            "{C:money}-3${} every played hand", --you can add as many lines as you want
            "{C:inactive}(currently gives {}{X:red,C:white}X#2#{}{C:inactive} mult){}",
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        },
        config = { extra = { mult = 0, x_mult = 1.2, xmultadd = 0.2 } },  --variables used for abilities and effects.
        pos = { x = 0, y = 0 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
        rarity = 2,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
        cost = 1,                                       --cost to buy the joker in shops
        blueprint_compat = true,                        --doses joker work with blueprint
        eternal_compat = true,                          --can joker be eternal
        unlocked = true,                                --joker is unlocked by default
        discovered = true,                              --joker is discovered by default
        atlas = nil,                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
        soul_pos = nil,                                 --pos of a soul sprite.

        calculate = function(self, context)             --define calculate functions here
            if SMODS.end_calculate_context(context) then
                ease_dollars(-3)
                self.ability.extra.x_mult = self.ability.extra.x_mult + self.ability.extra.xmultadd
                return {
                    Xmult_mod = self.ability.extra.x_mult-self.ability.extra.xmultadd,
                    card = self,
                    message = localize { type = 'variable', key = 'a_xmult', vars = { self.ability.extra.x_mult-self.ability.extra.xmultadd } }
                }
            end
        end,

        loc_def = function(self) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
            return { self.ability.extra.mult, self.ability.extra.x_mult, self.ability.extra.xmultadd }
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
                    chip_mod = (self.ability.extra.chips*self.ability.extra.chips - (hand_chips or 0)) or 0,
                    card = self,
                    message = localize { type = 'variable', key = 'a_chips', vars = { (self.ability.extra.chips*self.ability.extra.chips) or 0 } }
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
        blueprint_compat = true,                        --doses joker work with blueprint
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
    },

    rajoker = {                                     --slug used by the joker.
        name = "Ra",                                --name used by the joker
        text = {
            "Gives {C:chips}chip{} value as {C:mult}mult{}",               --description text.	
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        },
        config = { extra = { mult = 0, x_mult = 1.2 } },  --variables used for abilities and effects.
        pos = { x = 0, y = 0 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
        rarity = 3,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
        cost = 6,                                       --cost to buy the joker in shops
        blueprint_compat = true,                        --doses joker work with blueprint
        eternal_compat = true,                          --can joker be eternal
        unlocked = true,                                --joker is unlocked by default
        discovered = true,                              --joker is discovered by default
        atlas = nil,                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
        soul_pos = nil,                                 --pos of a soul sprite.

        calculate = function(self, context)             --define calculate functions here
            if SMODS.end_calculate_context(context) then
                return {
                    mult_mod = hand_chips,
                    card = self,
                    message = localize { type = 'variable', key = 'a_chips', vars = { hand_chips } }
                }
            end
        end,

        loc_def = function(self) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
            return { self.ability.extra.mult, self.ability.extra.x_mult }
        end
    },

    sandjoker = {                                     --slug used by the joker.
        name = "Hot sand",                                --name used by the joker
        text = {
            "gains {C:mult}#3# mult{} every {C:red}discard{} played,",               --description text.	
            "{C:inactive}(currently gives #1# mult){}",
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        },
        config = { extra = { mult = -20, x_mult = 1.2, multadd = 2 } },  --variables used for abilities and effects.
        pos = { x = 0, y = 0 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
        rarity = 1,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
        cost = 1,                                       --cost to buy the joker in shops
        blueprint_compat = true,                        --doses joker work with blueprint
        eternal_compat = true,                          --can joker be eternal
        unlocked = true,                                --joker is unlocked by default
        discovered = true,                              --joker is discovered by default
        atlas = nil,                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
        soul_pos = nil,                                 --pos of a soul sprite.

        calculate = function(self, context)             --define calculate functions here
            if context.discard and context.other_card == context.full_hand[#context.full_hand] and not context.blueprint then
                self.ability.extra.mult = self.ability.extra.mult + self.ability.extra.multadd
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
            return { self.ability.extra.mult, self.ability.extra.x_mult, self.ability.extra.multadd }
        end
    },

    sphinxjoker = {                                     --slug used by the joker.
        name = "Sphinx",                                --name used by the joker
        text = {
            "{C:attention}Stone{} cards retrigger",               --description text.	
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        },
        config = { extra = { mult = -20, x_mult = 1.2 } },  --variables used for abilities and effects.
        pos = { x = 0, y = 0 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
        rarity = 2,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
        cost = 5,                                       --cost to buy the joker in shops
        blueprint_compat = true,                        --doses joker work with blueprint
        eternal_compat = true,                          --can joker be eternal
        unlocked = true,                                --joker is unlocked by default
        discovered = true,                              --joker is discovered by default
        atlas = nil,                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
        soul_pos = nil,                                 --pos of a soul sprite.

        calculate = function(self, context)             --define calculate functions here
            if context.repetition then
                 if context.cardarea == G.play then
                    if context.other_card.ability.effect == "Stone Card" then
                        return {
                            message = localize('k_again_ex'),
                            repetitions = 1,
                            card = self
                        }
                    end
                end
            end
        end,

        loc_def = function(self) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
            return { self.ability.extra.mult, self.ability.extra.x_mult }
        end
    },

    yellowjoker = {                                     --slug used by the joker.
        name = "Yellow joker",                                --name used by the joker
        text = {
            "after each {C:attention}blind{}, set money to {C:money}14${}",               --description text.	
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        },
        config = { extra = { mult = -20, x_mult = 1.2 } },  --variables used for abilities and effects.
        pos = { x = 0, y = 0 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
        rarity = 2,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
        cost = 14,                                       --cost to buy the joker in shops
        blueprint_compat = false,                        --doses joker work with blueprint
        eternal_compat = true,                          --can joker be eternal
        unlocked = true,                                --joker is unlocked by default
        discovered = true,                              --joker is discovered dby default
        atlas = nil,                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
        soul_pos = nil,                                 --pos of a soul sprite.

        calculate = function(self, context)             --define calculate functions here
            if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
                G.GAME.dollars = 14
                return {
                    message = localize { "Reset" }
                }
            end
        end,

        loc_def = function(self) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
            return { self.ability.extra.mult, self.ability.extra.x_mult }
        end
    },

    sunjoker = {                                     --slug used by the joker.
        name = "The sun",                                --name used by the joker
        text = {
            "If your first hand is 1 {C:attention}Hearts{} card,",               --description text.	
            "destroy the played card",
            "and Create a {C:attention}'The sun'{} tarot card",
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        },
        config = { extra = { mult = -20, x_mult = 1.2, card_tally = 0 } },  --variables used for abilities and effects.
        pos = { x = 0, y = 0 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
        rarity = 2,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
        cost = 6,                                       --cost to buy the joker in shops
        blueprint_compat = true,                        --doses joker work with blueprint
        eternal_compat = true,                          --can joker be eternal
        unlocked = true,                                --joker is unlocked by default
        discovered = true,                              --joker is discovered dby default
        atlas = nil,                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
        soul_pos = nil,                                 --pos of a soul sprite.

        calculate = function(self, context)             --define calculate functions here
            if context.individual and context.cardarea == G.play and G.GAME.current_round.hands_played == 0 and not context.blueprint then
                for k, v in ipairs(context.full_hand) do
                    if v.base.suit == 'Hearts' then self.ability.extra.card_tally = self.ability.extra.card_tally + 1 end
                end
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit and self.ability.extra.card_tally == 1 then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.0,
                        func = (function()
                                local card = create_card(nil,G.consumeables, nil, nil, nil, nil, 'c_sun', 'sup')
                                card:add_to_deck()
                                G.consumeables:emplace(card)
                                G.GAME.consumeable_buffer = 0
                            return true
                        end)}))
                    card_eval_status_text(self, 'extra', nil, nil, nil, {message = "SUN", colour = G.C.PURPLE})
                    context.other_card:start_dissolve()
                end
                self.ability.extra.card_tally = 0
            end
        end,

        loc_def = function(self) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
            return { self.ability.extra.mult, self.ability.extra.x_mult, self.ability.extra.card_tally }
        end
    },

    hieroglyphjoker = {                                     --slug used by the joker.
        name = "Hieroglyph",                                --name used by the joker
        text = {
            "Gains {C:mult}+#3# mult{} per each {C:attention}ace{} played",               --description text.	
            "{C:inactive}(currently gives #1# mult){}",
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        },
        config = { extra = { mult = 0, x_mult = 1.2, multadd = 2 } },  --variables used for abilities and effects.
        pos = { x = 0, y = 0 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
        rarity = 2,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
        cost = 5,                                       --cost to buy the joker in shops
        blueprint_compat = true,                        --doses joker work with blueprint
        eternal_compat = true,                          --can joker be eternal
        unlocked = true,                                --joker is unlocked by default
        discovered = true,                              --joker is discovered dby default
        atlas = nil,                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
        soul_pos = nil,                                 --pos of a soul sprite.

        calculate = function(self, context)             --define calculate functions here
            if context.individual and context.cardarea == G.play and not context.blueprint then
                if context.other_card:get_id() == 14 then
                    self.ability.extra.mult = self.ability.extra.mult + self.ability.extra.multadd
                end
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
            return { self.ability.extra.mult, self.ability.extra.x_mult, self.ability.extra.multadd }
        end
    },

    mummyjoker = {                                     --slug used by the joker.
        name = "Mummy",                                --name used by the joker
        text = {
            "{C:mult}-#3# Mult{} for every card scored",               --description text.	
            "{C:inactive}(currently gives #1# mult){}",
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        },
        config = { extra = { mult = 20, x_mult = 1.2, multadd = 1 } },  --variables used for abilities and effects.
        pos = { x = 0, y = 0 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
        rarity = 1,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
        cost = 4,                                       --cost to buy the joker in shops
        blueprint_compat = true,                        --doses joker work with blueprint
        eternal_compat = true,                          --can joker be eternal
        unlocked = true,                                --joker is unlocked by default
        discovered = true,                              --joker is discovered dby default
        atlas = nil,                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
        soul_pos = nil,                                 --pos of a soul sprite.

        calculate = function(self, context)             --define calculate functions here
            if self.ability.extra.mult == nil then
                self.ability.extra.mult = 0
            end
            if self.ability.extra.mult <= 0 then
                play_sound('tarot1')
                self.T.r = -0.2
                self:juice_up(0.3, 0.4)
                self.states.drag.is = true
                self.children.center.pinch.x = true
                G.jokers:remove_card(self)
                self:remove()
                self = nil
            end
            if context.individual and context.cardarea == G.play then
                self.ability.extra.mult = (self.ability.extra.mult - self.ability.extra.multadd)
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
            return { self.ability.extra.mult, self.ability.extra.x_mult, self.ability.extra.multadd }
        end
    },

    pyramidjoker = {                                     --slug used by the joker.
        name = "Pyramid Joker",                                --name used by the joker
        text = {
            "Scored {C:attention}3{} cards {C:attention}retrigger #3#{} times",               --description text.	
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        },
        config = { extra = { mult = 20, x_mult = 1.2, rep = 3 } },  --variables used for abilities and effects.
        pos = { x = 0, y = 0 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
        rarity = 1,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
        cost = 5,                                       --cost to buy the joker in shops
        blueprint_compat = true,                        --doses joker work with blueprint
        eternal_compat = true,                          --can joker be eternal
        unlocked = true,                                --joker is unlocked by default
        discovered = true,                              --joker is discovered dby default
        atlas = nil,                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
        soul_pos = nil,                                 --pos of a soul sprite.

        calculate = function(self, context)             --define calculate functions here
            if context.repetition then
                if context.cardarea == G.play then
                   if context.other_card:get_id() == 3 then
                       return {
                           message = localize('k_again_ex'),
                           repetitions = self.ability.extra.rep,
                           card = self
                       }
                   end
               end
           end
        end,

        loc_def = function(self) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
            return { self.ability.extra.mult, self.ability.extra.x_mult, self.ability.extra.rep }
        end
    },

    stormjoker = {                                     --slug used by the joker.
        name = "Stormy Seas",                                --name used by the joker
        text = {
            "{C:mult}+#2# mult{} for every untriggered/disabled card played",
            "{C:inactive}(currently gives #1# mult){}",               --description text.	
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        },
        config = { extra = { mult = 0, x_mult = 1, scored_tally = 0, card_tally = 0 } },  --variables used for abilities and effects.
        pos = { x = 0, y = 0 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
        rarity = 2,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
        cost = 5,                                       --cost to buy the joker in shops
        blueprint_compat = true,                        --doses joker work with blueprint
        eternal_compat = true,                          --can joker be eternal
        unlocked = true,                                --joker is unlocked by default
        discovered = true,                              --joker is discovered dby default
        atlas = nil,                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
        soul_pos = nil,                                 --pos of a soul sprite.

        calculate = function(self, context)             --define calculate functions here
            if context.individual and context.cardarea == G.play then
                self.ability.extra.scored_tally = self.ability.extra.scored_tally + self.ability.extra.x_mult
            end
            if SMODS.end_calculate_context(context) then
                for k, v in ipairs(context.full_hand) do
                    self.ability.extra.card_tally = self.ability.extra.card_tally + self.ability.extra.x_mult
                end
                self.ability.extra.mult = self.ability.extra.mult + (self.ability.extra.card_tally - self.ability.extra.scored_tally)
                self.ability.extra.card_tally = 0
                self.ability.extra.scored_tally = 0
                return {
                    mult_mod = self.ability.extra.mult,
                    card = self,
                    message = localize { type = 'variable', key = 'a_mult', vars = { self.ability.extra.mult } }
                }
            end
        end,

        loc_def = function(self) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
            return { self.ability.extra.mult, self.ability.extra.x_mult, self.ability.extra.scored_tally, self.ability.extra.card_tally }
        end
    },

    mermaidjoker = {                                     --slug used by the joker.
        name = "Mermaid",                                --name used by the joker
        text = {
            "swaps between giving you",
            "{C:mult}+#1# mult{} and {C:chips}+#3# chips",
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        },
        config = { extra = { mult = 4, x_mult = 0, chips = 40, swap = 0 } },  --variables used for abilities and effects.
        pos = { x = 0, y = 0 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
        rarity = 1,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
        cost = 2,                                       --cost to buy the joker in shops
        blueprint_compat = true,                        --doses joker work with blueprint
        eternal_compat = true,                          --can joker be eternal
        unlocked = true,                                --joker is unlocked by default
        discovered = true,                              --joker is discovered dby default
        atlas = nil,                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
        soul_pos = nil,                                 --pos of a soul sprite.

        calculate = function(self, context)             --define calculate functions here
            if SMODS.end_calculate_context(context) then
                if self.ability.extra.swap == 0 then
                    self.ability.extra.swap = 1
                    return {
                        mult_mod = self.ability.extra.mult,
                        card = self,
                        message = localize { type = 'variable', key = 'a_mult', vars = { self.ability.extra.mult } }
                    }
                else
                    self.ability.extra.swap = 0
                    return {
                        chip_mod = self.ability.extra.chips,
                        card = self,
                        message = localize { type = 'variable', key = 'a_chips', vars = { self.ability.extra.chips } }
                    }
                end
            end
        end,

        loc_def = function(self) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
            return { self.ability.extra.mult, self.ability.extra.x_mult, self.ability.extra.chips, self.ability.extra.swap }
        end
    },

    decorationjoker = {                                     --slug used by the joker.
        name = "Figurehead",                                --name used by the joker
        text = {
            "{X:red,C:white}X#2#{} mult on the first hand",
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        },
        config = { extra = { mult = 4, x_mult = 2 } },  --variables used for abilities and effects.
        pos = { x = 0, y = 0 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
        rarity = 3,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
        cost = 5,                                       --cost to buy the joker in shops
        blueprint_compat = true,                        --doses joker work with blueprint
        eternal_compat = true,                          --can joker be eternal
        unlocked = true,                                --joker is unlocked by default
        discovered = true,                              --joker is discovered dby default
        atlas = nil,                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
        soul_pos = nil,                                 --pos of a soul sprite.

        calculate = function(self, context)             --define calculate functions here
            if SMODS.end_calculate_context(context) and G.GAME.current_round.hands_played == 0 then
                return{
                    Xmult_mod = self.ability.extra.x_mult,
                    card = self,
                    message = localize { type = 'variable', key = 'a_xmult', vars = { self.ability.extra.x_mult } }
                }
            end
        end,

        loc_def = function(self) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
            return { self.ability.extra.mult, self.ability.extra.x_mult }
        end
    },

    rumjoker = {                                     --slug used by the joker.
        name = "Rum",                                --name used by the joker
        text = {
            "does nothing{C:inactive}?{}",
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        },
        config = { extra = { mult = 4, x_mult = 2 } },  --variables used for abilities and effects.
        pos = { x = 0, y = 0 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
        rarity = 3,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
        cost = 1,                                       --cost to buy the joker in shops
        blueprint_compat = true,                        --doses joker work with blueprint
        eternal_compat = true,                          --can joker be eternal
        unlocked = true,                                --joker is unlocked by default
        discovered = true,                              --joker is discovered dby default
        atlas = nil,                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
        soul_pos = nil,                                 --pos of a soul sprite.

        calculate = function(self, context)             --define calculate functions here

        end,

        loc_def = function(self) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
            return { self.ability.extra.mult, self.ability.extra.x_mult, }
        end
    },

    islandjoker = {                                     --slug used by the joker.
        name = "Island",                                --name used by the joker
        text = {
            "{C:attention}retrigger{} all cards based on how many cards were scored so far",
            "{C:inactive}(ie if 3 cards scored, the first will retrigger once{}",
            "{C:inactive}the second will retrigger twice, the third will retrigger thrice)",
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        },
        config = { extra = { mult = 4, x_mult = 2, scored_tally = 0 } },  --variables used for abilities and effects.
        pos = { x = 0, y = 0 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
        rarity = 3,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
        cost = 8,                                       --cost to buy the joker in shops
        blueprint_compat = true,                        --doses joker work with blueprint
        eternal_compat = true,                          --can joker be eternal
        unlocked = true,                                --joker is unlocked by default
        discovered = true,                              --joker is discovered dby default
        atlas = nil,                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
        soul_pos = nil,                                 --pos of a soul sprite.

        calculate = function(self, context)             --define calculate functions hereS
            if context.repetition then
                if context.cardarea == G.play then
                    self.ability.extra.scored_tally = self.ability.extra.scored_tally + 1
                    return {
                        message = localize('k_again_ex'),
                        repetitions = self.ability.extra.scored_tally,
                        card = self
                    }
                end
           end
           if SMODS.end_calculate_context(context) then
                self.ability.extra.scored_tally = 0
           end
        end,

        loc_def = function(self) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
            return { self.ability.extra.mult, self.ability.extra.x_mult, self.ability.extra.scored_tally }
        end
    },

    flagjoker = {                                     --slug used by the joker.
        name = "Flag",                                --name used by the joker
        text = {
            "{C:mult}#2# mult{} per each 5 cards remaining in {C:attention}deck{}",
            "{C:inactive}(currently gives #1# mult){}",
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        },
        config = { extra = { mult = 0, x_mult = 1 } },  --variables used for abilities and effects.
        pos = { x = 0, y = 0 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
        rarity = 2,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
        cost = 6,                                       --cost to buy the joker in shops
        blueprint_compat = true,                        --doses joker work with blueprint
        eternal_compat = true,                          --can joker be eternal
        unlocked = true,                                --joker is unlocked by default
        discovered = true,                              --joker is discovered dby default
        atlas = nil,                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
        soul_pos = nil,                                 --pos of a soul sprite.

        calculate = function(self, context)             --define calculate functions here
            self.ability.extra.mult = math.floor(#G.deck.cards / 5)
            if SMODS.end_calculate_context(context) then
                return{
                    mult_mod = self.ability.extra.mult*self.ability.extra.x_mult,
                    card = self,
                    message = localize { type = 'variable', key = 'a_mult', vars = { self.ability.extra.mult*self.ability.extra.x_mult } }
                }
            end
        end,

        loc_def = function(self) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
            return { self.ability.extra.mult, self.ability.extra.x_mult }
        end
    },

    jbeardjoker = {                                     --slug used by the joker.
        name = "Cap'n J-Beard",                                --name used by the joker
        text = {
            "{X:red,C:white}+X#1#{} mult per each {C:attention}joker{}",
            "{C:inactive}(currently gives {}{X:red,C:white}X#2#{}{C:inactive} mult){}",
            "{C:inactive}(jonkler){}"                   --more than 5 lines look odd
        },
        config = { extra = { mult = 0.2, x_mult = 1 } },  --variables used for abilities and effects.
        pos = { x = 0, y = 0 },                         --pos in spirtesheet 0,0 for single sprites or the first sprite in the spritesheet
        rarity = 3,                                     --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
        cost = 7,                                       --cost to buy the joker in shops
        blueprint_compat = true,                        --doses joker work with blueprint
        eternal_compat = true,                          --can joker be eternal
        unlocked = true,                                --joker is unlocked by default
        discovered = true,                              --joker is discovered dby default
        atlas = nil,                                    --defines the atlas that you want to use for the sprite sheet. atlas=nil if you want to use single sprites
        soul_pos = nil,                                 --pos of a soul sprite.

        calculate = function(self, context)             --define calculate functions here
            self.ability.extra.x_mult = 1
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].ability.set == 'Joker' then self.ability.extra.x_mult = self.ability.extra.x_mult + self.ability.extra.mult end
            end
            if SMODS.end_calculate_context(context) then
                return{
                    Xmult_mod = self.ability.extra.x_mult,
                    card = self,
                    message = localize { type = 'variable', key = 'a_mult', vars = { self.ability.extra.x_mult } }
                }
            end
        end,

        loc_def = function(self) --defines variables to use in the UI. you can use #1# for example to show the mult variable, and #2# for x_mult
            return { self.ability.extra.mult, self.ability.extra.x_mult }
        end
    },
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
