void () Waypoint_Functions =
{
	switch (self.impulse)
	{
		case 15:
			Make_Special_Waypoint();
			break;
		case 10:
			Move_Waypoint();
			break;
		case 18:
			Remove_Waypoint ();
			break;
		case 21:
			Link_Waypoints ();
			break;
		case 20: 
			Dual_Link_Waypoints();
			break;
		case 22: 
			Auto_Link_Waypoints();
			break;
		case 101:
			Save_Waypoints();
			break;
		case 102:
			Load_Waypoints();
			break;
	}
	
	if(self.button7 && !self.semi)
	{
		self.semi = true;
		Dual_Link_Waypoints();
	}
	if (self.button0 && !self.semi)
	{
		Create_New_Waypoint();
		self.semi = true;
	}
	
	if (self.button1 && !self.semiuse)
	{
		Select_Waypoint();
		self.semiuse = true;
	}
	
	if(self.button4 && !self.semiuse)
	{
		self.semiuse = true;
		Move_Waypoint();
	}
	if(self.button6 && !self.semiuse)
	{
		Remove_Waypoint ();
		self.semiuse = true;
	}
	if(self.button5 && !self.semiuse)
	{
		Make_Special_Waypoint();
		self.semiuse = true;
	}
	
	if(!self.button0 && !self.button1 && !self.button4 && !self.button5 && !self.button6 && !self.button7)
	{
		self.semiuse = false;
		self.semi = false;
	}
	
	self.impulse = 0;
};

void () Waypoint_logic =
{
	Waypoint_Functions();
};