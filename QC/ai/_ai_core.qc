void(float what) play_sound_z;

void() path_corner_touch =
{
	self.origin_z = self.origin_z + 32;
	setorigin(self, self.origin);
	self.classname = "path_corner";
	self.movetype = MOVETYPE_NONE;
	self.solid = SOLID_NOT;
	self.touch = SUB_Null;
	setsize(self, '0 0 0 ', '0 0 0');
	if(!self.target)
	{
		if (self.spawnflags & 1)
			return;
		bprint("path_corner with name: ");
		bprint(self.targetname);
		bprint(" has no target!\n");
	}
};
//We want the path corner to drop to the ground and then we set it up 32 units so it's exact
void() path_corner =
{
	self.classname = "path_corner_set";
	self.movetype = MOVETYPE_BOUNCE;
	self.solid = SOLID_BBOX;
	self.touch = path_corner_touch;
	setsize(self, '0 0 0 ', '0 0 0');
};
void removeZombie();

void() Respawn = 
{
	Current_Zombies = Current_Zombies - 1;
	removeZombie();
};

entity(entity blarg) find_new_enemy =
{
	local entity player;
	local entity closest;
	local float bestdist;
	local float dist;
	bestdist = 10000;
	if(self.classname == "ai_zombie")
	{
		player = find(world,classname,"monkey");
		if(player)
			return player;
		
		player = find(world,classname,"player");
		///////////////////////////////
		if(!player)
		{
			return world;
		}
		//////////////////////////////
		while(player)
		{
			dist = vlen(self.origin - player.origin);
			if (dist < bestdist)
			{
				closest = player;
				bestdist = dist;
				
			}
			player = find(player,classname,"player");
		}
		return closest;
		
	}
	else if(self.classname == "ai_hellhound")
	{
		if(self.enemy.classname == "player")
			return self.enemy;
		else
		{
			player = find(world,classname,"player");
			///////////////////////////////
			if(!player)
			{
				return world;
			}
			//////////////////////////////
			while(player)
			{
				dist = vlen(self.origin - player.origin);
				if (dist < bestdist)
				{
					closest = player;
					bestdist = dist;
					
				}
				player = find(player,classname,"player");
			}
			return closest;
			
		}	
		
	}
	bprint("Error: Find_New_Enemy returns world! \n");
	return world;
};


float() avoid_zombies =
{
	local entity ent;
	ent = findradius(self.origin,23);//22.67
	makevectors(self.angles);
	float left_amount, right_amount;
	left_amount = right_amount = 0;
	while(ent)
	{
		if(ent.classname == "ai_zombie" && ent != self)
		{
			local vector vec_b;
			local float dot;
			//vec_b = normalize(self.origin - ent.origin);
			//dot = v_right * vec_b;
			//dot = self.angles_y - (dot > 0.5) ? 90 :  270;
			
			vec_b = (self.origin - ent.origin);
			dot = (v_right_x * vec_b_x) + (v_right_y * vec_b_y);//dot product
			if(dot > 0)// on right
				right_amount++;
			else// on left
				left_amount++;
		}
		ent = ent.chain;
	}
	if(left_amount + right_amount == 0)
		return 0;
	
	return (left_amount > right_amount) ? 15 : -15;
};

float() push_away_zombies =
{
	local entity ent;
	ent = findradius(self.origin,11);
	float return_value;
	return_value = 0;
	while(ent)
	{
		if(ent.classname == "ai_zombie" && ent != self)
		{
			vector push;
			push = ent.origin - self.origin;
			push_z = 0;
			push = normalize(push) * 10;
			
			ent.velocity += push;
			return_value = 1;
		}
		ent = ent.chain;
	}
	return return_value;
}


void(float dist, vector vec) do_walk_to_vec =
{
	if(dist == 0)
		return;
	
	self.ideal_yaw = vectoyaw(vec - self.origin);
	if(self.outside == false)
	{
		push_away_zombies();
		//self.ideal_yaw += avoid_zombies(); //no longer relevant since our direction doesn't care about our yaw any more
	}
	ChangeYaw();
	vector new_velocity;
	
	float len;
	len = vlen(self.origin - vec);
	
	if(dist > len)//if we're moving past our goal position
	{
		dist = len;
	}
	//This movement method is moving directly towards the goal, regardless of where our yaw is facing (fixes several issues)
	new_velocity = normalize(vec - self.origin) * dist * 10;
	
	new_velocity_z = self.velocity_z;
	self.velocity = new_velocity;
};

void(float dist) do_walk =
{
	do_walk_to_vec(dist,self.goalentity.origin);
};


vector() get_window_origin =
{
	if(!self.used || self.used & WWINDOW)
		return self.goalentity.origin;
	if(self.used & WBOX1)
		return self.goalentity.box1;
	if(self.used & WBOX2)
		return self.goalentity.box2;
	if(self.used & WBOX3)
		return self.goalentity.box3;
	if(self.used & WIDLEBOX)
		return self.goalentity.idlebox;
	
	return self.goalentity.origin;
}

void(float dist) walk_to_window =
{
	do_walk_to_vec(dist,self.goalorigin);
};

void(vector org, float scale) interpolateToVector =
{
	self.origin_x += (org_x - self.origin_x) * scale;
	self.origin_y += (org_y - self.origin_y) * scale;
	setorigin(self,self.origin);
	self.zoom = 1;//value to let engine know to not check for collisions
}


float(vector where) nearby = 
{
	if(self.classname == "ai_zombie")
	{
		float xdist;
		float ydist;
		float zdist;
		xdist = fabs(self.origin_x - where_x);
		ydist = fabs(self.origin_y - where_y);
		zdist = fabs(self.origin_z - where_z);
		
		if(xdist < 4 && ydist < 4)//horizontal distance is fairly close
		{
			if(zdist < 50)//vertical distance just has to be arbitrarily close
			{
				return 1;
			}
		}
		return 0;
	}
	/*else if(self.classname == "ai_hellhound")
	{
		if(vlen(self.origin - what.origin) < 35)
		{
			if(vlen(self.origin - what.origin) < 6)
			{
				return 1;
			}
			else
			{
				interpolateToVector(what.origin,0.25);
			}
		}
	}*/
	return 0;
};

void(float dist) Window_Walk =
{
	if(self.reload_delay < time)
		Respawn();
	
	if(self.hop_step == 0)//following path corners
	{		
		if(self.goalentity == world)
		{
			if((!self.target) && (self.outside == TRUE))
			{
				bprint("Error: Outside zombie spawn point has no target.\n");
				Respawn();
			}
			self.goalentity = find(world,targetname, self.target);
			if(!self.goalentity)
			{
				bprint("Error: Outside zombie spawn point target does not exist.\n");
				Respawn();
			}
		}
		
		if(self.goalentity.classname == "path_corner" && nearby(self.goalentity.origin))
		{
			if (self.goalentity.spawnflags & 1) //this path corner sets zombie on inside.
			{
				self.outside = FALSE;
				self.goalentity = world;
				self.enemy = find_new_enemy(self);
				self.th_walk();
				return;
			}
			self.reload_delay = time + 30;
			self.goalentity = find(world,targetname,self.goalentity.target);
			
			//Assumption is that when the zombie is outside, we can always walk from one path_corner to the next in a straight line, any devation should be corrected by the mapper
		}
		
		do_walk(dist);
		
		if(self.goalentity.classname == "window")
		{
			if(!self.goalentity.used & WBOX1)
			{
				self.used = WBOX1;
				self.goalentity.used |= WBOX1;
				self.goalorigin = get_window_origin();
				self.hop_step = 3;
				self.reload_delay = time + 30;
			}
			else 	if(!self.goalentity.used & WBOX2)
			{
				self.used = WBOX2;
				self.goalentity.used |= WBOX2;
				self.goalorigin = get_window_origin();
				self.hop_step = 3;
				self.reload_delay = time + 30;
			}
			else 	if(!self.goalentity.used & WBOX3)
			{
				self.used = WBOX3;
				self.goalentity.used |= WBOX3;
				self.goalorigin = get_window_origin();
				self.hop_step = 3;
				self.reload_delay = time + 30;
			}
			else if(vlen(self.origin - self.goalentity.origin) < 150)
			{	
				//self.goalentity.used |= WIDLEBOX;//do not claim idlebox
				self.used = WIDLEBOX;
				self.goalorigin = get_window_origin();
				self.hop_step = 1;
				self.reload_delay = time + 30;
			}
			//else we continue walking to window until we either find one that's good, or we are close enough to chase idle_spot
		}
	}
	else if(self.hop_step == 1)//walking to the window's idle location
	{
		if(nearby(self.goalorigin))
		{
			self.hop_step = 2;
			self.reload_delay = time + 30;
			self.th_idle();
		}
		else
		{
			walk_to_window(dist);
		}
	}
	else if(self.hop_step == 2)//we're at idle box, waiting for a window attack box to be free...
	{
		if(!self.goalentity.used & WBOX1)
		{
			self.used = WBOX1;
			self.goalentity.used |= WBOX1;
			self.goalorigin = get_window_origin();
			self.hop_step = 3;
			self.reload_delay = time + 30;
			self.th_walk();
		}
		else if(!self.goalentity.used & WBOX2)
		{
			self.used = WBOX2;
			self.goalentity.used |= WBOX2;
			self.goalorigin = get_window_origin();
			self.hop_step = 3;
			self.reload_delay = time + 30;
			self.th_walk();
		}
		else if(!self.goalentity.used & WBOX3)
		{
			self.used = WBOX3;
			self.goalentity.used |= WBOX3;
			self.goalorigin = get_window_origin();
			self.hop_step = 3;
			self.reload_delay = time + 30;
			self.th_walk();
		}
	}
	else if(self.hop_step == 3)//walking to window attack box
	{
		if(nearby(self.goalorigin))
		{
			self.hop_step = 4;
			self.reload_delay = time + 30;
			self.th_idle();
		}
		else
		{
			walk_to_window(dist);
			/*if(vlen(self.origin - self.lastOrg) < dist/2)
			{
				if(self.OrgStuckCount >= 5)
				{
					self.origin = self.goalorigin;
					setorigin(self,self.origin);
					self.OrgStuckCount = 0;
					return;
				}
				self.OrgStuckCount++;
				self.lastOrg = self.origin;
			}*/
		}
	}
	else if(self.hop_step == 4)//attacking box
	{
		if(self.chase_time < time)
		{
			if(self.angles_z != self.goalentity.angles_z)
			{
				self.ideal_yaw = self.goalentity.angles_z;
				ChangeYaw();
				return;
			}
			if(self.goalentity.health > 0)
			{
				self.reload_delay = time + 30;
				self.th_melee();				
				if(rounds <= 5)
					self.chase_time = time + 1.5;
				else
					self.chase_time = time + 0.75;
				return;
			}
		}
		if(self.goalentity.health <= 0)
		{
			self.outside = 2;
			self.chase_time = 0;
			self.hop_step = 0;
		}
		else return;
	}
};

void(float dist) Window_Hop =
{
	if(self.hop_step == 0)
	{
		if(self.used & WBOX1)//we're at center box.
		{
			self.hop_step = 4;
		}
		else
		{
			self.hop_step = 1;//wait for box1 to be free so we can claim it and walk to it.
			self.th_idle();
		}
	}
	if(self.hop_step == 1)//waiting idly for box1 to be free, when free, we will claim it.
	{
		if(!self.goalentity.used & WBOX1 || ((self.used&WBOX1) && (self.goalentity.used&WBOX1)))
		{
			//self.goalentity.used &= ~self.used;//sigh... QC...
			self.goalentity.used -= (self.goalentity.used & self.used);
			self.used = WBOX1;
			self.goalentity.used |= WBOX1;
			self.goalorigin = get_window_origin();
			self.hop_step = 2;
			self.th_walk();
		}
	}
	if(self.hop_step == 2)//we've claimed it, walk to box1
	{
		if(nearby(self.goalorigin))
		{
			self.hop_step = 4;
			self.angles = self.goalentity.angles;
		}
		else
		{
			walk_to_window(dist);
		}
	}
	
	if(self.hop_step == 4 && self.chase_time < time)//we're at this step because we already own box1, so don't even check if window is busy...
	{
		if(!self.goalentity.used & WWINDOW)
		{
			self.hop_step = 5;
			self.angles = self.goalentity.angles;
			self.goalentity.used -= (self.goalentity.used & WBOX1);
			self.goalentity.used |= WWINDOW;
			//self.goalentity.used &= ~self.used;//sigh... QC...
			self.used = WWINDOW;
			self.chase_time = 0;
			self.th_windowhop();
			return;
		}
		else
		{
			self.tries++;
			self.chase_time = time + 0.2;
			if(self.tries > 10)
			{
				//self.goalentity.used &= ~WWINDOW;//sigh... QC...
				self.goalentity.used -= (self.goalentity.used & WWINDOW);
			
			}
		}
	}
	
	if(self.hop_step == 6)
	{
		self.outside = FALSE;
		//self.goalentity.used &= ~WWINDOW;//sigh... QC...
		self.goalentity.used -= (self.goalentity.used & WWINDOW);
		self.used = 0;
		self.goalentity = world;
		self.enemy = find_new_enemy(self);
		//self.th_die();
		self.th_walk();
	}
};

float() TryWalkToEnemy =
{
	//was tracebox
	local float TraceResult;
	TraceResult = tracemove(self.origin,VEC_HULL_MIN,VEC_HULL_MAX,self.enemy.origin,TRUE,self);
	if(TraceResult == 1)
	{
		self.goalentity = self.enemy;
		self.chase_time = time + 7;
		return 1;
	}
	else
	{	
		return 0;	
	}		
};


float() SetUpGoalDummy =
{
	self.goaldummy.origin = Get_Waypoint_Near(self);
	setorigin(self.goaldummy,self.goaldummy.origin);
	self.goalentity = self.goaldummy;
	if (self.goalentity)
	{
		//setmodel(self.goalentity, "progs/Props/teddy.mdl");//on  waypoint
		//if (cvar("developer"))
	}
	else
		bprint("Could not find waypoint for zombie\n");
	
	return 1;//because we can't actually know if it was good or not... yet
};

void() PathfindToEnemy =
{
	float path_success;
	path_success = Do_Pathfind(self,self.enemy);
	if(path_success ==1)
	{
		self.goaldummy.origin = Get_First_Waypoint(self,self.origin,VEC_HULL_MIN,VEC_HULL_MAX);
		setorigin(self.goaldummy,self.goaldummy.origin);
		self.goalentity = self.goaldummy;
		self.chase_time = time + 7;
	}
	else if(path_success == -1)
	{
		self.goalentity = self.enemy;
		self.chase_time = time + 6;
	}
	else
	{
		bprint("FirstPathfind Failure\n");
	}
}

void() NextPathfindToEnemy =
{
	float path_success;
	path_success = Do_Pathfind(self,self.enemy);
	if(path_success ==1)
	{
		self.goaldummy.origin = Get_Next_Waypoint(self,self.origin,VEC_HULL_MIN,VEC_HULL_MAX);
		setorigin(self.goaldummy,self.goaldummy.origin);
		self.goalentity = self.goaldummy;
		self.chase_time = time + 7;
	}
	else if(path_success == -1)
	{
		self.goalentity = self.enemy;
		self.chase_time = time + 6;
	}
	else
	{
		bprint("NextPathfind Failure\n");
	}
}


void(float dist) Inside_Walk =
{
	if(self.enemy_timeout < time || self.enemy == world)
	{
		self.enemy_timeout = time + 5;
		local entity oldEnemy;
		oldEnemy = self.enemy;
		self.enemy = find_new_enemy(self);
	}
	//================Check for proximity to player ===========
	if(vlen(self.enemy.origin - self.origin) < 60)
	{
		if(self.enemy.classname == "monkey")
			self.th_idle();
		
		if(self.attack_delay < time)
		{
			self.attack_delay = time + 1 + (1 * random());
			self.th_melee();  
			self.goalentity = self.enemy;
			self.chase_time = time + 5;
		}
		return;
	}
	
	if(vlen(self.enemy.origin - self.origin) < 600)//50 feet
	{
		if(self.goalentity == self.enemy && self.chase_enemy_time > time)
		{
			return;
		}
		if(TryWalkToEnemy())
		{
			self.chase_enemy_time = time + 0.5;
			return;
		}
	}
	if(self.goalentity == self.enemy)
	{
		self.goalentity = self.goaldummy;
		self.chase_time = 0;
	}
	//============= No Target ====================
	if(self.goalentity == world)//not sure when this would ever occur... but whatever.
		self.goalentity = self.goaldummy;
	//============ GoalDummy is Target ============
	if(self.goalentity == self.goaldummy)
	{
		if(nearby(self.goaldummy.origin))
		{
			NextPathfindToEnemy();
		}
		if(self.chase_time < time)
		{
			if(self.goaldummy.origin != world.origin && tracemove(self.origin,VEC_HULL_MIN,VEC_HULL_MAX,self.goalentity.origin,TRUE,self) == 1)
			{
				self.chase_time = time + 7;
			}
			else
			{
				PathfindToEnemy();
			}
		}
	}
};


float(float dist) CheckForNearbyZombies =
{
	local entity ent;
	ent = findradius(self.origin,10);//22.67, 23
	makevectors(self.angles);
	while(ent)
	{
		if(ent.classname == "ai_zombie" && ent != self)
		{
			//local vector vec_b;
			//local float yaw_angle;
			//vec_b = normalize(self.origin - ent.origin);
			//yaw_angle = v_right * vec_b;
			//yaw_angle = self.angles_y - (yaw_angle > 0.5) ? 90 :  270;
			
			local float yaw_angle;
			
			yaw_angle = vectoyaw(self.origin - ent.origin);
			yaw_angle += 180;
			while(yaw_angle < -180)
				yaw_angle += 180;
			while(yaw_angle > 180)
				yaw_angle -= 180;
			
			self.ideal_yaw = yaw_angle;
			ChangeYaw();
			
			vector new_velocity;
			new_velocity = self.velocity;
			//move towards my angle
			makevectors(self.angles);
			new_velocity = v_forward * dist * 10;//temp, the 10 is misleading atm
			new_velocity_z = self.velocity_z;
			self.velocity = new_velocity;
			return 0;//might have issues here... :(
		}
		ent = ent.chain;
	}
	return 0;
};

void(float dist) Zombie_Walk = 
{
	//Resetting velocity from last frame (except for vertical)
	self.velocity_x = 0;
	self.velocity_y = 0;
	//self.flags = self.flags | FL_PARTIALGROUND;
	//check_onfire();
	if (!(self.flags & FL_ONGROUND))
	{
	//	bprint("not on ground\n");
		self.th_fall();
		return;
	}
	//else
	//	bprint("on ground\n");
	
	if(self.outside == TRUE)
	{
		//handle special walk case for walking to org
		Window_Walk(dist);
		return;
	}
	
	if(self.outside == 2)
	{
		//play_sound_z(2);
		Window_Hop(dist);
		//handle special walk case for walking to org
		return;
	}
	if(self.outside == FALSE)
	{
		if(self.goalentity == self.enemy)
		{
			if(vlen(self.origin - self.enemy.origin) < 60)
			{
				return;
			}
		}
	}
	do_walk(dist);
};
void() Zombie_AI =
{
	//dist = 0;
	float dist = 0;
	self.flags = self.flags | FL_PARTIALGROUND;
	//check_onfire();
	if (!(self.flags & FL_ONGROUND))
	{
		//self.th_fall();
		//return;
	}
	
	if(self.outside == TRUE)
	{
		play_sound_z(2);
		//self.calc_time = time + (0.3 * random());
		//Window_Walk(dist);
		return;
	}
	else if(self.outside == 2)
	{
		play_sound_z(2);
		//Window_Hop(0);
		return;
	}
	else if(self.outside == FALSE)
	{
		//if(CheckForNearbyZombies(dist) == 1)
		//{
		//	return;
		//}
		
		/*if((self.calc_time >= time))
		{
			//if(!dist)
			//	return;
			if(self.goalentity == self.enemy)
			{
				if(vlen(self.origin - self.enemy.origin) < 60)
				{
					return;
				}
			}
			//do_walk(dist);
		}*/
		//else
		//{
			play_sound_z(2);
			//self.calc_time = time + (0.25 + (0.15 * random()));
			Inside_Walk(dist);
		//}
	}
};

//This function ensures that only one zombie's ai is done at a time, brings down lag significantly
void() Do_Zombie_AI =
{
	local entity z;
	
	z = find(lastzombie,aistatus,"1");
	if(z == world)
	{
		z = find(world,aistatus,"1");
		if(z == world)
		{
			return;//no zombies alive.
		}
	}
	local entity oself;	
	oself = self;
	self = z;
	//if(z.classname == "ai_zombie")//removed because only zombies atm
	Zombie_AI();
	self = oself;
	lastzombie = z;
};