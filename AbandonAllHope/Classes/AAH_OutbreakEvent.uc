class AAH_OutbreakEvent extends KFOutbreakEvent;

function OnScoreKill(Pawn KilledPawn)
{
    local StatAdjustments ToAdjust;

    foreach ActiveEvent.ZedsToAdjust(ToAdjust)
    {
        if (ClassIsChildOf(KilledPawn.class, ToAdjust.ClassToAdjust))
        {
            if (ToAdjust.bExplosiveDeath && ToAdjust.ExplosionTemplate != none)
            {
                //Skip if we shouldn't do the normal death explosion
                if (KFPawn(KilledPawn) != none && !KFPawn(KilledPawn).WeeklyShouldExplodeOnDeath())
                {
                    return;
                }

                KFGameInfo_WeeklySurvival(Outer).DoDeathExplosion(KilledPawn, ToAdjust.ExplosionTemplate, ToAdjust.ExplosionIgnoreClass);
            }
        }
    }
}

function AdjustScoreDamage(Controller InstigatedBy, Pawn DamagedPawn, class<DamageType> damageType)
{
    super.AdjustScoreDamage(InstigatedBy, DamagedPawn, damageType);

    if (ActiveEvent.bUseBeefcakeRules)
    {
        if (InstigatedBy != none)
        {
            AdjustForBeefcakeRules(InstigatedBy.Pawn);
        }

        if (DamagedPawn != none && damageType == class'KFDT_Toxic_PlayerCrawlerSuicide')
        {
            AdjustForBeefcakeRules(DamagedPawn, EBT_StalkerPoison);
        }
    }
}

static function int GetOutbreakId(int SetEventsIndex)
{
    if (SetEventsIndex < 0 || SetEventsIndex >= default.SetEvents.length)
    {
        return INDEX_NONE;
    }

    return SetEventsIndex;
}

defaultproperties
{
//	SetEvents.length=2

	SetEvents[0]={(
                    EventDifficulty=3,
                    GameLength=GL_Normal,
                    SpawnRateMultiplier=3,
                    WaveAICountScale=(1.3, 1.3, 1.3, 1.3, 1.3, 1.3),
                    OverrideAmmoPickupModifier=1, // 1.2
                    WaveAmmoPickupModifiers={(
                       0.125, 0.15, 0.3, 0.45, 0.6, 0.75, 0.9, 0.99, 0.99
                    )},
                    bUseOverrideAmmoRespawnTime=true,
                    OverrideAmmoRespawnTime={(
                                PlayersMod[0]=25.000000,
                                PlayersMod[1]=12.000000,
                                PlayersMod[2]=8.000000,
                                PlayersMod[3]=5.000000,
                                PlayersMod[4]=4.000000,
                                PlayersMod[5]=3.000000,
                                ModCap=1.000000
                    )},
                    
                    ZedsToAdjust={(
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedMatriarch',HealthScale=2.0,DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.25),
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedPatriarch',HealthScale=2.0,DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.25),              
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedHans',HealthScale=2.0,DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.25),
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedFleshpoundKing',HealthScale=2.0,DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.25),
								(ClassToAdjust=class'KFGameContent.KFPawn_ZedBloatKing',HealthScale=2.0,DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.25),
                                
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedClot_Cyst',bStartEnraged=true, DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.2),
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedClot_Alpha', bStartEnraged=true, DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.2),
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedClot_AlphaKing', bStartEnraged=true, DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.2),
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedClot_Slasher', bStartEnraged=true, DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.2),
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedSiren', bStartEnraged=true, DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.2),
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedStalker', bStartEnraged=true, DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.2),
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedCrawler', bStartEnraged=true, DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.2),
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedCrawlerKing', bStartEnraged=true, DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.2),
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedGorefast', bStartEnraged=true, DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.2),
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedGorefastDualBlade', bStartEnraged=true, DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.2),
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedBloat', bStartEnraged=true, DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.2),
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedHusk', bStartEnraged=true, DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.2),
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedDAR_EMP', bStartEnraged=true, DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.2),
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedDAR_Laser', bStartEnraged=true, DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.2),
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedDAR_Rocket', bStartEnraged=true, DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.2),
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedScrake', bStartEnraged=true, DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.2),
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedFleshpound', bStartEnraged=true, DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.2),
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedFleshpoundMini',bStartEnraged=true, DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.2),
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedBloatKingSubspawn', bStartEnraged=true, DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.2)
					)},
                    SpawnReplacementList={(
                                (SpawnEntry=AT_Clot,NewClass=(class'KFGameContent.KFPawn_ZedClot_Alpha'),PercentChance=0.15),
                                (SpawnEntry=AT_AlphaClot,NewClass=(class'KFGameContent.KFPawn_ZedClot_AlphaKing'),PercentChance=0.15),
                                (SpawnEntry=AT_GoreFast,NewClass=(class'KFGameContent.KFPawn_ZedGorefastDualBlade'),PercentChance=0.15),
                                (SpawnEntry=AT_Crawler,NewClass=(class'KFGameContent.KFPawn_ZedCrawlerKing'),PercentChance=0.15),
                                (SpawnEntry=AT_Bloat,NewClass=(class'KFGameContent.KFPawn_ZedScrake'),PercentChance=0.05),
								(SpawnEntry=AT_FleshpoundMini,NewClass=(class'KFGameContent.KFPawn_ZedFleshpound'),PercentChance=0.05)
                    )}
    )}

	SetEvents[1]={(
                    EventDifficulty=3,
                    GameLength=GL_Normal,
                    SpawnRateMultiplier=3,
                    WaveAICountScale=(1.3, 1.3, 1.3, 1.3, 1.3, 1.3),
                    OverrideAmmoPickupModifier=1, // 1.2
                    WaveAmmoPickupModifiers={(
                       0.125, 0.15, 0.3, 0.45, 0.6, 0.75, 0.9, 0.99, 0.99
                    )},
                    bUseOverrideAmmoRespawnTime=true,
                    OverrideAmmoRespawnTime={(
                                PlayersMod[0]=25.000000,
                                PlayersMod[1]=12.000000,
                                PlayersMod[2]=8.000000,
                                PlayersMod[3]=5.000000,
                                PlayersMod[4]=4.000000,
                                PlayersMod[5]=3.000000,
                                ModCap=1.000000
                    )},
                    
                    ZedsToAdjust={(
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedMatriarch',HealthScale=1.75,DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.25),
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedPatriarch',HealthScale=1.75,DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.25),              
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedHans',HealthScale=1.75,DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.25),
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedFleshpoundKing',HealthScale=1.75,DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.25),
								(ClassToAdjust=class'KFGameContent.KFPawn_ZedBloatKing',HealthScale=1.75,DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.25),
                                
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedClot_Cyst', DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.2),
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedClot_Alpha', DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.2),
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedClot_AlphaKing', DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.2),
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedClot_Slasher', DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.2),
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedSiren', DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.2),
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedStalker', DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.2),
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedCrawler', DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.2),
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedCrawlerKing', DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.2),
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedGorefast', DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.2),
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedGorefastDualBlade', DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.2),
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedBloat', DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.2),
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedHusk', DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.2),
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedDAR_EMP', DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.2),
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedDAR_Laser', DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.2),
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedDAR_Rocket', DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.2),
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedScrake', DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.2),
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedFleshpound', DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.2),
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedFleshpoundMini',bStartEnraged=true, DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.2),
                                (ClassToAdjust=class'KFGameContent.KFPawn_ZedBloatKingSubspawn', DamageDealtScale=1.0, InitialGroundSpeedModifierScale=1.2)
					)},
                    SpawnReplacementList={(
                                (SpawnEntry=AT_Clot,NewClass=(class'KFGameContent.KFPawn_ZedClot_Alpha'),PercentChance=0.15),
                                (SpawnEntry=AT_AlphaClot,NewClass=(class'KFGameContent.KFPawn_ZedClot_AlphaKing'),PercentChance=0.15),
                                (SpawnEntry=AT_GoreFast,NewClass=(class'KFGameContent.KFPawn_ZedGorefastDualBlade'),PercentChance=0.15),
                                (SpawnEntry=AT_Crawler,NewClass=(class'KFGameContent.KFPawn_ZedCrawlerKing'),PercentChance=0.15),
                                (SpawnEntry=AT_Bloat,NewClass=(class'KFGameContent.KFPawn_ZedScrake'),PercentChance=0.05),
								(SpawnEntry=AT_FleshpoundMini,NewClass=(class'KFGameContent.KFPawn_ZedFleshpound'),PercentChance=0.2)
                    )}
    )}
}