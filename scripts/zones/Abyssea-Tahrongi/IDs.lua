-----------------------------------
-- Area: Abyssea-Tahrongi
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.ABYSSEA_TAHRONGI] =
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
            --  [16961954] = { 'qm1',           {2915},                                                                                                                     {}, 16961917}, -- Halimede
            --  [16961955] = { 'qm2',           {2916},                                                                                                                     {}, 16961918}, -- Vetehinen
            --  [16961956] = { 'qm3', {2917,2945,2946},                                                                                                                     {}, 16961919}, -- Ophanim
            --  [16961957] = { 'qm4',           {2918},                                                                                                                     {}, 16961920}, -- Cannered Noz
            --  [16961958] = { 'qm5',      {2919,2947},                                                                                                                     {}, 16961921}, -- Treble Noctules
            --  [16961959] = { 'qm6',           {2920},                                                                                                                     {}, 16961922}, -- Gancanagh
            --  [16961960] = { 'qm7',      {2921,2948},                                                                                                                     {}, 16961923}, -- Hedetet
            --  [16961961] = { 'qm8',           {2922},                                                                                                                     {}, 16961924}, -- Abas
            --  [16961962] = { 'qm9',      {2923,2949},                                                                                                                     {}, 16961925}, -- Alectryon
            --  [16961963] = {'qm10',           {2924},                                                                                                                     {}, 16961926}, -- Tefnet
            --  [16961964] = {'qm11',      {2925,2950},                                                                                                                     {}, 16961927}, -- Muscaliet
            --  [16961965] = {'qm12',           {2926},                                                                                                                     {}, 16961928}, -- Lachrymater
            --  [16961966] = {'qm13',               {},         {tpz.ki.VEINOUS_HECTEYES_EYELID,tpz.ki.TORN_BAT_WING,tpz.ki.GORY_SCORPION_CLAW,tpz.ki.MOSSY_ADAMANTOISE_SHELL}, 16961929}, -- Chloris
            --  [16961967] = {'qm14',               {}, {tpz.ki.FAT_LINED_COCKATRICE_SKIN,tpz.ki.SODDEN_SANDWORM_HUSK,tpz.ki.LUXURIANT_MANTICORE_MANE,tpz.ki.STICKY_GNAT_WING}, 16961930}, -- Glavoid
            --  [16961968] = {'qm15',               {},                                                     {tpz.ki.OVERGROWN_MANDRAGORA_FLOWER,tpz.ki.CHIPPED_SANDWORM_TOOTH}, 16961931}, -- Lacovie
            --  [16961969] = {'qm16',               {},         {tpz.ki.VEINOUS_HECTEYES_EYELID,tpz.ki.TORN_BAT_WING,tpz.ki.GORY_SCORPION_CLAW,tpz.ki.MOSSY_ADAMANTOISE_SHELL}, 16961946}, -- Chloris
            --  [16961970] = {'qm17',               {}, {tpz.ki.FAT_LINED_COCKATRICE_SKIN,tpz.ki.SODDEN_SANDWORM_HUSK,tpz.ki.LUXURIANT_MANTICORE_MANE,tpz.ki.STICKY_GNAT_WING}, 16961947}, -- Glavoid
            --  [16961971] = {'qm18',               {},                                                     {tpz.ki.OVERGROWN_MANDRAGORA_FLOWER,tpz.ki.CHIPPED_SANDWORM_TOOTH}, 16961948}, -- Lacovie
            --  [16961972] = {'qm19',               {},         {tpz.ki.VEINOUS_HECTEYES_EYELID,tpz.ki.TORN_BAT_WING,tpz.ki.GORY_SCORPION_CLAW,tpz.ki.MOSSY_ADAMANTOISE_SHELL}, 16961949}, -- Chloris
            --  [16961973] = {'qm20',               {}, {tpz.ki.FAT_LINED_COCKATRICE_SKIN,tpz.ki.SODDEN_SANDWORM_HUSK,tpz.ki.LUXURIANT_MANTICORE_MANE,tpz.ki.STICKY_GNAT_WING}, 16961950}, -- Glavoid
            --  [16961974] = {'qm21',               {},                                                     {tpz.ki.OVERGROWN_MANDRAGORA_FLOWER,tpz.ki.CHIPPED_SANDWORM_TOOTH}, 16961951}, -- Lacovie
        },
        Sturdy_Pyxis_Base = 16961991,
    },
}

return zones[tpz.zone.ABYSSEA_TAHRONGI]
