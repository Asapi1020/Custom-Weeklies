class AD_SpawnManager extends KFAISpawnManager_Long;

function GetSpawnListFromSquad(byte SquadIdx, out array< KFAISpawnSquad > SquadsList, out array< class<KFPawn_Monster> >  AISpawnList)
{
	local int i, j;

	super.GetSpawnListFromSquad(SquadIdx, SquadsList, AISpawnList);

	// ZedReplacement
	j = AISpawnList.Length;
	for ( i = 0; i < j; i++ )
	{
		if(AISpawnList[i] == AIClassList[AT_Stalker])
			AISpawnList[i] = class'AD_Pawn_ZedStalker';

		else if(AISpawnList[i] == AIClassList[AT_Husk])
			AISpawnList[i] = class'AD_Pawn_ZedHusk';

		else if(AISpawnList[i] == AIClassList[AT_FleshPound])
			AISpawnList[i] = class'AD_Pawn_ZedFleshpound';

		else if(AISpawnList[i] == AIClassList[AT_FleshPoundMini])
			AISpawnList[i] = class'AD_Pawn_ZedFleshpoundMini';

		else if(AISpawnList[i] == AIClassList[AT_EDAR_EMP] ||
				AISpawnList[i] == AIClassList[AT_EDAR_Laser] ||
				AISpawnList[i] == AIClassList[AT_EDAR_Rocket])
			AISpawnList[i] = Rand(2) == 0 ? class'AD_Pawn_ZedStalker' : class'AD_Pawn_ZedHusk';
	}
}