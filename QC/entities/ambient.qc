/*
+-------+
|Ambient|
+-------+=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-+
| QuakeC From Scratch                             http://qcfs.sourceforge.net|
+=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-+
| Handles ambient sounds in levels.                                          |
+=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-+
*/

.float 	misc;
.float cnt;

void(string soundfile, float volume) doambient; // Definition from Ambient.qc

void(string soundfile, float volume) doambient =
{
 precache_sound (soundfile);
 ambientsound (self.origin, soundfile, volume, ATTN_STATIC);
};

// ----------------------------------
void() info_ambient =
// ----------------------------------
{
	setorigin(self, self.origin);
	self.solid = SOLID_NOT;
	self.classname = "Ambience";
	self.movetype = MOVETYPE_NONE;
	
	if(self.noise == "" || self.noise == "ambience/")
		{
		error("ERROR: info_ambient, No sound path provdied.");
		return;
		}
		
	
	precache_sound(self.noise);
	if(!self.misc)
		self.misc = 1;
	if(self.cnt == 0)
		ambientsound (self.origin, self.noise, self.misc, ATTN_NONE);
	if(self.cnt == 1)
		ambientsound (self.origin, self.noise, self.misc, ATTN_STATIC);
};

