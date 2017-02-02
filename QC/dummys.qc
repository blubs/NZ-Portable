/*
+------+
|Dummys|
+------+-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-+
| Scratch                                      Http://www.admdev.com/scratch |
+=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-+
| This file contains remove(self); statements for entities not yet coded.    |
| This avoids Quake spewing out pages and pages of error messages when       |
| loading maps.                                                              |
+=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-+
*/

// Triggers
void() trigger_relay            = {remove(self);};
void() trigger_multiple         = {remove(self);};
void() trigger_once             = {remove(self);};
void() trigger_changelevel      = {remove(self);};
void() trigger_counter          = {remove(self);};
void() trigger_teleport         = {remove(self);};
void() trigger_secret           = {remove(self);};
void() trigger_setskill         = {remove(self);};
void() trigger_monsterjump      = {remove(self);};
void() trigger_onlyregistered   = {remove(self);};
void() trigger_push             = {remove(self);};
void() trigger_hurt             = {remove(self);};

// Player Starts
void() info_player_start        = {};
void() info_player_start2       = {};
void() info_player_deathmatch   = {};
void() info_player_coop         = {};
void() info_player_tank         = {};
void() info_player_nikolai		= {};
void() info_player_doctor		= {};
void() info_player_takeo		= {};

void() teddy_spawn = {remove(self);};
void() zapper1 = {remove(self);};
void() zapper2 = {remove(self);};
void() trigger_electro = {remove(self);};
void() item_switch = {remove(self);};
void() zap_light = {remove(self);};
void() mystery_box_tp_spot = {remove(self);};
void() info_end = {remove(self);};
void() spawn_dog = {remove(self);};

void(float which)  SetZombieHitBox;

void() change_frame;
void() change_frame2 =
{
	self.frame++;
	self.think = change_frame;
	self.nextthink = time + 1;
}
void() change_frame =
{
	self.frame++;
	self.think = change_frame2;
	self.nextthink = time + 1;
}
void() test_dummy =
{
	self.frame = 0;
	
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;

	
	setmodel(self, "progs/ai/zfull.mdl");
	
	setsize (self, '-8 -8 -32', '8 8 30');
	setorigin(self, self.origin);
	self.classname = "ai_zombie";
	self.takedamage = DAMAGE_YES;
	self.flags = self.flags | FL_PARTIALGROUND | FL_MONSTER;
	self.health = 999999;


	self.head = spawn();
	self.head.classname = "in_ai_zombie_head";
	self.head.owner = self;
	self.head.solid = SOLID_NOT;
	self.head.movetype = MOVETYPE_NONE;
	self.head.takedamage = DAMAGE_NO;
	
	self.larm = spawn();
	self.larm.classname = "in_ai_zombie_larm";
	self.larm.owner = self;
	self.larm.solid = SOLID_NOT;
	self.larm.movetype = MOVETYPE_NONE;
	self.larm.takedamage = DAMAGE_NO;
	
	self.rarm = spawn();
	self.rarm.classname = "in_ai_zombie_rarm";
	self.rarm.owner = self;
	self.rarm.solid = SOLID_NOT;
	self.rarm.movetype = MOVETYPE_NONE;
	self.rarm.takedamage = DAMAGE_NO;

	self.head.deadflag = 1;
	self.larm.deadflag = 1;
	self.rarm.deadflag = 1;
	

	setmodel(self.head, "progs/ai/zh^.mdl");
	setmodel(self.rarm, "progs/ai/zar(.mdl");
	setmodel(self.larm, "progs/ai/zal(.mdl");
	updateLimb (self, 0, self.head);
	updateLimb (self, 1, self.larm);
	updateLimb (self, 2, self.rarm);

	self.head.solid = SOLID_CORPSE;
	self.head.movetype = MOVETYPE_NONE;
	self.head.classname = "ai_zombie_head";
	self.head.takedamage = DAMAGE_YES;

	self.larm.solid = SOLID_CORPSE;
	self.larm.movetype = MOVETYPE_NONE;
	self.larm.classname = "ai_zombie_larm";
	self.larm.takedamage = DAMAGE_YES;

	self.rarm.solid = SOLID_CORPSE;
	self.rarm.movetype = MOVETYPE_NONE;
	self.rarm.classname = "ai_zombie_rarm";
	self.rarm.takedamage = DAMAGE_YES;
	
	SetZombieHitBox(1);
	
	self.think = change_frame;
	self.nextthink = time + 1;
}