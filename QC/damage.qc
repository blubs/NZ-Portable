
void(entity attacker, float d_style) DieHandler =
{
	if (self.classname == "ai_zombie")
		self.th_die();
	
	if (attacker.classname == "player")
	{
		if (d_style == S_HEADSHOT)
		{
			addmoney(attacker, 100, true);
			total_powerup_points = total_powerup_points + 100;
		}
		else if (d_style == S_KNIFE)
		{
			addmoney(attacker, 130, true);
			total_powerup_points = total_powerup_points + 130;
		}
		else if (d_style == S_NORMAL)
		{
			addmoney(attacker, 60, true);
			total_powerup_points = total_powerup_points + 60;
		}
		attacker.kills = attacker.kills + 1;
	}
}

void() EndGame =
{
	local entity oldself;
	local entity who;

	self.health = 0;
	WriteByte (MSG_ALL, SVC_INTERMISSION);
	self.origin = '0 0 0';
	setorigin (self, self.origin);
	self.velocity = '0 0 0';
	sound (self, CHAN_BODY, "music/end.wav", 1, ATTN_NORM);

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
}
void() GetDown =
{
	float tempf;
	if (!deathmatch && !coop && !(self.perks & P_REVIVE))
	{
		game_over = true;
		self.health = 10;
		self.think = EndGame;
		self.nextthink = time + 5;
		self.weapon = 0;
		self.currentammo = 0;
		self.currentmag = 0;
		self.weaponmodel = "";
		self.weapon2model = "";
		self.animend = SUB_Null;
	}
	else
		self.health = 20;
	
	self.view_ofs = '0 0 -20';
	self.velocity = '0 0 0';           			// Stop any old movement
	self.zoom = 0;
	self.downed = 1;
	self.perks = 0;
	if (self.health == 10)
		return;
	if (self.weapon != W_COLT && self.secondaryweapon == W_COLT)
	{
		tempf = self.secondaryweapon;
		self.secondaryweapon = self.weapon;
		self.weapon = tempf;

		tempf = self.secondaryammo;
		self.secondaryammo = self.currentammo;
		self.currentammo = tempf;

		self.secondarymag = tempf;
		self.secondarymag = self.currentmag;
		self.currentmag = tempf;
	}
	else
	{
		self.weaponbk = self.weapon;
		self.currentammobk = self.currentammo;
		self.currentmagbk = self.currentmag;
		
		self.weapon = W_COLT;
		self.currentammo = 32;
		self.currentmag = 8;
	}
	self.progress_bar = 10 + time;
	self.points = 10*rint((self.points*0.95)/10);
}

void () GetUp =
{
	self.view_ofs = VEC_VIEW_OFS;
	self.health = 100;
	self.downed = 0;
	self.classname = "player";
	if (self.weaponbk)
	{
		self.weapon = self.weaponbk;
		self.currentammo = self.currentammobk;
		self.currentmag = self.currentmagbk;
	}
	
};

void(entity victim,entity attacker, float damage, float d_style) DamageHandler =
{
	local entity old_self;
	if (victim.classname == "ai_zombie")
	{
		if (attacker.classname == "player" && (victim.health - damage)> 0)
			addmoney(attacker, 10, 1);

		victim.health = victim.health - damage;

		if (d_style == S_EXPLOSIVE)
		{
			if (victim.health < z_health*0.5)
			{
				if(victim.crawling != TRUE)
					makeCrawler(victim);
			}
			return;
		}
		if (victim.health <= 0 || instakill_finished)
		{
			old_self = self;
			self = victim;
			DieHandler(attacker, d_style);
			self = old_self;
		}
	}
	if (victim.classname == "player" && !victim.downed)
	{
		if (victim.perks & P_JUG)
			damage = ceil(damage*0.5);
		if (attacker.classname == "ai_zombie")
			victim.health = victim.health - damage;
		if(attacker.classname == "player" && d_style == S_EXPLOSIVE)
			victim.health = victim.health - damage;
		
		victim.health_delay = time + 2;

		if (victim.health <= 20)
		{
			old_self = self;
			self = victim;
			GetDown();
			self = old_self;
		}
	}
}
/*
============
CanDamage

Returns true if the inflictor can directly damage the target.  Used for
explosions and melee attacks.
============
*/
float(entity targ, entity inflictor) CanDamage =
{
// bmodels need special checking because their origin is 0,0,0
	if (targ.movetype == MOVETYPE_PUSH)
	{
		traceline(inflictor.origin, 0.5 * (targ.absmin + targ.absmax), TRUE, self);
		if (trace_fraction == 1)
			return TRUE;
		if (trace_ent == targ)
			return TRUE;
		return FALSE;
	}
	
	traceline(inflictor.origin, targ.origin, TRUE, self);
	if (trace_fraction == 1)
		return TRUE;
	traceline(inflictor.origin, targ.origin + '15 15 0', TRUE, self);
	if (trace_fraction == 1)
		return TRUE;
	traceline(inflictor.origin, targ.origin + '-15 -15 0', TRUE, self);
	if (trace_fraction == 1)
		return TRUE;
	traceline(inflictor.origin, targ.origin + '-15 15 0', TRUE, self);
	if (trace_fraction == 1)
		return TRUE;
	traceline(inflictor.origin, targ.origin + '15 -15 0', TRUE, self);
	if (trace_fraction == 1)
		return TRUE;

	return FALSE;
};

/*
============
DamgageExplode
============
*/
void(entity inflictor, entity attacker, float damage2, float mindamage, float radius) DamgageExplode =
{
	//local	float 	distance, final_damage;
	local	float 	final_damage;
	local	entity	ent;

	local float multi,r;
	ent = findradius(inflictor.origin, radius);
	
	while (ent)
	{
		if(ent.classname == "player")
		{
			final_damage = radius - vlen(inflictor.origin - ent.origin);
			if(final_damage < 0)
				continue;
			
			if(final_damage > radius * 0.6)
				final_damage = 100;
			else
			{
				final_damage /= radius;
				final_damage *= 60;
			}
			DamageHandler (attacker, attacker, final_damage, S_EXPLOSIVE);
		}
		else if (ent.takedamage && ent.classname != "ai_zombie_head" && ent.classname != "ai_zombie_larm" && ent.classname != "ai_zombie_rarm")
		{
			/* kcount = kcount + 1;
			if (kcount >= 10 && !attacker.allreadyach19)
			{
				achievement(attacker, 19);
				attacker.allreadyach19 = true;
			} */
			/*distance = vlen (inflictor.origin - ent.origin);
			if (distance < 0)
				distance = 0;
			final_damage = mindamage + (damage2 - (damage2/radius)*distance);
			if (ent == attacker)
				final_damage = final_damage * 0.5;
			else
				final_damage = 100*rounds + random()*100 + final_damage; //damage is increased every round by 100x to 200x
			if(radius == 0)
				return;
			*/
			
			/*Damage = 300 * 1.05^rounds + 200*/
			
			r = rounds;
			multi = 1.07;
			while(r > 0)
			{
				multi *= 1.05;
				r --;
			}
			
			final_damage = (200 * multi) + 185;
			
			if (final_damage > 0)
			{
				/* ndaekill = true; */
				if (CanDamage (ent, inflictor))
					DamageHandler (ent, attacker, final_damage, S_EXPLOSIVE);
				/* kill = false; */
			}
		}
		ent = ent.chain;
	}
};