/*
+----+
|Main|
+----+-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-+
| Scratch                                      Http://www.admdev.com/scratch |
+=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-+
| Contains some 'base' subroutines. As a general rule nothing in this file   |
| does much, except to setup basic variables and entities.                   |
+=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-+
*/
void() LightStyles_setup;       // Entities/Lights.QC
void() precaches;
void() Load_Waypoints;
float zombie_cleaned_w;

void() main = {};
void() SetNewParms = {};
void() SetChangeParms = {};
	
void() RelinkZombies =
{
	entity ent,ent2;
	local float i;
	local vector min, max;
	while ((ent = find (ent, classname, "ai_zombie")))
	{
		if(ent.currentHitBoxSetup == 0)//empty bbox, we don't care to update
			continue;
		
		makevectors (ent.angles);
		
		for(i = 0; i < 3; i++)
		{
			if(i == 0)
				ent2 = ent.head;
			if(i == 1)
				ent2 = ent.larm;
			if(i == 2)
				ent2 = ent.rarm;
				
			
			if (ent2)
			{
				//setorigin (ent.head, ent.origin + v_right * ent.head.view_ofs_x + v_forward * ent.head.view_ofs_y + v_up * ent.head.view_ofs_z);
				setorigin (ent2, ent.origin);
				//fixme, move angles set and frame set to below the continue, we only want to update origin (maybe angles too?)
				ent2.angles = ent.angles;
				
				if(ent2.deadflag)
					ent2.frame = ent.frame; 
				
				//if(OnlyOrigin)
				//	continue;
					
				min = ent2.bbmins + (v_right * ent2.view_ofs_x) + (v_forward * ent2.view_ofs_y) + (v_up * ent2.view_ofs_z);
				max = ent2.bbmaxs + (v_right * ent2.view_ofs_x) + (v_forward * ent2.view_ofs_y) + (v_up * ent2.view_ofs_z);
				
				if(min_x > max_x) { min_x += max_x; max_x = min_x - max_x; min_x -= max_x; }
				if(min_y > max_y) { min_y += max_y; max_y = min_y - max_y; min_y -= max_y; }
				if(min_z > max_z) { min_z += max_z; max_z = min_z - max_z; min_z -= max_z; }
				
				setsize(ent2,min,max);
			}

		}
	}
}
	
void() StartFrame = 
{
	if (cvar("waypoint_mode"))
	{	
		if (!zombie_cleaned_w)
		{
			entity zent;
			zent = find (world, classname, "ai_zombie");
			while (zent)
			{
				if (zent.head)
					remove (zent.head);
				if (zent.larm)
					remove (zent.larm);
				if (zent.rarm)
					remove (zent.rarm);
				remove (zent);
				zent = find (zent, classname, "ai_zombie");
			}
			zombie_cleaned_w = true;
			
			zent = find (world, classname, "waypoint");
			while (zent)
			{
				if (zent.targetname)
					setmodel(zent, "progs/way/normal_way_door.spr");
				else
					setmodel(zent, "progs/way/normal_way.spr");
				zent = find (zent, classname, "waypoint");
			}
			zent = find (world, classname, "door_nzp_cost");
			while (zent)
			{
				zent.solid = SOLID_NOT;
				zent.touch = SUB_Null;
				zent = find (zent, classname, "door_nzp_cost");
			}
			zent = find (world, classname, "door_nzp");
			while (zent)
			{
				zent.solid = SOLID_NOT;
				zent.touch = SUB_Null;
				zent.solid = SOLID_NOT;
				zent = find (zent, classname, "door_nzp");
			}
			zent = find (world, classname, "window");
			while (zent)
			{
				zent.solid = SOLID_NOT;
				zent.touch = SUB_Null;
				zent = find (zent, classname, "window");
			}
		}
		return;
	}
	
	if (roundinit && ai_delay_time < time)
	{
		ai_delay_time = time + 0.03;//Only run 30 times per second
		Round_Core();
		Do_Zombie_AI ();
	}
	
	if (instakill_finished >= time)
	{
		if (instakill_finished < 4 + time)
		{
			if (insta_blink< time - 0.25)
				insta_blink = time + 0.25;
		}
		else if (instakill_finished < 7 + time)
		{
			if (insta_blink< time - 0.5)
				insta_blink = time + 0.5;
		}
		else if (instakill_finished < 10 + time)
		{
			if (insta_blink< time - 1)
				insta_blink = time + 1;
		}
		if (insta_blink < time)
			insta_icon = true;
		else 
			insta_icon = false;			
	}
	else if(instakill_finished)
	{
		instakill_finished = 0;
		insta_icon = false;
	}
	
	if (x2_finished > time)
	{
		if (x2_finished < 4 + time)
		{
			if (x2_blink< time - 0.25)
				x2_blink = time + 0.25;
		}
		else if (x2_finished < 7 + time)
		{
			if (x2_blink< time - 0.5)
				x2_blink = time + 0.5;
		}
		else if (x2_finished < 10 + time)
		{
			if (x2_blink< time - 1)
				x2_blink = time + 1;
		}
		if (x2_blink < time)
			x2_icon = true;
		else 
			x2_icon = false;

		
	}
	else if(x2_finished)
	{
		x2_finished = 0;
		x2_icon = false;
	}
};
void() worldspawn = 
{
	precaches();
	LightStyles_setup();
	mappath = strcat("maps/", mapname);
	mappath = strzone(mappath);
	dprint("Error: file not found \n");
	if (cvar("waypoint_mode"))
		Load_Waypoints();
}

void() precaches =
{
	//models
	precache_model ("progs/player.mdl");
	//precache_model ("progs/Enemies/zombie.mdl");
	
	//precache_model ("progs/ai/zspr.spr");
	precache_model ("progs/ai/zfull.mdl");
	precache_model ("progs/ai/zb#.mdl");
	precache_model ("progs/ai/zal(.mdl");
	precache_model ("progs/ai/zar(.mdl");
	precache_model ("progs/ai/zh^.mdl");
	
	
	precache_model ("progs/ai/zcfull.mdl");
	precache_model ("progs/ai/zbc#.mdl");
	precache_model ("progs/ai/zalc(.mdl");
	precache_model ("progs/ai/zarc(.mdl");
	precache_model ("progs/ai/zhc^.mdl");
	
	
	precache_model ("progs/VModels/mzfl.mdl");
	precache_model ("progs/VModels/v_Colt.mdl");
	precache_model ("progs/VModels/v_knife.mdl");
	precache_model ("progs/VModels/v_nade.mdl");
	precache_model ("progs/VModels/v_betty.mdl");
	precache_model ("progs/GModels/g_grenade.mdl");
	precache_model ("progs/Misc/instakill!.mdl");
	precache_model ("progs/Misc/maxammo!.mdl");
	precache_model ("progs/Sprites/sprkle.spr");
	precache_model ("progs/Misc/nuke!.mdl");
	precache_model ("progs/Misc/carpenter!.mdl");
	precache_model ("progs/Misc/x2!.mdl");
	
	//sprites
	precache_model ("progs/way/current_way.spr");
	precache_model ("progs/way/current_way_door.spr");
	precache_model ("progs/way/last_way.spr");
	precache_model ("progs/way/last_way_door.spr");
	precache_model ("progs/way/normal_way.spr");
	precache_model ("progs/way/normal_way_door.spr");
	precache_model ("progs/way/way_jump.spr");
	precache_model ("progs/way/way_land.spr");
	
	//sounds
	precache_sound ("player/steps/step_1.wav");
	precache_sound ("player/steps/step_2.wav");
	precache_sound ("player/steps/step_3.wav");
	precache_sound ("player/steps/step_4.wav");
	
	precache_sound("misc/ching.wav");
	precache_sound("misc/debris.wav");
	precache_sound("misc/wood_door.wav");
	precache_sound("misc/buy.wav");
	precache_sound ("rounds/splash.wav");
	precache_sound ("rounds/nround.wav");
	precache_sound ("rounds/eround.wav");
	precache_sound ("weapons/colt/shoot.wav");
	precache_sound ("weapons/colt/magout.wav");
	precache_sound ("weapons/colt/magin.wav");
	precache_sound ("weapons/colt/slide.wav");
	precache_sound ("weapons/knife/knife_hitbod.wav");
	precache_sound ("weapons/knife/knife_hit.wav");
	precache_sound ("weapons/knife/knife.wav");
	precache_sound ("weapons/grenade/prime.wav");
	precache_sound ("weapons/grenade/throw.wav");
	
	precache_sound ("pu/double_points.wav");
	precache_sound ("pu/insta_kill.wav");
	precache_sound ("pu/maxammo.wav");
	precache_sound ("pu/nuke.wav");
	precache_sound ("pu/powerup.wav");
	precache_sound ("pu/drop.wav");
	precache_sound ("pu/pickup.wav");
	
	//OLD SOUNDS BACKUP
	/*precache_sound ("zombie/atk1.wav");
	precache_sound ("zombie/atk2.wav");
	precache_sound ("zombie/atk3.wav");
	precache_sound ("zombie/atk4.wav");
	precache_sound ("zombie/atk5.wav");
	precache_sound ("zombie/d1.wav");
	precache_sound ("zombie/d2.wav");
	precache_sound ("zombie/d3.wav");
	precache_sound ("zombie/r1.wav");
	precache_sound ("zombie/r2.wav");
	precache_sound ("zombie/w1.wav");
	precache_sound ("zombie/w2.wav");
	precache_sound ("zombie/w3.wav");
	precache_sound ("zombie/w4.wav");
	precache_sound ("zombie/w5.wav");
	precache_sound ("zombie/w6.wav");*/
	//NEW SOUNDS
	//Walk
	
	precache_sound ("zombie/w0.wav");
	precache_sound ("zombie/w1.wav");
	precache_sound ("zombie/w2.wav");
	precache_sound ("zombie/w3.wav");
	precache_sound ("zombie/w4.wav");
	precache_sound ("zombie/w5.wav");
	precache_sound ("zombie/w6.wav");
	precache_sound ("zombie/w7.wav");
	precache_sound ("zombie/w8.wav");
	precache_sound ("zombie/w9.wav");
	//Run
	precache_sound ("zombie/r0.wav");
	precache_sound ("zombie/r1.wav");
	precache_sound ("zombie/r2.wav");
	precache_sound ("zombie/r3.wav");
	precache_sound ("zombie/r4.wav");
	precache_sound ("zombie/r5.wav");
	precache_sound ("zombie/r6.wav");
	precache_sound ("zombie/r7.wav");
	precache_sound ("zombie/r8.wav");
	precache_sound ("zombie/r9.wav");
	//Attack
	precache_sound ("zombie/a0.wav");
	precache_sound ("zombie/a1.wav");
	precache_sound ("zombie/a2.wav");
	precache_sound ("zombie/a3.wav");
	precache_sound ("zombie/a4.wav");
	precache_sound ("zombie/a5.wav");
	precache_sound ("zombie/a6.wav");
	precache_sound ("zombie/a7.wav");
	//Death
	precache_sound ("zombie/d0.wav");
	precache_sound ("zombie/d1.wav");
	precache_sound ("zombie/d2.wav");
	precache_sound ("zombie/d3.wav");
	precache_sound ("zombie/d4.wav");
	precache_sound ("zombie/d5.wav");
	precache_sound ("zombie/d6.wav");
	precache_sound ("zombie/d7.wav");
	//Taunt
	precache_sound ("zombie/t0.wav");
	precache_sound ("zombie/t1.wav");
	precache_sound ("zombie/t2.wav");
	precache_sound ("zombie/t3.wav");
	precache_sound ("zombie/t4.wav");
	//Footsteps
	precache_sound ("zombie/s0.wav");
	precache_sound ("zombie/s1.wav");
	precache_sound ("zombie/sc0.wav");
	precache_sound ("zombie/sc1.wav");
	
	precache_sound ("music/end.wav");
	
	precache_sound ("null.wav");
};

void() EndFrame =
{
	RelinkZombies();
};