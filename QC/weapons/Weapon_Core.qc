// +-----------+
// |Weapon Core|
// +-----------+-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-+
// | Scratch                                   Http://www.admdev.com/scratch |
// +=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--=-+
// | This file contains Core weapon function needed for weapon system.		 |
// | 									                                     |
// +=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-+

.float NeedLoad;
void () W_LoadAmmo;

void() ReturnWeaponModel =
{
	self.weaponmodel = GetWeaponModel(self.weapon, 0);
	if (self.weapon == W_KAR_SCOPE)
		self.weapon2model = "progs/VModels/v_karscope.mdl";
}


/*
 +-=-=-=-=+
 |W_Reload|
 +-=-=-=-=+
*/
void() W_Give_Ammo =
{
	float ammo_shot, max_mag;
	
	max_mag = getWeaponMag(self.weapon);

	ammo_shot = max_mag - self.currentmag;
	if (ammo_shot < self.currentammo)
	{
		self.currentammo = self.currentammo - ammo_shot;
		self.currentmag = max_mag;
	}
	else
	{
		self.currentmag = self.currentmag + self.currentammo;
		self.currentammo = 0;
	}
	//UpdateWeapons(0);
};

.float pressedbuttonwhilereloadomg;
void() ContinueReload = //Special reloads
{
	float tempf;
	if (self.new_anim_stop)
		return;
	string modelname;
	modelname = GetWeaponModel(self.weapon, 0);
	if (self.currentmag >= getWeaponMag(self.weapon) || !self.currentammo || self.pressedbuttonwhilereloadomg)
	{
		if (self.weapon == W_TRENCH )//||self.weapon == IT_GUT)
		{
			if (self.perks & P_SPEED)
				tempf = 0.375;
			else
				tempf = 0.5; 
			self.reload_delay = time + tempf;
			Set_W_Frame (24, 26, tempf, 0, RELOAD, W_LoadAmmo, modelname, false);
		}
		else if (self.weapon == W_KAR_SCOPE)
		{
			if (self.perks & P_SPEED)
				tempf = 0.75;
			else
				tempf = 1; 
			self.reload_delay = time + tempf;
			Set_W_Frame (24, 28, tempf, 0, RELOAD, SUB_Null, modelname, false);
		}
		self.pressedbuttonwhilereloadomg = 0;
	}
	else if (self.currentmag < getWeaponMag(self.weapon))
	{
		if (self.weapon == W_TRENCH)
		{
			self.currentmag++;
			self.currentammo = self.currentammo - 1;

			if (self.perks & P_SPEED)
				tempf = 0.375;
			else
				tempf = 0.5; 
			self.reload_delay = time + tempf;
			Set_W_Frame (18, 23, tempf, 0, RELOAD, ContinueReload, modelname, false);
		}
		/*else if (self.weapon == W_GUT)
		{
			if (self.currentammo > 1 && self.currentammo < 9)
			{
				self.currentmag = self.currentmag + 2;
				self.currentammo = self.currentammo -2;
			}
			else
			{
				self.currentmag++;
				self.currentammo--;
			}
			if (self.perks & P_SPEED)
				self.reload_delay = time + 0.375; 
			else
				self.reload_delay = time + 0.5; 
			Set_W_Frame (21, 25, 0, 0, RELOAD, ContinueReload, modelname, false);
		}*/
		else if (self.weapon == W_KAR_SCOPE)
		{
			self.currentmag++;
			self.currentammo = self.currentammo - 1;
			if (self.perks & P_SPEED)
				tempf = 0.6;
			else
				tempf = 0.8; 
			self.reload_delay = time + tempf;
			Set_W_Frame (19, 24, tempf, 0, RELOAD, ContinueReload, modelname, false);
		}
		else if (self.weapon == W_BROWNING )//|| self.weapon == W_ACCELERATOR)
		{
			if (self.perks & P_SPEED)
				tempf = 3;
			else
				tempf = 4; 
			self.reload_delay = time + tempf;
			Set_W_Frame (45, 77, tempf, 50, RELOAD, W_Give_Ammo, modelname, false);
		}
	}
}

void() W_Reload =
{
	//blubs remove me, for testing rendering zombie models=============
	local entity z;
	z = find(world,classname,"test_zombie");
	while(z)
	{
		remove(z);
		z = find(z,classname,"test_zombie");
	}
	//==============================================================
	if (self.reload_delay > time || self.new_anim_stop || self.zoom == 3)
		return;
	if (self.currentmag >= getWeaponMag(self.weapon))
		return;
	float endframe, startframe, reloadcancelframe;
	string modelname;
	modelname = GetWeaponModel(self.weapon, 0);

	if (self.currentammo)
	{
		if (self.weapon == W_TRENCH )//|| self.weapon == IT_GUT)
		{
			if (self.currentmag == 0)
				self.NeedLoad = true;
			Set_W_Frame (14, 17, 0, 0, RELOAD, ContinueReload, modelname, false);
			self.reload_delay = 0.8;
		}
		else if (self.weapon == W_KAR_SCOPE)
		{
			Set_W_Frame (14, 18, 0, 0, RELOAD, ContinueReload, modelname, false);
			self.reload_delay = 0.8;
		}
		else if (self.weapon == W_BROWNING )//|| self.weapon ==  IT_ACCELERATOR)
		{
			if (!self.currentmag)
			{
				Set_W_Frame (26, 77, 0, 45, RELOAD, W_Give_Ammo, modelname, false);
				self.reload_delay = 6;
			}
			else if (self.currentmag > 0)
			{
				Set_W_Frame (4, 25, 0, 0, RELOAD, ContinueReload, modelname, false);
				self.reload_delay = 3.5;
			}
		}
		else if (self.weapon == W_M1 )//|| self.weapon == IT_M1000)
		{
			if (self.currentmag > 0)
			{
				Set_W_Frame (4, 44, 0, 25, RELOAD, W_Give_Ammo, modelname, false);
				self.reload_delay = 3.9;
			}
			else
			{
				Set_W_Frame (8, 44, 0, 25, RELOAD, W_Give_Ammo, modelname, false);
				self.reload_delay = 3.6;
			}
		}
		else
		{
			startframe = GetFrame(self.weapon,RELOAD_START);
			endframe = GetFrame(self.weapon,RELOAD_END);
			reloadcancelframe = GetFrame(self.weapon,RELOAD_CANCEL);

			Set_W_Frame (startframe, endframe, 0, reloadcancelframe, RELOAD, W_Give_Ammo, modelname, false);
			self.reload_delay = getWeaponDelay(self.weapon,RELOAD);
		}
		self.zoom = false;
		//self.pressedbuttonwhilereloadomg = false;
		if (self.weapon != W_TRENCH)
			self.NeedLoad = false;
		if (self.perks & P_SPEED)
			self.reload_delay = self.reload_delay*0.75;
		self.reload_delay = self.reload_delay + time;
	}
};
/*
 +-=-=-=+
 |W_Fire|
 +-=-=-=+
*/

/*
================
SpawnBlood
================
*/
void(vector org, vector vel, float damage) SpawnBlood =
{
	particle (org, vel*0.1, 73, damage*2);
	//below is for gib testing.
	//particle (org, org, 225, 1);
};

float() crandom =
{
	return 2*(random() - 0.5);
}


/*
===============
spawn_gibs
===============
*/
void(vector where) spawn_gibs =
{
	particle(where,where,225,1);
};


void() LungeKnifeHit =
{		
	vector	source,org;
	float	f_damage;
	entity	hit_ent;

	makevectors (self.v_angle);
	source = self.origin + self.view_ofs;
	if (self.weapon == W_BK)
		traceline (source, source + v_forward*80, 0, self);
	else
		traceline (source, source + v_forward*64, 0, self);
	
	org = trace_endpos - v_forward*4;
	

	if (trace_ent.takedamage)
	{
		sound (self, CHAN_WEAPON, "weapons/knife/knife_hitbod.wav", 1, ATTN_NORM);
		if(trace_ent.classname == "item_radio")
		{
			entity oldself;
			oldself  = self;
			self = trace_ent;
			self.th_die();
			self = oldself;
			return;
		}
		
		if (self.bowie && self.weapon == W_BK)
			f_damage = 1200;
		else if (self.bowie)
			f_damage = 1000;
		else if (self.weapon == W_BK)
			f_damage = 500;
		else
			f_damage = 150;
		
		if (trace_ent.classname == "ai_zombie_head")
		{
			hit_ent = trace_ent.owner;
			f_damage = f_damage*1.5;
		}
		else if (trace_ent.classname == "ai_zombie_larm")
		{
			hit_ent = trace_ent.owner;
		}
		else if (trace_ent.classname == "ai_zombie_rarm")
		{
			hit_ent = trace_ent.owner;
		}
		else
		{
			hit_ent = trace_ent;
		}
		if (hit_ent.takedamage != DAMAGE_NOMARKER)
		{
			org = source + (v_forward * 20);
			SpawnBlood (org, org, 50);
			//hit = 1;
		}
		
		DamageHandler (hit_ent, self, f_damage, S_KNIFE);
	}
}


/*
================
TraceAttack
================
*/
// Now with locational damage
void(float Damage, vector dir, vector org, vector plane, entity hit_ent) TraceAttack =
{
	local vector  vel;
	local float f_damage;
	entity oldself;
  
	vel = normalize(dir);
	vel = vel + 2*plane;
	vel = vel * 200;

	if (hit_ent.takedamage)
	{
		if (trace_fraction >= 1)
			return;
		if (hit_ent.classname == "item_radio")
		{
			oldself  = self;
			self = hit_ent;
			self.th_die();
			self = oldself;
			return;
		} else if (hit_ent.classname == "explosive_barrel") {
			hit_ent.enemy = self;
			oldself  = self;
			self = hit_ent;
			self.health = self.health - Damage;
			barrel_hit ();
			self = oldself;
			return;
		}
		SpawnBlood (org, vel, Damage*10);

		if (hit_ent.classname == "ai_zombie_head")
		{
			f_damage = Damage*GetWeapopnMultiplier(self.weapon,HEAD_X);
		}
		else if (hit_ent.classname == "ai_zombie_larm")
		{
			f_damage = Damage*GetWeapopnMultiplier(self.weapon,LIMBS_X);
		}
		else if (hit_ent.classname == "ai_zombie_rarm")
		{
			f_damage = Damage*GetWeapopnMultiplier(self.weapon,LIMBS_X);
		}
		else
		{
			if (hit_ent.classname == "ai_zombie")
			{
				if (trace_endpos_z < hit_ent.origin_z)
					f_damage = Damage*GetWeapopnMultiplier(self.weapon,LOWER_TORSO_X);
				else
					f_damage = Damage*GetWeapopnMultiplier(self.weapon,UPPER_TORSO_X);
				
				
			}
			else
				f_damage = Damage;
		}

		hit_ent.washit = 1;
		hit_ent.hitamount = hit_ent.hitamount + f_damage;

		msg_entity = self;
		WriteByte(MSG_ONE, SVC_HITMARK);
	}
	else
	{
		WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
		WriteByte (MSG_BROADCAST, TE_GUNSHOT);
		WriteCoord (MSG_BROADCAST, org_x);
		WriteCoord (MSG_BROADCAST, org_y);
		WriteCoord (MSG_BROADCAST, org_z);
		//self.shotmissed = true;
	}
};

void () CL_SendWeaponFire =
{
	float return_time;
	vector Wep_Recoil;
	
	Wep_Recoil = GetWeaponRecoil(self.weapon);

	msg_entity = self;
	WriteByte(MSG_ONE, SVC_WEAPONFIRE);
	return_time = getWeaponRecoilReturn(self.weapon);
	WriteLong(MSG_ONE, return_time);
	WriteCoord (MSG_ONE, Wep_Recoil_x);
	WriteCoord (MSG_ONE, Wep_Recoil_y);
	WriteCoord (MSG_ONE, Wep_Recoil_z);
	//self.punchangle = Wep_Recoil;
	self.recoil_delay = 60/return_time + time;
}

void Parse_Damage () = // DO NOT TOUCH
{
	entity ent, body_ent;
	float head_hit, headoff;
	float total_dmg;
	
	ent = findfloat (world, washit, 1);
	
	while (ent)
	{
		if (ent.classname != "radio" && ent.classname != "explosive_barrel") 
		{	
			if (ent.classname == "ai_zombie_head")
			{
				head_hit = 1;
				body_ent = ent.owner;
			}
			else if (ent.classname == "ai_zombie_larm")
			{
				body_ent = ent.owner;
			}
			else if (ent.classname == "ai_zombie_rarm")
			{
				body_ent = ent.owner;
			}
			else
				body_ent = ent;
			
			total_dmg = body_ent.hitamount;
			if (body_ent.head.washit)
			{
				total_dmg = total_dmg + body_ent.head.hitamount;
				head_hit = 1;
				body_ent.head.health = body_ent.head.health - body_ent.head.hitamount;
				
				if (body_ent.head.health <= 0 && self.weapon != W_COLT)
				{
					if(!body_ent.head.deadflag)
						return;
					local vector where;
					
					makevectors(body_ent.head.owner.angles);
					where = body_ent.head.owner.origin + (body_ent.head.view_ofs_x * v_right) + (body_ent.head.view_ofs_y * v_forward) + (body_ent.head.view_ofs_z * v_up);
					spawn_gibs(where);
					
					body_ent.head.deadflag = false;
					body_ent.head.solid = SOLID_NOT;
					setmodel(body_ent.head,"");
					body_ent.head.frame = 0;
					
					body_ent.usedent = self;
					
					//body_ent.health = random() * 10 + 1;
					
					body_ent.bleedingtime = time + 2;
					headoff = 1;
					updateLimb (body_ent.head.owner, 0, world);
				}
				
				body_ent.head.washit = 0;
				body_ent.head.hitamount = 0;
			}
			if (body_ent.larm.washit)
			{
				total_dmg = total_dmg + body_ent.larm.hitamount;

				body_ent.larm.health = body_ent.larm.health - body_ent.larm.hitamount;
				if (body_ent.larm.health <= 0 && self.weapon != W_COLT && body_ent.larm.owner.rarm.deadflag && body_ent.larm.deadflag)
				{
					//if(!body_ent.larm.deadflag)//blubs disabled this, read below in the rarm as to why
					//	return;
					
					makevectors(body_ent.larm.owner.angles);
					where = body_ent.larm.owner.origin + (body_ent.larm.view_ofs_x * v_right) + (body_ent.larm.view_ofs_y * v_forward) + (body_ent.larm.view_ofs_z * v_up);
					spawn_gibs(where);
					
					body_ent.larm.deadflag = false;
					body_ent.larm.solid = SOLID_NOT;
					setmodel(body_ent.larm,"");
					body_ent.larm.frame = 0;
					updateLimb (body_ent.larm.owner, 1, world);
				}

				body_ent.larm.washit = 0;
				body_ent.larm.hitamount = 0;
			}
			if (body_ent.rarm.washit)
			{
				total_dmg = total_dmg + body_ent.rarm.hitamount;

				body_ent.rarm.health = body_ent.rarm.health - body_ent.rarm.hitamount;
				if (body_ent.rarm.health <= 0 && self.weapon != W_COLT && body_ent.rarm.owner.larm.deadflag && body_ent.rarm.deadflag)
				{
					//if(!body_ent.rarm.deadflag) //blubs disabled these, since arm hitboxes aren't100% accurate, a lot of the time you'd shoot at zombie with no arm, hit his arm bbox, and do no damage to zombie
					//	return;	//but the bullet should have hit the zombie, but no damage was done, so wtf
					//didn't disable the head, because the head bbox is usually pretty accurate, so it doesn't have the same effect
					//added the "body_ent.rarm.deadflag" check in the conditional, we don't want function to return, but we also don't want you to remove arms more than once
					
					makevectors(body_ent.rarm.owner.angles);
					where = body_ent.rarm.owner.origin + (body_ent.rarm.view_ofs_x * v_right) + (body_ent.rarm.view_ofs_y * v_forward) + (body_ent.rarm.view_ofs_z * v_up);
					spawn_gibs(where);
					
					body_ent.rarm.deadflag = false;
					body_ent.rarm.solid = SOLID_NOT;
					setmodel(body_ent.rarm,"");
					body_ent.rarm.frame = 0;
					updateLimb (body_ent.rarm.owner, 2, world);
				}

				body_ent.rarm.washit = 0;
				body_ent.rarm.hitamount = 0;
			}

			/*if (!body_ent.head.deadflag && !headoff) JUKKI FIX ME, if i jsut remember what this was for XD
				total_dmg = (body_ent.health * 2);*/
			
			/*println("Final dealt damage = ");
			println(ftos(total_dmg));
			println("\n");*/
		
			if (instakill_finished)
			{
				if(body_ent.head.deadflag)
				{
					body_ent.head.deadflag = false;
					body_ent.head.solid = SOLID_NOT;
					setmodel(body_ent.head,"");
					body_ent.head.frame = 0;
				}
			}
			if (head_hit)
				DamageHandler(body_ent,self, total_dmg, S_HEADSHOT);
			else
				DamageHandler(body_ent,self, total_dmg, S_NORMAL);
			
			body_ent.washit = 0;
			body_ent.hitamount = 0;
			ent = findfloat (ent, washit, 1);
		}
	}
}
void (float shotcount, float sprd, float Damage/*, float headmulti, float legmulti*/) FireTrace =
{
	float count, r, ru, do_break, penetration_times;
	vector dir, src, trace_start_org;
	entity hitent;
	
	makevectors(self.v_angle);
	
	src = self.origin + self.view_ofs;
	
	CL_SendWeaponFire();

	while (count < shotcount)
	{
		dir = aim (self,0);
		r = random() * sprd*10;
		if (random() < 0.5)
			r = r*-1;
		ru = random() * sprd*10;
		if (random() < 0.5)
			ru = ru*-1;

		dir = dir*2048;
		dir = dir + v_right*r + v_up*ru;
		trace_start_org = src;
		trace_ent = self;
		do_break = 0;
		penetration_times = 0;
		hitent = world;
		while (!do_break && random() < getWeaponPenetration(self.weapon, penetration_times))
		{
			while (1)
			{
				traceline (trace_start_org, trace_start_org + dir, 0, trace_ent);
				if (hitent == world)
					break;
				if (hitent.larm == trace_ent || hitent.rarm == trace_ent || hitent.head == trace_ent)
				{
					hitent = trace_ent;
					trace_start_org = trace_endpos + normalize(dir)*10;
					//break;
				}
				else
					break;
			}
			
			if (trace_fraction != 1.0)
				TraceAttack (Damage, dir, trace_endpos, trace_plane_normal, trace_ent);
			trace_start_org = trace_endpos;
			penetration_times++;
			if (!trace_ent.takedamage)
				do_break = 1;
			
			if (trace_ent.classname == "ai_zombie_head" || trace_ent.classname == "ai_zombie_larm" || trace_ent.classname == "ai_zombie_rarm")
				hitent = trace_ent.owner;
			else
				hitent = trace_ent;
		}
		hitent = world;

		count++;
	}
	Parse_Damage();

}
void () W_LoadAmmoDone =
{
	self.NeedLoad = false;
}
void () W_LoadAmmo =
{
	string modelname;
	if (!self.NeedLoad)
		return;
	if (!self.currentmag)
	{
		W_Reload();
		return;
	}

	if (self.zoom != 2)
		modelname = GetWeaponModel(self.weapon, 0);
	else
		modelname = "";

	if (self.weapon == W_TRENCH/* || self.weapon == W_GUT*/)
	{
		Set_W_Frame (4, 14, 0, 12, FIRE, W_LoadAmmoDone, modelname, false);
		if (self.perks & P_DOUBLE)
			self.fire_delay = 0.75 + time;
		else
			self.fire_delay = 1 + time;
	}
	else if (self.weapon == W_KAR/* || self.weapon == W_ARMAGEDDON*/ || self.weapon == W_KAR_SCOPE)
	{
		Set_W_Frame (4, 13, 1.1, 9, FIRE, W_LoadAmmoDone, modelname, false);
		if (self.perks & P_DOUBLE)
			self.fire_delay = 0.675 + time;
		else
			self.fire_delay = 0.9 + time;
	}	
}

void () CheckReload = 
{
	if (!self.currentmag)
		W_Reload();
}
void() W_Fire =
{
	if (time < self.fire_delay || self.new_anim_stop || self.zoom == 3 || self.reload_delay > time)
		return;
	float startframe;
	float endframe;
	float firetype;
	float damage;
	float shotcount;
	string modelname;
	string soundname;
	float spread;
	float tempf;


	makevectors(self.v_angle);

	if (!self.currentmag)
	{
		W_Reload();
		return;
	}
	if (self.NeedLoad && (self.weapon == W_TRENCH || /*self.weapon == W_GUT ||  */self.weapon == W_KAR_SCOPE || self.weapon == W_KAR/* || self.weapon == W_ARMAGEDDON*/))
	{
		W_LoadAmmo();
		return;
	}

	firetype = GetFiretype (self.weapon);

	if (self.zoom != 2)
		modelname = GetWeaponModel(self.weapon, 0);
	else
		modelname = "";
	damage = getWeaponDamage(self.weapon);

	//===Double tap 2.0===
	local float dt2Multi;
	if(self.perks & P_DOUBLE)
		dt2Multi = 2;
	else
		dt2Multi = 1;
	//====/Double tap 2.0 ====
	shotcount = 1;//dt2Multi;
	
	if (!firetype)
	{
		if (self.zoom == 1 || self.zoom == 2)
		{
			spread = 0;
			shotcount *= GetWeaponShotcount(self.weapon);
			FireTrace(shotcount, spread, damage/* , self.weaponslot1.headx, self.weaponslot1.legx */);
		}
		else
		{
			spread = GetWeaponSpread(self.weapon);
			shotcount *= GetWeaponShotcount(self.weapon);
			FireTrace(shotcount, spread,damage/* , self.weaponslot1.headx, self.weaponslot1.legx */);
		}
	}
	else if (firetype == 1)
	{
		if (self.semi)
			return;
		if (self.zoom == 1 || self.zoom == 2)
		{
			if (self.weapon == W_TRENCH || self.weapon == W_DB || self.weapon == W_SAWNOFF)
				spread = GetWeaponSpread(self.weapon)*0.75;
			else
				spread = 0;
			shotcount *= GetWeaponShotcount(self.weapon);
			FireTrace(shotcount, spread, damage/* , self.weaponslot1.headx, self.weaponslot1.legx */);
		}
		else
		{
			spread = GetWeaponSpread(self.weapon);
			shotcount *= GetWeaponShotcount(self.weapon);
			FireTrace(shotcount, spread,damage/* , self.weaponslot1.headx, self.weaponslot1.legx */);
		}
		self.semi = true;
	}
	else
		bprint ("Missing firetype for weapon.\n");
	
	tempf = getWeaponDelay(self.weapon, FIRE);
	if (self.perks & P_DOUBLE)
		tempf = getWeaponDelay(self.weapon, FIRE)*0.75;
	if (/*self.weapon == W_GUT || */ self.weapon == W_KAR_SCOPE || self.weapon == W_TRENCH || self.weapon == W_KAR/* || self.weapon == W_ARMAGEDDON*/)
	{
		startframe = GetFrame(self.weapon,FIRE_START);
		endframe = GetFrame(self.weapon,FIRE_END);
		Set_W_Frame (startframe, endframe, tempf, 0, FIRE, /*CheckReload*/ W_LoadAmmo, modelname, false);//FIXME
		self.NeedLoad = true;
	}
	else
	{
		startframe = GetFrame(self.weapon,FIRE_START);
		endframe = GetFrame(self.weapon,FIRE_END);
		Set_W_Frame (startframe, endframe, tempf, 0, FIRE, CheckReload, modelname, false);//FIXME
	}

	self.effects = self.effects | EF_MUZZLEFLASH;
	self.currentmag = self.currentmag - 1;
	self.fire_delay = getWeaponDelay(self.weapon, FIRE) + time;
	if (self.perks & P_DOUBLE)
		self.fire_delay = getWeaponDelay(self.weapon, FIRE)*0.75 + time;
	
	soundname = GetWeaponSound(self.weapon);
	sound (self, CHAN_WEAPON, soundname, 1, ATTN_NORM);
};

/*
 +-=-=-=-+
 |W_AimIn|
 +-=-=-=-+
*/
.float scope_zoom_in_time;
void() W_AimIn =
{
	if (self.zoom == 1 || self.reload_delay > time || self.new_anim_stop || self.zoom == 3)
		return;

	if (self.weapon == W_M2)//flame thrower does not have aim in.
		return;
	/*float startframe;
	float endframe;
	string modelname;
	startframe = 0;
	endframe = 0;
	modelname = GetWeaponModel(self.weapon, 0);

	if (self.weapon == W_KAR_SCOPE || self.weapon == W_PTRS || self.weapon == W_HEADCRACKER || self.weapon == W_PENETRATOR)
	{
		Set_W_Frame (startframe, endframe, 0, 0, ZOOM, ScopeZoom, modelname, false);//FIXME
		self.zoom = 2;
	}
	else
	{
		Set_W_Frame (startframe, endframe, 0, 0, ZOOM, CheckReload, modelname, false);//FIXME
	}*/
	
	self.zoom = TRUE;
	if (self.weapon == W_KAR_SCOPE || self.weapon == W_PTRS)
		self.scope_zoom_in_time = time + 0.3;
	

	/*self.reload_delay2 = self.fire_delay2 = self.reload_delay = self.fire_delay = 0;*/
}
void() W_AimOut =
{
	if (self.zoom == 0 || self.new_anim_stop || self.zoom == 3)
		return;
	/*float startframe;
	float endframe;
	string modelname;
	startframe = 0;
	endframe = 0;
	modelname = GetWeaponModel(self.weapon, 0);

	Set_W_Frame (startframe, endframe, 0, 0, ZOOM, SUB_Null, modelname, false);*///FIXME
	self.zoom = false;
	if (self.weapon == W_KAR_SCOPE)
	{
		self.weapon2model = "progs/VModels/v_karscope.mdl";
		self.weaponmodel = "progs/VModels/v_kar.mdl";
	}
	self.scope_zoom_in_time = 0;
	/*self.reload_delay2 = self.fire_delay2 = self.reload_delay = self.fire_delay = 0;*/
}

void() W_Switch =
{
	if (self.secondaryweapon && !self.new_anim_stop)
	{
		float tempf,tempf1,tempf2;
		float startframe;
		float endframe;
		string modelname;

		tempf = self.currentammo;
		self.currentammo = self.secondaryammo;
		self.secondaryammo = tempf;

		tempf1 = self.currentmag;
		self.currentmag = self.secondarymag;
		self.secondarymag = tempf1;

		tempf2 = self.weapon;
		self.weapon = self.secondaryweapon;
		self.secondaryweapon = tempf2;

		startframe = GetFrame(self.weapon,TAKE_OUT_START);
		endframe = GetFrame(self.weapon,TAKE_OUT_END);
		modelname = GetWeaponModel(self.weapon, 0);
		
		//UpdateWeapons(1);
		//if (self.weaponslot1.dualwield)
		//	Set_W2_Frame (self.weaponslot1.TakeWeaponStart, self.weaponslot1.TakeWeaponEnd, 0, 0, 0, SUB_Null, self.weaponslot1.v_model2, false);//FIXME
		Set_W_Frame (startframe, endframe, 0, 0, 0, SUB_Null, modelname, false);//FIXME
		
		/*self.reload_delay2 = self.fire_delay2 = */self.reload_delay = self.fire_delay = 0;
	}
}

void() W_PutOut =
{
	if (self.downed)
		return;
	if (self.secondaryweapon && !self.new_anim_stop)
	{
		float startframe;
		float endframe;
		string modelname;
		startframe = GetFrame(self.weapon,PUT_OUT_START);
		endframe = GetFrame(self.weapon,PUT_OUT_END);
		modelname = GetWeaponModel(self.weapon, 0);
		//UpdateWeapons(1);
		//if (self.weaponslot1.dualwield)
		//	Set_W2_Frame (self.weaponslot1.PutOutStart, self.weaponslot1.PutOutEnd, (self.weaponslot1.PutOutEnd - self.weaponslot1.PutOutStart)/10, 0, SWITCHWEP, W_Switch, self.weaponslot1.v_model2, false);//FIXME
		Set_W_Frame (startframe, endframe, (endframe - startframe)/10, 0, SWITCHWEP, W_Switch, modelname, false);//FIXME
		/*self.reload_delay2 = self.fire_delay2 = */self.reload_delay = self.fire_delay = 0;
	}
}
void() sprintrun =
{
	//if (self.weaponslot1.dualwield)
	//	Set_W2_Frame (self.weaponslot1.SprintInStart, self.weaponslot1.SprintInEnd, 0, 0, SPRINT, ContinueRun2, self.weaponslot1.v_model2, false);//FIXME
	if (self.fire_delay > time || self.new_anim_stop)
		return;
	float startframe;
	float endframe;
	string modelname;
	startframe = GetFrame(self.weapon,SPRINT_IN_START);
	endframe = GetFrame(self.weapon,SPRINT_IN_END);
	modelname = GetWeaponModel(self.weapon, 0);
	if (startframe || endframe)
		Set_W_Frame (startframe, endframe, 0, 0, SPRINT, ContinueRun, modelname, false);//FIXME
	self.zoom = 3;
	self.into_sprint = time;
	/*self.reload_delay2 = self.fire_delay2 = */self.reload_delay = self.fire_delay = 0;
}

void() sprintstop =
{
	float startframe;
	float endframe;
	string modelname;
	startframe = GetFrame(self.weapon,SPRINT_OUT_START);
	endframe = GetFrame(self.weapon,SPRINT_OUT_END);
	modelname = GetWeaponModel(self.weapon, 0);
	Set_W_Frame (startframe, endframe, 0, 0, SPRINT, /*ContinueRun*/ SUB_Null, modelname, false);//FIXME
	self.zoom = 0;
	self.into_sprint = 0;
	/*self.reload_delay2 = self.fire_delay2 = */self.reload_delay = self.fire_delay = 0;
}

void () W_Knife =
{
	if (time < self.fire_delay || time < self.knife_delay || self.new_anim_stop)
		return;
	
	if (self.zoom == 2 || self.zoom == 3)//dolphin dive here when its time has come
		return;

	if (self.downed)
		return;

	sound (self, CHAN_WEAPON, "weapons/knife/knife.wav", 1, ATTN_NORM);

	vector	source;
	entity	hit_ent;
	//entity	oldself;
	float	r;
	vector	org;
	float hit;


	makevectors (self.v_angle);
	source = self.origin + self.view_ofs;
	if (self.weapon == W_BK)
		traceline (source, source + v_forward*128, 0, self);
	else
		traceline (source, source + v_forward*100, 0, self);
	
	org = trace_endpos - v_forward*4;

	r = vlen(source - org);

	if (trace_ent.takedamage)
	{

		if (trace_ent.classname == "ai_zombie_head")
			hit_ent = trace_ent.owner;
		else if (trace_ent.classname == "ai_zombie_larm")
			hit_ent = trace_ent.owner;
		else if (trace_ent.classname == "ai_zombie_rarm")
			hit_ent = trace_ent.owner;
		else
			hit_ent = trace_ent;
		if (hit_ent.classname == "ai_zombie")
			hit = true;
	}
	else if (trace_fraction < 1.0)
	{	// hit wall
		sound (self, CHAN_WEAPON, "weapons/knife/knife_hit.wav", 1, ATTN_NORM);
		WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
		WriteByte (MSG_BROADCAST, TE_GUNSHOT);
		WriteCoord (MSG_BROADCAST, org_x);
		WriteCoord (MSG_BROADCAST, org_y);
		WriteCoord (MSG_BROADCAST, org_z);
	}

	if (r > 40 && hit)//lunge
	{

		if (self.weapon == W_BK)
		{
			Set_W_Frame (14, 24, 1.4, 0, KNIFE, SUB_Null, "progs/VModels/v_bk.mdl", false);
			self.fire_delay = time + 1.5;
			self.knife_delay = time + 1.75;
		}
		else if (self.bowie)
		{
			Set_W_Frame (4, 10, 0.7, 0, KNIFE, ReturnWeaponModel, "progs/VModels/v_bowie.mdl", false);
			self.fire_delay = time + 0.8;
			self.knife_delay = time + 1.3;
		}
		else
		{
			Set_W_Frame (4, 12, 0.7, 0, KNIFE, ReturnWeaponModel, "progs/VModels/v_knife.mdl", false);
			self.fire_delay = time + 0.8;
			self.knife_delay = time + 1;
		}
		self.velocity = v_forward * 200;
	}
	else
	{
		if (self.weapon == W_BK)//slash
		{
			Set_W_Frame (8, 13, 0, 0.4, KNIFE, SUB_Null, "progs/VModels/v_bk.mdl", false);
			self.fire_delay = time + 0.5;
			self.knife_delay = time + 0.8;
		}
		else if (self.bowie)
		{
			Set_W_Frame (0, 3, 0.3, 0, KNIFE, ReturnWeaponModel, "progs/VModels/v_bowie.mdl", false);
			self.fire_delay = time + 0.4;
			self.knife_delay = time + 0.9;
		}
		else
		{
			self.punchangle_x = -5;
			self.punchangle_y = -10;
			//self.punchangle_z = 5;
			Set_W_Frame (0, 3, 0.3, 0, KNIFE, ReturnWeaponModel, "progs/VModels/v_knife.mdl", false);
			self.fire_delay = time + 0.4;
			self.knife_delay = time + 0.7;
		}
	}
	self.reload_delay = 0;
};

void() GrenadeExplode =
{
	DamgageExplode (self, self.owner, 225, 75, 128);//was 256 inch radius, kicked it down to 128 because 21 feet exploding radius is... a bit overkill...

	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);

	SUB_Remove ();
};
void() NadeStraighten =
{
	self.angles_x = (self.angles_x > 0) ? 90 : -90;	
};
void() Velocity_reduce =
{
	if (!other.solid || other.solid == SOLID_TRIGGER)
		if (other != world)
			return;

	self.velocity = self.velocity*0.5;
	
	NadeStraighten();
};

void() W_ThrowGrenade =
{
	
	local	entity nade;

	nade = spawn ();
	nade.owner = self;
	nade.grenade_delay = nade.owner.grenade_delay;
	nade.owner.grenade_delay = 0;
	nade.movetype = MOVETYPE_BOUNCE;
	nade.solid = SOLID_BBOX;
	nade.classname = "grenade";
		
// set nade speed	

	makevectors (self.v_angle);

	nade.velocity = v_forward*800;

	nade.avelocity = '400 -400 400';

	//nade.angles = vectoangles(nade.velocity);
	//nade.angles_z += (nade.angles_z + 180 < 360)? 180 : -180;
	nade.angles = vectoangles(v_forward);
	nade.angles_z -= 35;
// set nade duration
	nade.nextthink = nade.grenade_delay;
	nade.think = GrenadeExplode;

	nade.touch = Velocity_reduce;
	setmodel (nade, "progs/GModels/g_grenade.mdl");
	setsize (nade, '0 0 0', '0 0 0');
	nade.origin = self.origin + self.view_ofs;
	nade.origin += v_forward * 12;
	setorigin (nade, nade.origin);
	
	self.animend = ReturnWeaponModel;
	self.callfuncat = 0;
}

void() checkHold =
{
	if (!self.button3 || self.grenade_delay < time)
	{
		if(self.grenade_delay < time)
			self.grenade_delay = time + 0.05;
		Set_W_Frame (3, 6, 0, 5, GRENADE, W_ThrowGrenade, "progs/VModels/v_nade.mdl", true);
		sound (self, CHAN_WEAPON, "weapons/grenade/throw.wav", 1, ATTN_NORM);
		self.reload_delay = self.fire_delay = time + 0.4;
		self.throw_delay = time + 0.9;
		
	}
	else
	{
		Set_W_Frame (2, 2, 0, 0, GRENADE, checkHold, "progs/VModels/v_nade.mdl", true);
		//self.weaponframe = 12;
		//self.weapon_anim_end = 12;
		//self.animend = checkHold;
		//self.weapon_anim_type = GRENADE;
	}
}

void() W_Grenade =
{
	if (self.throw_delay > time || self.zoom || self.downed)
		return;

	if (self.primary_grenades > 0)
	{
		Set_W_Frame (0, 2, 0, 0, GRENADE, checkHold, "progs/VModels/v_nade.mdl", true);
		sound (self, CHAN_WEAPON, "weapons/grenade/prime.wav", 1, ATTN_NORM);	
		self.primary_grenades = self.primary_grenades - 1;
		self.throw_delay = self.reload_delay = self.fire_delay = time + 6;
		self.grenade_delay = time + 5;
		//self.holdnade = TRUE;
	}
}

void () Impulse_Functions =
{
	switch (self.impulse)
	{
		case 23:
			if (!self.downed/* && self.stamina > 25*/)
			sprintrun();
			break;
		case 24:
			if (self.zoom == 3)
				sprintstop();
			break;
		case 232:
			addmoney(self, 10000, 0);
			break;
	}
	
	self.impulse = 0;
};

void () Recoil_Update =
{
	if (self.velocity)
		self.cur_spread = GetWeaponMaxSpread(self.weapon);
	else if (self.recoil_delay > time && self.recoil_delay)
    {
        self.cur_spread = self.cur_spread + 10;
		if (self.cur_spread >= GetWeaponMaxSpread(self.weapon))
			self.cur_spread = GetWeaponMaxSpread(self.weapon);
    }
    else if (self.recoil_delay < time && self.recoil_delay)
    {
        self.cur_spread = self.cur_spread - 4;
		if (self.cur_spread <= 0)
		{
			self.cur_spread = 0;
			self.recoil_delay = 0;
		}
    }
}

.float semiswitch;
.float semireload;
.float semiknife;
void () Weapon_Logic =
{
	
	W_Frame_Update ();
	Impulse_Functions();
	
	if (self.scope_zoom_in_time < time && self.scope_zoom_in_time)
	{
		//Set_W_Frame (0, 0, 0, 0, ZOOM, SUB_Null, "", false);//FIXME
		self.scope_zoom_in_time = 0;
		self.zoom = 2;
		self.weaponmodel = "";
		self.weapon2model = "";
	}

	if (self.button0)
		W_Fire();
	else
		self.semi = false;
	
	if (self.button3)
	{
		W_Grenade();
	}

	if (self.button4 && !self.semiswitch)
	{
		W_PutOut();
		self.semiswitch = true;
	}
	else if (!self.button4)
		self.semiswitch = false;

	if (self.button5 && !self.semireload)
	{
		W_Reload();
		self.semireload = true;
	}
	else if (!self.button5)
		self.semireload = false;

	if (self.button6 && !self.semiknife)
	{
		W_Knife();
		self.semiknife = true;
	}
	else if (!self.button6)
		self.semiknife = false;

	if (!self.button1)
		self.semiuse = false;
	
	if (self.button7 && !self.zoom)
		W_AimIn();
	else if (!self.button7 && self.zoom)
		W_AimOut();


	Recoil_Update();
};