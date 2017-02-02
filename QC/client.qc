/*
+------+
|Client|
+------+-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-+
| Scratch                                      Http://www.admdev.com/scratch |
+=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-+
| Handle's "clients" (eg, Players) connecting, disconnecting, etc.           |
+=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-+
*/
void () Weapon_Logic;
void () Waypoint_logic;
string(float wep, float gorvmodel) GetWeaponModel;
void() sprintstop;
void() ClientKill = {};
void() ClientConnect = {bprint("Client connected\n");};
void() ClientDisconnect = {bprint("Client disconnected\n");};

//entity whooloo;

void() PlayerPreThink = 
{
	/*if(whooloo == world)
	{
		whooloo = spawn();
		makevectors(self.angles);
		//whooloo.origin = self.origin + (v_forward * 10) + v_up;
		//setorigin(whooloo,whooloo.origin);
		setmodel(whooloo, "progs/player.mdl"); 
		setsize (whooloo, VEC_HULL_MIN, VEC_HULL_MAX);
		
		whooloo.solid = SOLID_SLIDEBOX;
		whooloo.movetype = MOVETYPE_WALK;
		whooloo.origin = whooloo.origin + '0 0 1'; 	
		whooloo.angles = whooloo.angles;    
		whooloo.fixangle = TRUE;  
		whooloo.velocity_x = v_forward_x * -5;
		whooloo.velocity_z = v_forward_y * -5;
	}
	else
	{
		
		makevectors(self.angles);
		if(whooloo.origin == world.origin)
		{
			whooloo.origin = self.origin + (v_forward * 10) + v_up;
			setorigin(whooloo,whooloo.origin);
		}
		vector newVel;
		newVel = normalize(self.origin - whooloo.origin) * 80;
		newVel_z = whooloo.velocity_z;
		whooloo.velocity = newVel;
		newVel_z = 0;
		whooloo.angles = vectoangles(newVel);
		while(whooloo.angles_y > 360)
			whooloo.angles_y -= 360;
		while(whooloo.angles_y < 0)
			whooloo.angles_y += 360;
	}*/
	
		
	self.cost = 0;
	if (self.health <= 0)
		return;

	if (self.impulse == 100)
	{
		cvar_set("waypoint_mode", "1");
		
		local entity d;
		d = find(world,classname,"door_nzp_cost");
		while(d != world)
		{
			d.classname = "door_nzp";
			d = find(d,classname,"door_nzp_cost");
		}
		d = find(world,classname,"door_open");
		while(d != world)
		{
			d.classname = "door_nzp";
			d = find(d,classname,"door_open");
		}
	}
	if (cvar("waypoint_mode"))
		Waypoint_logic();
	else
		Weapon_Logic();
};
void () GetUp;
//Player sound footstep function
/*void() footstep = 
{
	local float r;
	r = random();
	while(1)
	{
		r = random();
		if(r < 0.25 && self.last_step != 1)
		{
			r = 1;
			break;
		}
		else if(r < 0.5 && self.last_step != 2)
		{
			r = 2;
			break;
		}
		else if(r < 0.75 && self.last_step != 3)
		{
			r = 3;
			break;
		}
		else if(r < 1.00 && self.last_step != 4)
		{
			r = 4;
			break;
		}
	}
	
	if(r == 1)
	{
		sound (self, CHAN_VOICE, "player/steps/step_1.wav", 1, ATTN_NORM);
		self.last_step = 1;
	}
	if(r == 2)
	{
			sound (self, CHAN_VOICE, "player/steps/step_2.wav", 1, ATTN_NORM);
			self.last_step = 2;
	}
	if(r == 3)
	{
		sound (self, CHAN_VOICE, "player/steps/step_3.wav", 1, ATTN_NORM);
		self.last_step = 3;
	}
	if(r == 4)
	{
		sound (self, CHAN_VOICE, "player/steps/step_4.wav", 1, ATTN_NORM);
		self.last_step = 4;
	}	
};*/



void() PlayerPostThink = 
{	
	self.cost = 0;
	if (self.health <= 0)
		return;
	if (!roundinitfinal)
	{
		if (roundinit == 10)// Create a delay for the round start to make sure the player has fully loaded in
			InitRounds();
		else
			roundinit = roundinit + 1;
	}
	
	if (self.health_delay < time && self.health != self.max_health && !self.downed)
	{
		self.health = self.health + 5;
		if (self.max_health < self.health)
			self.health = self.max_health;
	}
	if (self.progress_bar < time && self.progress_bar)
	{
		GetUp();
		self.progress_bar = 0;
	}
	
	if (self.zoom == 3)
	{
		if (!self.velocity)//we are not moving, stop sprinting
			sprintstop();
		
		if (self.perks & P_STAMIN)
			self.stamina = self.stamina - 0.015;
		else
			self.stamina = self.stamina - 0.03;

		if (self.stamina <= 0)
			sprintstop();
	}
	else if (self.stamina < 3)
	{
		self.stamina = self.stamina + 0.06;
		if (self.stamina > 3)
			self.stamina = 3;
	}
	
	//Removed references for .float footstep_time and  .float last_step
	/*if(self.velocity_x || self.velocity_y)//BLUBS ADDED THIS TO ENGINE INSTEAD, REMOVE ME IF I DON'T DECIDE TO ADD IT BACK
	{
		if((time > self.footstep_time) && (self.flags & FL_ONGROUND))
		{
			////////Footsteps
			local float speed_sound;
			//footstep();
			speed_sound = vlen(self.velocity);
			
			if(speed_sound < 0)
				speed_sound *= -1;//Vlen() should never return a negative length, but just in case, flip it
			
			speed_sound = 63/speed_sound;
			if(speed_sound > 1.8)//the delay is way too big
			{
				speed_sound = 0.45;
			}
			self.footstep_time = time + speed_sound;
		}
	}*/
};
void() PutClientInServer =
{
	local entity spawn_spot;             		// This holds where we want to spawn
	spawn_spot = find (world, classname, "info_player_start"); // Find it :)

	self.classname = "player";           		// I'm a player!
	self.health = self.max_health = 100; 		// My health (and my max) is 100
	self.takedamage = DAMAGE_AIM;        		// I can be fired at
	self.solid = SOLID_SLIDEBOX;         		// Things sort of 'slide' past me
	self.movetype = MOVETYPE_WALK;       		// Yep, I want to walk.
	self.flags = FL_CLIENT;              		// Yes, I'm a client.

	self.origin = spawn_spot.origin + '0 0 1'; 	// Move to the spawnspot location
	self.angles = spawn_spot.angles;     		// Face the angle the spawnspot indicates
	self.fixangle = TRUE;                		// Turn this way immediately

	setmodel (self, "progs/player.mdl"); 		// Set my player to the player model
	setsize (self, VEC_HULL_MIN, VEC_HULL_MAX); // Set my size

	//self.view_ofs = '0 0 22';            			// Center my view
	self.view_ofs = VEC_VIEW_OFS;            			// Center my view
	self.velocity = '0 0 0';           			// Stop any old movement
	
	self.currentammo = 32;						// Give reserve ammo
	self.currentmag = 8;						// Give magazine ammo
	self.weapon = W_COLT;						// Define weapon
	self.weaponmodel = GetWeaponModel(self.weapon, 0);// Give weapon model
	
	/*self.secondaryweapon= W_KAR_SCOPE;
	self.secondaryammo = 50;
	self.secondarymag = 5;*/
	
	self.grenades = self.grenades | 1; //add frag grenades to player inventory
	self.primary_grenades = 0; //add frag grenades to player inventory

	self.perks = 0;						// Remove perks
	self.stamina = 3;


	addmoney(self, 500, 0);						//starting points
};

