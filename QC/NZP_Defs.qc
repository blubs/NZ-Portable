/*
+----+
|Defs|
+----+-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-+
| Scratch                                      Http://www.admdev.com/scratch |
+=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-+
| This contains necessary definitions from the original V1.06 defs.qc file.  |
| This includes some basic constants, the built in function definitions, and |
| some variable's used by the Quake Engine internally.                       |
| Certain lines in this file are hardcoded into Quake engine, and -must- be  |
| present and unchanged, in the order they are shown. Otherwise Quake will   |
| refuse to run.                                                             |
+=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-+
*/

//generic defines
#define false 0
#define true 1

// AI definitions
//Used for global one-zombie-at-a-time type ai
void Do_Zombie_AI();
float ai_delay_time;
.string aistatus;
entity lastzombie;
//Other AI definitions
.vector box1, box2, box3;//used for windows and zombies
.vector idlebox;
.vector hop_spot;//used for windows (zombies hop to these)
.vector goalorigin;
//==== Reference Vars ====
const float WWINDOW = 1; 
const float WBOX1 = 2;
const float WBOX2 = 4;
const float WBOX3 = 8;
const float WIDLEBOX = 16;
//========================

//we're using usedent for who is currently hopping the window
//Used for windows to keep track of what zombies are at windows
.entity box1owner, box2owner, box3owner;

.entity usedent;
//.float used;//used for the window boxes//not anymore

.float outside;//used for knowing if a zomibe has hopped window yet
.float chase_enemy_time;
.float chase_time;
.float enemy_timeout;
//.float pathing;
.float calc_time; //used as a delay thing (so zombie ai doesn't run 100% of the time
.string waynum; //reserved for only waypoints, do not use on any other entities
.string target2;
.string target3;
.string target4;
.string target5;
.string target6;
.string target7;
.string target8;
.string wayTarget;
.entity active_door;//Set in waypoint mode
.string targetname;//the name of an entitys
entity lastspawn;//last spawn point used by spawning code
.entity goaldummy; //Used to store the origin of the zombies target
.float walktype;//decides animations and moving speeds for zombies
.void() th_walk;
//.void() th_run;
.void() th_die;
.void() th_melee;
.void() th_idle;
.void() th_windowhop;
.void() th_diewunder;

.void() th_fall;
.void() th_falling;
.void() th_land;

.void() th_jump;
.void() th_grabledge;
.float tries;
.float hop_step;//KEEPS TRACK OF WHERE WE ARE ON THE HOPPING PART

float INACTIVE = 1;

//rounds

//nzp: economy defines
.float cost;
.float semiuse; //used to not buy twice, or anyting like that
void(entity person, float expamt , float doublepoint) addmoney;

//nzp weapon defines
//id list
#define W_COLT 		1
#define W_KAR 		2
#define W_THOMPSON 	3
#define W_357		4
#define W_BAR		5
#define W_BK		6
#define W_BROWNING	7
#define W_DB		8
#define W_FG		9
#define W_GEWEHR	10
#define W_KAR_SCOPE	11
#define W_M1		12
#define W_M1A1		13
#define W_M2		14
#define W_MP40		15
#define W_MG		16
#define W_PANZER	17
#define W_PPSH		18
#define W_PTRS		19
#define W_RAY		20
#define W_SAWNOFF	21
#define W_STG		22
#define W_TRENCH	23
#define W_TYPE		24
#define W_BOWIE		25
#define W_GRENADE	26
#define W_BETTY		27


.float weaponbk;
.float currentammobk;
.float currentmagbk;

string mappath;
float FILE_READ = 0;
float FILE_APPEND = 1;
float FILE_WRITE = 2;

//weaponsystem defines
.float downed;
.float reload_delay;
.float knife_delay;
.float fire_delay;
.float grenade_delay;
.float throw_delay;
.float health_delay;
.float recoil_delay;
.float cur_spread;
.float secondaryammo;
.float secondarymag;
.float secondaryweapon;
.float semi;
.float bowie;

//weapon frames
.float weapon_animduration;
.float weapon_anim_type;
.float anim_weapon_time;
.float weaponframe_end;
.float callfuncat;
.float new_anim_stop;
.float anim_reversed;
.void() animend;

#define BASE_FRAME			1
#define FIRE_START 			2
#define FIRE_END 			3
#define RELOAD_START 		4
#define RELOAD_END 			5
#define SPRINT_IN_START		12
#define SPRINT_IN_END 		13
#define SPRINT_START		10
#define SPRINT_END 			11
#define SPRINT_OUT_START 	14
#define SPRINT_OUT_END 		15
#define TAKE_OUT_START		16
#define TAKE_OUT_END 		17
#define PUT_OUT_START 		18
#define PUT_OUT_END 		19
#define RELOAD_CANCEL 		20

#define RELOAD		1
#define GRENADE		2
#define FIRE		3
#define SWITCHWEP	4
#define KNIFE		5
#define ZOOM		6
#define SPRINT		7
#define PERK		8
#define KNIFE2		9
#define REVIVE		10

#define S_HEADSHOT	1
#define S_KNIFE		2
#define S_NORMAL	3
#define S_ZOMBIE	4
#define S_EXPLOSIVE	5

#define 	P_JUG		1
#define 	P_DOUBLE	2
#define 	P_SPEED		4
#define 	P_REVIVE	8
#define 	P_FLOP		16
#define 	P_STAMIN	32

//Power system
float  POWER_ON; //used for terminating if there is power on map

//dummy
.float renderamt; // dr_mabuse1981: Halflife Rendermode
.float rendermode; // dr_mabuse1981: Halflife Rendermode
.vector rendercolor; // dr_mabuse1981: Halflife Rendermode
.float mapversion;
.float ammo;


float instakill_finished;
float insta_blink;
float x2_finished;
float x2_blink;
float total_windows_down;
float total_powerup_points;
float powerup_activate;

.float revivesoda;

.float stamina;
.float into_sprint;

.float sound_time;
.float s_time;
float sounds_playing;


.float fall;
//.vector lastOrg;//Zombie's last origin, for checking stuckness
//.float OrgStuckCount;
.float crawling;

.float washit;
.float hitamount;

.float currentHitBoxSetup;
.float laststep;
.vector		bbmins, bbmaxs;		// Used for zombie hitboxes
void(entity who) makeCrawler;
.float state;//used to delay making a crawler, ex) when zombie is rising from ground or climbing over barrier, turn zombie into a crawler afterwards
float crandom();

float z_health;
.float bleedingtime;