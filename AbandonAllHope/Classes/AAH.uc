class AAH extends KFGameInfo_WeeklySurvival
	config(AbandonAllHope);

var array<sGameMode> CWGameModes;

var config int Version;
var config bool bBeta1;
var config bool EnableOpenTrader;
var config bool EnableTraderDash;

event InitGame(string Options,  out string ErrorMessage)
{
	local string OptStr;

	SetupConfig();

	OptStr = class'GameInfo'.static.ParseOption(Options, "beta");
	if(OptStr != "") bBeta1 = bool(OptStr);
	
	super.InitGame(Options, ErrorMessage);

	GameModes = CWGameModes;
	SaveConfig();
}

function SetupConfig()
{
	if(Version < 1)
	{
		bBeta1 = false;
		EnableOpenTrader = true;
		EnableTraderDash = true;
		Version = 1;
	}
}

function BroadcastTeam( Controller Sender, coerce string Msg, optional name Type )
{
	Broadcast(Sender, Msg, 'Say');
}

event Broadcast(Actor Sender, coerce string Msg, optional name Type)
{
	super.Broadcast(Sender, Msg, Type);

	if ( Type == 'Say' )
	{
		Msg = Locs(Msg);
		if(Msg == "!ot") CC_OpenTrader(KFPlayerController(Sender));
	}
}

function CC_OpenTrader(KFPlayerController KFPC)
{
	if(GetStateName() == 'TraderOpen' && EnableOpenTrader) KFPC.OpenTraderMenu();
}

function CreateOutbreakEvent()
{
	super.CreateOutbreakEvent();

	ActiveEventIdx = bBeta1 ? 0 : 1;
	
	OutbreakEvent.SetActiveEvent(ActiveEventIdx);
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
	ModTraderDash(GetStateName() == 'TraderOpen' && EnableTraderDash);
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

exec function BetaVersion(bool b)
{
	bBeta1 = b;
	SaveConfig();
}

exec function EnableOT(bool b)
{
	EnableOpenTrader = b;
	SaveConfig();
}

exec function EnableDash(bool b)
{
	EnableTraderDash = b;
	SaveConfig();
}

DefaultProperties
{
	OutbreakEventClass=class'AAH_OutbreakEvent'
	PlayerControllerClass=class'AAH_PlayerController'

	CWGameModes.Add((FriendlyName="Weekly_AAH",ClassNameAndPath="Asapi.Weekly_AAH",bSoloPlaySupported=True,DifficultyLevels=4,Lengths=4,LocalizeID=0))

    	GameInfoClassAliases.Add((ShortName="Weekly_AAH", GameClassName="Asapi.Weekly_AAH"))
}