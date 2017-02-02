float(float wep) GetFiretype =
{

	switch (wep)
	{
		case W_COLT:
			return 1;
			break;
		case W_KAR:
			return 1;
			break;
		case W_THOMPSON:
			return 0;
			break;
		case W_357:
			return 1;
			break;
		case W_BAR:
			return 0;
			break;
		case W_BK:
			return 1;
			break;
		case W_BROWNING:
			return 0;
			break;
		case W_DB:
			return 1;
			break;
		case W_FG:
			return 0;
			break;
		case W_GEWEHR:
			return 1;
			break;
		case W_KAR_SCOPE:
			return 1;
			break;
		case W_M1:
			return 1;
			break;
		case W_M1A1:
			return 1;
			break;
		case W_M2:
			return 3;
			break;
		case W_MP40:
			return 0;
			break;
		case W_MG:
			return 0;
			break;
		case W_PANZER:
			return 3;
			break;
		case W_PPSH:
			return 0;
			break;
		case W_PTRS:
			return 1;
			break;
		case W_RAY:
			return 3;
			break;
		case W_SAWNOFF:
			return 1;
			break;
		case W_STG:
			return 0;
			break;
		case W_TRENCH:
			return 1;
			break;
		case W_TYPE:
			return 0;
			break;
	}
	return 0;
}

#define	HEAD_X			0
#define	UPPER_TORSO_X	1
#define	LOWER_TORSO_X	2
#define	LIMBS_X			3

float(float wep, float type) GetWeapopnMultiplier =
{

	switch (wep)
	{
		case W_COLT:
			switch (type)
			{
				case HEAD_X: 		return 3;
				case UPPER_TORSO_X: return 1;
				case LOWER_TORSO_X: return 1;
				case LIMBS_X: 		return 1;
			}
			break;
		case W_KAR:
			switch (type)
			{
				case HEAD_X: 		return 3.5;
				case UPPER_TORSO_X:	return 1.8;
				case LOWER_TORSO_X:	return 1.7;
				case LIMBS_X: 		return 0.7;
			}
			break;
		case W_THOMPSON:
			switch (type)
			{
				case HEAD_X: 		return 4;
				case UPPER_TORSO_X:	return 1;
				case LOWER_TORSO_X:	return 1;
				case LIMBS_X: 		return 1;
			}
			break;
		case W_357:
			switch (type)
			{
				case HEAD_X: 		return 1.4;
				case UPPER_TORSO_X:	return 1;
				case LOWER_TORSO_X:	return 1;
				case LIMBS_X: 		return 1;
			}
			break;
		case W_BAR:
			switch (type)
			{
				case HEAD_X: 		return 2.7;
				case UPPER_TORSO_X:	return 1.8;
				case LOWER_TORSO_X:	return 1;
				case LIMBS_X: 		return 1.5;
			}
			break;
		case W_BK:
			return 1;
			break;
		case W_BROWNING:
			switch (type)
			{
				case HEAD_X: 		return 3;
				case UPPER_TORSO_X:	return 1;
				case LOWER_TORSO_X:	return 1;
				case LIMBS_X: 		return 1;
			}
			break;
		case W_DB:
			switch (type)
			{
				case HEAD_X: 		return 1;
				case UPPER_TORSO_X:	return 1;
				case LOWER_TORSO_X:	return 1;
				case LIMBS_X: 		return 1;
			}
			break;
		case W_FG:
			switch (type)
			{
				case HEAD_X: 		return 2.7;
				case UPPER_TORSO_X:	return 1;
				case LOWER_TORSO_X:	return 1;
				case LIMBS_X: 		return 1.5;
			}
			break;
		case W_GEWEHR:
			switch (type)
			{
				case HEAD_X: 		return 2.7;
				case UPPER_TORSO_X:	return 1.25;
				case LOWER_TORSO_X:	return 1;
				case LIMBS_X: 		return 0.8;
			}
			break;
		case W_KAR_SCOPE:
			switch (type)
			{
				case HEAD_X: 		return 10;
				case UPPER_TORSO_X:	return 1.5;
				case LOWER_TORSO_X:	return 1;
				case LIMBS_X: 		return 1;
			}
			break;
		case W_M1:
			switch (type)
			{
				case HEAD_X: 		return 2.7;
				case UPPER_TORSO_X:	return 1.25;
				case LOWER_TORSO_X:	return 1;
				case LIMBS_X: 		return 0.7;
			}
			break;
		case W_M1A1:
			switch (type)
			{
				case HEAD_X: 		return 2.7;
				case UPPER_TORSO_X:	return 1.25;
				case LOWER_TORSO_X:	return 1;
				case LIMBS_X: 		return 0.7;
			}
			break;
		case W_M2:
			return 3;
			break;
		case W_MP40:
			switch (type)
			{
				case HEAD_X: 		return 4;
				case UPPER_TORSO_X:	return 1;
				case LOWER_TORSO_X:	return 1;
				case LIMBS_X: 		return 1;
			}
			break;
		case W_MG:
			switch (type)
			{
				case HEAD_X: 		return 3;
				case UPPER_TORSO_X:	return 1;
				case LOWER_TORSO_X:	return 1;
				case LIMBS_X: 		return 1;
			}
			break;
		case W_PANZER:
			return 3;
			break;
		case W_PPSH:
			switch (type)
			{
				case HEAD_X: 		return 3;
				case UPPER_TORSO_X:	return 1;
				case LOWER_TORSO_X:	return 1;
				case LIMBS_X: 		return 1;
			}
			break;
		case W_PTRS:
			switch (type)
			{
				case HEAD_X: 		return 4;
				case UPPER_TORSO_X:	return 1;
				case LOWER_TORSO_X:	return 1;
				case LIMBS_X: 		return 1;
			}
			break;
		case W_RAY:
			return 3;
			break;
		case W_SAWNOFF:
			switch (type)
			{
				case HEAD_X: 		return 1;
				case UPPER_TORSO_X:	return 1;
				case LOWER_TORSO_X:	return 1;
				case LIMBS_X: 		return 1;
			}
			break;
		case W_STG:
			switch (type)
			{
				case HEAD_X: 		return 2.7;
				case UPPER_TORSO_X:	return 1;
				case LOWER_TORSO_X:	return 1;
				case LIMBS_X: 		return 0.5;
			}
			break;
		case W_TRENCH:
			switch (type)
			{
				case HEAD_X: 		return 1;
				case UPPER_TORSO_X:	return 1;
				case LOWER_TORSO_X:	return 1;
				case LIMBS_X: 		return 1;
			}
			break;
		case W_TYPE:
			switch (type)
			{
				case HEAD_X: 		return 4;
				case UPPER_TORSO_X:	return 1;
				case LOWER_TORSO_X:	return 1;
				case LIMBS_X: 		return 1;
			}
			break;
	}
	return 0;
}
float(float wep) getWeaponMag =
{

	switch (wep)
	{
		case W_COLT:
			return 8;
			break;
		case W_KAR:
			return 5;
			break;
		case W_THOMPSON:
			return 20;
			break;
		case W_357:
			return 6;
			break;
		case W_BAR:
			return 20;
			break;
		case W_BK:
			return 1;
			break;
		case W_BROWNING:
			return 125;
			break;
		case W_DB:
			return 2;
			break;
		case W_FG:
			return 32;
			break;
		case W_GEWEHR:
			return 10;
			break;
		case W_KAR_SCOPE:
			return 5;
			break;
		case W_M1:
			return 8;
			break;
		case W_M1A1:
			return 15;
			break;
		case W_MP40:
			return 32;
			break;
		case W_MG:
			return 125;
			break;
		case W_PANZER:
			return 1;
			break;
		case W_PPSH:
			return 71;
			break;
		case W_PTRS:
			return 5;
			break;
		case W_RAY:
			return 20;
			break;
		case W_SAWNOFF:
			return 2;
			break;
		case W_STG:
			return 30;
			break;
		case W_TRENCH:
			return 6;
			break;
		case W_TYPE:
			return 30;
			break;
	}
	return 0;
}
float(float wep) getWeaponAmmo =
{

	switch (wep)
	{
		case W_COLT:
			return 80;
			break;
		case W_KAR:
			return 50;
			break;
		case W_THOMPSON:
			return 200;
			break;
		case W_357:
			return 60;
			break;
		case W_BAR:
			return 140;
			break;
		case W_BK:
			return 4;
			break;
		case W_BROWNING:
			return 500;
			break;
		case W_DB:
			return 60;
			break;
		case W_FG:
			return 192;
			break;
		case W_GEWEHR:
			return 120;
			break;
		case W_KAR_SCOPE:
			return 50;
			break;
		case W_M1:
			return 128;
			break;
		case W_M1A1:
			return 120;
			break;
		case W_MP40:
			return 192;
			break;
		case W_MG:
			return 500;
			break;
		case W_PANZER:
			return 20;
			break;
		case W_PPSH:
			return 355;
			break;
		case W_PTRS:
			return 60;
			break;
		case W_RAY:
			return 160;
			break;
		case W_SAWNOFF:
			return 60;
			break;
		case W_STG:
			return 180;
			break;
		case W_TRENCH:
			return 60;
			break;
		case W_TYPE:
			return 160;
			break;
	}
	return 0;
}
float(float wep) getWeaponDamage =
{

	switch (wep)
	{
		case W_COLT:
			return 20;
			break;
		case W_KAR:
			return 100;
			break;
		case W_THOMPSON:
			return 120;
			break;
		case W_357:
			return 1000;
			break;
		case W_BAR:
			return 100;
			break;
		case W_BROWNING:
			return 130;
			break;
		case W_DB:
			return 200;
			break;
		case W_FG:
			return 100;
			break;
		case W_GEWEHR:
			return 90;
			break;
		case W_KAR_SCOPE:
			return 800;
			break;
		case W_M1:
			return 200;
			break;
		case W_M1A1:
			return 120;
			break;
		case W_MP40:
			return 100;
			break;
		case W_MG:
			return 130;
			break;
		case W_PANZER:
			return 600;
			break;
		case W_PPSH:
			return 100;
			break;
		case W_PTRS:
			return 1000;
			break;
		case W_RAY:
			return 1000;
			break;
		case W_SAWNOFF:
			return 240;
			break;
		case W_STG:
			return 180;
			break;
		case W_TRENCH:
			return 120;
			break;
		case W_TYPE:
			return 100;
			break;
	}
	return 0;
}

float(float wep) GetWeaponShotcount =
{
	switch (wep)
	{
		case W_DB:
			return 8;
		case W_SAWNOFF:
			return 8;
		case W_TRENCH:
			return 8;
		default:
			return 1;
	}
	return 0;
}

vector(float wep) GetWeaponRecoil =
{
	vector guaranteed, kick_change, final_kick;
	float change_1, change_2, change_3,total_recoil, r, temp1, temp2;
	switch (wep)
	{
		case W_COLT:
			guaranteed = '0 35 0';
			kick_change = '25 15 25';
			break;
		case W_357:
			guaranteed = '0 80 50';
			kick_change = '0 60 40';
			break;
		case W_THOMPSON:
			kick_change = '74 74 85';
			break;
		case W_MP40:
			kick_change = '104 104 119';
			break;
		case W_TYPE:
			kick_change = '74 74 85';
			break;
		case W_PPSH:
			kick_change = '44 22 44';
			break;
		case W_GEWEHR:
			kick_change = '50 60 50';
			break;
		case W_M1:
			guaranteed = '0 80 0';
			kick_change = '40 40 40';
			break;
		case W_STG:
			kick_change = '63 80 63';
			break;
		case W_M1A1:
			kick_change = '50 60 50';
			break;
		case W_KAR:
			guaranteed = '0 50 0';
			kick_change = '25 30 25';
			break;
		case W_KAR_SCOPE:
			guaranteed = '0 50 0';
			kick_change = '25 30 25';
			break;
		case W_PTRS:
			guaranteed = '0 100 85';
			kick_change = '0 95 75';
			break;
		case W_TRENCH:
			guaranteed = '0 100 85';
			kick_change = '0 95 75';
			break;
		case W_DB:
			guaranteed = '0 95 0';
			kick_change = '45 85 45';
			break;
		case W_SAWNOFF:
			guaranteed = '0 95 0';
			kick_change = '45 85 45';
			break;
		case W_BAR:
			kick_change = '112 112 112';
			break;
		case W_MG:
			kick_change = '40 30 40';
			break;
		case W_FG:
			kick_change = '45 45 45';
			break;
		case W_BROWNING:
			kick_change = '103 88 103';
			break;
	}
	total_recoil = kick_change_x + kick_change_y + kick_change_z;

	change_1 = (kick_change_x)/total_recoil;
	change_2 = (kick_change_y)/total_recoil;
	change_3 = (kick_change_z)/total_recoil;

	r = random();
	temp1 = change_1 + change_2;
	temp2 = change_1 + change_2 + change_3;
	if (r < change_1)
		final_kick_y = kick_change_x;
	else if (r < temp1)
		final_kick_x = kick_change_y*-1;
	else if (r < temp2)
		final_kick_y = kick_change_z*-1;

	final_kick_y = final_kick_y + guaranteed_x;
	final_kick_x = final_kick_x - guaranteed_y;
	final_kick_y = final_kick_y - guaranteed_z;

	final_kick_x = final_kick_x / 10;
	final_kick_y = final_kick_y / 10;
	final_kick_z = final_kick_z / 10;
	//bprint	(vtos(final_kick));
	//bprint	("\n");
	return final_kick;
}

float(float wep) getWeaponRecoilReturn =
{
	switch (wep)
	{
		case W_COLT:
			return 750;
			break;
		case W_KAR:
			return 750;
			break;
		case W_THOMPSON:
			return 1813;
			break;
		case W_357:
			return 1500;
			break;
		case W_BAR:
			return 2823;
			break;
		case W_BROWNING:
			return 2510;
			break;
		case W_DB:
			return 1000;
			break;
		case W_FG:
			return 1129;
			break;
		case W_GEWEHR:
			return 1500;
			break;
		case W_KAR_SCOPE:
			return 750;
			break;
		case W_M1:
			return 1500;
			break;
		case W_M1A1:
			return 1500;
			break;
		case W_MP40:
			return 2538;
			break;
		case W_MG:
			return 1778;
			break;
		case W_PANZER:
			return 0;
			break;
		case W_PPSH:
			return 1255;
			break;
		case W_PTRS:
			return 1500;
			break;
		case W_RAY:
			return 0;
			break;
		case W_SAWNOFF:
			return 1000;
			break;
		case W_STG:
			return 2400;
			break;
		case W_TRENCH:
			return 500;
			break;
		case W_TYPE:
			return 1813;
			break;
	}
	return 0;
}

float(float wep, float penetration_times) getWeaponPenetration =
{
	if (!penetration_times)
		return 2;
	switch (wep)
	{
		case W_COLT:
			if (penetration_times >= 2)
				return 0;
			return 0.75;
		case W_KAR:
			if (penetration_times >= 3)
				return 0;
			return 1;
		case W_THOMPSON:
			if (penetration_times >= 2)
				return 0;
			return 0.8;
		case W_357:
			if (penetration_times >= 3)
				return 0;
			return 1;
		case W_BAR:
			if (penetration_times >= 3)
				return 0;
			return 1;
		case W_BROWNING:
			if (penetration_times >= 3)
				return 0;
			return 1;
		case W_DB:
			if (penetration_times >= 1)
				return 0;
			return 0.5;
		case W_FG:
			if (penetration_times >= 2)
				return 0;
			return 0.9;
		case W_GEWEHR:
			if (penetration_times >= 2)
				return 0;
			return 0.9;
		case W_KAR_SCOPE:
			if (penetration_times >= 3)
				return 0;
			return 1;
		case W_M1:
			if (penetration_times >= 2)
				return 0;
			return 0.9;
		case W_M1A1:
			if (penetration_times >= 2)
				return 0;
			return 0.9;
		case W_MP40:
			if (penetration_times >= 2)
				return 0;
			return 0.8;
		case W_MG:
			if (penetration_times >= 3)
				return 0;
			return 1;
		case W_PPSH:
			if (penetration_times >= 2)
				return 0;
			return 0.75;
		case W_PTRS:
			if (penetration_times >= 5)
				return 0;
			return 1;
		case W_SAWNOFF:
			if (penetration_times >= 1)
				return 0;
			return 0.4;
		case W_STG:
			if (penetration_times >= 2)
				return 0;
			return 0.8;
		case W_TRENCH:
			if (penetration_times >= 1)
				return 0;
			return 0.7;
		case W_TYPE:
			if (penetration_times >= 2)
				return 0;
			return 0.8;
	}
	return 0;
}

float(float wep) GetWeaponMaxSpread =
{
	switch (wep)
	{
		case W_COLT:
			return 15;
			break;
		case W_KAR:
			return 37.5;
			break;
		case W_THOMPSON:
			return 12.5;
			break;
		case W_357:
			return 10;
			break;
		case W_BAR:
			return 17.5;
			break;
		case W_BROWNING:
			return 25;
			break;
		case W_DB:
			return 12.5;
			break;
		case W_FG:
			return 20;
			break;
		case W_GEWEHR:
			return 17.5;
			break;
		case W_KAR_SCOPE:
			return 37.5;
			break;
		case W_M1:
			return 17.5;
			break;
		case W_M1A1:
			return 17.5;
			break;
		case W_MP40:
			return 12.5;
			break;
		case W_MG:
			return 25;
			break;
		case W_PANZER:
			return 0;
			break;
		case W_PPSH:
			return 12.5;
			break;
		case W_PTRS:
			return 37.5;
			break;
		case W_RAY:
			return 10;
			break;
		case W_SAWNOFF:
			return 15;
			break;
		case W_STG:
			return 17.5;
			break;
		case W_TRENCH:
			return 12.5;
			break;
		case W_TYPE:
			return 12.5;
			break;
	}
	return 0;
}

float(float wep) GetWeaponSpread =
{
	float Weapon_Spread, Total_Spread;
	switch (wep)
	{
		case W_COLT:
			Weapon_Spread = 7.5;
			break;
		case W_KAR:
			Weapon_Spread = 25;
			break;
		case W_THOMPSON:
			Weapon_Spread = 5;
			break;
		case W_RAY:
			Weapon_Spread = 5;
			break;
		case W_KAR_SCOPE:
			Weapon_Spread = 25;
			break;
		case W_BAR:
			Weapon_Spread = 5;
			break;
		case W_M1A1:
			Weapon_Spread = 5;
			break;
		case W_M2:
			Weapon_Spread = 0;
			break;
		case W_TYPE:
			Weapon_Spread = 5;
			break;
		case W_SAWNOFF:
			Weapon_Spread = 15;
			break;
		case W_PPSH:
			Weapon_Spread = 5;
			break;
		case W_DB:
			Weapon_Spread = 12.5;
			break;
		case W_FG:
			Weapon_Spread = 5;
			break;
		case W_TRENCH:
			Weapon_Spread = 12.5;
			break;
		case W_MG:
			Weapon_Spread = 10;
			break;
		case W_GEWEHR:
			Weapon_Spread = 5;
			break;
		case W_BROWNING:
			Weapon_Spread = 10;
			break;
		case W_357:
			Weapon_Spread = 5;
			break;
		case W_M1:
			Weapon_Spread = 5;
			break;
		case W_MP40:
			Weapon_Spread = 5;
			break;
		case W_PTRS:
			Weapon_Spread = 15;
			break;
		case W_STG:
			Weapon_Spread = 5;
			break;
	}
	
	if (self.recoil_delay > time) // no need to calculate the current spread
		return GetWeaponMaxSpread(wep);

	Total_Spread = Weapon_Spread + self.cur_spread;
	return Total_Spread;
}//600,08
float(float wep, float delaytype) getWeaponDelay =
{

	switch (wep)
	{
		case W_COLT:
			if (delaytype == RELOAD)
				return 2.5;
			else if (delaytype == FIRE)
				return 0.075;
			break;
		case W_KAR:
			if (delaytype == RELOAD)
				return 1.6;
			else if (delaytype == FIRE)
				return 0.3;
		case W_THOMPSON:
			if (delaytype == RELOAD)
				return 2.4;
			else if (delaytype == FIRE)
				return 0.08;
			break;
		case W_357:
			if (delaytype == RELOAD)
				return 2.2;
			else if (delaytype == FIRE)
				return 0.32;
			break;
		case W_BAR:
			if (delaytype == RELOAD)
				return 3.5;
			else if (delaytype == FIRE)
				return 0.16;
			break;
		case W_BK:
			if (delaytype == RELOAD)
				return 2.2;
			else if (delaytype == FIRE)
				return 0.705;
			break;
		case W_BROWNING:
			if (delaytype == RELOAD)
				return 3.3;
			else if (delaytype == FIRE)
				return 0.096;
			break;
		case W_DB:
			if (delaytype == RELOAD)
				return 2.8;
			else if (delaytype == FIRE)
				return 0.283;
			break;
		case W_FG:
			if (delaytype == RELOAD)
				return 3.3;
			else if (delaytype == FIRE)
				return 0.064;
			break;
		case W_GEWEHR:
			if (delaytype == RELOAD)
				return 3.5;
			else if (delaytype == FIRE)
				return 0.125;
			break;
		case W_KAR_SCOPE:
			if (delaytype == RELOAD)
				return 2.7;
			else if (delaytype == FIRE)
				return 0.3;
			break;
		case W_M1:
			if (delaytype == RELOAD)
				return 3.8;
			else if (delaytype == FIRE)
				return 0.135;
			break;
		case W_M1A1:
			if (delaytype == RELOAD)
				return 2.8;
			else if (delaytype == FIRE)
				return 0.135;
			break;
		case W_M2:
			if (delaytype == RELOAD)
				return 2.7;
			else if (delaytype == FIRE)
				return 0,2;
			break;
		case W_MP40:
			if (delaytype == RELOAD)
				return 2.2;
			else if (delaytype == FIRE)
				return 0.112;
			break;
		case W_MG:
			if (delaytype == RELOAD)
				return 3.6;
			else if (delaytype == FIRE)
				return 0.01;
			break;
		case W_PANZER:
			if (delaytype == RELOAD)
				return 1.55;
			else if (delaytype == FIRE)
				return 0.331;
			break;
		case W_PPSH:
			if (delaytype == RELOAD)
				return 3.3;
			else if (delaytype == FIRE)
				return 0.048;
			break;
		case W_PTRS:
			if (delaytype == RELOAD)
				return 2.8;
			else if (delaytype == FIRE)
				return 0.8;
			break;
		case W_RAY:
			if (delaytype == RELOAD)
				return 3.1;
			else if (delaytype == FIRE)
				return 0.331;
			break;
		case W_SAWNOFF:
			if (delaytype == RELOAD)
				return 2.8;
			else if (delaytype == FIRE)
				return 0.283;
			break;
		case W_STG:
			if (delaytype == RELOAD)
				return 3.3;
			else if (delaytype == FIRE)
				return 0.102;
			break;
		case W_TRENCH:
			if (delaytype == RELOAD)
				return 2.2;
			else if (delaytype == FIRE)
				return 0.283;
			break;
		case W_TYPE:
			if (delaytype == RELOAD)
				return 2.3;
			else if (delaytype == FIRE)
				return 0.08;
			break;
	}
	return 0;
}

float(float wep, float frametype) GetFrame =
{
	if (frametype == BASE_FRAME)
	{
		if (self.zoom == 3)
			frametype = SPRINT_IN_END;
		else
			return 0;
	}
	switch (wep)
	{
		case W_COLT:
			switch (frametype)
			{
				case FIRE_START:
					return 1;
				case FIRE_END:
					return 2;
				case RELOAD_START:
					return 3;
				case RELOAD_END:
					return 26;
				case SPRINT_IN_START:
					return 33;
				case SPRINT_IN_END:
					return 34;
				case SPRINT_START:
					return 35;
				case SPRINT_END:
					return 40;
				case SPRINT_OUT_START:
					return 41;
				case SPRINT_OUT_END:
					return 42;
				case TAKE_OUT_START:
					return 29;
				case TAKE_OUT_END:
					return 32;
				case PUT_OUT_START:
					return 26;
				case PUT_OUT_END:
					return 29;
				case RELOAD_CANCEL:
					return 13;
			}
			break;
		case W_THOMPSON:
			switch (frametype)
			{
				case FIRE_START:
					return 1;
				case FIRE_END:
					return 2;
				case RELOAD_START:
					return 3;
				case RELOAD_END:
					return 25;
				case SPRINT_IN_START:
					return 26;
				case SPRINT_IN_END:
					return 27;
				case SPRINT_OUT_START:
					return 28;
				case SPRINT_OUT_END:
					return 29;
				case TAKE_OUT_START:
					return 32;
				case TAKE_OUT_END:
					return 35;
				case PUT_OUT_START:
					return 29;
				case PUT_OUT_END:
					return 32;
				case RELOAD_CANCEL:
					return 15;
			}
			break;

		case W_357:
			switch (frametype)
			{
				case FIRE_START:
					return 1;
				case FIRE_END:
					return 3;
				case RELOAD_START:
					return 4;
				case RELOAD_END:
					return 25;
				case SPRINT_IN_START:
					return 32;
				case SPRINT_IN_END:
					return 33;
				case SPRINT_START:
					return 35;
				case SPRINT_END:
					return 40;
				case SPRINT_OUT_START:
					return 41;
				case SPRINT_OUT_END:
					return 42;
				case TAKE_OUT_START:
					return 29;
				case TAKE_OUT_END:
					return 31;
				case PUT_OUT_START:
					return 26;
				case PUT_OUT_END:
					return 28;
				case RELOAD_CANCEL:
					return 14;
			}
			break;
		case W_BAR:
			switch (frametype)
			{
				case FIRE_START:
					return 1;
				case FIRE_END:
					return 2;
				case RELOAD_START:
					return 3;
				case RELOAD_END:
					return 36;
				case SPRINT_IN_START:
					return 37;
				case SPRINT_IN_END:
					return 38;
				case SPRINT_OUT_START:
					return 38;
				case SPRINT_OUT_END:
					return 37;
				case TAKE_OUT_START:
					return 41;
				case TAKE_OUT_END:
					return 39;
				case PUT_OUT_START:
					return 39;
				case PUT_OUT_END:
					return 41;
				case RELOAD_CANCEL:
					return 21;
			}
			break;
		case W_BK:
			switch (frametype)
			{
				case FIRE_START:
					return 25;
				case FIRE_END:
					return 30;
				case RELOAD_START:
					return 3;
				case RELOAD_END:
					return 28;
				case SPRINT_IN_START:
					return 35;
				case SPRINT_IN_END:
					return 37;
				case SPRINT_OUT_START:
					return 38;
				case SPRINT_OUT_END:
					return 40;
				case TAKE_OUT_START:
					return 44;
				case TAKE_OUT_END:
					return 46;
				case PUT_OUT_START:
					return 41;
				case PUT_OUT_END:
					return 43;
				case RELOAD_CANCEL:
					return 16;
			}
			break;
		case W_BROWNING:
			switch (frametype)
			{
				case FIRE_START:
					return 1;
				case FIRE_END:
					return 3;
				case RELOAD_START:
					return 4;
				case RELOAD_END:
					return 37;
				case SPRINT_IN_START:
					return 35;
				case SPRINT_IN_END:
					return 37;
				case SPRINT_OUT_START:
					return 38;
				case SPRINT_OUT_END:
					return 40;
				case TAKE_OUT_START:
					return 44;
				case TAKE_OUT_END:
					return 46;
				case PUT_OUT_START:
					return 41;
				case PUT_OUT_END:
					return 43;
				case RELOAD_CANCEL:
					return 16;
			}
			break;
		case W_DB:
			switch (frametype)
			{
				case FIRE_START:
					return 1;
				case FIRE_END:
					return 4;
				case RELOAD_START:
					return 5;
				case RELOAD_END:
					return 31;
				case SPRINT_IN_START:
					return 32;
				case SPRINT_IN_END:
					return 33;
				case SPRINT_OUT_START:
					return 33;
				case SPRINT_OUT_END:
					return 31;
				case TAKE_OUT_START:
					return 38;
				case TAKE_OUT_END:
					return 41;
				case PUT_OUT_START:
					return 35;
				case PUT_OUT_END:
					return 37;
				case RELOAD_CANCEL:
					return 22;
			}
			break;
		case W_FG:
			switch (frametype)
			{
				case FIRE_START:
					return 1;
				case FIRE_END:
					return 3;
				case RELOAD_START:
					return 41;
				case RELOAD_END:
					return 89;
				case SPRINT_IN_START:
					return 35;
				case SPRINT_IN_END:
					return 37;
				case SPRINT_OUT_START:
					return 38;
				case SPRINT_OUT_END:
					return 40;
				case TAKE_OUT_START:
					return 44;
				case TAKE_OUT_END:
					return 46;
				case PUT_OUT_START:
					return 41;
				case PUT_OUT_END:
					return 43;
				case RELOAD_CANCEL:
					return 16;
			}
			break;
		case W_GEWEHR:
			switch (frametype)
			{
				case FIRE_START:
					return 1;
				case FIRE_END:
					return 2;
				case RELOAD_START:
					return 3;
				case RELOAD_END:
					return 38;
				case SPRINT_IN_START:
					return 35;
				case SPRINT_IN_END:
					return 37;
				case SPRINT_OUT_START:
					return 38;
				case SPRINT_OUT_END:
					return 40;
				case TAKE_OUT_START:
					return 44;
				case TAKE_OUT_END:
					return 46;
				case PUT_OUT_START:
					return 41;
				case PUT_OUT_END:
					return 43;
				case RELOAD_CANCEL:
					return 16;
			}
			break;
		case W_KAR:
			switch (frametype)
			{
				case FIRE_START:
					return 1;
				case FIRE_END:
					return 3;
				case RELOAD_START:
					return 14;
				case RELOAD_END:
					return 28;
				case SPRINT_IN_START:
					return 29;
				case SPRINT_IN_END:
					return 30;
				case SPRINT_OUT_START:
					return 30;
				case SPRINT_OUT_END:
					return 29;
				case TAKE_OUT_START:
					return 33;
				case TAKE_OUT_END:
					return 35;
				case PUT_OUT_START:
					return 32;
				case PUT_OUT_END:
					return 33;
				case RELOAD_CANCEL:
					return 21;
			}	
			break;
		case W_KAR_SCOPE:
			switch (frametype)
			{
				case FIRE_START:
					return 1;
				case FIRE_END:
					return 3;
				case SPRINT_IN_START:
					return 36;
				case SPRINT_IN_END:
					return 37;
				case SPRINT_OUT_START:
					return 37;
				case SPRINT_OUT_END:
					return 36;
				case TAKE_OUT_START:
					return 33;
				case TAKE_OUT_END:
					return 35;
				case PUT_OUT_START:
					return 32;
				case PUT_OUT_END:
					return 33;
				case RELOAD_CANCEL:
					return 21;
			}
			break;
		case W_M1:
			switch (frametype)
			{
				case FIRE_START:
					return 1;
				case FIRE_END:
					return 3;
				case RELOAD_START:
					return 8;
				case RELOAD_END:
					return 44;
				case SPRINT_IN_START:
					return 35;
				case SPRINT_IN_END:
					return 37;
				case SPRINT_OUT_START:
					return 38;
				case SPRINT_OUT_END:
					return 40;
				case TAKE_OUT_START:
					return 44;
				case TAKE_OUT_END:
					return 46;
				case PUT_OUT_START:
					return 41;
				case PUT_OUT_END:
					return 43;
				case RELOAD_CANCEL:
					return 16;
			}
			break;
		case W_M1A1:
			switch (frametype)
			{
				case FIRE_START:
					return 1;
				case FIRE_END:
					return 2;
				case RELOAD_START:
					return 3;
				case RELOAD_END:
					return 29;
				case SPRINT_IN_START:
					return 37;
				case SPRINT_IN_END:
					return 38;
				case SPRINT_OUT_START:
					return 38;
				case SPRINT_OUT_END:
					return 37;
				case TAKE_OUT_START:
					return 33;
				case TAKE_OUT_END:
					return 36;
				case PUT_OUT_START:
					return 30;
				case PUT_OUT_END:
					return 33;
				case RELOAD_CANCEL:
					return 17;
			}
			break;
		case W_M2:
			switch (frametype)
			{
				case FIRE_START:
					return 0;
				case FIRE_END:
					return 0;
				case SPRINT_IN_START:
					return 35;
				case SPRINT_IN_END:
					return 37;
				case SPRINT_OUT_START:
					return 38;
				case SPRINT_OUT_END:
					return 40;
				case TAKE_OUT_START:
					return 44;
				case TAKE_OUT_END:
					return 46;
				case PUT_OUT_START:
					return 41;
				case PUT_OUT_END:
					return 43;
				case RELOAD_CANCEL:
					return 16;
			}
			break;
		case W_MP40:
			switch (frametype)
			{
				case FIRE_START:
					return 1;
				case FIRE_END:
					return 2;
				case RELOAD_START:
					return 3;
				case RELOAD_END:
					return 21;
				case SPRINT_IN_START:
					return 35;
				case SPRINT_IN_END:
					return 37;
				case SPRINT_OUT_START:
					return 38;
				case SPRINT_OUT_END:
					return 40;
				case TAKE_OUT_START:
					return 44;
				case TAKE_OUT_END:
					return 46;
				case PUT_OUT_START:
					return 41;
				case PUT_OUT_END:
					return 43;
				case RELOAD_CANCEL:
					return 16;
			}
			break;
		case W_MG:
			switch (frametype)
			{
				case FIRE_START:
					return 1;
				case FIRE_END:
					return 2;
				case RELOAD_START:
					return 3;
				case RELOAD_END:
					return 38;
				case SPRINT_IN_START:
					return 39;
				case SPRINT_IN_END:
					return 40;
				case SPRINT_OUT_START:
					return 40;
				case SPRINT_OUT_END:
					return 38;
				case TAKE_OUT_START:
					return 43;
				case TAKE_OUT_END:
					return 47;
				case PUT_OUT_START:
					return 42;
				case PUT_OUT_END:
					return 43;
				case RELOAD_CANCEL:
					return 21;
			}
			break;
		case W_PANZER:
			switch (frametype)
			{
				case FIRE_START:
					return 1;
				case FIRE_END:
					return 6;
				case RELOAD_START:
					return 7;
				case RELOAD_END:
					return 28;
				case SPRINT_IN_START:
					return 35;
				case SPRINT_IN_END:
					return 37;
				case SPRINT_OUT_START:
					return 38;
				case SPRINT_OUT_END:
					return 40;
				case TAKE_OUT_START:
					return 44;
				case TAKE_OUT_END:
					return 46;
				case PUT_OUT_START:
					return 41;
				case PUT_OUT_END:
					return 43;
				case RELOAD_CANCEL:
					return 16;
			}
			break;
		case W_PPSH:
			switch (frametype)
			{
				case FIRE_START:
					return 1;
				case FIRE_END:
					return 3;
				case RELOAD_START:
					return 4;
				case RELOAD_END:
					return 34;
				case SPRINT_IN_START:
					return 35;
				case SPRINT_IN_END:
					return 37;
				case SPRINT_OUT_START:
					return 38;
				case SPRINT_OUT_END:
					return 40;
				case TAKE_OUT_START:
					return 44;
				case TAKE_OUT_END:
					return 46;
				case PUT_OUT_START:
					return 41;
				case PUT_OUT_END:
					return 43;
				case RELOAD_CANCEL:
					return 16;
			}
			break;
		case W_PTRS:
			switch (frametype)
			{
				case FIRE_START:
					return 1;
				case FIRE_END:
					return 4;
				case RELOAD_START:
					return 5;
				case RELOAD_END:
					return 32;
				case SPRINT_IN_START:
					return 35;
				case SPRINT_IN_END:
					return 37;
				case SPRINT_OUT_START:
					return 38;
				case SPRINT_OUT_END:
					return 40;
				case TAKE_OUT_START:
					return 44;
				case TAKE_OUT_END:
					return 46;
				case PUT_OUT_START:
					return 41;
				case PUT_OUT_END:
					return 43;
				case RELOAD_CANCEL:
					return 16;
			}
			break;
		case W_RAY:
			switch (frametype)
			{
				case FIRE_START:
					return 1;
				case FIRE_END:
					return 3;
				case RELOAD_START:
					return 4;
				case RELOAD_END:
					return 30;
				case SPRINT_IN_START:
					return 35;
				case SPRINT_IN_END:
					return 37;
				case SPRINT_OUT_START:
					return 38;
				case SPRINT_OUT_END:
					return 40;
				case TAKE_OUT_START:
					return 44;
				case TAKE_OUT_END:
					return 46;
				case PUT_OUT_START:
					return 41;
				case PUT_OUT_END:
					return 43;
				case RELOAD_CANCEL:
					return 16;
			}
			break;
		case W_SAWNOFF:
			switch (frametype)
			{
				case FIRE_START:
					return 1;
				case FIRE_END:
					return 4;
				case RELOAD_START:
					return 5;
				case RELOAD_END:
					return 31;
				case SPRINT_IN_START:
					return 32;
				case SPRINT_IN_END:
					return 33;
				case SPRINT_OUT_START:
					return 33;
				case SPRINT_OUT_END:
					return 31;
				case TAKE_OUT_START:
					return 38;
				case TAKE_OUT_END:
					return 41;
				case PUT_OUT_START:
					return 35;
				case PUT_OUT_END:
					return 37;
				case RELOAD_CANCEL:
					return 22;
			}
			break;
		case W_STG:
			switch (frametype)
			{
				case FIRE_START:
					return 1;
				case FIRE_END:
					return 2;
				case RELOAD_START:
					return 3;
				case RELOAD_END:
					return 24;
				case SPRINT_IN_START:
					return 35;
				case SPRINT_IN_END:
					return 37;
				case SPRINT_OUT_START:
					return 38;
				case SPRINT_OUT_END:
					return 40;
				case TAKE_OUT_START:
					return 44;
				case TAKE_OUT_END:
					return 46;
				case PUT_OUT_START:
					return 41;
				case PUT_OUT_END:
					return 43;
				case RELOAD_CANCEL:
					return 16;
			}
			break;
		case W_TRENCH:
			switch (frametype)
			{
				case FIRE_START:
					return 1;
				case FIRE_END:
					return 3;
				case SPRINT_IN_START:
					return 27;
				case SPRINT_IN_END:
					return 28;
				case SPRINT_OUT_START:
					return 27;
				case SPRINT_OUT_END:
					return 26;
				case TAKE_OUT_START:
					return 32;
				case TAKE_OUT_END:
					return 36;
				case PUT_OUT_START:
					return 30;
				case PUT_OUT_END:
					return 32;
				case RELOAD_CANCEL:
					return 20;
			}
			break;
		case W_TYPE:
			switch (frametype)
			{
				case FIRE_START:
					return 0;
				case FIRE_END:
					return 1;
				case RELOAD_START:
					return 2;
				case RELOAD_END:
					return 24;
				case SPRINT_IN_START:
					return 35;
				case SPRINT_IN_END:
					return 37;
				case SPRINT_OUT_START:
					return 38;
				case SPRINT_OUT_END:
					return 40;
				case TAKE_OUT_START:
					return 44;
				case TAKE_OUT_END:
					return 46;
				case PUT_OUT_START:
					return 41;
				case PUT_OUT_END:
					return 43;
				case RELOAD_CANCEL:
					return 16;
			}
			break;
	}
	return 0;
}
string(float wep, float gorvmodel) GetWeaponModel =
{

	switch (wep)
	{
		case W_COLT:
			if (gorvmodel)
				return ("progs/GModels/g_colt.mdl");
			else
			{
				return ("progs/VModels/v_Colt.mdl");
				//return ("progs/md2/v_colt.md2");
			}
			break;
		case W_KAR:
			if (gorvmodel)
				return ("progs/GModels/g_kar.mdl");
			else
				return ("progs/VModels/v_kar.mdl");
			break;
		case W_THOMPSON:
			if (gorvmodel)
				return ("progs/GModels/g_thomp.mdl");
			else
				return ("progs/VModels/v_thomp.mdl");
			break;
		case W_357:
			if (gorvmodel)
				return ("progs/GModels/g_357.mdl");
			else
				return ("progs/VModels/v_357.mdl");
			break;
		case W_BAR:
			if (gorvmodel)
				return ("progs/GModels/g_bar.mdl");
			else
				return ("progs/VModels/v_bar.mdl");
			break;
		case W_BK:
			if (gorvmodel)
				return ("progs/GModels/g_bk.mdl");
			else
				return ("progs/VModels/v_bk.mdl");
			break;
		case W_BROWNING:
			if (gorvmodel)
				return ("progs/GModels/g_browning.mdl");
			else
				return ("progs/VModels/v_browning.mdl");
			break;
		case W_DB:
			if (gorvmodel)
				return ("progs/GModels/g_db.mdl");
			else
				return ("progs/VModels/v_db.mdl");
			break;
		case W_FG:
			if (gorvmodel)
				return ("progs/GModels/g_fg.mdl");
			else
				return ("progs/VModels/v_fg.mdl");
			break;
		case W_GEWEHR:
			if (gorvmodel)
				return ("progs/GModels/g_gewehr.mdl");
			else
				return ("progs/VModels/v_gewehr.mdl");
			break;
		case W_KAR_SCOPE:
			if (gorvmodel)
				return ("progs/GModels/g_kars.mdl");
			else
				return ("progs/VModels/v_kar.mdl");
			break;
		case W_M1:
			if (gorvmodel)
				return ("progs/GModels/g_m1.mdl");
			else
				return ("progs/VModels/v_m1.mdl");
			break;
		case W_M1A1:
			if (gorvmodel)
				return ("progs/GModels/g_m1a1.mdl");
			else
				return ("progs/VModels/v_m1a1.mdl");
			break;
		case W_M2:
			if (gorvmodel)
				return ("progs/GModels/g_m2flame.mdl");
			else
				return ("progs/VModels/v_m2flame.mdl");
			break;
		case W_MP40:
			if (gorvmodel)
				return ("progs/GModels/g_mp40.mdl");
			else
				return ("progs/VModels/v_mp40.mdl");
			break;
		case W_MG:
			if (gorvmodel)
				return ("progs/GModels/g_mg.mdl");
			else
				return ("progs/VModels/v_mg.mdl");
			break;
		case W_PANZER:
			if (gorvmodel)
				return ("progs/GModels/g_panzer.mdl");
			else
				return ("progs/VModels/v_panzer.mdl");
			break;
		case W_PPSH:
			if (gorvmodel)
				return ("progs/GModels/g_ppsh.mdl");
			else
				return ("progs/VModels/v_ppsh.mdl");
			break;
		case W_PTRS:
			if (gorvmodel)
				return ("progs/GModels/g_ptrs.mdl");
			else
				return ("progs/VModels/v_ptrs.mdl");
			break;
		case W_RAY:
			if (gorvmodel)
				return ("progs/GModels/g_ray.mdl");
			else
				return ("progs/VModels/v_ray.mdl");
			break;
		case W_SAWNOFF:
			if (gorvmodel)
				return ("progs/GModels/g_sawnoff.mdl");
			else
				return ("progs/VModels/v_sawnoff.mdl");
			break;
		case W_STG:
			if (gorvmodel)
				return ("progs/GModels/g_stg.mdl");
			else
				return ("progs/VModels/v_stg.mdl");
			break;
		case W_TRENCH:
			if (gorvmodel)
				return ("progs/GModels/g_trench.mdl");
			else
				return ("progs/VModels/v_trench.mdl");
				//return ("progs/VModels/MD2_v_trench.md2");
			break;
		case W_TYPE:
			if (gorvmodel)
				return ("progs/GModels/g_type.mdl");
			else
				return ("progs/VModels/v_type.mdl");
			break;
		case W_BOWIE:
			if (gorvmodel)
				return ("progs/GModels/g_bowie.mdl");
			else
				return ("progs/VModels/v_bowie.mdl");
			break;
		case W_GRENADE:
			if (gorvmodel)
				return ("progs/GModels/g_grenade.mdl");
			else
				return ("progs/VModels/v_nade.mdl");
			break;
		case W_BETTY:
			if (gorvmodel)
				return ("progs/GModels/g_betty.mdl");
			else
				return ("progs/VModels/v_betty.mdl");
			break;
	}
	//I say calling an objError is a bit too harsh...
	//string s;
	//s = ftos((wep));
	//s = strcat("Uknown weapon id ", s);
	//objerror(s);
	//return "";
	//...instead, let's just alert to the error, but return colt model as default, or do we want to make it harsh to force fix it?
	//either way, for development purposes: COLT IT IS
	bprint("Uknown weapon id ");
	bprint(ftos(wep));
	bprint("\n");
	return GetWeaponModel(W_COLT,gorvmodel);
}

string(float wep) GetWeaponSound =
{

	switch (wep)
	{
		case W_COLT:
			return "weapons/colt/shoot.wav";
			break;
		case W_KAR:
			return "weapons/kar/shoot.wav";
			break;
		case W_THOMPSON:
			return "weapons/tommy/shoot.wav";
			break;
		case W_357:
			return "weapons/357/shoot.wav";
			break;
		case W_BAR:
			return "weapons/bar/shoot.wav";
			break;
		/*case W_BK:
			return "weapons/357/shoot.wav";
			break;*/
		case W_BROWNING:
			return "weapons/browning/shoot.wav";
			break;
		case W_DB:
			return "weapons/shotgun/shoot.wav";
			break;
		case W_FG:
			return "weapons/fg42/shoot.wav";
			break;
		case W_GEWEHR:
			return "weapons/gewehr/shoot.wav";
			break;
		case W_KAR_SCOPE:
			return "weapons/kar/shoot.wav";
			break;
		case W_M1:
			return "weapons/m1garand/shoot.wav";
			break;
		case W_M1A1:
			return "weapons/m1carbine/shoot.wav";
			break;
		case W_M2:
			return "weapons/flamethrower.wav";
			break;
		case W_MP40:
			return "weapons/mp40/shoot.wav";
			break;
		case W_MG:
			return "weapons/mg42/shoot.wav";
			break;
		case W_PANZER:
			return "weapons/panzer/shoot.wav";
			break;
		case W_PPSH:
			return "weapons/ppsh/shoot.wav";
			break;
		case W_PTRS:
			return "weapons/ptrs/shoot.wav";
			break;
		case W_RAY:
			return "weapons/raygun/shoot.wav";
			break;
		case W_SAWNOFF:
			return "weapons/shotgun/shoot.wav";
			break;
		case W_STG:
			return "weapons/stg/shoot.wav";
			break;
		case W_TRENCH:
			return "weapons/shotgun/shoot.wav";
			break;
		case W_TYPE:
			return "weapons/type100/shoot.wav";
			break;
	}
	return "";
}
void() LungeKnifeHit;
void (float anim_style, float dualwep)	PlayWeaponSound =
{
	float curweaponframe;
	//if (dualwep)
	//	curweaponframe = self.weaponframe2;
	//else
		curweaponframe = self.weaponframe;
	/*dprint ("Weapon 1: ");
	dprint (ftos(self.weaponframe));
	dprint (" Weapon 2: ");
	dprint (ftos(self.weaponframe2));
	dprint (" Weapon cur: ");
	dprint (ftos(curweaponframe));
	dprint ("\n");*/
	if(anim_style == KNIFE)
	{
		if(curweaponframe == 6)
		{
			self.punchangle_x = -2;
			self.punchangle_y = -5;	
		}
		else if(curweaponframe == 7)
		{
			self.punchangle_x = 5;
			self.punchangle_y = 10;
		}
		else if(curweaponframe == 9 || curweaponframe == 2)
		{
			LungeKnifeHit();
		}
	}
	if (anim_style == FIRE)
	{
		if (self.weapon == W_KAR/* || self.weapon == W_ARMAGEDDON*/)
		{
			if (curweaponframe == 6)
				sound (self ,5, "weapons/kar/boltup.wav", 1, ATTN_NORM);
			else if (curweaponframe == 7)
				sound (self ,5, "weapons/kar/boltback.wav", 1, ATTN_NORM);
			else if (curweaponframe == 9)
				sound (self ,5, "weapons/kar/boltforward.wav", 1, ATTN_NORM);
			else if (curweaponframe == 10)
				sound (self ,5, "weapons/kar/boltdown.wav", 1, ATTN_NORM);
		}
		else if (self.weapon == W_KAR_SCOPE)
		{
			if (curweaponframe == 6)
				sound (self ,5, "weapons/kar/boltup.wav", 1, ATTN_NORM);
			else if (curweaponframe == 7)
				sound (self ,5, "weapons/kar/boltback.wav", 1, ATTN_NORM);
			else if (curweaponframe == 9)
				sound (self ,5, "weapons/kar/boltforward.wav", 1, ATTN_NORM);
			else if (curweaponframe == 10)
				sound (self ,5, "weapons/kar/boltdown.wav", 1, ATTN_NORM);
		}
		else if (self.weapon == W_TRENCH)
		{
			if (curweaponframe == 7)
				sound (self ,5, "weapons/shotgun/pump.wav", 1, ATTN_NORM);
		}
	}if (anim_style != RELOAD)
		return;

	if (self.weapon == W_COLT)
	{
		if (curweaponframe == 5)
			sound (self ,5, "weapons/colt/magout.wav", 1, ATTN_NORM);
		else if (curweaponframe == 12)
			sound (self ,5, "weapons/colt/magin.wav", 1, ATTN_NORM);
		else if(curweaponframe == 18)
			sound (self ,5, "weapons/colt/slide.wav", 1, ATTN_NORM);
	}
	else if (self.weapon == W_THOMPSON/* || self.weapon == W_GIBS*/)
	{
		if (curweaponframe == 6)
			sound (self ,5, "weapons/tommy/magout.wav", 1, ATTN_NORM);
		else if (curweaponframe == 12)
			sound (self ,5, "weapons/tommy/magin.wav", 1, ATTN_NORM);
		else if (curweaponframe == 19)
			sound (self ,5, "weapons/tommy/boltback.wav", 1, ATTN_NORM);
	}/*
	else if (self.weapon == W_BIATCH)
	{
		if (curweaponframe == 9)
			sound (self ,5, "weapons/biatch/magout.wav", 1, ATTN_NORM);
		else if (curweaponframe == 18)
			sound (self ,5, "weapons/biatch/magin.wav", 1, ATTN_NORM);
		else if (curweaponframe == 25)
			sound (self ,5, "weapons/biatch/slideback.wav", 1, ATTN_NORM);
		else if (curweaponframe == 32)
			sound (self ,5, "weapons/biatch/sliderelease.wav", 1, ATTN_NORM);
	}*/
	else if (self.weapon == W_357)
	{
		if (curweaponframe == 5)
			sound (self ,5, "weapons/357/open.wav", 1, ATTN_NORM);
		else if (curweaponframe == 9)
			sound (self ,5, "weapons/357/out.wav", 1, ATTN_NORM);
		else if (curweaponframe == 15)
			sound (self ,5, "weapons/357/in.wav", 1, ATTN_NORM);
		else if (curweaponframe == 20)
			sound (self ,5, "weapons/357/close.wav", 1, ATTN_NORM);
	}
	else if (self.weapon == W_BK)
	{
		if (curweaponframe == 38)
			sound (self ,5, "weapons/ballknife/insert.wav", 1, ATTN_NORM);
	}
	else if (self.weapon == W_BAR)
	{
		if (curweaponframe == 6  || curweaponframe == 31)
			sound (self ,5, "weapons/bar/magout.wav", 1, ATTN_NORM);
		else if (curweaponframe == 19 || curweaponframe == 29)
			sound (self ,5, "weapons/bar/magin.wav", 1, ATTN_NORM);
		else if (curweaponframe == 23)
			sound (self ,5, "weapons/bar/maghit.wav", 1, ATTN_NORM);
	}
	else if (self.weapon == W_BROWNING)
	{
		if (curweaponframe == 9)
			sound (self ,5, "weapons/browning/boltback.wav", 1, ATTN_NORM);
		else if (curweaponframe == 16)
			sound (self ,5, "weapons/browning/topopen.wav", 1, ATTN_NORM);
		else if (curweaponframe == 22)
			sound (self ,5, "weapons/browning/chainoff.wav", 1, ATTN_NORM);
		else if (curweaponframe == 32)
			sound (self ,5, "weapons/browning/boltback.wav", 1, ATTN_NORM);
		else if (curweaponframe == 39)
			sound (self ,5, "weapons/browning/topopen.wav", 1, ATTN_NORM);
		else if (curweaponframe == 49)
			sound (self ,5, "weapons/browning/chainon.wav", 1, ATTN_NORM);
		else if (curweaponframe == 53)
			sound (self ,5, "weapons/browning/chainplace.wav", 1, ATTN_NORM);
		else if (curweaponframe == 58)
			sound (self ,5, "weapons/browning/topclose.wav", 1, ATTN_NORM);
		else if (curweaponframe == 61)
			sound (self ,5, "weapons/browning/tophit.wav", 1, ATTN_NORM);
		else if (curweaponframe == 70)
			sound (self ,5, "weapons/browning/boltforward.wav", 1, ATTN_NORM);
	}
	else if (self.weapon == W_DB || self.weapon == W_SAWNOFF)
	{
		if (curweaponframe == 6)
			sound (self ,5, "weapons/shotgun/open.wav", 1, ATTN_NORM);
		else if (curweaponframe == 12)
			sound (self ,5, "weapons/shotgun/out.wav", 1, ATTN_NORM);
		else if (curweaponframe == 20)
			sound (self ,5, "weapons/shotgun/in.wav", 1, ATTN_NORM);
		else if (curweaponframe == 26)
			sound (self ,5, "weapons/shotgun/close.wav", 1, ATTN_NORM);
	}
	else if (self.weapon == W_FG)
	{
		if (curweaponframe == 43)
			sound (self ,5, "weapons/fg42/magout.wav", 1, ATTN_NORM);
		else if (curweaponframe == 60)
			sound (self ,5, "weapons/fg42/magin.wav", 1, ATTN_NORM);
		else if (curweaponframe == 72)
			sound (self ,5, "weapons/fg42/boltback.wav", 1, ATTN_NORM);
		else if (curweaponframe == 77)
			sound (self ,5, "weapons/fg42/boltforward.wav", 1, ATTN_NORM);
	}
	else if (self.weapon == W_GEWEHR)
	{
		if (curweaponframe == 10)
			sound (self ,5, "weapons/gewehr/magout.wav", 1, ATTN_NORM);
		else if (curweaponframe == 24)
			sound (self ,5, "weapons/gewehr/magin.wav", 1, ATTN_NORM);
		else if (curweaponframe == 27)
			sound (self ,5, "weapons/gewehr/maghit.wav", 1, ATTN_NORM);
		else if (curweaponframe == 33)
			sound (self ,5, "weapons/gewehr/boltrelease.wav", 1, ATTN_NORM);
	}
	else if (self.weapon == W_KAR/* || self.weapon == W_ARMAGEDDON*/)
	{
		if (curweaponframe == 15)
			sound (self ,5, "weapons/kar/boltup.wav", 1, ATTN_NORM);
		else if (curweaponframe == 16)
			sound (self ,5, "weapons/kar/boltback.wav", 1, ATTN_NORM);
		else if (curweaponframe == 20)
			sound (self ,5, "weapons/kar/clipin.wav", 1, ATTN_NORM);
		else if (curweaponframe == 25)
			sound (self ,5, "weapons/kar/boltforward.wav", 1, ATTN_NORM);
		else if (curweaponframe == 26)
			sound (self ,5, "weapons/kar/clipoff.wav", 1, ATTN_NORM);
		else if (curweaponframe == 27)
			sound (self ,5, "weapons/kar/boltdown.wav", 1, ATTN_NORM);
	}
	else if (self.weapon == W_KAR_SCOPE)
	{
		if (curweaponframe == 15)
			sound (self ,5, "weapons/kar/boltup.wav", 1, ATTN_NORM);
		else if (curweaponframe == 16)
			sound (self ,5, "weapons/kar/boltback.wav", 1, ATTN_NORM);
		else if (curweaponframe == 20)
			sound (self ,5, "weapons/kar/insert.wav", 1, ATTN_NORM);
		else if (curweaponframe == 25)
			sound (self ,5, "weapons/kar/boltforward.wav", 1, ATTN_NORM);
		else if (curweaponframe == 27)
			sound (self ,5, "weapons/kar/boltdown.wav", 1, ATTN_NORM);
	}
	else if (self.weapon == W_M1A1)
	{
		if (curweaponframe == 6)
			sound (self ,5, "weapons/m1carbine/magout.wav", 1, ATTN_NORM);
		else if (curweaponframe == 14)
			sound (self ,5, "weapons/m1carbine/magin.wav", 1, ATTN_NORM);
		else if(curweaponframe == 16)
			sound (self ,5, "weapons/m1carbine/maghit.wav", 1, ATTN_NORM);
		else if (curweaponframe == 24)
			sound (self ,5, "weapons/m1carbine/bolt.wav", 1, ATTN_NORM);
	}
	else if (self.weapon == W_M1)
	{
		if (curweaponframe == 6)
			sound (self ,5, "weapons/m1garand/clipout.wav", 1, ATTN_NORM);
		else if (curweaponframe == 14)
			sound (self ,5, "weapons/m1garand/clipin.wav", 1, ATTN_NORM);
		else if (curweaponframe == 16)
			sound (self ,5, "weapons/m1garand/clippush.wav", 1, ATTN_NORM);
		else if (curweaponframe == 25)
			sound (self ,5, "weapons/m1garand/boltrelease.wav", 1, ATTN_NORM);
	}
	else if (self.weapon == W_MG)
	{
		if (curweaponframe == 8)
			sound (self ,5, "weapons/mg42/magout.wav", 1, ATTN_NORM);
		else if (curweaponframe == 19)
			sound (self ,5, "weapons/mg42/magin.wav", 1, ATTN_NORM);
		else if (curweaponframe == 29)
			sound (self ,5, "weapons/mg42/charge.wav", 1, ATTN_NORM);
	}
	else if (self.weapon == W_MP40)
	{
		if (curweaponframe == 10)
			sound (self ,5, "weapons/mp40/magout.wav", 1, ATTN_NORM);
		else if (curweaponframe == 17)
			sound (self ,5, "weapons/mp40/magin.wav", 1, ATTN_NORM);
	}
	else if (self.weapon == W_PANZER)
	{
		if (curweaponframe == 12)
			sound (self ,5, "weapons/panzer/move.wav", 1, ATTN_NORM);
		else if (curweaponframe == 16)
			sound (self ,5, "weapons/panzer/insert.wav", 1, ATTN_NORM);
	}
	else if (self.weapon == W_PPSH)
	{
		if (curweaponframe == 7)
			sound (self ,5, "weapons/ppsh/magout.wav", 1, ATTN_NORM);
		else if (curweaponframe == 15)
			sound (self ,5, "weapons/ppsh/magin.wav", 1, ATTN_NORM);
		else if (curweaponframe == 19)
			sound (self ,5, "weapons/ppsh/maghit.wav", 1, ATTN_NORM);
		else if (curweaponframe == 26)
			sound (self ,5, "weapons/ppsh/boltback.wav", 1, ATTN_NORM);
		else if (curweaponframe == 28)
			sound (self ,5, "weapons/ppsh/boltrelease.wav", 1, ATTN_NORM);
	}
	else if (self.weapon == W_PTRS)
	{
		if (curweaponframe == 6)
			sound (self ,5, "weapons/ptrs/open.wav", 1, ATTN_NORM);
		else if (curweaponframe == 18)
			sound (self ,5, "weapons/ptrs/magin.wav", 1, ATTN_NORM);
		else if (curweaponframe == 21)
			sound (self ,5, "weapons/ptrs/maghit.wav", 1, ATTN_NORM);
		else if (curweaponframe == 27)
			sound (self ,5, "weapons/ptrs/close.wav", 1, ATTN_NORM);
	}
	else if (self.weapon == W_RAY)
	{
		if (curweaponframe == 7)
			sound (self ,5, "weapons/raygun/open.wav", 1, ATTN_NORM);
		else if (curweaponframe == 12)
			sound (self ,5, "weapons/raygun/out.wav", 1, ATTN_NORM);
		else if (curweaponframe == 21)
			sound (self ,5, "weapons/raygun/in.wav", 1, ATTN_NORM);
		else if (curweaponframe == 26)
			sound (self ,5, "weapons/raygun/close.wav", 1, ATTN_NORM);
	}/*
	else if (self.weapon == W_SNUFF)
	{
		if (curweaponframe == 9)
			sound (self ,5, "weapons/shotgun/open.wav", 1, ATTN_NORM);
		else if (curweaponframe == 16)
			sound (self ,5, "weapons/shotgun/out.wav", 1, ATTN_NORM);
		else if (curweaponframe == 26)
			sound (self ,5, "weapons/shotgun/in.wav", 1, ATTN_NORM);
		else if (curweaponframe == 35)
			sound (self ,5, "weapons/shotgun/close.wav", 1, ATTN_NORM);
	}*/
	else if (self.weapon == W_STG)
	{
		if (curweaponframe == 11)
			sound (self ,5, "weapons/stg/magout.wav", 1, ATTN_NORM);
		else if (curweaponframe == 21)
			sound (self ,5, "weapons/stg/magin.wav", 1, ATTN_NORM);
	}/*
	else if (self.weapon == W_TESLA)
	{
		if (curweaponframe == 10)
			sound (self ,5, "weapons/tesla/switchoff.wav", 1, ATTN_NORM);
		else if (curweaponframe == 16)
			sound (self ,5, "weapons/tesla/pulllever.wav", 1, ATTN_NORM);
		else if (curweaponframe == 22)
			sound (self ,5, "weapons/tesla/glassbreak.wav", 1, ATTN_NORM);
		else if (curweaponframe == 29)
			sound (self ,5, "weapons/tesla/clipin.wav", 1, ATTN_NORM);
		else if (curweaponframe == 32)
			sound (self ,5, "weapons/tesla/clipoff.wav", 1, ATTN_NORM);
		else if (curweaponframe == 41)
			sound (self ,5, "weapons/tesla/switchon.wav", 1, ATTN_NORM);
	}*/
	else if (self.weapon == W_TRENCH)
	{
		if (curweaponframe == 19)
			sound (self ,5, "weapons/shotgun/insert.wav", 1, ATTN_NORM);
	}
	else if (self.weapon == W_TYPE)
	{
		if (curweaponframe == 6)
			sound (self ,5, "weapons/type100/magout.wav", 1, ATTN_NORM);
		else if (curweaponframe == 15)
			sound (self ,5, "weapons/type100/magin.wav", 1, ATTN_NORM);
		else if (curweaponframe == 20)
			sound (self ,5, "weapons/type100/boltpull.wav", 1, ATTN_NORM);
	}
}