-----------------------------------
-- Area: Abyssea-La_Theine
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.ABYSSEA_LA_THEINE] =
{
    text =
    {
        -- General Texts
        ITEM_CANNOT_BE_OBTAINED     = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED               = 6388, -- Obtained: <item>.
        GIL_OBTAINED                = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED            = 6391, -- Obtained key item: <keyitem>.
        CRUOR_TOTAL                 = 6986, -- Obtained <number> cruor. (Total: <number>)

        -- Abyssea Weakness Targeting
        STAGGERED                   = 7316, -- ?Player/Chocobo Parameter 0?'s attack staggers the fiend!
        YELLOW_STAGGER              = 7317, -- The fiend is unable to cast magic.
        BLUE_STAGGER                = 7318, -- The fiend is unable to use special attacks.
        RED_STAGGER                 = 7319, -- The fiend is frozen in its tracks.
        YELLOW_WEAKNESS             = 7320, -- The fiend appears vulnerable to Multiple Choice (Parameter 0)[/fire/ice/wind/earth/lightning/water/light/darkness] elemental magic
        BLUE_WEAKNESS               = 7321, -- The fiend appears vulnerable to Multiple Choice (Parameter 0)[/hand-to-hand/dagger/sword/great sword/axe/great axe/scythe/polearm/katana/great katana/club/staff/archery/marksmanship] weapon skills
        RED_WEAKNESS                = 7322, -- The fiend appears vulnerable to Multiple Choice (Parameter 0)[/fire/ice/wind/earth/lightning/water/light/darkness] elemental weapon skills

        -- Visitant Related Messages
        EXACT_TIME_REMAINING        = 7323, -- Your visitant status will wear off inMultiple Choice (Parameter 1)[second/minute]
        TIME_REMAINING              = 7324, -- Your visitant status will wear off inMultiple Choice (Parameter 1)[seconds/minutes]
        LOST_VISITANT_STATUS        = 7325, -- Your visitant status has worn off
        VISITANT_EXTENDED           = 7326, -- Your visitant status has been extended bySingular/Plural Choice (Parameter 0)[minute/minutes]
        EXIT_WARNING_1              = 7327, -- Exiting inSingular/Plural Choice (Parameter 0)[minute/minutes]
        EXIT_WARNING_2              = 7328, -- Those without visitant status will be ejected from the area inSingular/Plural Choice (Parameter 0)[minute/minutes]. To learn about this status, please consult a Conflux Surveyor
        EXIT_WARNING_3              = 7329, -- Exiting inMultiple Choice (Parameter 1)[second/minute]
        EXIT_WARNING_4              = 7330, -- Exiting inMultiple Choice (Parameter 1)[seconds/minutes]
        EXITING_NOW                 = 7331, -- Exiting now.
        WARD_WARNING_1              = 7332, -- Returning to the Searing Ward inSingular/Plural Choice (Parameter 0)[second/seconds]
        WARD_WARNING_2              = 7333, -- You do not have visitant status. Returning to the Searing Ward inSingular/Plural Choice (Parameter 0)[second/seconds]
        WARD_WARNING_3              = 7334, -- Returning to the Searing Ward inSingular/Plural Choice (Parameter 0)[second/seconds]
        SEARING_WARD_TELE           = 7335, -- Returning to the Searing Ward now.
        LIGHTS_MESSAGE_1            = 7314, --≺Set Color #5≻Visitant Light Intensity≺Set Color #1≻Pearlescent: ≺Numeric Parameter 0≻ / Ebon: ≺Numeric Parameter 1≻Golden: ≺Numeric Parameter 2≻ / Silvery: ≺Numeric Parameter 3≻≺Prompt≻
        LIGHTS_MESSAGE_2            = 7315, --Azure: ≺Numeric Parameter 0≻ / Ruby: ≺Numeric Parameter 1≻ / Amber: ≺Numeric Parameter 2≻≺Prompt≻

        -- Sturdy Pyxis
        MONSTER_CONCEALED_CHEST     = 7475, -- ≺Possible Special Code: 1F≻yThe monster was concealing a treasure chest!≺Prompt≻
        OBTAINS_TEMP_ITEM           = 7485, -- ≺Possible Special Code: 1F≻y≺Player/Chocobo Parameter 0≻ obtains the temporary item: ≺Unknown Parameter (Type: 80) 1≻≺Possible Special Code: 01≻≺Possible Special Code: 05≻#≺BAD CHAR: 8280≻≺BAD CHAR: 80≻≺BAD CHAR: 80≻!
        OBTIANS_THE_ITEM            = 7486, -- ≺Possible Special Code: 1F≻y≺Player/Chocobo Parameter 0≻ obtains the item: ≺Unknown Parameter (Type: 80) 1≻≺Possible Special Code: 01≻≺Possible Special Code: 05≻#≺BAD CHAR: 8280≻≺BAD CHAR: 80≻≺BAD CHAR: 80≻!
        OBTAINS_THE_KEY_ITEM        = 7487, -- ≺Possible Special Code: 1F≻y≺Player/Chocobo Parameter 0≻ obtains the key item: ≺Unknown Parameter (Type: 80) 1≻≺Possible Special Code: 01≻≺Possible Special Code: 05≻3≺BAD CHAR: 8280≻≺BAD CHAR: 80≻≺BAD CHAR: 80≻!
        ADD_SPOILS_TO_TREASURE      = 7488, -- ≺Possible Special Code: 1F≻y≺Player/Chocobo Parameter 0≻ transferred the contents of the pyxis to the cache of lottable spoils.≺Prompt≻
        ALLREADY_POSSESS_TEMP_ITEM  = 7489, -- You already possess that temporary item.
        ALLREADY_POSSESS_KEY_ITEM   = 7490, -- You already possess that key item.
        TEMP_ITEM_DISAPPEARED       = 7491, -- That temporary item had already disappeared.
        KEY_ITEM_DISAPPEARED        = 7492, -- That key item had already disappeared.
        ITEM_DISAPPEARED            = 7493, -- That item had already disappeared.
        CHEST_DESPAWNED             = 7494, -- The treasure chest had already disappeared.
        CRUOR_OBTAINED              = 7495, -- <Possible Special Code: 1F>y<Player Name> obtains <Numeric Parameter 0> cruor.
        OBTAINES_SEVERAL_TEMPS      = 7496, -- ≺Possible Special Code: 1F≻y≺Player Name≻ obtains several temporary items!
        BODY_EMITS_PEARL_LIGHT      = 7497, -- ≺Player Name≻'s body emits ≺Multiple Choice (Parameter 0)≻[a faint/a mild/a strong] pearlescent light!
        BODY_EMITS_GOLDEN_LIGHT     = 7498, -- ≺Player Name≻'s body emits ≺Multiple Choice (Parameter 0)≻[a faint/a mild/a strong] golden light!
        BODY_EMITS_SILVERY_LIGHT    = 7499, -- ≺Player Name≻'s body emits ≺Multiple Choice (Parameter 0)≻[a faint/a mild/a strong] silvery light!
        BODY_EMITS_EBON_LIGHT       = 7500, -- ≺Player Name≻'s body emits ≺Multiple Choice (Parameter 0)≻[a faint/a mild/a strong] ebon light!
        BODY_EMITS_AZURE_LIGHT      = 7501, -- ≺Player Name≻'s body emits ≺Multiple Choice (Parameter 0)≻[a feeble/a faint/a mild/a strong/an intense] azure light!
        BODY_EMITS_RUBY_LIGHT       = 7502, -- ≺Player Name≻'s body emits ≺Multiple Choice (Parameter 0)≻[a feeble/a faint/a mild/a strong/an intense] ruby light!
        BODY_EMITS_AMBER_LIGHT      = 7503, -- ≺Player Name≻'s body emits ≺Multiple Choice (Parameter 0)≻[a feeble/a faint/a mild/a strong/an intense] amber light!
        CANNOT_OPEN_CHEST           = 7504, -- You cannot open that treasure chest.
        PLAYER_HAS_CLAIM_OF_CHEST   = 7505, -- ≺Player/Chocobo Parameter 0≻ has claim over that treasure chest.
        PARTY_NOT_OWN_CHEST         = 7506, -- Your party does not have claim over that treasure chest.
        TIME_LIMIT_REDUCED          = 7507, -- ≺Player/Chocobo Parameter 0≻'s time limit has been reduced by ≺Numeric Parameter 0≻ ≺Singular/Plural Choice (Parameter 0)≻[minute/minutes].
        CHEST_DISAPPEARED           = 7509, -- The treasure chest has disappeared.
        SELECTION_VOID              = 7530, -- Your selection has been rendered void. Another party member has already made a selection.
        RANDOM_SUCCESS_FAIL_GUESS   = 7531, -- The randomly generated number was ≺Numeric Parameter 0≻!≺Player/Chocobo Parameter 0≻ guessed ≺Multiple Choice (Parameter 1)≻[successfully/unsuccessfully]!
        AIR_PRESSURE_CHANGE         = 7535, -- ≺Player/Chocobo Parameter 0≻ ≺Multiple Choice (Parameter 1)≻[reduced/increased] the air pressure by ≺Numeric Parameter 0≻ units. Current air pressure: ≺Numeric Parameter 3≻≺Multiple Choice (Parameter 2)≻[/ (minimum)/ (maximum)]
        INPUT_SUCCESS_FAIL_GUESS    = 7540, -- ≺Player/Chocobo Parameter 0≻ inputs the number ≺Numeric Parameter 0≻≺Multiple Choice (Parameter 1)≻[, but nothing happens./, successfully unlocking the chest!]≺Prompt≻
        GREATER_OR_LESS_THAN        = 7541, -- You have a hunch that the lock's combination is ≺Multiple Choice (Parameter 1)≻[greater/less] than ≺Numeric Parameter 0≻.≺Prompt≻
        HUNCH_SECOND_FIRST_EVEN_ODD = 7542, -- You have a hunch that the ≺Singular/Plural Choice (Parameter 0)≻[second/first] digit is ≺Multiple Choice (Parameter 1)≻[even/odd].≺Prompt≻
        HUNCH_SECOND_FIRST_IS       = 7543, -- You have a hunch that the ≺Singular/Plural Choice (Parameter 0)≻[second/first] digit is ≺Numeric Parameter 1≻.≺Prompt≻
        HUNCH_SECOND_FIRST_IS_OR    = 7544, -- You have a hunch that the ≺Singular/Plural Choice (Parameter 0)≻[second/first] digit is ≺Numeric Parameter 1≻, ≺Numeric Parameter 2≻, or ≺Numeric Parameter 3≻.≺Prompt≻
        HUNCH_ONE_DIGIT_IS          = 7545, -- You have a hunch that one of the digits is ≺Numeric Parameter 0≻.≺Prompt≻
        HUNCH_SUM_EQUALS            = 7546, -- You have a hunch that the sum of the two digits is ≺Numeric Parameter 0≻.≺Prompt≻
        PLAYER_OPENED_LOCK          = 7547, -- ≺Possible Special Code: 1F≻y≺Player/Chocobo Parameter 0≻ succeeded in opening the lock!≺Prompt≻
        PLAYER_FAILED_LOCK          = 7548, -- ≺Player/Chocobo Parameter 0≻ failed to open the lock.≺Prompt≻
        TRADE_KEY_OPEN              = 7549, -- ≺Player/Chocobo Parameter 0≻ uses ≺Possible Special Code: 01≻≺Possible Special Code: 01≻≺Possible Special Code: 01≻ ≺Possible Special Code: 01≻≺Possible Special Code: 05≻$≺BAD CHAR: 8280≻≺BAD CHAR: 80≻≺BAD CHAR: 80≻ and opens the lock!

        -- Abyssea ??? Targets
        BOUNDLESS_RAGE              = 7572, -- You sense an aura of boundless rage...
        INFO_KI                     = 7573, -- Your keen senses tell you that something may happen if only you had Multiple Choice (Parameter 0)[this item/these items]
        USE_KI                      = 7576, -- Use the Multiple Choice (Parameter 0)[key item/key items]
        },
    mob =
    {
    },
    npc =
    {
        QM_POPS =
        {
            --  [17318473] = { 'qm1', {2891},                                                                                                                      {}, 17318434}, -- Dozing Dorian
            --  [17318474] = { 'qm2', {2892},                                                                                                                      {}, 17318435}, -- Trudging Thomas
            --  [17318475] = { 'qm3', {2893},                                                                                                                      {}, 17318436}, -- Megantereon
            --  [17318476] = { 'qm4', {2894},                                                                                                                      {}, 17318437}, -- Adamastor
            --  [17318477] = { 'qm5', {2895},                                                                                                                      {}, 17318438}, -- Pantagruel
            --  [17318478] = { 'qm6', {2896},                                                                                                                      {}, 17318439}, -- Grandgousier
            --  [17318479] = { 'qm7', {2897},                                                                                                                      {}, 17318440}, -- La Theine Liege
            --  [17318480] = { 'qm8', {2898},                                                                                                                      {}, 17318441}, -- Baba Yaga
            --  [17318481] = { 'qm9', {2899},                                                                                                                      {}, 17318442}, -- Nguruvilu
            --  [17318482] = {'qm10', {2900},                                                                                                                      {}, 17318443}, -- Poroggo Dom Juan
            --  [17318483] = {'qm11', {2901},                                                                                                                      {}, 17318444}, -- Toppling Tuber
            --  [17318484] = {'qm12', {2902},                                                                                                                      {}, 17318445}, -- Lugarhoo
            --  [17318485] = {'qm13',     {},                                    {tpz.ki.DENTED_GIGAS_SHIELD,tpz.ki.WARPED_GIGAS_ARMBAND,tpz.ki.SEVERED_GIGAS_COLLAR}, 17318446}, -- Briareus
            --  [17318486] = {'qm14',     {},                                                                {tpz.ki.PELLUCID_FLY_EYE,tpz.ki.SHIMMERING_PIXIE_PINION}, 17318447}, -- Carabosse
            --  [17318487] = {'qm15',     {}, {tpz.ki.MARBLED_MUTTON_CHOP,tpz.ki.BLOODIED_SABER_TOOTH,tpz.ki.GLITTERING_PIXIE_CHOKER,tpz.ki.BLOOD_SMEARED_GIGAS_HELM}, 17318448}, -- Hadhayosh
            --  [17318488] = {'qm16',     {},                                    {tpz.ki.DENTED_GIGAS_SHIELD,tpz.ki.WARPED_GIGAS_ARMBAND,tpz.ki.SEVERED_GIGAS_COLLAR}, 17318456}, -- Briareus
            --  [17318489] = {'qm17',     {},                                                                {tpz.ki.PELLUCID_FLY_EYE,tpz.ki.SHIMMERING_PIXIE_PINION}, 17318457}, -- Carabosse
            --  [17318490] = {'qm18',     {}, {tpz.ki.MARBLED_MUTTON_CHOP,tpz.ki.BLOODIED_SABER_TOOTH,tpz.ki.GLITTERING_PIXIE_CHOKER,tpz.ki.BLOOD_SMEARED_GIGAS_HELM}, 17318458}, -- Hadhayosh
            --  [17318491] = {'qm19',     {},                                    {tpz.ki.DENTED_GIGAS_SHIELD,tpz.ki.WARPED_GIGAS_ARMBAND,tpz.ki.SEVERED_GIGAS_COLLAR}, 17318459}, -- Briareus
            --  [17318492] = {'qm20',     {},                                                                {tpz.ki.PELLUCID_FLY_EYE,tpz.ki.SHIMMERING_PIXIE_PINION}, 17318460}, -- Carabosse
            --  [17318493] = {'qm21',     {}, {tpz.ki.MARBLED_MUTTON_CHOP,tpz.ki.BLOODIED_SABER_TOOTH,tpz.ki.GLITTERING_PIXIE_CHOKER,tpz.ki.BLOOD_SMEARED_GIGAS_HELM}, 17318461}, -- Hadhayosh
        },
    },
}

return zones[tpz.zone.ABYSSEA_LA_THEINE]
