class AD_Survival extends KFGameInfo_WeeklySurvival
	config(AreaDefense);

var array<sGameMode> ADGameModes;

const ContaminationModeIndex = 19;

event InitGame(string Options,  out string ErrorMessage)
{
	super.InitGame(Options, ErrorMessage);
	GameModes = ADGameModes;
}

event Broadcast(Actor Sender, coerce string Msg, optional name Type)
{
	local KFPlayerController KFPC;

	super.Broadcast(Sender, Msg, Type);

	if ( Type == 'Say' )
	{
		if(Msg ~= "!ot" && MyKFGRI.bTraderIsOpen)
		{
			KFPC = KFPlayerController(Sender);
			if(KFPC != none)
				KFPC.OpenTraderMenu();
		}
	}
}

static function bool GametypeChecksDifficulty()
{
    return false;
}

static function bool GametypeChecksWaveLength()
{
    return false;
}

function CreateOutbreakEvent()
{
	super.CreateOutbreakEvent();
	OutbreakEvent.SetActiveEvent(ContaminationModeIndex);
}

function bool UsesModifiedLength()
{
	return true;
}

function bool UsesModifiedDifficulty()
{
	return true;
}

function SetModifiedGameLength()
{
	GameLength = 2;
}

function SetModifiedGameDifficulty()
{
	if (OutbreakEvent == none)
	{
		CreateOutbreakEvent();
	}

	GameDifficulty = 3;
}

State TraderOpen
{
	function BeginState( Name PreviousStateName )
	{
		super.BeginState( PreviousStateName );
		SetTimer(0.5f, true, 'DecideDash');
	}
	function EndState( Name NextStateName )
	{
		super.EndState( NextStateName );
		ClearTimer('DecideDash');
		ModTraderDash(false);
	}
}

//	TraderDash
function DecideDash()
{
	ModTraderDash(GetStateName() == 'TraderOpen');
}

function ModTraderDash(bool bOpened)
{
	local KFPlayerController KFPC;
	local KFPawn Player;
	foreach WorldInfo.AllControllers(class'KFPlayerController', KFPC)
	{
		Player = KFPawn(KFPC.Pawn);
		if(Player!=None)
		{
			if ( bOpened && KFWeap_Edged_Knife(Player.Weapon)!=None ) Player.GroundSpeed = 364364.0f;
			else Player.UpdateGroundSpeed();
		}
	}
}

function WaveEnded( EWaveEndCondition WinCondition )
{
	if(WaveNum == WaveMax - 1 && WinCondition != WEC_TeamWipedOut)
	{
		DramaticEvent( 1, 6.f );
		WinMatch();
	}

	super.WaveEnded( WinCondition );
}

exec function MapVote()
{
	ShowPostGameMenu();
}

function bool AllowWaveCheats(){ return true; }

DefaultProperties
{
	SpawnManagerClasses(2)=class'AD_SpawnManager'
	GameReplicationInfoClass=class'AD_GameReplicationInfo'
	OutbreakEventClass=class'AD_OutbreakEvent'

	ADGameModes.Add((FriendlyName="AraaDefense",ClassNameAndPath="AreaDefense.AD_Survival",bSoloPlaySupported=True,DifficultyLevels=4,Lengths=4,LocalizeID=0))

    	GameInfoClassAliases.Add((ShortName="AreaDefense", GameClassName="AreaDefense.AD_Survival"))
}