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

// These lines CANNOT be altered/moved
entity          self;
entity		other;
entity		world;
float		time;
float		frametime;
float		force_retouch;		// force all entities to touch triggers
string		mapname;
float		deathmatch;
float		coop;
float		teamplay;
float		serverflags;		// propagated from level to level, used to
float		rounds;
float		rounds_change;
float		x2_icon;		// double points icon
float		insta_icon;	// number of monsters killed
float		parm1, parm2, parm3, parm4, parm5, parm6, parm7, parm8, parm9, parm10, parm11, parm12, parm13, parm14, parm15, parm16;
vector		v_forward, v_up, v_right;	// set by makevectors()
float		trace_allsolid;
float		trace_startsolid;
float		trace_fraction;
vector		trace_endpos;
vector		trace_plane_normal;
float		trace_plane_dist;
entity		trace_ent;
float		trace_inopen;
float		trace_inwater;

entity          msg_entity;                      // destination of single entity writes
void()          main;                            // only for testing
void()		StartFrame;
void()		EndFrame;
void() 		PlayerPreThink;
void() 		PlayerPostThink;
void()		ClientKill;
void()		ClientConnect;
void() 		PutClientInServer;		// call after setting the parm1... parms
void()		ClientDisconnect;
void()		SetNewParms;			// called when a client first connects to
void()		SetChangeParms;			// call to set parms for self so they can
void		end_sys_globals;		// flag for structure dumping

.float		modelindex;		// *** model index in the precached list
.vector		absmin, absmax;	// *** origin + mins / maxs
.float		ltime;			// local time for entity
.float		movetype;
.float		solid;
.vector		origin;			// ***
.vector		oldorigin;		// ***
.vector		velocity;
.vector		angles;
.vector		avelocity;
.vector		punchangle;		// temp angle adjust from damage or recoil
.string		classname;		// spawn function
.string		model;
.float		frame;
.float		skin;
.float		iframetime;
.float		effects;
.vector		mins, maxs;		// bounding box extents reletive to origin
.vector		size;			// maxs - mins
.void()		touch;
.void()		use;
.void()		think;
.void()		blocked;		// for doors or plats, called when can't push other
.float		nextthink;
.entity		groundentity;
.float		health;
.float		points;
.float		kills;
.float		weapon;			// one of the W_COLT, etc flags
.string		weaponmodel;
.string		weapon2model;
.float		weaponframe;
.float		weapon2frame;
.float		currentammo;
.float		currentmag;
.float		zoom;
.float 		weaponskin;
.float 		weapon2skin;
.float		primary_grenades;
.float		secondary_grenades;
.float		grenades;
.float		perks;			// bit flags
.float		takedamage;
.entity		chain;
.float		deadflag;
.vector		view_ofs;			// add to origin to get eye point
.float		button0;		// fire
.float		button1;		// use
.float		button2;		// jump
.float		button3;		// grenade
.float		button4;		// switch
.float		button5;		// reload
.float		button6;		// knife
.float		button7;		// aim
.float		impulse;		// weapon changes
.float		fixangle;
.vector		v_angle;		// view / targeting angle for players
.float		idealpitch;		// calculated pitch angle for lookup up slopes
.string		netname;
.entity 	enemy;
.float		flags;
.float		colormap;
.float		team;
.float		max_health;		// players maximum health is stored here
.float		teleport_time;	// don't back up
.float		waterlevel;		// 0 = not in, 1 = feet, 2 = wast, 3 = eyes
.float		watertype;		// a contents value
.float		ideal_yaw;
.float		yaw_speed;
.entity		aiment;
.entity 	head;
.entity		larm;
.entity 	rarm;
.entity 	goalentity;		// a movetarget or an enemy
//.entity 	goalorigin;		// a movetarget location
.float		spawnflags;
.string		target;
.string		targetname;
.float		bleed_out;
.float		progress_bar;
.entity		dmg_inflictor;
.entity		owner;		// who launched a missile
.vector		movedir;	// mostly for doors, but also used for waterjump
.string		message;		// trigger messages
.float		sounds;		// either a cd track number or sound number
.string         noise, noise1, noise2, noise3;  // contains names of wavs to play

void		end_sys_fields;			// flag for structure dumping
// End. Lines below this MAY be altered, to some extent

// Built In functions
void(vector ang) makevectors			= #1;	// sets v_forward, etc globals
void(entity e, vector o) setorigin		= #2;
void(entity e, string m) setmodel		= #3;	// set movetype and solid first
void(entity e, vector min, vector max) setsize	= #4;
void() break					= #6;
float() random					= #7;	// returns 0 - 1
void(entity e, float chan, string samp, float vol, float atten) sound = #8;
vector(vector v) normalize			= #9;
void(string e) error				= #10;
void(string e) objerror				= #11;
float(vector v) vlen				= #12;
float(vector v) vectoyaw			= #13;
entity() spawn					= #14;
void(entity e) remove				= #15;
void(vector v1, vector v2, float nomonsters, entity forent) traceline = #16;	
entity() checkclient				= #17;		// returns a client to look for
entity(entity start, .string fld, string match) find = #18;
string(string s) precache_sound			= #19;
string(string s) precache_model			= #20;
void(entity client, string s)stuffcmd		= #21;
entity(vector org, float rad) findradius	= #22;
void(string s) dprint				= #25;
string(float f) ftos				= #26;
string(vector v) vtos				= #27;
void() coredump					= #28;		// prints all edicts
void() traceon					= #29;		// turns statment trace on
void() traceoff					= #30;
void(entity e) eprint				= #31;		// prints an entire edict
float(float yaw, float dist) walkmove		= #32;		// returns TRUE or FALSE
float(entity zombie, float which, entity limb) updateLimb		= #33;
float(float yaw, float dist) droptofloor	= #34;		// TRUE if landed on floor
void(float style, string value) lightstyle	= #35;
float(float v) rint				= #36;		// round to nearest int
float(float v) floor				= #37;		// largest integer <= v
float(float v) ceil				= #38;		// smallest integer >= v
float(entity e) checkbottom			= #40;		// true if self is on ground
float(vector v) pointcontents			= #41;		// returns a CONTENT_*
float(float f) fabs				= #43;
vector(entity e, float speed) aim		= #44;		// returns the shooting vector
float(string s) cvar				= #45;		// return cvar.value
void(string s) localcmd				= #46;		// put string into local que
entity(entity e) nextent			= #47;		// for looping through all ents
void() ChangeYaw 				= #49;		// turn towards self.ideal_yaw
float(string name) getSoundLen			= #50;
vector(vector v) vectoangles			= #51;
void(float to, float f) WriteByte		= #52;
void(float to, float f) WriteChar		= #53;
void(float to, float f) WriteShort		= #54;
void(float to, float f) WriteLong		= #55;
void(float to, float f) WriteCoord		= #56;
void(float to, float f) WriteAngle		= #57;
void(float to, string s) WriteString		= #58;
void(float to, entity s) WriteEntity		= #59;
string(entity s) etos			= #65;
void(float step) movetogoal			= #67;
string(string s) precache_file			= #68;		// no effect except for -copy
void(entity e) makestatic			= #69;
void(string s) changelevel			= #70;
void(float step, vector origin) movetoorigin			= #71;
void(string var, string val) cvar_set		= #72;		// sets cvar.value
void(entity client, string s) centerprint 	= #73;		// sprint, but in middle
void(entity client, string s, string s) centerprint2 = #73;
void(entity client, string s, string s, string s) centerprint3 = #73;
void(entity client, string s, string s, string s, string s) centerprint4 = #73;
void(entity client, string s, string s, string s, string s, string s) centerprint5 = #73;
void(entity client, string s, string s, string s, string s, string s, string s) centerprint6 = #73;
void(entity client, string s, string s, string s, string s, string s, string s, string s) centerprint7 = #73;
void(vector pos, string samp, float vol, float atten) ambientsound = #74;
string(string s) precache_model2		= #75;	// registered version only
string(string s) precache_sound2		= #76;	// registered version only
string(string s) precache_file2			= #77;	// registered version only
void(entity e) setspawnparms			= #78;	// set parm1... to the
void(vector start, vector min, vector max, vector end, float nomonsters, entity forent) tracebox = #90; 
float(vector start, vector min, vector max, vector end, float nomonsters, entity forent) tracemove = #99; 
entity (entity start, .float field, float match) findfloat = #98;
float(string s) stof = #81;	// 2001-09-20 QuakeC string manipulation by FrikaC
vector(entity what) Get_Waypoint_Near = #83;
float(entity zombie, entity target) Do_Pathfind = #84;
void(string s) Open_Waypoint = #85;
vector(entity zombie,vector start,vector min, vector max) Get_Next_Waypoint = #86;
void(entity client, float type, float cost, float weapon) useprint = #87;
vector(entity zombie,vector start,vector min, vector max) Get_First_Waypoint = #88;

void(entity plr, float achievement) achievement = #79;
/*
type 0 = clear
type 1 = buy door
type 2 = buy debris
type 3 = Buy ammo
type 4 = buy weapon
type 5 = repair window
type 6 = use box
type 7 = use trap
type 8 = require power
*/


// 2001-09-20 QuakeC file access by FrikaC  start
float(string filename, float mode) fopen = #110;
void(float fhandle) fclose = #111;
string(float fhandle) fgets = #112;
void(float fhandle, string s) fputs = #113;
// 2001-09-20 QuakeC file access by FrikaC  end

// 2001-09-20 QuakeC string manipulation by FrikaC  start
float(string s) strlen = #114;
string(string s1, string s2) strcat = #115;
string(string s, float start, float length) substring = #116;
vector(string s) stov = #117;
string(string s) strzone = #118;
string(string s) strunzone = #119;
// 2001-09-20 QuakeC string manipulation by FrikaC  end

//
// constants
//

float	FALSE					= 0;
float 	TRUE					= 1;

// edict.flags
float	FL_FLY					= 1;
float	FL_SWIM					= 2;
float	FL_CLIENT				= 8;	// set for all client edicts
float	FL_INWATER				= 16;	// for enter / leave water splash
float	FL_MONSTER				= 32;
float	FL_GODMODE				= 64;	// player cheat
float	FL_NOTARGET				= 128;	// player cheat
float	FL_ITEM					= 256;	// extra wide size for bonus items
float	FL_ONGROUND				= 512;	// standing on something
float	FL_PARTIALGROUND		= 1024;	// not all corners are valid
float	FL_WATERJUMP			= 2048;	// player jumping out of water
float	FL_JUMPRELEASED			= 4096;	// for jump debouncing

// edict.movetype values
#define		MOVETYPE_NONE				0	// never moves
#define   	MOVETYPE_ANGLENOCLIP    	1
#define   	MOVETYPE_ANGLECLIP        	2
#define		MOVETYPE_WALK				3	// players only
#define		MOVETYPE_STEP				4	// discrete, not real time unless fall
#define		MOVETYPE_FLY				5
#define		MOVETYPE_TOSS				6	// gravity
#define		MOVETYPE_PUSH				7	// no clip to world, push and crush
#define		MOVETYPE_NOCLIP				8
#define		MOVETYPE_FLYMISSILE			9	// fly with extra size against monsters
#define		MOVETYPE_BOUNCE				10
#define		MOVETYPE_BOUNCEMISSILE		11	// bounce with extra size
#define		MOVETYPE_FOLLOW				12	

// edict.solid values
float	SOLID_NOT				= 0;	// no interaction with other objects
float	SOLID_TRIGGER			= 1;	// touch on edge, but not blocking
float	SOLID_BBOX				= 2;	// touch on edge, block
float	SOLID_SLIDEBOX			= 3;	// touch on edge, but not an onground
float	SOLID_BSP				= 4;	// bsp clip, touch on edge, block
float	SOLID_CORPSE			= 5;	// bsp clip, touch on edge, block

// range values
float	RANGE_MELEE				= 0;
float	RANGE_NEAR				= 1;
float	RANGE_MID				= 2;
float	RANGE_FAR				= 3;

// deadflag values

float	DEAD_NO					= 0;
float	DEAD_DYING				= 1;
float	DEAD_DEAD				= 2;
float	DEAD_RESPAWNABLE		= 3;

// takedamage values

float	DAMAGE_NO				= 0;
float	DAMAGE_YES				= 1;
float	DAMAGE_AIM				= 2;
float	DAMAGE_NOMARKER			= 3;

/*.void()		th_stand;
.void()		th_walk;
.void()		th_run;
.void(entity attacker, float damage)		th_pain;*/
.void()		th_die;
//.void()         th_missile;
.void()         th_melee;

// point content values

float	CONTENT_EMPTY			= -1;
float	CONTENT_SOLID			= -2;
float	CONTENT_WATER			= -3;
float	CONTENT_SLIME			= -4;
float	CONTENT_LAVA			= -5;
float   CONTENT_SKY                     = -6;


vector	VEC_ORIGIN = '0 0 0';

//Standard Quake View Offset
//vector VEC_VIEW_OFS = '0 0 22';

//Half Life View Offset is 64
//64 units above ground, for our purposes it's, 64 - (how low bounding box goes)
vector VEC_VIEW_OFS = '0 0 32';

//Standard Quake Hull
//vector	VEC_HULL_MIN = '-16 -16 -24';
//vector	VEC_HULL_MAX = '16 16 32';

//Half Life 1 Hull Sizes ADDED BY BLUBS, COMMENTED ORIGINAL QUAKE BBOX SIZS OUT
vector	VEC_HULL_MIN = '-16 -16 -32';
vector	VEC_HULL_MAX = '16 16 40';

vector	VEC_HULL2_MIN = '-32 -32 -24';
vector	VEC_HULL2_MAX = '32 32 64';

// protocol bytes
float	SVC_BAD					= 0;
float	SVC_NOP					= 1;
float	SVC_DISCONNECT			= 2;
float	SVC_UPDATESTAT			= 3;
float	SVC_VERSION				= 4;
float	SVC_SETVIEW				= 5;
float	SVC_SOUND				= 6;
float	SVC_TIME				= 7;
float	SVC_PRINT				= 8;
float	SVC_STUFFTEXT			= 9;
float	SVC_SETANGLE			= 10;
float	SVC_SERVERINFO			= 11;
float	SVC_LIGHTSTYLE			= 12;
float	SVC_UPDATENAME			= 13;
float	SVC_UPDATEPOINTS		= 14;
float	SVC_CLIENTDATA			= 15;
float	SVC_STOPSOUND			= 16;
float	SVC_PARTICLE			= 18;
float	SVC_DAMAGE				= 19;
float	SVC_SPAWNSTATIC			= 20;
float	SVC_SPAWNBINARY			= 21;
float	SVC_SPAWNBASELINE		= 22;
float	SVC_TEMPENTITY			= 23;
float	SVC_SETPAUSE			= 24;
float	SVC_SIGNONNUM			= 25;
float	SVC_CENTERPRINT			= 26;
float	SVC_SPAWNSTATICSOUND	= 29;	// 1998-08-08 Complete SVC list by Zhenga
float	SVC_INTERMISSION		= 30;
float	SVC_FINALE				= 31;
float	SVC_CDTRACK				= 32;
float	SVC_SELLSCREEN			= 33;
float	SVC_CUTSCENE			= 34;	// 1998-08-08 Complete SVC list by Zhenga
float	SVC_WEAPONFIRE			= 35;
float	SVC_HITMARK				= 36;
float	SVC_USEPRINT			= 38;

float	TE_SPIKE		= 0;
float	TE_SUPERSPIKE	= 1;
float	TE_GUNSHOT		= 2;
float	TE_EXPLOSION	= 3;
float	TE_TAREXPLOSION	= 4;
float	TE_LIGHTNING1	= 5;
float	TE_LIGHTNING2	= 6;
float	TE_WIZSPIKE		= 7;
float	TE_KNIGHTSPIKE	= 8;
float	TE_LIGHTNING3	= 9;
float	TE_LAVASPLASH	= 10;
float	TE_TELEPORT		= 11;

// sound channels
// channel 0 never willingly overrides
// other channels (1-7) allways override a playing sound on that channel
float	CHAN_AUTO		= 0;
float	CHAN_WEAPON		= 1;
float	CHAN_VOICE		= 2;
float	CHAN_ITEM		= 3;
float	CHAN_BODY		= 4;
//Player uses channel 5 for all weapon reload sfx

float	ATTN_NONE		= 0;
float	ATTN_NORM		= 1;
float	ATTN_IDLE		= 2;
float	ATTN_STATIC		= 3;

// update types

float	UPDATE_GENERAL	= 0;
float	UPDATE_STATIC	= 1;
float	UPDATE_BINARY	= 2;
float	UPDATE_TEMP		= 3;

// entity effects

#define	EF_BLUELIGHT			1
#define	EF_MUZZLEFLASH 			2
#define	EF_BRIGHTLIGHT 			4
#define	EF_REDLIGHT 			8
#define	EF_ORANGELIGHT			16
#define	EF_GREENLIGHT			32
#define	EF_LIGHT				64
#define	EF_NODRAW				128
#define EF_BRIGHTFIELD			256
#define EF_FULLBRIGHT 			512
#define EF_DARKLIGHT			1024
#define EF_DARKFIELD			2048


// messages
float	MSG_BROADCAST	= 0;		// unreliable to all
float	MSG_ONE			= 1;		// reliable to one (msg_entity)
float	MSG_ALL			= 2;		// reliable to all
float	MSG_INIT		= 3;		// write to the init string

float	AS_STRAIGHT		= 1;
float	AS_SLIDING		= 2;
float	AS_MELEE		= 3;
float	AS_MISSILE		= 4;

void() SUB_Null = {};
void() SUB_Null2 = {};

// Quake assumes these are defined.
entity activator;
string string_null;    // null string, nothing should be held here

//.string         wad, map;
.float /*worldtype,*/ delay, wait, lip, /*light_lev,*/ speed, style/*, skill*/;
.string killtarget;
.void() think1;
.vector finaldest;
.vector pos1, pos2/*, mangle*/;

void(vector o, vector d, float color, float count) particle = #48;// start a particle effect
void(string s) bprint				= #23;
void(entity client, string s) sprint		= #24;
void() SUB_Remove = {remove(self);};
// End

void(string s) println = {bprint(s);} //just when brain decided to think this is c

entity damage_attacker;

//doors
.float		state;
float	STATE_TOP		= 0;
float	STATE_BOTTOM	= 1;
float	STATE_UP		= 2;
float	STATE_DOWN		= 3;
