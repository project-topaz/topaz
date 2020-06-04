-----------------------------------
-- Area: Abyssea-Konschtat
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.ABYSSEA_KONSCHTAT] =
{
    text =
    {
        -- General Texts
        ITEM_CANNOT_BE_OBTAINED     = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED               = 6388, -- Obtained: <item>.
        GIL_OBTAINED                = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED            = 6391, -- Obtained key item: <keyitem>.
        CRUOR_TOTAL                 = 6986, -- Obtained <number> cruor. (Total: <number>)
        FISHING_MESSAGE_OFFSET      = 7049, -- You can't fish here.

        -- Abyssea Weakness Targeting
        STAGGERED                   = 7316, -- <name>'s attack staggers the fiend!
        YELLOW_STAGGER              = 7317, -- The fiend is unable to cast magic.
        BLUE_STAGGER                = 7318, -- The fiend is unable to use special attacks.
        RED_STAGGER                 = 7319, -- The fiend is frozen in its tracks.
        YELLOW_WEAKNESS             = 7320, -- The fiend appears vulnerable to <0-7>[/fire/ice/wind/earth/lightning/water/light/darkness] elemental magic
        BLUE_WEAKNESS               = 7321, -- The fiend appears vulnerable to <0-14>[/hand-to-hand/dagger/sword/great sword/axe/great axe/scythe/polearm/katana/great katana/club/staff/archery/marksmanship] weapon skills
        RED_WEAKNESS                = 7322, -- The fiend appears vulnerable to <0-7>[/fire/ice/wind/earth/lightning/water/light/darkness] elemental weapon skills

        -- Visitant Related Messages
        EXACT_TIME_REMAINING        = 7323, -- Your visitant status will wear off <amount>[second/minute]
        TIME_REMAINING              = 7324, -- Your visitant status will wear off <amount>[seconds/minutes]
        LOST_VISITANT_STATUS        = 7325, -- Your visitant status has worn off
        VISITANT_EXTENDED           = 7326, -- Your visitant status has been extended <amount><0/1>[minute/minutes]
        EXIT_WARNING_1              = 7327, -- Exiting inSingular/Plural Choice (Parameter 0)[minute/minutes]
        EXIT_WARNING_2              = 7328, -- Those without visitant status will be ejected from the area <amount><0/1>[minute/minutes]. To learn about this status, please consult a Conflux Surveyor
        EXIT_WARNING_3              = 7329, -- Exiting <amount><0/1>[second/minute]
        EXIT_WARNING_4              = 7330, -- Exiting <amount><0/1>[seconds/minutes]
        EXITING_NOW                 = 7331, -- Exiting now.
        WARD_WARNING_1              = 7332, -- Returning to the Searing Ward <amount><0/1>[second/seconds]
        WARD_WARNING_2              = 7333, -- You do not have visitant status. Returning to the Searing Ward <amount><0/1>[second/seconds]
        WARD_WARNING_3              = 7334, -- Returning to the Searing Ward <amount><0/1>[second/seconds]
        SEARING_WARD_TELE           = 7335, -- Returning to the Searing Ward now.
        LIGHTS_MESSAGE_1            = 7314, -- Visitant Light Intensity Pearlescent: ≺amount≻ / Ebon: ≺amount≻ Golden: ≺amount≻ / Silvery: ≺amount≻
        LIGHTS_MESSAGE_2            = 7315, -- Azure: ≺amount≻ / Ruby: ≺amount≻ / Amber: ≺amount≻

        -- Sturdy Pyxis
        MONSTER_CONCEALED_CHEST     = 7475, -- The monster was concealing a treasure chest!
        OBTAINS_TEMP_ITEM           = 7485, -- obtains the temporary item: <item≻!
        OBTIANS_THE_ITEM            = 7486, -- ≺name≻ obtains the item: ≺item≻!
        OBTAINS_THE_KEY_ITEM        = 7487, -- ≺name≻ obtains the key item: ≺key item≻!
        ADD_SPOILS_TO_TREASURE      = 7488, -- ≺name≻ transferred the contents of the pyxis to the cache of lottable spoils.
        ALLREADY_POSSESS_TEMP_ITEM  = 7489, -- You already possess that temporary item.
        ALLREADY_POSSESS_KEY_ITEM   = 7490, -- You already possess that key item.
        TEMP_ITEM_DISAPPEARED       = 7491, -- That temporary item had already disappeared.
        KEY_ITEM_DISAPPEARED        = 7492, -- That key item had already disappeared.
        ITEM_DISAPPEARED            = 7493, -- That item had already disappeared.
        CHEST_DESPAWNED             = 7494, -- The treasure chest had already disappeared.
        CRUOR_OBTAINED              = 7495, -- <name> obtains <amount> cruor.
        OBTAINES_SEVERAL_TEMPS      = 7496, -- ≺name≻ obtains several temporary items!
        BODY_EMITS_PEARL_LIGHT      = 7497, -- ≺name≻'s body emits [a faint/a mild/a strong] pearlescent light!
        BODY_EMITS_GOLDEN_LIGHT     = 7498, -- ≺name≻'s body emits [a faint/a mild/a strong] golden light!
        BODY_EMITS_SILVERY_LIGHT    = 7499, -- ≺name≻'s body emits [a faint/a mild/a strong] silvery light!
        BODY_EMITS_EBON_LIGHT       = 7500, -- ≺name≻'s body emits [a faint/a mild/a strong] ebon light!
        BODY_EMITS_AZURE_LIGHT      = 7501, -- ≺name≻'s body emits [a feeble/a faint/a mild/a strong/an intense] azure light!
        BODY_EMITS_RUBY_LIGHT       = 7502, -- ≺name≻'s body emits [a feeble/a faint/a mild/a strong/an intense] ruby light!
        BODY_EMITS_AMBER_LIGHT      = 7503, -- ≺name≻'s body emits [a feeble/a faint/a mild/a strong/an intense] amber light!
        CANNOT_OPEN_CHEST           = 7504, -- You cannot open that treasure chest.
        PLAYER_HAS_CLAIM_OF_CHEST   = 7505, -- ≺name≻ has claim over that treasure chest.
        PARTY_NOT_OWN_CHEST         = 7506, -- Your party does not have claim over that treasure chest.
        TIME_LIMIT_REDUCED          = 7507, -- ≺name≻'s time limit has been reduced by ≺amount≻[minute/minutes].
        CHEST_DISAPPEARED           = 7509, -- The treasure chest has disappeared.
        SELECTION_VOID              = 7530, -- Your selection has been rendered void. Another party member has already made a selection.
        RANDOM_SUCCESS_FAIL_GUESS   = 7531, -- The randomly generated number was ≺number≻!≺name≻ guessed ≺0/1≻[successfully/unsuccessfully]!
        AIR_PRESSURE_CHANGE         = 7535, -- ≺name≻ ≺choice≻[reduced/increased] the air pressure by ≺amount≻ units. Current air pressure: ≺amount≻[/ (minimum)/ (maximum)]
        INPUT_SUCCESS_FAIL_GUESS    = 7540, -- ≺name≻ inputs the number ≺input≻, but nothing happens./, successfully unlocking the chest!]
        GREATER_OR_LESS_THAN        = 7541, -- You have a hunch that the lock's combination is greater/less than ≺amount≻.
        HUNCH_SECOND_FIRST_EVEN_ODD = 7542, -- You have a hunch that the ≺0/1)≻[second/first] digit is ≺0/1≻[even/odd].
        HUNCH_SECOND_FIRST_IS       = 7543, -- You have a hunch that the ≺0/1≻[second/first] digit is ≺0/1≻.
        HUNCH_SECOND_FIRST_IS_OR    = 7544, -- You have a hunch that the ≺0/1≻[second/first] digit is ≺number≻, ≺number≻, or ≺number≻.
        HUNCH_ONE_DIGIT_IS          = 7545, -- You have a hunch that one of the digits is ≺number≻.
        HUNCH_SUM_EQUALS            = 7546, -- You have a hunch that the sum of the two digits is ≺number≻.
        PLAYER_OPENED_LOCK          = 7547, -- ≺name≻ succeeded in opening the lock!
        PLAYER_FAILED_LOCK          = 7548, -- ≺name≻ failed to open the lock.
        TRADE_KEY_OPEN              = 7549, -- ≺name≻ uses ≺item≻ and opens the lock!

        -- Abyssea ??? Targets
        BOUNDLESS_RAGE              = 7572, -- You sense an aura of boundless rage...
        INFO_KI                     = 7573, -- Your keen senses tell you that something may happen if only you had <item><0/1>[this item/these items]
        USE_KI                      = 7576, -- Use the <item><0/1>[key item/key items]
    },
    mob =
    {
    },
    npc =
    {
        QM_POPS =
        {
            --  [16839078] = { 'qm1', {2914},                                                                                                                                           {}, 16838718}, -- Ashtaerth The Gallvexed
            --  [16839079] = { 'qm2', {2911},                                                                                                                                           {}, 16838767}, -- Sarcophilus
            --  [16839080] = { 'qm3', {2909},                                                                                                                                           {}, 16838782}, -- Bombadeel
            --  [16839081] = { 'qm4', {2908},                                                                                                                                           {}, 16838837}, -- Hexenpilz
            --  [16839082] = { 'qm5', {2910},                                                                                                                                           {}, 16838871}, -- Keratyrannos
            --  [16839083] = { 'qm6', {2904},                                                                                                                                           {}, 16838885}, -- Lentor
            --  [16839084] = { 'qm7', {2903},                                                                                                                                           {}, 16838899}, -- Bloodguzzler
            --  [16839085] = { 'qm8', {2907},                                                                                                                                           {}, 16838946}, -- Clingy Clare
            --  [16839086] = { 'qm9', {2906},                                                                                                                                           {}, 16838962}, -- Siranpa-Kamuy
            --  [16839087] = {'qm10', {2912},                                                                                                                                           {}, 16838979}, -- Alkonost
            --  [16839088] = {'qm11', {2913},                                                                                                                                           {}, 16838993}, -- Arimaspi
            --  [16839089] = {'qm12', {2905},                                                                                                                                           {}, 16839033}, -- Fear Gorta
            --  [16839090] = {'qm13',     {}, {tpz.ki.FRAGRANT_TREANT_PETAL,tpz.ki.FETID_RAFFLESIA_STALK,tpz.ki.DECAYING_MORBOL_TOOTH,tpz.ki.TURBID_SLIME_OIL,tpz.ki.VENOMOUS_PEISTE_CLAW}, 16839007}, -- Eccentric Eve
            --  [16839091] = {'qm14',     {},                                                     {tpz.ki.TATTERED_HIPPOGRYPH_WING,tpz.ki.CRACKED_WIVRE_HORN,tpz.ki.MUCID_AHRIMAN_EYEBALL}, 16838872}, -- Kukulkan
            --  [16839092] = {'qm15',     {},                                                                                                              {tpz.ki.TWISTED_TONBERRY_CROWN}, 16839068}, -- Bloodeye Vileberry
            --  [16839093] = {'qm16',     {}, {tpz.ki.FRAGRANT_TREANT_PETAL,tpz.ki.FETID_RAFFLESIA_STALK,tpz.ki.DECAYING_MORBOL_TOOTH,tpz.ki.TURBID_SLIME_OIL,tpz.ki.VENOMOUS_PEISTE_CLAW}, 16839069}, -- Eccentric Eve
            --  [16839094] = {'qm17',     {},                                                     {tpz.ki.TATTERED_HIPPOGRYPH_WING,tpz.ki.CRACKED_WIVRE_HORN,tpz.ki.MUCID_AHRIMAN_EYEBALL}, 16839070}, -- Kukulkan
            --  [16839095] = {'qm18',     {},                                                                                                              {tpz.ki.TWISTED_TONBERRY_CROWN}, 16839071}, -- Bloodeye Vileberry
            --  [16839096] = {'qm19',     {}, {tpz.ki.FRAGRANT_TREANT_PETAL,tpz.ki.FETID_RAFFLESIA_STALK,tpz.ki.DECAYING_MORBOL_TOOTH,tpz.ki.TURBID_SLIME_OIL,tpz.ki.VENOMOUS_PEISTE_CLAW}, 16839072}, -- Eccentric Eve
            --  [16839097] = {'qm20',     {},                                                     {tpz.ki.TATTERED_HIPPOGRYPH_WING,tpz.ki.CRACKED_WIVRE_HORN,tpz.ki.MUCID_AHRIMAN_EYEBALL}, 16839073}, -- Kukulkan
            --  [16839098] = {'qm21',     {},                                                                                                              {tpz.ki.TWISTED_TONBERRY_CROWN}, 16839074}, -- Bloodeye Vileberry
        },
        Sturdy_Pyxis_Base = 16839114,
    },
}

return zones[tpz.zone.ABYSSEA_KONSCHTAT]
