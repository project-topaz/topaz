#ifndef _CINDEPENDANTANIMATIONPACKET_H
#define _CINDEPENDANTANIMATIONPACKET_H

#include "../../common/cbasetypes.h"

#include "basic.h"

class CBaseEntity;

class CIndependantAnimationPacket : public CBasicPacket
{
public:
	CIndependantAnimationPacket(CBaseEntity * PEntity, uint16 animId, uint8 mode, uint8 unknown);
};

#endif // _CINDEPENDANTANIMATIONPACKET_H
