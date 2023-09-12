class AAH_PlayerController extends KFPlayerController_WeeklySurvival;

reliable client event TeamMessage( PlayerReplicationInfo PRI, coerce string S, name Type, optional float MsgLifeTime  )
{
	if ( PRI == None && S != "" && Type == 'Console')
	{
		LocalPlayer(Player).ViewportClient.ViewportConsole.OutputText("[Console Printer]\n  " $ Repl(S, "\n", "\n  "));
	}

	else if ( PRI == None && S != "" && TypeIsColor(Type) )
	{
		if ( None != MyGFxManager.PartyWidget )
		{
			MyGFxManager.PartyWidget.ReceiveMessage( S, string(Type) );
		}

		if (MyGFxManager != none)
		{
			if( None != MyGFxManager.PostGameMenu )
			{
				MyGFxManager.PostGameMenu.ReceiveMessage( S, string(Type) );
			}
		}

		if( None != MyGFxHUD && None != MyGFxHUD.HudChatBox )
		{
			MyGFxHUD.HudChatBox.AddChatMessage(S, string(Type));
		}
	}

	else if ( Type == 'MapVote' )
	{
		TeamMessage(None, S, '00DCCE');
	}

	else if ( Left(S, 4) == "!ano")
	{
		TeamMessage(None, "匿名: " $ Mid(S, 5), 'FFFFFF');
	}

	else if(!(StopBroadcast(S)))
	{
		// Everything else is processed as usual
		super.TeamMessage( PRI, S, Type, MsgLifeTime );
	}
}

function bool TypeIsColor(name Type){
	switch(Type){
		case '00FF0A': //Green
		case 'FF0000': //Red
		case 'F8FF00': //Yellow
		case '00DCCE': //Blue
		case 'FF20B7': //Pink
		case 'FFFFFF': //White
			return true;
	}
	return false;
}

function bool StopBroadcast(string s){
	switch(s){
		case "!ot":
		case "!cdr":
		case "!inpo":
		case "!admin":
			return true;
	}
	if(Left(s, 5) == "!tips") return true;
	return false;
}