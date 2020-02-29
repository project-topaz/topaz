#ifndef _CLUOPANENTITY_H
#define _CLUOPANENTITY_H

#include "petentity.h"

class CCharEntity;

class CLuopanEntity : public CPetEntity
{
public:
    CLuopanEntity();
	~CLuopanEntity();

    virtual void PostTick() override;
    virtual void FadeOut() override;
    virtual void Die() override;
    virtual void Spawn() override;

    void OnAbility(CAbilityState&, action_t&) override {}
    bool ValidTarget(CBattleEntity* PInitiator, uint16 targetFlags) override { return false; }
};

#endif