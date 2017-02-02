.float zombie_drop_id;
.float flashtime;
.float flash_step;
void() W_Reload;
void() maxammo =
{
	entity tempe, temp;
	
	tempe = find (world, classname, "player");
	while (tempe)
	{	
		if (!tempe.downed)
		{
			if (tempe.weapon)
			{
				tempe.currentammo = getWeaponAmmo(tempe.weapon);
				if (!tempe.currentmag)
				{
					temp = self;
					self = tempe;
					W_Reload();
					self = temp;
				}
			}
			if (tempe.secondaryweapon)
				tempe.secondaryammo = getWeaponAmmo(tempe.secondaryweapon);
			
			tempe.primary_grenades = 4;
		}
		tempe = find (tempe, classname, "player");
	}
}


void() nuke =
{
	local entity oldself;
	local entity who;
	oldself = self;
	
	
	who = find(world,classname,"ai_zombie");
	while(who != world)
	{
		if(who.health)
		{
			self = who;
			self.th_die();
			self = oldself;
		}
		
		who = find(who,classname,"ai_zombie");
	}
	
	who = find(world,classname,"player");
	while(who)
	{
		addmoney(who,400,1);
		
		who = find(who,classname,"player");
	}
}

void() carpenter =
{
	local entity oldself;
	local entity who;
	oldself = self;
	
	
	who = find(world,classname,"window");
	while(who != world)
	{
		if(who.health < 6 && who.health != -10)//-10 is for boardless windows
		{
			self = who;
			window_carpenter_1 ();
			who.health = 6;
			self = oldself;
		}
		
		who = find(who,classname,"window");
	}
	
	who = find(world,classname,"player");
	while(who)
	{
		addmoney(who,200,1);
		
		who = find(who,classname,"player");
	}
	total_windows_down = 0;
}


void() powerup_flash =
{
	if(self.flash_step == 0)
	{
		self.flash_step = 1;
		self.flashtime = time + 3;
		self.nextthink = time + 0.6;
	}
	else if(self.flash_step == 1)
	{
		self.nextthink = time + 0.6;
		
		if(self.flashtime < time)
		{
			self.flash_step = 2;
			self.nextthink = time + 0.3;
			self.flashtime = time + 3;
		}

	}
	else if(self.flash_step == 2)
	{
		self.nextthink = time + 0.3;
		
		if(self.flashtime < time)
		{
			self.flash_step = 3;
			self.nextthink = time + 0.15;
			self.flashtime = time + 3;
		}
		
	}
	else if(self.flash_step == 3)
	{
		self.nextthink = time + 0.15;
		if(self.flashtime < time)
		{
			setmodel(self,"");
			setmodel(self.owner,"");
			remove(self.owner);
			remove(self);
			return;
		}
	}
	
	if(self.model == "")
	{
		if(self.zombie_drop_id == 1)
			setmodel(self,"progs/Misc/maxammo!.mdl");
		if(self.zombie_drop_id == 2)
			setmodel(self,"progs/Misc/x2!.mdl");
		if(self.zombie_drop_id == 3)
			setmodel(self,"progs/Misc/instakill!.mdl");
		if(self.zombie_drop_id == 4)
			setmodel(self,"progs/Misc/nuke!.mdl");
		if(self.zombie_drop_id == 5)
			setmodel(self,"progs/Misc/carpenter!.mdl");
	}
	else
	{
		setmodel(self,"");
	}
};

void() powerup_touch =
{
	if(other.classname == "player")
	{
		sound(self.owner,CHAN_VOICE,"pu/pickup.wav",1,ATTN_NONE);
		
		if(self.zombie_drop_id == 1)
		{
			sound(self,CHAN_VOICE,"pu/maxammo.wav",1,ATTN_NONE);
			maxammo();
		}
		else if(self.zombie_drop_id == 2)
		{
			sound(self,CHAN_VOICE,"pu/double_points.wav",1,ATTN_NONE);   
			x2_finished = time + 30;
			x2_icon = true;
		}
		else if(self.zombie_drop_id == 3)
		{
			sound(self,CHAN_VOICE,"pu/insta_kill.wav",1,ATTN_NONE);
			instakill_finished = time + 30;
			insta_icon = true;
		}
		else if(self.zombie_drop_id == 4)
		{
			sound(self,CHAN_VOICE,"pu/nuke.wav",1,ATTN_NONE);
			nuke();
		}
		else if(self.zombie_drop_id == 5)
		{
			carpenter();
		}/*
		else if(self.zombie_drop_id == 6)
		{
			give_perk();
		}*/
		stuffcmd(other, "bf\n");
		remove(self.owner);
		remove(self);
	}
};

void() sparkle_think =
{
	local float f;
	f = self.frame;
	local float r;
	while(f == self.frame)
	{
		r = random();
		r = ((r > 0.2) ? 1 : 0) + ((r > 0.4) ? 1 : 0) + ((r > 0.6) ? 1 : 0) + ((r > 0.8) ? 1 : 0);
		f = r;
	}
	self.frame = f;
	
	self.think = sparkle_think;
	self.nextthink = time + 0.1;
	
	if(self.calc_time <= time)
	{
		sound(self,CHAN_VOICE,"pu/powerup.wav",0.6,ATTN_NORM);
		self.calc_time = time + 2.998;
	}
	
};

float last_pu;
void(vector where) Spawn_Powerup =
{
	entity new_powerup;
	float t;

	new_powerup = spawn();
	new_powerup.origin = where;
	setorigin(new_powerup, new_powerup.origin);
	new_powerup.solid = SOLID_TRIGGER;
	new_powerup.classname = "item_powerup";

	
	setsize (new_powerup, VEC_HULL_MIN, VEC_HULL_MAX);
	new_powerup.movetype = MOVETYPE_NONE;
	//new_powerup.effects = new_powerup.effects | EF_BRIGHTLIGHT;
	
	//=================== Sparkle Effects =====================
	entity twlt_Sparkle;
	twlt_Sparkle = spawn();
	new_powerup.owner = twlt_Sparkle; //just a reference so power up can delete the sparkle later on
	
	setorigin(twlt_Sparkle,where);
	setmodel(twlt_Sparkle,"progs/Sprites/sprkle.spr");
	
	twlt_Sparkle.think = sparkle_think;
	twlt_Sparkle.nextthink = time + 0.1;
	sound(twlt_Sparkle,CHAN_VOICE,"pu/powerup.wav",0.6,ATTN_NORM);
	
	sound(new_powerup,CHAN_AUTO,"pu/drop.wav",1,ATTN_NONE);
	//========================================================
	t = random();
	if (total_windows_down >= 5)
	{
		if (t < 0.2)
		{
			setmodel(new_powerup,"progs/Misc/maxammo!.mdl");
			new_powerup.zombie_drop_id = 1;
		}
		else if (t < 0.4)
		{
			setmodel(new_powerup,"progs/Misc/x2!.mdl");
			new_powerup.zombie_drop_id = 2;
		}
		else if (t < 0.6)
		{
			setmodel(new_powerup,"progs/Misc/instakill!.mdl");
			new_powerup.zombie_drop_id = 3;
		}
		else if (t < 0.8)
		{
			setmodel(new_powerup,"progs/Misc/nuke!.mdl");
			new_powerup.zombie_drop_id = 4;
		}
		else
		{
			setmodel(new_powerup,"progs/Misc/carpenter!.mdl");
			new_powerup.zombie_drop_id = 5;
		}
	}
	else
	{
		if (t < 0.25)
		{
			setmodel(new_powerup,"progs/Misc/maxammo!.mdl");
			new_powerup.zombie_drop_id = 1;
		}
		else if (t < 0.5)
		{
			setmodel(new_powerup,"progs/Misc/x2!.mdl");
			new_powerup.zombie_drop_id = 2;
		}
		else if (t < 0.75)
		{
			setmodel(new_powerup,"progs/Misc/instakill!.mdl");
			new_powerup.zombie_drop_id = 3;
		}
		else
		{
			setmodel(new_powerup,"progs/Misc/nuke!.mdl");
			new_powerup.zombie_drop_id = 4;
		}
	}
	last_pu = new_powerup.zombie_drop_id;
	new_powerup.touch = powerup_touch;
	
	new_powerup.think = powerup_flash;
	new_powerup.nextthink = time + 21;
	totalpowerups = 1;
}