class AD_Pawn_ZedFleshpoundMini extends KFPawn_ZedFleshpoundMini;

static event class<KFPawn_Monster> GetAIPawnClassToSpawn()
{
	return default.class;
}

defaultproperties
{
	ControllerClass=class'AD_AIController_ZedFleshpound'
	DifficultySettings=class'KFDifficulty_FleshpoundMini'
}