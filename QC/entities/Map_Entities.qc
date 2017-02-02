void() func_wall =
{
	self.angles = '0 0 0';
	self.movetype = MOVETYPE_PUSH;	// so it doesn't get pushed by anything
	self.solid = SOLID_BSP;
	setmodel (self, self.model);
};

void() func_illusionary =
{
	self.angles = '0 0 0';
	self.movetype = MOVETYPE_NONE;
	self.solid = SOLID_NOT;
	setmodel (self, self.model);
	// makestatic (self); // dr_mabuse1981: dont use makestatic, it doesnt show the HL rendermodes then.
};


//weapon buying code
void(entity person, float expamt , float doublepoint) addmoney =
{
	if (person.classname != "player")
		return;

	if (expamt > 0 && doublepoint == TRUE && x2_finished> time)
		person.points = person.points + expamt*2;
	else
		person.points = person.points + expamt;
};

// button and multiple button

void() button_wait;
void() button_return;

void() button_wait =
{
	self.state = STATE_TOP;
	self.nextthink = self.ltime + self.wait;
	self.think = button_return;
	activator = self.enemy;
	SUB_UseTargets();
	self.frame = 1;			// use alternate textures
};

void() button_done =
{
	self.state = STATE_BOTTOM;
};

void() button_return =
{
	self.state = STATE_DOWN;
	SUB_CalcMove (self.pos1, self.speed, button_done);
	self.frame = 0;			// use normal textures
	if (self.health)
		self.takedamage = DAMAGE_YES;	// can be shot again
};


void() button_blocked =
{	// do nothing, just don't ome all the way back out
};


void() button_fire =
{
	if (self.state == STATE_UP || self.state == STATE_TOP)
		return;

	sound (self, CHAN_VOICE, self.noise, 1, ATTN_NORM);

	self.state = STATE_UP;
	SUB_CalcMove (self.pos2, self.speed, button_wait);
};


void() button_use =
{
	self.enemy = activator;
	button_fire ();
};

void() button_touch =
{
	if (other.classname != "player")
		return;
	
	if(self.cost)
	{
		if(self.state == STATE_BOTTOM||self.state == STATE_DOWN)
		{
			centerprint(other,"Press use to buy [cost:");
			centerprint(other,ftos(self.cost));
			centerprint(other,"]\n");
			if (other.button1)
			{
				if(other.points >= self.cost)
				{
					self.enemy = other;
					addmoney(other, 0 - self.cost, FALSE);
					button_fire();
					return;
				}
				else
				{
					centerprint(other,"You do not have enough points\n");
				}
			}
		}
	}
	else
	{
	self.enemy = other;
	button_fire ();
	}
};

void() button_killed =
{
	self.enemy = damage_attacker;
	self.health = self.max_health;
	self.takedamage = DAMAGE_NO;	// wil be reset upon return
	button_fire ();
};


/*QUAKED func_button (0 .5 .8) ?
When a button is touched, it moves some distance in the direction of it's angle, triggers all of it's targets, waits some time, then returns to it's original position where it can be triggered again.

"angle"		determines the opening direction
"target"	all entities with a matching targetname will be used
"speed"		override the default 40 speed
"wait"		override the default 1 second wait (-1 = never return)
"lip"		override the default 4 pixel lip remaining at end of move
"health"	if set, the button must be killed instead of touched
"sounds"
0) steam metal
1) wooden clunk
2) metallic click
3) in-out
*/

void() func_button =
{
	SetMovedir ();
	
	self.movetype = MOVETYPE_PUSH;
	self.solid = SOLID_BSP;
	setmodel (self, self.model);

	self.blocked = button_blocked;
	self.use = button_use;
	
	if (self.health)
	{
		self.max_health = self.health;
		self.th_die = button_killed;
		self.takedamage = DAMAGE_YES;
	}
	else
		self.touch = button_touch;

	if (!self.speed)
		self.speed = 40;
	if (!self.wait)
		self.wait = 1;
	if (!self.lip)
		self.lip = 4;

	self.state = STATE_BOTTOM;

	self.pos1 = self.origin;
	self.pos2 = self.pos1 + self.movedir*(fabs(self.movedir*self.size) - self.lip);
};

.float sequence;
void() flame_update = {
	particle (self.origin, v_up*8, 111, 0);
	self.think = flame_update;
	self.nextthink = time + random()+0.1;
}
void() place_fire =
{
	particle (self.origin, v_up*8, self.frame, 0);
	self.think = flame_update;
	self.nextthink = time + random()+0.1;
};

void() place_model =
{
	precache_model (self.model);
	setmodel (self, self.model);
	
	self.skin = 0;
	setsize (self, VEC_HULL2_MIN, VEC_HULL2_MAX);
	self.angles = self.angles;
	self.solid = SOLID_NOT;
	self.frame = self.sequence;
	
	if (self.spawnflags & 1)
		self.effects = self.effects | EF_FULLBRIGHT;
};

void(float weptype) precache_extra =
{
	if (weptype == W_COLT)
	{
		precache_sound("weapons/colt/shoot.wav");
		precache_sound("weapons/colt/magout.wav");
		precache_sound("weapons/colt/magin.wav");
	}
	else if (weptype == W_KAR)
	{
		precache_sound ("weapons/kar/boltup.wav");
		precache_sound ("weapons/kar/boltback.wav");
		precache_sound ("weapons/kar/boltforward.wav");
		precache_sound ("weapons/kar/boltdown.wav");
		precache_sound ("weapons/kar/clipin.wav");
		precache_sound ("weapons/kar/clipoff.wav");
		precache_sound ("weapons/kar/shoot.wav");
	}
	else if (weptype == W_THOMPSON)
	{
		precache_sound("weapons/tommy/magout.wav");
		precache_sound("weapons/tommy/magin.wav");
		precache_sound("weapons/tommy/boltback.wav");
		precache_sound("weapons/tommy/shoot.wav");
	}/*
	else if (weptype == W_BIATCH)
	{
		precache_model("progs/v_biatch_left.mdl");
		precache_model("progs/v_biatch_right.mdl");
		precache_sound("weapons/biatch/magout.wav");
		precache_sound("weapons/biatch/magin.wav");
		precache_sound("weapons/biatch/slideback.wav");
		precache_sound("weapons/biatch/sliderelease.wav");
	}*/
	else if (weptype == W_RAY)
	{
		precache_sound("weapons/raygun/open.wav");
		precache_sound("weapons/raygun/out.wav");
		precache_sound("weapons/raygun/in.wav");
		precache_sound("weapons/raygun/close.wav");
		precache_sound("weapons/raygun/shoot.wav");
		//precache_model ("progs/raybeam.mdl");
	}
	/*else if (weptype == W_BETTY)
	{
		precache_model ("progs/g_betty.mdl");
	}*/
	else if (weptype == W_KAR_SCOPE)
	{
		precache_sound ("weapons/kar/boltup.wav");
		precache_sound ("weapons/kar/boltback.wav");
		precache_sound ("weapons/kar/boltforward.wav");
		precache_sound ("weapons/kar/boltdown.wav");
		precache_sound ("weapons/kar/clipin.wav");
		precache_sound ("weapons/kar/clipoff.wav");
		precache_sound ("weapons/kar/insert.wav");
		precache_sound ("weapons/kar/shoot.wav");
		precache_model ("progs/VModels/v_karscope.mdl");
	}
	else if (weptype == W_BAR)
	{
		precache_sound("weapons/bar/shoot.wav");
		precache_sound("weapons/bar/magout.wav");
		precache_sound("weapons/bar/magin.wav");
		precache_sound("weapons/bar/maghit.wav");
	}
	else if (weptype == W_M1A1)
	{
		precache_sound("weapons/m1carbine/shoot.wav");
		precache_sound("weapons/m1carbine/magout.wav");
		precache_sound("weapons/m1carbine/magin.wav");
		precache_sound("weapons/m1carbine/maghit.wav");
		precache_sound("weapons/m1carbine/bolt.wav");
	}
	/*else if (weptype == W_TESLA)
	{
		precache_sound("weapons/tesla/switchoff.wav");
		precache_sound("weapons/tesla/pulllever.wav");
		precache_sound("weapons/tesla/glassbreak.wav");
		precache_sound("weapons/tesla/clipin.wav");
		precache_sound("weapons/tesla/clipoff.wav");
		precache_sound("weapons/tesla/switchon.wav");
		precache_sound("weapons/tesla/shoot.wav");
	}*/
	else if (weptype == W_TYPE)
	{
		precache_sound("weapons/type100/magout.wav");
		precache_sound("weapons/type100/magin.wav");
		precache_sound("weapons/type100/boltpull.wav");
		precache_sound("weapons/type100/shoot.wav");
	}
	else if (weptype == W_SAWNOFF)
	{
		precache_sound("weapons/shotgun/open.wav");
		precache_sound("weapons/shotgun/out.wav");
		precache_sound("weapons/shotgun/in.wav");
		precache_sound("weapons/shotgun/close.wav");
		precache_sound("weapons/shotgun/shoot.wav");
		//precache_model("progs/v_snuff_left.mdl");
		//precache_model("progs/v_snuff_right.mdl");
	}
	else if (weptype == W_PPSH)
	{
		precache_sound("weapons/ppsh/magout.wav");
		precache_sound("weapons/ppsh/magin.wav");
		precache_sound("weapons/ppsh/maghit.wav");
		precache_sound("weapons/ppsh/boltback.wav");
		precache_sound("weapons/ppsh/boltrelease.wav");
		precache_sound("weapons/ppsh/shoot.wav");
	}
	else if (weptype == W_DB)
	{
		precache_sound("weapons/shotgun/open.wav");
		precache_sound("weapons/shotgun/out.wav");
		precache_sound("weapons/shotgun/in.wav");
		precache_sound("weapons/shotgun/close.wav");
		precache_sound("weapons/shotgun/shoot.wav");
	}
	else if (weptype == W_FG)
	{
		precache_sound("weapons/fg42/magout.wav");
		precache_sound("weapons/fg42/magin.wav");
		precache_sound("weapons/fg42/boltback.wav");
		precache_sound("weapons/fg42/boltforward.wav");
		precache_sound("weapons/fg42/shoot.wav");
	}
	else if (weptype == W_TRENCH)
	{
		precache_sound ("weapons/shotgun/pump.wav");
		precache_sound ("weapons/shotgun/insert.wav");
		precache_sound ("weapons/shotgun/shoot.wav");
	}
	else if (weptype == W_MG)
	{
		precache_sound("weapons/mg42/magout.wav");
		precache_sound("weapons/mg42/magin.wav");
		precache_sound("weapons/mg42/charge.wav");
		precache_sound("weapons/mg42/shoot.wav");
	}
	else if (weptype == W_GEWEHR)
	{
		precache_sound ("weapons/gewehr/magout.wav");
		precache_sound ("weapons/gewehr/magin.wav");
		precache_sound ("weapons/gewehr/maghit.wav");
		precache_sound ("weapons/gewehr/boltrelease.wav");
		precache_sound ("weapons/gewehr/shoot.wav");
	}
	else if (weptype == W_BROWNING)
	{
		precache_sound ("weapons/browning/boltback.wav");
		precache_sound ("weapons/browning/topopen.wav");
		precache_sound ("weapons/browning/chainoff.wav");
		precache_sound ("weapons/browning/boltback.wav");
		precache_sound ("weapons/browning/topopen.wav");
		precache_sound ("weapons/browning/chainon.wav");
		precache_sound ("weapons/browning/chainplace.wav");
		precache_sound ("weapons/browning/topclose.wav");
		precache_sound ("weapons/browning/tophit.wav");
		precache_sound ("weapons/browning/boltforward.wav");
		precache_sound ("weapons/browning/shoot.wav");
	}
	else if (weptype == W_357)
	{
		precache_sound("weapons/357/open.wav");
		precache_sound("weapons/357/out.wav");
		precache_sound("weapons/357/in.wav");
		precache_sound("weapons/357/close.wav");
		precache_sound("weapons/357/shoot.wav");
	}
	else if (weptype == W_M1)
	{
		precache_sound ("weapons/m1garand/clipout.wav");
		precache_sound ("weapons/m1garand/clipin.wav");
		precache_sound ("weapons/m1garand/clippush.wav");
		precache_sound ("weapons/m1garand/boltrelease.wav");
		precache_sound ("weapons/m1garand/shoot.wav");
	}/*
	else if (weptype == W_BIATCH)
	{
		precache_sound("weapons/colt/shoot.wav");
		precache_sound("weapons/colt/magout.wav");
		precache_sound("weapons/colt/magin.wav");
		precache_sound ("weapons/papfire.wav");
	}*/
	else if (weptype == W_MP40)
	{
		precache_sound ("weapons/mp40/shoot.wav");
		precache_sound ("weapons/mp40/magout.wav");
		precache_sound ("weapons/mp40/magin.wav");
	}
	else if (weptype == W_PANZER)
	{
		precache_sound ("weapons/panzer/move.wav");
		precache_sound ("weapons/panzer/insert.wav");
		precache_sound ("weapons/panzer/shoot.wav");
		//precache_model ("progs/shark.mdl");
	}
	else if (weptype == W_PTRS)
	{
		precache_sound ("weapons/ptrs/open.wav");
		precache_sound ("weapons/ptrs/maghit.wav");
		precache_sound ("weapons/ptrs/magin.wav");
		precache_sound ("weapons/ptrs/close.wav");
		precache_sound ("weapons/ptrs/shoot.wav");
	}
	else if (weptype == W_BK)
	{
		//precache_sound ("weapons/bounce.wav");
	}
	else if (weptype == W_STG)
	{		
		precache_sound ("weapons/stg/magout.wav");
		precache_sound ("weapons/stg/magin.wav");
		precache_sound ("weapons/stg/shoot.wav");

	}
	else if (weptype == W_M2)
	{
		precache_sound("weapons/flamethrower.wav");
		//precache_model ("progs/on_fire.mdl");
	}
};

//.string message2;

.float cost;
.float cost2;
float(float wep) getWeaponAmmo;
float(float wep) getWeaponMag;
float(float wep, float frametype) GetFrame;
void Set_W_Frame (float startframe, float endframe, float duration, float funccalledin, float animtype, void() endanimfunc, string set_model, float dontstartnew);
void() ReturnWeaponModel;
void () buy_weapon_touch =
{
	entity oldent;
	entity old_Self;
	local float tempf, tempf1, tempf2;
	local float startframe,endframe;
	local string modelname;

	if (other.classname != "player" || cvar("waypoint_mode") || other.downed)
		return;
	
	//centerprints*/
	if (self.weapon == W_BOWIE)
	{
		if (!other.bowie)
			useprint (other, 3, self.cost, self.weapon);
		if (!other.bowie && other.button1 && !other.semiuse)
		{
			if (other.points < self.cost)
			{
				centerprint(other, "You do not have enough points\n");
				return;
			}
			else
			{
				sound(self, 0,"misc/ching.wav", 1, 1);
				//other.boughtweapon = true;
				other.bowie = true;
				other.reload_delay = 0;
				old_Self = self;
				self = other;
				Set_W_Frame (12, 29, 1.8, 0, 0, ReturnWeaponModel, "progs/VModels/v_bowie.mdl", true);
				addmoney(other, 0 - old_Self.cost, FALSE);
				self = old_Self;
				other.semiuse = true;
				//if (!self.bought)
				//	other.total_bought = other.total_bought + 1;
				if (self.enemy)
				{
					oldent = self;
					self = self.enemy;
					self.use();
					self = oldent;
				}
				return;
			}
		}
		else if (other.bowie)
			return;
	}
	if (self.weapon == W_BETTY)
	{
		useprint (other, 3, self.cost2, self.weapon);
		if (!other.button1 || other.semiuse)
			return;
		if (other.points < self.cost)
		{
			centerprint(other, "You do not have enough points\n");
			return;
		}
		else
		{
			other.reload_delay = 0;
			sound(self, 0,"misc/ching.wav", 1, 1);
			other.grenades = other.grenades | 2; 
			addmoney(other, 0 - self.cost, FALSE);
			other.secondary_grenades = 2;
			if (self.enemy)
			{
				oldent = self;
				self = self.enemy;
				self.use();
				self = oldent;
			}
		}
		//if (!self.bought)
		//	other.total_bought = other.total_bought + 1;
		other.semiuse = true;
		return;
	}
	else if (self.weapon == W_GRENADE)
	{
		if (other.primary_grenades < 4)
			useprint (other, 3, self.cost2, self.weapon);
		else
			return;
		if (!other.button1 || other.semiuse)
			return;
		if (other.points < self.cost)
		{
			centerprint(other, "You do not have enough points\n");
			return;
		}
		else
		{
			other.reload_delay = 0;
			sound(self, 0,"misc/ching.wav", 1, 1);
			//other.boughtweapon = true;
			addmoney(other, 0 - self.cost, FALSE);
			other.primary_grenades = 4;
			if (self.enemy)
			{
				oldent = self;
				self = self.enemy;
				self.use();
				self = oldent;
			}
		}
		other.semiuse = true;
		return;
	}
	if (self.weapon == other.weapon || self.weapon == other.secondaryweapon/* || self.weapon == other.weapon3*/)
	{
		entity tempe1;
		//centerprint(other, self.message2);
		useprint (other, 3, self.cost2, self.weapon);
		if (!other.button1 || other.semiuse)
			return;
		if ((self.weapon == other.weapon && other.currentammo >= getWeaponAmmo(self.weapon)) || (self.weapon == other.secondaryweapon && other.secondaryammo >= getWeaponAmmo(self.weapon))/* || (self.weapon == other.weapon3 && other.weaponslot3.cur_ammo >= self.weaponslot1.max_spare)*/)//loong if statement, basicaly if one of players weaponslot is same as buy_weapons weaponslot then check if that weaponslots ammo is same or higher than max
			return;
		other.semiuse = true;
		if (other.points < self.cost2)
		{
			centerprint(other, "You do not have enough points\n");
			return;
		}
		if (self.weapon == other.weapon)
			other.currentammo = getWeaponAmmo(self.weapon);
		else if (self.weapon == other.secondaryweapon)
			other.secondaryammo = getWeaponAmmo(self.weapon);
		/*else if (self.weapon == other.weapon3)
			other.weaponslot3.cur_ammo = self.weaponslot1.max_spare;*/
		sound(self, 0,"misc/ching.wav", 1, 1);
		other.reload_delay = 0;
		addmoney(other, -1*self.cost2, 0);
		if (self.enemy)
		{
			oldent = self;
			self = self.enemy;
			self.use();
			self = oldent;
		}
		
		tempe1 = self;
		self = other;
		//UpdateWeapons(0);
		self = tempe1;
	}
	/*else if (EqualPapWeapon(other.weapon, 1) == self.weapon || EqualPapWeapon(other.secondaryweapon, 1) == self.weapon || EqualPapWeapon(other.weapon3, 1) == self.weapon)
		centerprint(other, "Press use to buy ammo [4500]");*/
	else
	{
		entity tempe;

		//centerprint(other, self.message);
		useprint (other, 4, self.cost, self.weapon);
		if (!other.button1 || other.semiuse)
			return;
		other.semiuse = 1;
		if (other.points < self.cost)
		{
			centerprint (other, "Not enough points\n");
			return;
		}

		if (other.weapon && !other.secondaryweapon)
		{
			tempf = other.currentammo;
			other.currentammo = other.secondaryammo;
			other.secondaryammo = tempf;

			tempf1 = other.currentmag;
			other.currentmag = other.secondarymag;
			other.secondarymag = tempf1;

			tempf2 = other.weapon;
			other.weapon = other.secondaryweapon;
			other.secondaryweapon = tempf2;
		}
		else if (other.weapon && other.secondaryweapon)
		{
			other.currentammo = 0;
			other.currentmag = 0;
			other.weapon = 0;
		}
		/* insert here mule kick thingy*/
		sound(self, 0,"misc/ching.wav", 1, 1);
		other.reload_delay = 0;
		addmoney(other, -1*self.cost, 0);
		if (self.enemy)
		{
			oldent = self;
			self = self.enemy;
			self.use();
			self = oldent;
		}
		other.weapon = self.weapon;
		other.currentammo = getWeaponAmmo(self.weapon);
		other.currentmag = getWeaponMag(self.weapon);
		tempe = self;
		self = other;
		//UpdateWeapons(1);
		startframe = GetFrame(self.weapon,TAKE_OUT_START);
		endframe = GetFrame(self.weapon,TAKE_OUT_END);
		modelname = GetWeaponModel(self.weapon, 0);
		//if (self.weaponslot1.dualwield)
		//	Set_W2_Frame (self.weaponslot1.TakeWeaponStart, self.weaponslot1.TakeWeaponEnd, 0, 0, 0, SUB_Null, self.weaponslot1.v_model2, false);//FIXME
		Set_W_Frame (startframe, endframe, 0, 0, 0, SUB_Null, modelname, false);//FIXME
		self = tempe;
	}
};

void() buy_weapon_link_wall =
{
	entity ent;
	
	ent = find (world, targetname, self.target);
	
	if (ent.classname == "weapon_wall")
		self.enemy = ent;
}

void() buy_weapon =
{
	/*if (gametype == 1 && self.weapon != IT_BOWIE)
	{
		remove (self);
		return;
	}*/
	local string weaponname;
	InitTrigger ();
	weaponname = GetWeaponModel (self.weapon, 0);
	if (weaponname != "")
		precache_model (weaponname);
	weaponname = GetWeaponModel(self.weapon, 1);
	if (weaponname != "")
		precache_model (weaponname);
	
	/*if (self.weapon == IT_BOWIE)
		precache_model ("progs/v_bowie.mdl");
	if (self.weapon == IT_BETTY)
		precache_model ("progs/v_betty.mdl");*/
	
	precache_extra (self.weapon);
	self.touch = buy_weapon_touch;
	//total_buy = total_buy + 1;
	
	self.think = buy_weapon_link_wall;
	self.nextthink = time + 0.2; 
};
entity last_act_trigger;
void() trigger_activator_touch =
{
	
	other.cost = other.cost +1; //hack, we can only touch one of thease at the time
	if (other.classname != "player" || last_act_trigger == self || other.cost > 1)
		return;
	last_act_trigger = self;

	entity t;
	float tempcount, temptotal,breakthis;
	string tempstring;
	tempcount = 1;
	t = world;
	do
	{
		t = find (t, classname, "spawn_zombie");
		if (!t)
		{
			breakthis = 1;
		}
		if (t.classname == "spawn_zombie")
		{
			t.classname = "spawn_zombie_away";
			if (cvar("developer"))
				setmodel(t, "progs/player.mdl");
		}
	} while (!breakthis);
	
	if (self.target2)
		tempcount =+ 1;
	if (self.target3)
		tempcount =+ 1;
	if (self.target4)
		tempcount =+ 1;
	if (self.target5)
		tempcount =+ 1;
	if (self.target6)
		tempcount =+ 1;
	if (self.target7)
		tempcount =+ 1;
	if (self.target8)
		tempcount =+ 1;
	if (self.target2)
		tempcount = tempcount + 1;
	if (self.target3)
		tempcount = tempcount + 1;
	if (self.target4)
		tempcount = tempcount + 1;
	if (self.target5)
		tempcount = tempcount + 1;
	if (self.target6)
		tempcount = tempcount + 1;
	if (self.target7)
		tempcount = tempcount + 1;
	if (self.target8)
		tempcount = tempcount + 1;

	while(tempcount > temptotal)
	{
		temptotal = temptotal + 1;
		if (temptotal == 1)
			tempstring = self.target;
		if (temptotal == 2)
			tempstring = self.target2;
		if (temptotal == 3)
			tempstring = self.target3;
		if (temptotal == 4)
			tempstring = self.target4;
		if (temptotal == 5)
			tempstring = self.target5;
		if (temptotal == 6)
			tempstring = self.target6;
		if (temptotal == 7)
			tempstring = self.target7;
		if (temptotal == 8)
			tempstring = self.target8;
		if (tempstring)
		{
			t = find (world, targetname, tempstring);
			breakthis = 0;
			while (!breakthis)
			{
				if (!t)
				{
					breakthis = true;
				}
				if (t.classname == "spawn_zombie_away")
				{
					t.classname = "spawn_zombie";
					if (cvar("developer"))
						setmodel(t, "progs/ai/zfull.mdl");
				}
				t = find (t, targetname, tempstring);
			} 
		}
	}
}

void() trigger_activator =
{
	InitTrigger ();
	self.touch = trigger_activator_touch;
}

.float boxstatus;
.entity boxweapon;


float colt, kar, db,bar, mg, ray, thomp, flame, ppsh, sawn, tesla, m1a1, ptrs, panz, stg, mp40, revolver, gewehr, fg, browning, kars, bknife, trench, m1, type100;

float() randomweapon = //this function is for making random box weapon system, currently it acts as just random thing
{
	local float r;
	r =rint((random() * 24)) + 1;

	if (r == 1)
	{
		if (ray)
			return 1;
		else
			return randomweapon();
	}
	else if (r == 2)
	{
		if (colt)
			return 2;	
		else
			return randomweapon();
	}
	else if (r == 3)
	{
		if (kar)
			return 3;
		else
			return randomweapon();
	}
	else if (r == 4)
	{
		if (m1a1)
			return 4;
		else
			return randomweapon();
	}
	else if (r == 5)
	{
		if (thomp)
			return 5;
		else
			return randomweapon();
	}
	else if (r == 6)
	{
		if (flame)
			return 6;
		else
			return randomweapon();
	}
	else if (r == 7)
	{
		if (ppsh)
			return 7;
		else
			return randomweapon();
	}
	else if (r == 8)
	{
		if (sawn)
			return 8;
		else
			return randomweapon();
	}
	else if (r == 9)
	{
		if (tesla)
			return 9;
		else
			return randomweapon();
	}
	else if (r == 10)
	{
		if (fg)
			return 10;
		else
			return randomweapon();
	}
	else if (r == 11)
	{
		if (trench)
			return 11;
		else
			return randomweapon();
	}
	else if (r == 12)
	{
		if (mg)
			return 12;
		else
			return randomweapon();
	}
	else if (r == 13)
	{
		if (db)
			return 13;
		else
			return randomweapon();
	}
	else if (r == 14)
	{
		if (bar)
			return 14;
		else
			return randomweapon();
	}
	else if (r == 15)
	{
		if (gewehr)
			return 15;
		else
			return randomweapon();
	}
	else if (r == 16)
	{
		if (browning)
			return 16;
		else
			return randomweapon();
	}
	else if (r == 17)
	{
		if (revolver)
			return 17;
		else
			return randomweapon();
	}
	else if (r == 18)
	{
		if (type100)
			return 18;
		else
			return randomweapon();
	}
	else if (r == 19)
	{
		if (kars)
			return 19;
		else
			return randomweapon();
	}
	else if (r == 20)
	{
		if (panz)
			return 20;
		else
			return randomweapon();
	}
	else if (r == 21)
	{
		if (ptrs)
			return 21;
		else
			return randomweapon();
	}
	else if (r == 22)
	{
		if (mp40)
			return 22;
		else
			return randomweapon();
	}
	else if (r == 23)
	{
		if (stg)
			return 23;
		else
			return randomweapon();
	}
	else if (r == 24)
	{
		if (bknife)
			return 24;
		else
			return randomweapon();
	}
	else if (r == 25)
	{
		if (m1)
			return 25;
		else
			return randomweapon();
	}
	else
		return randomweapon();
	
};

void() updateBoxGlow
{
	if(self.goaldummy)
	{
		self.goaldummy.frame = self.frame;
	}
};

void()	box_open1		=[	1,	box_open2	] { self.frame = 1;updateBoxGlow();};
void()	box_open2		=[	2,	box_open3	] { self.frame = 2;updateBoxGlow();};
void()	box_open3		=[	3,	box_open4	] { self.frame = 3;updateBoxGlow();};
void()	box_open4		=[	4,	box_open5	] { self.frame = 4;updateBoxGlow();};
void()	box_open5		=[	5,	box_open6	] { self.frame = 5;updateBoxGlow();};
void()	box_open6		=[	6,	box_open7	] { self.frame = 6;updateBoxGlow();};
void()	box_open7		=[	7,	box_open8	] { self.frame = 7;updateBoxGlow();};
void()	box_open8		=[	8,	SUB_Null	] { self.frame = 8;updateBoxGlow();};

void() resetbox = 
{
	self.frame = 0;
	self.boxstatus = 0;
};


void()	box_close1	=[	9,	box_close2	] { self.frame = 9;updateBoxGlow();sound (self, CHAN_VOICE, "misc/mbox_close.wav", 1, ATTN_NORM);};
void()	box_close2	=[	10,	box_close3	] { self.frame = 10;updateBoxGlow();};
void()	box_close3	=[	11,	box_close4	] { self.frame = 11;updateBoxGlow();};
void()	box_close4	=[	12,	resetbox	] { self.frame = 12;updateBoxGlow();};

void() Finalize_box =
{
	entity tempe;
	self.velocity = '0 0 0';
	tempe = self;
	self = self.owner;
	box_close1();
	self = tempe;
	self.owner.owner = world;
	self.owner.boxstatus = 0;
	remove (self);
}

void() Float_Decrease =
{
	makevectors(self.angles);
	self.velocity = v_up*-5;
	self.nextthink = time + 7;
	self.think = Finalize_box;
}
float (float r) Getweaponid =
{	
	if (r == 1)
		return W_RAY;
	else if (r == 2)
		return W_COLT;
	else if (r == 3)
		return W_KAR;
	else if (r== 4)
		return W_M1A1;
	else if (r== 5)
		return W_THOMPSON;
	else if (r== 6)
		return W_M2;
	else if (r== 7)
		return W_PPSH;
	else if (r== 8)
		return W_SAWNOFF;
	else if (r==9)
		return W_COLT;//W_TESLA;
	else if (r==10)
		return W_FG;
	else if (r==11)
		return W_TRENCH;
	else if (r==12)
		return W_MG;
	else if (r==13)
		return W_DB;
	else if (r==14)
		return W_BAR;
	else if (r==15)
		return W_GEWEHR;
	else if (r==16)
		return W_BROWNING;
	else if (r==17)
		return W_357;
	else if (r==18)
		return W_TYPE;
	else if (r==19)
		return W_KAR_SCOPE;
	else if (r == 20)
		return W_PANZER;
	else if (r==21)
		return W_PTRS;
	else if (r==22)
		return W_MP40;
	else if (r==23)
		return W_STG;
	else if (r==24)
		return W_BK;
	else if (r==25)
		return W_M1;

	return r;
}

float CheckWeapon (float w, entity user) =
{
	//entity check;
	/*if (w == W_TESLA || w == W_BK || w == W_M2)
	{
		check = find(world, classname, "player");
		while (check)
		{
			if (check.weapon == w || check.weapon2 == w)
				return 0;
			check = find(check, classname, "player");
		}
		return 1;
	}
	else*/
	{
		if (user.weapon == w || user.secondaryweapon == w)
			return 0;
		else
			return 1;
	}
	return 1;
};

void() Float_Change =
{
	float r, tempf;
	string temps;

	tempf = randomweapon ();
	r = Getweaponid(tempf);
	while (!CheckWeapon (r, self.owner.owner))
	{
		tempf = randomweapon ();
		r = Getweaponid(tempf);
	}
	temps = GetWeaponModel(r, 1);
	setmodel (self, temps);

	self.boxstatus = self.boxstatus + 0.01;
	if (self.wait <= time)
	{
		self.velocity = '0 0 0';
		self.owner.boxstatus = 2;
		self.weapon = r;
		self.nextthink = time + 5;
		self.think = Float_Decrease;
		return;
	}
	if (self.ltime <= time)
	{
		self.velocity_z = self.velocity_z*0.5;
		self.ltime = 0.5;
	}
	self.nextthink = time + self.boxstatus;
	self.think = Float_Change;
}

void() Create_Floating_Weapon =
{
	entity gun;
	float r, tempf;
	string temps;

	tempf = randomweapon ();
	r = Getweaponid(tempf);
	while (!CheckWeapon (r, self.owner.owner))
	{
		tempf = randomweapon ();
		r = Getweaponid(tempf);
	}
	temps = GetWeaponModel(r, 1);
	
	gun = spawn();
	
	setorigin (gun, self.origin);
	setmodel (gun, temps);
	setsize (gun, '0 0 0', '0 0 0');
	gun.angles = self.angles;
	
	gun.movetype = MOVETYPE_NOCLIP;
	gun.solid = SOLID_NOT;
	makevectors(self.angles);
	gun.velocity = v_up*15;
	
	gun.owner = self;
	self.boxweapon = gun;
	
	gun.ltime = time+2;
	gun.boxstatus = 0.01;
	gun.wait = time + 5;
	gun.nextthink = time + 0.01;
	gun.think = Float_Change;
}
void() mystery_touch =
{
	entity tempe;
	float startframe, endframe;
	string modelname;
	if (other.classname != "player" || other.downed)
		return;
		
	if (!self.boxstatus)
		useprint (other, 6, 950, 0);
	if (self.boxstatus == 2 && self.owner == other)
		useprint (other, 7, 0, 0);
	
	if (other.button1 && !other.semiuse)
	{
		if (!self.boxstatus)
		{
			if (other.points >= 950)
			{
				sound (self, CHAN_VOICE, "misc/mbox_open.wav", 1, ATTN_NORM);
				addmoney(other, -950, FALSE);
				self.boxstatus = 1;
				self.owner = other;
				box_open1 ();
				Create_Floating_Weapon();
			}
		}
		if (self.boxstatus == 2)
		{
			other.semiuse = 1;
			if (self.owner == other)
			{
				other.reload_delay = 0;
				self.boxstatus = 0;
				self.owner = world;
				if (other.weapon != self.boxweapon.weapon && other.secondaryweapon != self.boxweapon.weapon && other.secondaryweapon)
				{
					other.weapon = self.boxweapon.weapon;
					other.currentammo = getWeaponAmmo(self.boxweapon.weapon);
					other.currentmag = getWeaponMag(self.boxweapon.weapon);
				}
				else if (other.weapon == self.boxweapon.weapon)
				{
					other.currentammo = getWeaponAmmo(self.boxweapon.weapon);
					other.currentmag = getWeaponMag(self.boxweapon.weapon);
				}
				else if (other.secondaryweapon == self.boxweapon.weapon)
				{
					other.secondaryammo = getWeaponAmmo(self.boxweapon.weapon);
					other.secondarymag = getWeaponMag(self.boxweapon.weapon);
				}
				else if (!other.secondaryweapon)
				{
					other.secondaryweapon = other.weapon;
					other.weapon = self.boxweapon.weapon;

					other.secondaryammo = other.currentammo;
					other.currentammo = getWeaponAmmo(self.boxweapon.weapon);

					other.secondarymag = other.currentmag;
					other.currentmag = getWeaponMag(self.boxweapon.weapon);
				}
				sound(self, 0,"misc/ching.wav", 1, 1);
				tempe = self;
				self = other;
				startframe = GetFrame(self.weapon,TAKE_OUT_START);
				endframe = GetFrame(self.weapon,TAKE_OUT_END);
				modelname = GetWeaponModel(self.weapon, 0);
				Set_W_Frame (startframe, endframe, 0, 0, 0, SUB_Null, modelname, false);//FIXME
				self = tempe;
				remove (self.boxweapon);
				box_close1();
			}
		}
	}
}


void() Load_Mbox_Data =
{
	local float file;
	local string h;
	string temps;
	h = strcat(mapname,  ".mbox");
	h = strcat("maps/",  h);
	file = fopen (h, FILE_READ);
	
	if (file == -1) {
		colt = kar = db =bar = mg = ray = thomp = flame = ppsh = sawn = tesla = m1a1 = ptrs = panz = stg = mp40 = revolver = gewehr = fg = browning = kars = bknife = trench = m1 = type100 = 1;
	} else {
		h = (fgets(file));
		colt = stof(h);
		h = (fgets(file));
		kar = stof(h);
		h = (fgets(file));
		db = stof(h);
		h = (fgets(file));
		mg = stof(h);
		h = (fgets(file));
		ray = stof(h);
		h = (fgets(file));
		thomp = stof(h);
		h = (fgets(file));
		flame = stof(h);
		h = (fgets(file));
		ppsh = stof(h);
		h = (fgets(file));
		sawn = stof(h);
		h = (fgets(file));
		tesla = stof(h);
		h = (fgets(file));
		m1a1 = stof(h);
		h = (fgets(file));
		gewehr = stof(h);
		h = (fgets(file));
		fg = stof(h);
		h = (fgets(file));
		browning = stof(h);
		h = (fgets(file));
		kars = stof(h);
		h = (fgets(file));
		revolver = stof(h);
		h = (fgets(file));
		stg = stof(h);
		h = (fgets(file));
		panz = stof(h);
		h = (fgets(file));
		bknife = stof(h);
		h = (fgets(file));
		ptrs = stof(h);
		h = (fgets(file));
		mp40 = stof(h);
		h = (fgets(file));
		trench = stof(h);
		h = (fgets(file));
		bar = stof(h);
		h = (fgets(file));
		m1 = stof(h);
		h = (fgets(file));
		type100 = stof(h);
		fclose (file);
	}
	if (colt)
	{
		temps = GetWeaponModel(W_COLT, 1);
		precache_model (temps);
		temps = GetWeaponModel(W_COLT, 0);
		precache_model (temps);
		precache_extra(W_COLT);
	}
	if (kar)
	{
		temps = GetWeaponModel(W_KAR, 1);
		precache_model (temps);
		temps = GetWeaponModel(W_KAR, 0);
		precache_model (temps);
		precache_extra(W_KAR);
	}
	if (db)
	{
		temps = GetWeaponModel(W_DB, 1);
		precache_model (temps);
		temps = GetWeaponModel(W_DB, 0);
		precache_model (temps);
		precache_extra(W_DB);
	}
	if (mg)
	{
		temps = GetWeaponModel(W_MG, 1);
		precache_model (temps);
		temps = GetWeaponModel(W_MG, 0);
		precache_model (temps);
		precache_extra(W_MG);
	}
	if (ray)
	{
		temps = GetWeaponModel(W_RAY, 1);
		precache_model (temps);
		temps = GetWeaponModel(W_RAY, 0);
		precache_model (temps);
		precache_extra(W_RAY);
	}
	if (thomp)
	{
		temps = GetWeaponModel(W_THOMPSON, 1);
		precache_model (temps);
		temps = GetWeaponModel(W_THOMPSON, 0);
		precache_model (temps);
		precache_extra(W_THOMPSON);
	}
	if (flame)
	{
		temps = GetWeaponModel(W_M2, 1);
		precache_model (temps);
		temps = GetWeaponModel(W_M2, 0);
		precache_model (temps);
		precache_extra(W_M2);
	}
	if (ppsh)
	{
		temps = GetWeaponModel(W_PPSH, 1);
		precache_model (temps);
		temps = GetWeaponModel(W_PPSH, 0);
		precache_model (temps);
		precache_extra(W_PPSH);
	}
	if (sawn)
	{
		temps = GetWeaponModel(W_SAWNOFF, 1);
		precache_model (temps);
		temps = GetWeaponModel(W_SAWNOFF, 0);
		precache_model (temps);
		precache_extra(W_SAWNOFF);
	}
	if (tesla)
	{
		temps = GetWeaponModel(W_COLT, 1);
		precache_model (temps);
		temps = GetWeaponModel(W_COLT, 0);
		precache_model (temps);
		precache_extra(W_COLT);
	}
	if (m1a1)
	{
		temps = GetWeaponModel(W_M1A1, 1);
		precache_model (temps);
		temps = GetWeaponModel(W_M1A1, 0);
		precache_model (temps);
		precache_extra(W_M1A1);
	}
	if (gewehr)
	{
		temps = GetWeaponModel(W_GEWEHR, 1);
		precache_model (temps);
		temps = GetWeaponModel(W_GEWEHR, 0);
		precache_model (temps);
		precache_extra(W_GEWEHR);
	}
	if (fg)
	{
		temps = GetWeaponModel(W_FG, 1);
		precache_model (temps);
		temps = GetWeaponModel(W_FG, 0);
		precache_model (temps);
		precache_extra(W_FG);
	}
	if (browning)
	{
		temps = GetWeaponModel(W_BROWNING, 1);
		precache_model (temps);
		temps = GetWeaponModel(W_BROWNING, 0);
		precache_model (temps);
		precache_extra(W_BROWNING);
	}
	if (kars)
	{
		temps = GetWeaponModel(W_KAR_SCOPE, 1);
		precache_model (temps);
		temps = GetWeaponModel(W_KAR_SCOPE, 0);
		precache_model (temps);
		precache_extra(W_KAR_SCOPE);
	}
	if (revolver)
	{
		temps = GetWeaponModel(W_357, 1);
		precache_model (temps);
		temps = GetWeaponModel(W_357, 0);
		precache_model (temps);
		precache_extra(W_357);
	}
	if (stg)
	{
		temps = GetWeaponModel(W_STG, 1);
		precache_model (temps);
		temps = GetWeaponModel(W_STG, 0);
		precache_model (temps);
		precache_extra(W_STG);
	}
	if (panz)
	{
		temps = GetWeaponModel(W_PANZER, 1);
		precache_model (temps);
		temps = GetWeaponModel(W_PANZER, 0);
		precache_model (temps);
		precache_extra(W_PANZER);
	}
	if (bknife)
	{
		temps = GetWeaponModel(W_BK, 1);
		precache_model (temps);
		temps = GetWeaponModel(W_BK, 0);
		precache_model (temps);
		precache_extra(W_BK);
	}
	if (ptrs)
	{
		temps = GetWeaponModel(W_PTRS, 1);
		precache_model (temps);
		temps = GetWeaponModel(W_PTRS, 0);
		precache_model (temps);
		precache_extra(W_PTRS);
	}
	if (mp40)
	{
		temps = GetWeaponModel(W_MP40, 1);
		precache_model (temps);
		temps = GetWeaponModel(W_MP40, 0);
		precache_model (temps);
		precache_extra(W_MP40);
	}
	if (bar)
	{
		temps = GetWeaponModel(W_BAR, 1);
		precache_model (temps);
		temps = GetWeaponModel(W_BAR, 0);
		precache_model (temps);
		precache_extra(W_BAR);
	}
	if (trench)
	{
		temps = GetWeaponModel(W_TRENCH, 1);
		precache_model (temps);
		temps = GetWeaponModel(W_TRENCH, 0);
		precache_model (temps);
		precache_extra(W_TRENCH);
	}
	if (m1)
	{
		temps = GetWeaponModel(W_M1, 1);
		precache_model (temps);
		temps = GetWeaponModel(W_M1, 0);
		precache_model (temps);
		precache_extra(W_M1);
	}
	if (type100)
	{
		temps = GetWeaponModel(W_TYPE, 1);
		precache_model (temps);
		temps = GetWeaponModel(W_TYPE, 0);
		precache_model (temps);
		precache_extra(W_TYPE);
	}
}
void() mystery_box =
{
	
	Load_Mbox_Data();

	precache_model ("progs/Misc/mystery.mdl");
	precache_model ("progs/Misc/mglow$.mdl");
	precache_model ("progs/Misc/teddy.mdl"); 
	precache_sound ("misc/mbox_open.wav"); 
	precache_sound ("misc/mbox_close.wav"); 
	
	self.solid=SOLID_TRIGGER;
	self.classname = "mystery";
	setorigin(self, self.origin);
	setmodel (self, "progs/Misc/mystery.mdl");
	setsize (self, VEC_HULL2_MIN, VEC_HULL2_MAX);
	
	if (!(self.spawnflags & 2))
	{
		//self.effects = EF_BLUELIGHT;
		local entity g;
		g = spawn();
		self.goaldummy = g;
		setmodel(g,"progs/Misc/mglow$.mdl");
		setorigin(g,self.origin);
		g.angles = self.angles;
	}

	self.touch = mystery_touch;
}

void() use_wall_weapon =
{
	if (self.enemy)
		return;
	entity newent;
	
	newent = spawn();

	newent.movetype = MOVETYPE_NONE;	// so it doesn't get pushed by anything
	newent.solid=SOLID_NOT;
	newent.classname = "wall_weapon";
	setorigin(newent, self.origin);
	setmodel (newent, GetWeaponModel(self.sequence + 1, 1));
	setsize (newent, VEC_HULL2_MIN, VEC_HULL2_MAX);
	newent.angles = self.angles;
	
	self.enemy = newent;
}

void() weapon_wall =
{
	string temps;
	precache_model ("progs/Misc/chalk!.mdl");
	temps = GetWeaponModel(self.sequence + 1, 1);
	precache_model (temps);

	setmodel (self, "progs/Misc/chalk!.mdl");
	self.skin = 0;
	setsize (self, VEC_HULL2_MIN, VEC_HULL2_MAX);

	self.frame = self.sequence;
	self.use = use_wall_weapon;
	self.classname = "weapon_wall";

}
.float radioState;
void() radioPlay =
{
	self.health = 1;

	if (self.radioState == 1) {
		sound (self, CHAN_VOICE, "music/tune1.wav", 1, ATTN_NORM);
	} else if (self.radioState == 2) {
		sound (self, CHAN_VOICE, "music/tune1.wav", 1, ATTN_NONE);
	} else if (self.radioState == 0) {
		sound (self, CHAN_VOICE, "null.wav", 1, ATTN_NONE);
		self.nextthink = 0;
		self.think = SUB_Null;
	}
}

void() radio_hit =
{
	self.health = 1;

	sound (self, CHAN_VOICE, "misc/radio.wav", 1, ATTN_NORM);
	self.nextthink = time + getSoundLen("misc/radio.wav");
	self.think = radioPlay;
	
	if (self.radioState == 0)
		self.radioState = 1;
	else if (self.radioState == 1)
		self.radioState = 2;
	else if (self.radioState == 2)
		self.radioState = 0;
}

void() item_radio = 
{
	precache_model ("progs/Props/radio.mdl");
	precache_sound ("misc/radio.wav");
	precache_sound ("music/tune1.wav");

	self.movetype = MOVETYPE_NONE;	// so it doesn't get pushed by anything
	self.solid=SOLID_BBOX;
	self.classname = "item_radio";
	setmodel (self, "progs/Props/radio.mdl");
	setsize (self, '-8 -8 -4', '8 8 4');

	self.takedamage = DAMAGE_YES;
	self.health = 1;
	self.radioState = 0;
	self.th_die = radio_hit;
};

void() BarrelExplode =
{
	DamgageExplode (self, self.enemy, 500, 75, 200);//was 256 inch radius, kicked it down to 128 because 21 feet exploding radius is... a bit overkill...

	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);

	SUB_Remove ();
};

void() barrel_hit =
{
	if (self.health <= 0) {
		BarrelExplode();
	} else if (self.health <= 200) {
		makevectors(self.angles);
		self.think = barrel_hit;
		self.nextthink = time + 0.1;
		self.health = self.health - 1;
		if (self.health > 100)
			particle (self.origin + '0 0 30', v_up*8, 111, 0);
		else
			particle (self.origin + '0 0 30', v_up*8, 112, 0);
	}
}

void() explosive_barrel = 
{
	precache_model ("progs/Props/barrel_m.mdl");
	precache_model ("progs/Sprites/flame.spr");

	self.movetype = MOVETYPE_NONE;	// so it doesn't get pushed by anything
	self.solid=SOLID_BBOX;
	self.classname = "explosive_barrel";
	setmodel (self, "progs/Props/barrel_m.mdl");
	setsize (self, '-10 -10 ', '10 10 38');

	self.takedamage = DAMAGE_NOMARKER;
	self.health = 300;
};

float	SVC_BSPDECAL		= 42;
.string texture;
.float texsize;

void() infodecal =
{
	WriteByte (MSG_ALL, SVC_BSPDECAL);
	
	WriteString (MSG_ALL, self.texture);
	WriteByte (MSG_ALL, self.texsize);
	WriteCoord (MSG_ALL, self.origin_x);
	WriteCoord (MSG_ALL, self.origin_y);
	WriteCoord (MSG_ALL, self.origin_z);
};