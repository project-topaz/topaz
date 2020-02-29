#include "luopanentity.h"
#include "../ai/ai_container.h"
#include "../ai/controllers/automaton_controller.h"
#include "../utils/puppetutils.h"
#include "../../common/utils.h"
#include "../packets/entity_update.h"
#include "../packets/pet_sync.h"
#include "../packets/char_job_extra.h"
#include "../status_effect_container.h"
#include "../ai/states/magic_state.h"
#include "../ai/states/mobskill_state.h"
#include "../packets/action.h"
#include "../mob_modifier.h"
#include "../utils/mobutils.h"
#include "../recast_container.h"

CLuopanEntity::CLuopanEntity()
    : CPetEntity(PETTYPE_LUOPAN)
{
}

CLuopanEntity::~CLuopanEntity()
{
}

void CLuopanEntity::PostTick()
{
    CPetEntity::PostTick();
}

void CLuopanEntity::FadeOut()
{
    CPetEntity::FadeOut();
}

void CLuopanEntity::Die()
{
    CPetEntity::Die();
}

void CLuopanEntity::Spawn()
{
}
