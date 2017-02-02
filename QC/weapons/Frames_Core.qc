// +-----------+
// |Frames Core|
// +-----------+-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-+
// | Scratch                                   Http://www.admdev.com/scratch |
// +=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=--=-+
// | This file contains Core weapon frame functions for animations.			 |
// | 									                                     |
// +=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-+



void() ContinueRun =
{
	float startframe;
	float endframe;
	string modelname;
	startframe = GetFrame(self.weapon,SPRINT_START);
	endframe = GetFrame(self.weapon,SPRINT_END);
	if(!startframe && !endframe)
	{
		startframe = GetFrame(self.weapon,SPRINT_IN_END);
		endframe = GetFrame(self.weapon,SPRINT_IN_END);
	}
	if (!self.downed) {
		modelname = GetWeaponModel(self.weapon, 0);
	} else
		modelname = "";
	Set_W_Frame (startframe, endframe, 0, 0, SPRINT, ContinueRun, modelname, false);
}
void () W_Frame_Update =
{
	local void temp();

// note: call whenever weapon frames are called!

	if (self.anim_weapon_time > time)
		return; //don't call every frame, if it is the animations will play too fast

	
	if (self.weapon_animduration)
	{
		if (self.weapon_anim_type == RELOAD && self.perks & P_SPEED)
			self.anim_weapon_time = time + self.weapon_animduration * 0.75;
		else if (self.weapon_anim_type == FIRE && self.perks & P_DOUBLE)
			self.anim_weapon_time = time + self.weapon_animduration * 0.75;
		else
			self.anim_weapon_time = time + self.weapon_animduration;
	}
	else if (self.weapon_anim_type == RELOAD && self.perks & P_SPEED)
		self.anim_weapon_time = time + 0.075;
	else if (self.weapon_anim_type == FIRE && self.perks & P_DOUBLE)	
		self.anim_weapon_time = time + 0.075;
	else if (self.weapon_anim_type == REVIVE && self.perks & P_REVIVE)	
		self.anim_weapon_time = time + 0.05;
	else if (self.weapon_anim_type == KNIFE2)	
		self.anim_weapon_time = time + 0.05;
	else
		self.anim_weapon_time = time + 0.1;



	if (self.weaponframe < self.weaponframe_end && !self.anim_reversed)
	{   // continue an animation
		self.weaponframe = self.weaponframe + 1;
		if (self.weaponmodel == "progs/VModels/v_kar.mdl" && self.weapon == W_KAR_SCOPE)
		{
			self.weapon2model = "progs/VModels/v_karscope.mdl";
			self.weapon2frame = self.weaponframe;
			self.weapon2skin = self.weaponskin;
		}
		if (self.callfuncat)
		{
			if (self.weaponframe == self.callfuncat)
			{
				if (self.animend)
				{
					temp = self.animend;
					self.animend = SUB_Null;
					if (temp)
						temp();
				}
			}
		}
		PlayWeaponSound(self.weapon_anim_type, false);
		return;
	}
	else if (self.weaponframe > self.weaponframe_end && self.anim_reversed)
	{   // continue an animation reversed
		self.weaponframe = self.weaponframe - 1;
		if (self.weaponmodel == "progs/VModels/v_kar.mdl" && self.weapon == W_KAR_SCOPE)
		{
			self.weapon2model = "progs/VModels/v_karscope.mdl";
			self.weapon2frame = self.weaponframe;
			self.weapon2skin = self.weaponskin;
		}
		if (self.callfuncat)
		{
			if (self.weaponframe == self.callfuncat)
			{
				if (self.animend)
				{
					temp = self.animend;
					self.animend = SUB_Null;
					if (temp)
						temp();
				}
			}
		}
		PlayWeaponSound(self.weapon_anim_type, false);
		return;
	}
	else
	{
		//if (self.holding_bow && self.weapon == IT_BOW && self.button0) JUKKI Bow later
		//	Set_W_Frame (21, 24, 0, 0, FIRE, SUB_Null, self.weaponslot1.v_model, false);//FIXME
		//else
		{
			self.weapon2frame = self.weaponframe_end = self.weaponframe = GetFrame(self.weapon,BASE_FRAME);
		}
		self.new_anim_stop = false;
		self.weapon_anim_type = 0;
		self.weapon_animduration = 0;
		self.callfuncat = 0;
		temp = self.animend;
		self.animend = SUB_Null;
		if (temp)
			temp();
	}
};

void Set_W_Frame (float startframe, float endframe, float duration, float funccalledin, float animtype, void() endanimfunc, string set_model, float dontstartnew) = //FIXME
{
	self.weaponframe = startframe;
	self.weaponframe_end = endframe;
	self.animend = endanimfunc;
	self.callfuncat = funccalledin;
	self.weapon_anim_type = animtype;
	self.new_anim_stop = dontstartnew;
	if (startframe >= endframe)
		self.anim_reversed = 1;
	else
		self.anim_reversed = 0;
	if (duration)
	{
		local float math;
		if (startframe >= endframe)
			math = (startframe - endframe) + 1;
		else
			math = (endframe - startframe) + 1;
		self.weapon_animduration = (duration / math);
	}
	else
	{
		self.weapon_animduration = 0;
	}
	if (set_model)
		self.weaponmodel = set_model;
	if (set_model == "progs/VModels/v_kar.mdl" && self.weapon == W_KAR_SCOPE)
	{
		self.weapon2model = "progs/VModels/v_karscope.mdl";
		self.weapon2frame = self.weaponframe;
		self.weapon2skin = self.weaponskin;
	}
	else
	{
		self.weapon2model = "";
		self.weapon2frame = 0;
		self.weapon2skin = 0;
	}
}