#include "gambits_container.h"

#include "../../spell.h"
#include "../../utils/battleutils.h"

// Validate gambit before it's inserted into the gambit list
// Check levels, etc.
void CGambitsContainer::AddGambit(Gambit_t gambit)
{
    bool available = true;
    /*
    if (gambit.action.reaction == G_REACTION::MA && gambit.action.select == G_SELECT::SPECIFIC)
    {
        if (!spell::CanUseSpell(static_cast<CBattleEntity*>(POwner), static_cast<SpellID>(gambit.action.select_arg)))
        {
            available = false;
        }
    }
    */
    if (available)
    {
        gambits.push_back(gambit);
    }
}

void CGambitsContainer::Tick(time_point tick)
{
    // TODO: This could be a setting?
    // Do something every second
    if (tick < m_lastAction + 1s)
    {
        return;
    }
    m_lastAction = tick;

    auto controller = static_cast<CTrustController*>(POwner->PAI->GetController());

    for (auto gambit : gambits)
    {
        if (tick < gambit.last_used + std::chrono::seconds(gambit.retry_delay))
        {
            continue;
        }

        auto checkTrigger = [&](CBattleEntity* target, Predicate_t& predicate) -> bool
        {
            switch (predicate.condition)
            {
            case ALWAYS:
            {
                return true;
                break;
            }
            case HPP_LT:
            {
                return target->GetHPP() < predicate.condition_arg;
                break;
            }
            case HPP_GTE:
            {
                return target->GetHPP() >= predicate.condition_arg;
                break;
            }
            case MPP_LT:
            {
                return target->GetMPP() < predicate.condition_arg;
                break;
            }
            case TP_LT:
            {
                return target->health.tp < predicate.condition_arg;
                break;
            }
            case TP_GTE:
            {
                return target->health.tp >= predicate.condition_arg;
                break;
            }
            case STATUS:
            {
                return target->StatusEffectContainer->HasStatusEffect(static_cast<EFFECT>(predicate.condition_arg));
                break;
            }
            case NOT_STATUS:
            {
                return !target->StatusEffectContainer->HasStatusEffect(static_cast<EFFECT>(predicate.condition_arg));
                break;
            }
            case STATUS_FLAG:
            {
                return target->StatusEffectContainer->HasStatusEffectByFlag(static_cast<EFFECTFLAG>(predicate.condition_arg));
                break;
            }
            case HAS_ENMITY:
            {
                return (controller->GetTopEnmity()) ? controller->GetTopEnmity()->targid == POwner->targid : false;
                break;
            }
            case NOT_HAS_ENMITY:
            {
                return (controller->GetTopEnmity()) ? controller->GetTopEnmity()->targid != POwner->targid : false;
                break;
            }
            case SC_AVAILABLE:
            {
                auto PSCEffect = target->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN);
                return PSCEffect && PSCEffect->GetStartTime() + 3s < server_clock::now() && PSCEffect->GetTier() == 0;
                break;
            }
            case NOT_SC_AVAILABLE:
            {
                auto PSCEffect = target->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN);
                return PSCEffect == nullptr;
                break;
            }
            case MB_AVAILABLE:
            {
                auto PSCEffect = target->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN);
                return PSCEffect && PSCEffect->GetStartTime() + 3s < server_clock::now() && PSCEffect->GetTier() > 0;
                break;
            }
            default: { return false;  break; }
            }
        };

        CBattleEntity* target = nullptr;
        if (gambit.predicate.target == G_TARGET::SELF)
        {
            target = checkTrigger(POwner, gambit.predicate) ? POwner : nullptr;
        }
        else if (gambit.predicate.target == G_TARGET::TARGET)
        {
            auto mob = POwner->GetBattleTarget();
            target = checkTrigger(mob, gambit.predicate) ? mob : nullptr;
        }
        else if (gambit.predicate.target == G_TARGET::PARTY)
        {
            // TODO: This is very messy, priority are player chars
            CCharEntity* master = static_cast<CCharEntity*>(POwner->PMaster);
            for (uint8 i = 0; i < master->PParty->members.size(); ++i)
            {
                auto member = master->PParty->members.at(i);
                if (checkTrigger(member, gambit.predicate))
                {
                    target = member;
                    break;
                }
            }
            if (!target)
            {
                for (uint8 i = 0; i < master->PTrusts.size(); ++i)
                {
                    auto member = master->PTrusts.at(i);
                    if (checkTrigger(member, gambit.predicate))
                    {
                        target = member;
                        break;
                    }
                }
            }
        }
        else if (gambit.predicate.target == G_TARGET::MASTER)
        {
            target = POwner->PMaster;
        }

        if (target)
        {
            
            if (gambit.action.reaction == G_REACTION::MA)
            /*
            {
                if (action.reaction_mod == G_REACTION_MODIFIER::SELECT_SPECIFIC)
                {
                    auto spell_id = POwner->SpellContainer->GetAvailable(static_cast<SpellID>(action.reaction_arg));
                    if (spell_id.has_value())
                    {
                        controller->Cast(target->targid, static_cast<SpellID>(spell_id.value()));
                    }
                }
                else if (action.reaction_mod == G_REACTION_MODIFIER::SELECT_HIGHEST)
                {
                    auto spell_id = POwner->SpellContainer->GetBestAvailable(static_cast<SPELLFAMILY>(action.reaction_arg));
                    if (spell_id.has_value())
                    {
                        controller->Cast(target->targid, static_cast<SpellID>(spell_id.value()));
                    }
                }
                else if (action.reaction_mod == G_REACTION_MODIFIER::SELECT_LOWEST)
                {
                   
                    auto spell_id = POwner->SpellContainer->GetWorstAvailable(static_cast<SPELLFAMILY>(action.reaction_arg));
                    if (spell_id.has_value())
                    {
                        controller->Cast(target->targid, static_cast<SpellID>(spell_id.value()));
                    }

                }
                else if (action.reaction_mod == G_REACTION_MODIFIER::SELECT_RANDOM)
                {
                    auto spell_id = POwner->SpellContainer->GetSpell();
                    if (spell_id.has_value())
                    {
                        controller->Cast(target->targid, static_cast<SpellID>(spell_id.value()));
                    }
                }
                else if (action.reaction_mod == G_REACTION_MODIFIER::SELECT_MB_ELEMENT)
                {
                    CStatusEffect* PSCEffect = target->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN, 0);
                    std::list<SKILLCHAIN_ELEMENT> resonanceProperties;
                    if (uint16 power = PSCEffect->GetPower())
                    {
                        resonanceProperties.push_back((SKILLCHAIN_ELEMENT)(power & 0xF));
                        resonanceProperties.push_back((SKILLCHAIN_ELEMENT)(power >> 4 & 0xF));
                        resonanceProperties.push_back((SKILLCHAIN_ELEMENT)(power >> 8));
                    }

                    std::optional<SpellID> spell_id;
                    for (auto& resonance_element : resonanceProperties)
                    {
                        for (auto& chain_element : battleutils::GetSkillchainMagicElement(resonance_element))
                        {
                            // TODO: SpellContianer->GetBestByElement(ELEMENT)
                            // NOTE: Iterating this list in reverse guarantees finding the best match
                            for (size_t i = POwner->SpellContainer->m_damageList.size(); i > 0 ; --i)
                            {
                                auto spell = POwner->SpellContainer->m_damageList[i-1];
                                auto spell_element = spell::GetSpell(spell)->getElement();
                                if (spell_element == chain_element)
                                {
                                    spell_id = spell;
                                    break;
                                }
                            }
                        }
                    }

                    if (spell_id.has_value())
                    {
                        controller->Cast(target->targid, static_cast<SpellID>(spell_id.value()));
                    }
                }
            } */
            {
            }
            else if (gambit.action.reaction == G_REACTION::JA)
            {
                if (gambit.action.select == G_SELECT::SPECIFIC)
                {
                    controller->Ability(target->targid, gambit.action.select_arg);
                }
            }
            else if (gambit.action.reaction == G_REACTION::WS)
            {
                if (gambit.action.select == G_SELECT::SPECIFIC)
                {
                    auto mob = POwner->GetBattleTarget();
                    controller->WeaponSkill(mob->targid, gambit.action.select_arg);
                }
            }
            else if (gambit.action.reaction == G_REACTION::MS)
            {
                if (gambit.action.select == G_SELECT::SPECIFIC)
                {
                    auto mob = POwner->GetBattleTarget();
                    controller->MobSkill(mob->targid, gambit.action.select_arg);
                }
            }

            // Assume success
            if (gambit.retry_delay != 0)
            {
                gambit.last_used = tick;
            }
        }
    }
}
