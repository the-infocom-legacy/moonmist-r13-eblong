

	.FUNCT	TELL-IN-BROCHURE
	PRINTI	"[This is described in the "
	PRINTD	BROCHURE
	PRINTR	".]"


	.FUNCT	BROCHURE-PSEUDO
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	CALL	TELL-IN-BROCHURE
	RSTACK	
?CCL3:	CALL	RANDOM-PSEUDO
	RSTACK	


	.FUNCT	MEMENTO-F
	EQUAL?	PRSA,V?TAKE \?CCL3
	PRINTR	"But that would spoil the display!"
?CCL3:	CALL	BROCHURE-PSEUDO
	RSTACK	


	.FUNCT	OLD-GREAT-HALL-F,RARG=0
	EQUAL?	RARG,M-LOOK \?CCL3
	PRINTR	"Your footfalls echo across the ancient stone floor."
?CCL3:	EQUAL?	RARG,P?WEST,P?UP \?CCL7
	PRINT	STAIRS-UP-RIGHT
	RTRUE	
?CCL7:	ZERO?	RARG \FALSE
	CALL	NOUN-USED?,W?DOOR
	ZERO?	STACK /FALSE
	EQUAL?	PRSA,V?UNLOCK \?CCL16
	EQUAL?	HERE,OLD-GREAT-HALL \?CCL16
	CALL	OKAY,PRSO,STR?68
	RSTACK	
?CCL16:	EQUAL?	PRSA,V?EXAMINE \FALSE
	CALL	CHECK-DOOR,PRSO
	RSTACK	


	.FUNCT	JUNCTION-F,RARG=0
	EQUAL?	RARG,M-LOOK \?CCL3
	PRINTI	"The two halves of "
	PRINTD	CASTLE
	PRINTR	" meet here, as the past meets the present."
?CCL3:	EQUAL?	RARG,P?NORTH,P?DOWN \FALSE
	PRINT	STAIRS-DOWN-LEFT
	RTRUE	


	.FUNCT	BASEMENT-ENTER
	ZERO?	BRICKS-DOWN /?CCL3
	RETURN	CRYPT
?CCL3:	RETURN	DUNGEON


	.FUNCT	BASEMENT-F,RARG=0
	EQUAL?	RARG,M-LOOK \?CCL3
	PRINTI	"The "
	PRINTD	BASEMENT
	PRINTI	" of the tower keep still holds traces of the medieval past -- such as an "
	PRINTD	WELL
	PRINTI	". The "
	PRINTD	BASEMENT
	PRINTI	" now stores both Lionel's expedition gear and the castle wine cellar"
	EQUAL?	VARIATION,PAINTER-C \?PRG10
	PRINTI	" (a rack full of wine bottles)"
?PRG10:	PRINTI	".
The brick walls are damp and mossy"
	EQUAL?	VARIATION,FRIEND-C \?PRG18
	FSET?	CLUE-4,TOUCHBIT \?PRG18
	PRINTI	", and some bricks look loose"
?PRG18:	PRINTR	". A stairway lies north, and doors lead east and west."
?CCL3:	EQUAL?	RARG,P?NORTH,P?UP \FALSE
	PRINT	STAIRS-UP-RIGHT
	RTRUE	


	.FUNCT	WINE-RACK-F,X
	FCLEAR	WINE-RACK,NDESCBIT
	EQUAL?	PRSA,V?TAKE \?CCL3
	IN?	BOTTLE,WINE-RACK \FALSE
	CALL	NOUN-USED?,W?WINE
	ZERO?	STACK /FALSE
	CALL	PERFORM,PRSA,BOTTLE
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?LOOK-INSIDE,V?EXAMINE \FALSE
	CALL	TELL-AS-WELL-AS,WINE-RACK,STR?254
	RTRUE	


	.FUNCT	BOTTLE-F
	EQUAL?	PRSA,V?SEARCH-FOR,V?SEARCH /?CTR2
	EQUAL?	PRSA,V?READ,V?LOOK-INSIDE,V?EXAMINE \?CCL3
?CTR2:	CALL	NOT-HOLDING?,BOTTLE
	ZERO?	STACK \TRUE
	PRINTI	"The label says it's wine from a Cornish winery called Our Own Vintage."
	EQUAL?	VARIATION,PAINTER-C \?CND10
	PRINTR	" Someone has drawn a star in red ink over the word ""OUR."""
?CND10:	CRLF	
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?SHAKE,V?OPEN,V?MUNG /?CTR14
	EQUAL?	PRSA,V?EMPTY,V?EAT,V?DRINK \?CCL15
?CTR14:	EQUAL?	PRSO,BOTTLE \FALSE
	PRINTR	"You instantly realize that you don't need any wine -- or any more, as the case may be."
?CCL15:	EQUAL?	PRSA,V?FILL /?CTR23
	EQUAL?	PRSA,V?PUT-IN \?CCL24
	EQUAL?	PRSI,BOTTLE \?CCL24
?CTR23:	CALL	TOO-BAD-BUT,BOTTLE,STR?61
	RSTACK	
?CCL24:	CALL	ATTACK-VERB?
	ZERO?	STACK /FALSE
	CALL	NO-VIOLENCE?,BOTTLE
	RTRUE	


	.FUNCT	BRICKS-D,X
	PRINTI	"There's a "
	PRINTD	BRICKS
	ZERO?	BRICKS-DOWN /?PRG7
	PRINTC	32
	CALL	GROUND-DESC
	PRINT	STACK
	PRINTI	", and a hole"
?PRG7:	PRINTR	" in the wall."


	.FUNCT	BRICKS-F
	EQUAL?	PRSA,V?SEARCH /?CTR2
	EQUAL?	PRSA,V?RUB,V?KNOCK,V?EXAMINE \?CCL3
?CTR2:	FCLEAR	BRICKS,NDESCBIT
	FSET	BRICKS,SEENBIT
	CALL	BRICKS-D
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?TURN,V?TAKE /?CCL8
	EQUAL?	PRSA,V?SLAP,V?PUSH,V?OPEN /?CCL8
	EQUAL?	PRSA,V?MUNG,V?MOVE-DIR,V?MOVE \FALSE
?CCL8:	EQUAL?	VARIATION,FRIEND-C \FALSE
	ZERO?	BRICKS-DOWN \FALSE
	FCLEAR	BRICKS,NDESCBIT
	SET	'BRICKS-DOWN,TRUE-VALUE
	FCLEAR	HOLE-IN-WALL,INVISIBLE
	PRINTI	"You manage to pull them down into a pile "
	CALL	GROUND-DESC
	PRINT	STACK
	PRINTR	", making a large hole in the wall."


	.FUNCT	HOLE-IN-WALL-F,RM
	EQUAL?	PRSA,V?CLOSE \?CCL3
	CALL	YOU-CANT
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?LOOK-THROUGH,V?LOOK-INSIDE,V?EXAMINE \?CCL5
	EQUAL?	HERE,BASEMENT \?CCL8
	PRINTR	"Through the dusty air, you can see only dark inside. But the hole looks big enough to climb through."
?CCL8:	CALL	ROOM-PEEK,BASEMENT,TRUE-VALUE
	RTRUE	
?CCL5:	EQUAL?	PRSA,V?THROUGH,V?DISEMBARK,V?BOARD \FALSE
	EQUAL?	HERE,BASEMENT \?CCL15
	SET	'RM,CRYPT
	JUMP	?CND13
?CCL15:	SET	'RM,BASEMENT
?CND13:	CALL	GOTO,RM
	ZERO?	STACK /TRUE
	CALL	OKAY
	RTRUE	


	.FUNCT	WELL-F
	EQUAL?	PRSA,V?SEARCH-FOR,V?SEARCH /?PRG7
	EQUAL?	PRSA,V?LOOK-INSIDE,V?LOOK-DOWN,V?EXAMINE \?CCL3
?PRG7:	PRINTR	"It's deep and dark."
?CCL3:	EQUAL?	PRSA,V?CLOSE,V?OPEN \?CCL10
	CALL	YOU-CANT
	RSTACK	
?CCL10:	EQUAL?	PRSA,V?THROUGH,V?CLIMB-DOWN,V?BOARD \?CCL12
	PRINTI	"After a moment's thought, you remember "
	PRINTD	LOVER
	PRINTR	"'s fate and decide that's much too dangerous."
?CCL12:	EQUAL?	PRSA,V?PUT-IN,V?PUT \FALSE
	EQUAL?	PRSI,WELL \FALSE
	PRINTI	"As you watch,"
	CALL	PRINTT,PRSO
	PRINTI	" disappears into the dark well shaft. After a second or two, you hear a remote splash.
"
	CALL	REMOVE-CAREFULLY,PRSO
	RTRUE	


	.FUNCT	CRYPT-F,RARG=0
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This space at the bottom of the tower is so gloomy and musty that you should be glad there's an exit to the "
	PRINTD	BASEMENT
	PRINTR	"."


	.FUNCT	SKELETON-F
	EQUAL?	PRSA,V?SEARCH-FOR /?CCL3
	EQUAL?	PRSA,V?SEARCH,V?LOOK-UNDER,V?EXAMINE \FALSE
?CCL3:	IN?	NECKLACE,SKELETON \?PRG12
	FSET?	NECKLACE,SECRETBIT \?PRG12
	EQUAL?	PRSA,V?SEARCH-FOR,V?SEARCH,V?EXAMINE \?PRG12
	CALL	DISCOVER,NECKLACE,SKELETON
	RTRUE	
?PRG12:	PRINTR	"Just old bones moldering in the dark."


	.FUNCT	DUNGEON-F,ARG=0
	EQUAL?	ARG,M-LOOK \FALSE
	PRINTI	"In the northwest corner is an ancient door called a """
	PRINTD	PRIEST-DOOR
	PRINTI	"."" Another exit is east to the "
	PRINTD	BASEMENT
	PRINTR	"."


	.FUNCT	IRON-MAIDEN-F,X
	EQUAL?	PRSA,V?OPEN,V?CLOSE \?CCL3
	PRINTR	"It has no door!"
?CCL3:	EQUAL?	PRSA,V?LOOK-INSIDE,V?EXAMINE \?CCL7
	PRINTR	"The inner surface of this medieval torture device is covered with spikes. The space is just big enough to hold an unfortunate victim."
?CCL7:	EQUAL?	PRSA,V?PUT-IN \?CCL11
	CALL	WONT-HELP
	RSTACK	
?CCL11:	EQUAL?	PRSA,V?RUB,V?KISS \?CCL13
	PRINTR	"Ouch!"
?CCL13:	EQUAL?	PRSA,V?THROUGH,V?CLIMB-ON,V?BOARD \FALSE
	EQUAL?	WINNER,PLAYER /?PRG22
	PRINTR	"""No thank you!"""
?PRG22:	PRINTI	"As you step on the bottom of the "
	PRINTD	IRON-MAIDEN
	PRINTI	", it "
	EQUAL?	HERE,DUNGEON \?CCL26
	SET	'X,TOMB
	PRINTI	"sinks downward into"
	JUMP	?PRG31
?CCL26:	SET	'X,DUNGEON
	PRINTI	"rises again to"
?PRG31:	CALL	PRINTT,X
	PRINTI	". You step out again.
"
	MOVE	IRON-MAIDEN,X
	CALL	GOTO,X
	RTRUE	


	.FUNCT	COFFIN-F
	EQUAL?	PRSA,V?SIT,V?LIE,V?BOARD \?CCL3
	FSET?	COFFIN,OPENBIT /FALSE
	CALL	FIRST-YOU,STR?66,COFFIN
	RFALSE	
?CCL3:	EQUAL?	PRSA,V?CLOSE \?CCL7
	IN?	PLAYER,COFFIN \FALSE
	PRINTR	"The air is stifling, so you open it again."
?CCL7:	EQUAL?	PRSA,V?SEARCH-FOR /?CCL14
	EQUAL?	PRSA,V?SEARCH,V?LOOK-INSIDE,V?EXAMINE \FALSE
?CCL14:	IN?	CLUE-4,COFFIN \?CCL19
	FSET?	CLUE-4,SECRETBIT \?CCL19
	FSET?	COFFIN,OPENBIT /?CND22
	CALL	FIRST-YOU,STR?66,COFFIN
?CND22:	CALL	DISCOVER,CLUE-4,COFFIN
	RTRUE	
?CCL19:	IN?	PLAYER,COFFIN \FALSE
	PRINTI	"All you can see is "
	PRINTD	PLAYER
	PRINTR	"."


	.FUNCT	LOVER-PATH-LOSE-N
	CALL	LOVER-PATH-LOSE,P?NORTH
	RFALSE	


	.FUNCT	LOVER-PATH-LOSE,X
	CALL	HE-SHE-IT,WINNER,TRUE-VALUE,STR?256
	PRINTI	" to follow the path, but it's too tricky in the dim light"
	PRINTI	", so"
	CALL	HE-SHE-IT,WINNER,0,STR?161
	PRINTR	" back."


	.FUNCT	LOVER-PATH-F,RARG=0
	EQUAL?	RARG,M-LOOK \?CCL3
	PRINTI	"This is an area behind shrubbery by a steep cliff overlooking the sea. In the dim light, you can barely see a path leading north along the cliff. "
	CALL	LEVER-AND-DOOR,PRIEST-DOOR,P?OUT
	RTRUE	
?CCL3:	ZERO?	RARG \FALSE
	EQUAL?	PRSA,V?FOLLOW \FALSE
	CALL	DO-WALK,P?NORTH
	RTRUE	


	.FUNCT	CORR-2-F,RARG=0
	EQUAL?	RARG,M-LOOK \?CCL3
	PRINTI	"The "
	PRINTD	CORR-2
	PRINTI	" is lined with doors. To the west, a heavy oak door with ancient wrought-iron fittings b"
	FSET?	CREST,NDESCBIT \?PRG11
	PRINTI	"ears"
	JUMP	?PRG13
?PRG11:	PRINTI	"ore"
?PRG13:	PRINTI	" a bronze bas-relief of the "
	PRINT	TRESYLLIAN
	PRINTC	32
	PRINTD	CREST
	PRINTI	", marking this as the "
	PRINTD	JACK-ROOM
	PRINTR	" of the castle. Other doors lead to the northwest, east, northeast, and southeast. Stairways go up at the south end and down at the north end."
?CCL3:	EQUAL?	RARG,P?NORTH,P?DOWN,P?OUT \?CCL16
	PRINT	STAIRS-DOWN-LEFT
	RTRUE	
?CCL16:	EQUAL?	RARG,P?SOUTH,P?UP \FALSE
	PRINT	STAIRS-UP-RIGHT
	RTRUE	


	.FUNCT	CREST-F
	EQUAL?	PRSA,V?SEARCH,V?READ,V?EXAMINE \?CCL3
	PRINTI	"The "
	PRINTD	CREST
	PRINTI	" features a wyvern with wings raised."
	EQUAL?	VARIATION,LORD-C \?CND6
	PRINTR	" It seems to be loosely mounted on the door."
?CND6:	CRLF	
	RTRUE	
?CCL3:	EQUAL?	VARIATION,LORD-C \FALSE
	EQUAL?	PRSA,V?TAKE-OFF /?PRD16
	EQUAL?	PRSA,V?TAKE,V?REMOVE,V?MOVE-DIR /?PRD16
	EQUAL?	PRSA,V?MOVE,V?LOOK-UNDER,V?LOOK-BEHIND \?CCL14
?PRD16:	IN?	JACK-TAPE,HERE /?CCL14
	MOVE	JACK-TAPE,HERE
	FSET	CREST,TAKEBIT
	FCLEAR	CREST,NDESCBIT
	PRINTI	"By removing the "
	PRINTD	CREST
	PRINTI	" from its place, you can see that a small "
	PRINTD	JACK-TAPE
	PRINTR	" is built into the door."
?CCL14:	EQUAL?	PRSA,V?PUT \FALSE
	EQUAL?	PRSI,JACK-TAPE,JACK-ROOM \FALSE
	IN?	JACK-TAPE,HERE \FALSE
	MOVE	JACK-TAPE,LOCAL-GLOBALS
	FSET	CREST,NDESCBIT
	PRINTI	"The "
	PRINTD	CREST
	PRINTI	" fits neatly over the "
	PRINTD	JACK-TAPE
	PRINTR	"."


	.FUNCT	TV-PSEUDO
	EQUAL?	PRSA,V?LOOK-INSIDE,V?LAMP-ON,V?EXAMINE \?CCL3
	PRINTR	"It's boring compared to this mystery."
?CCL3:	EQUAL?	PRSA,V?LAMP-OFF \FALSE
	CALL	ALREADY,PRSO,STR?65
	RSTACK	


	.FUNCT	JACK-ROOM-F,RARG=0
	EQUAL?	RARG,M-BEG,M-EXIT \?CCL3
	CALL	SECRET-CHECK,RARG
	ZERO?	STACK \TRUE
	RFALSE	
?CCL3:	EQUAL?	RARG,P?SW,P?IN,P?DOWN \?CCL8
	CALL	ENTER-PASSAGE
	RTRUE	
?CCL8:	EQUAL?	RARG,M-LOOK \?CCL10
	PRINTI	"The "
	PRINTD	JACK-ROOM
	PRINTI	" has a canopied four-poster bed on a circular dais, a marble-topped console and mirror, two oversized "
	PRINTD	WARDROBE
	PRINTI	"s, cheval glass, tallboy, commode, overstuffed chair and color TV."
	CALL	OPEN-DOOR?,SECRET-JACK-DOOR
	CRLF	
	RTRUE	
?CCL10:	ZERO?	RARG \FALSE
	EQUAL?	PRSA,V?SEARCH,V?READ,V?EXAMINE \FALSE
	EQUAL?	HERE,CORR-2 \FALSE
	FSET?	CREST,NDESCBIT \FALSE
	CALL	PERFORM,PRSA,CREST,PRSI
	RTRUE	


	.FUNCT	NOT-FOUND,OBJ,WT=0
	EQUAL?	PRSA,V?WALK-TO \?CND1
	SET	'WT,TRUE-VALUE
?CND1:	ZERO?	WT \?PRG8
	SET	'CLOCK-WAIT,TRUE-VALUE
	PRINTI	"(Y"
	JUMP	?PRG10
?PRG8:	PRINTI	"But y"
?PRG10:	PRINTI	"ou haven't found"
	CALL	HIM-HER-IT,OBJ
	PRINTI	" yet!"
	ZERO?	WT \?CND12
	PRINTC	41
?CND12:	CRLF	
	RTRUE	


	.FUNCT	FREE-VERB?
	CALL	GAME-VERB?
	ZERO?	STACK \TRUE
	CALL	DIVESTMENT?,PRSO
	ZERO?	STACK \TRUE
	EQUAL?	PRSA,V?YES,V?YELL,V?WAIT-UNTIL /TRUE
	EQUAL?	PRSA,V?WAIT-FOR,V?SORRY,V?SLAP /TRUE
	EQUAL?	PRSA,V?SIT,V?SSHOW,V?SHOW /TRUE
	EQUAL?	PRSA,V?SHOOT,V?READ,V?PUSH /TRUE
	EQUAL?	PRSA,V?NO,V?LOOK-UP,V?LOOK-THROUGH /TRUE
	EQUAL?	PRSA,V?LOOK-OUTSIDE,V?LOOK-ON,V?LOOK-INSIDE /TRUE
	EQUAL?	PRSA,V?LOOK-DOWN,V?LOOK,V?LIE /TRUE
	EQUAL?	PRSA,V?KILL,V?INVENTORY,V?HELLO /TRUE
	EQUAL?	PRSA,V?EXAMINE,V?CHASTISE,V?ATTACK /TRUE
	RFALSE	


	.FUNCT	SECRET-CHECK,RARG=0,OBJ=0,PER=0,RM,GT
	EQUAL?	DISCOVERED-HERE,HERE \?CND1
	CALL	ZMEMQ,HERE,CHAR-ROOM-TABLE
	SUB	STACK,1
	GET	CHARACTER-TABLE,STACK >PER
	FSET?	PER,MUNGBIT /?CCL4
	EQUAL?	PER,CONFESSED /?CCL4
	CALL	META-LOC,PER
	EQUAL?	STACK,HERE /?CND1
?CCL4:	SET	'PER,FALSE-VALUE
?CND1:	EQUAL?	RARG,M-BEG \?CCL10
	EQUAL?	PRSA,V?WALK /FALSE
	EQUAL?	PRSA,V?THROUGH,V?FOLLOW,V?WALK-TO \?CCL13
	CALL	META-LOC,PRSO
	EQUAL?	HERE,STACK \FALSE
?CCL13:	ZERO?	PER /FALSE
	GETP	PER,P?LINE
	ZERO?	STACK \?PRD22
	EQUAL?	PRSA,V?SEARCH-FOR,V?SEARCH \FALSE
?PRD22:	EQUAL?	PER,PRSO,PRSI /FALSE
	CALL	FREE-VERB?
	ZERO?	STACK \FALSE
	CALL	START-SENTENCE,PER
	PRINTI	" prevents"
	CALL	HIM-HER-IT,WINNER,FALSE-VALUE,TRUE-VALUE
	PRINTR	" action!"
?CCL10:	EQUAL?	RARG,M-EXIT \FALSE
	ZERO?	PER /FALSE
	CALL	GENERIC-CLOSET,0 >RM
	GETP	PER,P?CHARACTER
	GET	GOAL-TABLES,STACK >GT
	EQUAL?	PRSA,V?WALK \?CCL34
	SET	'OBJ,PRSO
	JUMP	?CND32
?CCL34:	EQUAL?	PRSA,V?THROUGH,V?FOLLOW,V?WALK-TO \?CND32
	CALL	META-LOC,PRSO >OBJ
	EQUAL?	OBJ,HERE /FALSE
	EQUAL?	OBJ,LOCAL-GLOBALS \?CCL38
	FSET?	PRSO,DOORBIT \FALSE
?CCL38:	EQUAL?	PRSA,V?THROUGH \?CCL44
	EQUAL?	OBJ,RM,LOCAL-GLOBALS \?CND45
	GET	GT,GOAL-F
	CALL	ESTABLISH-GOAL,PER,STACK
	SET	'DISCOVERED-HERE,FALSE-VALUE
	RFALSE	
?CND45:	SET	'OBJ,P?OUT
	JUMP	?CND32
?CCL44:	CALL	DIR-FROM,HERE,OBJ >OBJ
?CND32:	CALL	DIR-EQV?,HERE,OBJ,P?OUT
	ZERO?	STACK /?CND47
	GETP	PER,P?LINE
	ZERO?	STACK /?CND47
	CALL	HE-SHE-IT,PER,TRUE-VALUE
	PRINTI	" blocks"
	CALL	HIM-HER-IT,WINNER,FALSE-VALUE,TRUE-VALUE
	PRINTR	" exit!"
?CND47:	EQUAL?	PER,GHOST-NEW \?CND53
	MOVE	PER,RM
?CND53:	GET	GT,GOAL-F
	CALL	ESTABLISH-GOAL,PER,STACK
	SET	'DISCOVERED-HERE,FALSE-VALUE
	RFALSE	


	.FUNCT	OPEN-SECRET,ACT,OBJ,DR
	PRINTI	"As"
	CALL	HE-SHE-IT,WINNER,FALSE-VALUE,ACT
	ZERO?	ACT \?CND3
	PRINTC	32
	CALL	VERB-PRINT
?CND3:	GRTR?	OBJ,0 \?CCL9
	LESS?	OBJ,256 \?CCL9
	CALL	PRINTT,OBJ
	FCLEAR	OBJ,SECRETBIT
	JUMP	?PRG14
?CCL9:	PRINT	OBJ
?PRG14:	PRINTC	44
	FSET?	DR,TOUCHBIT /?PRG37
	FSET	DR,TOUCHBIT
	CALL	QUEUE,I-FOUND-PASSAGES,1
	CALL	GENERIC-CLOSET,0 >ACT
	ZERO?	ACT /?CCL22
	PUT	FOUND-PASSAGES,PLAYER-C,ACT
	JUMP	?CND20
?CCL22:	PUT	FOUND-PASSAGES,PLAYER-C,TRUE-VALUE
?CND20:	FSET	PASSAGE,SEENBIT
	EQUAL?	OBJ,HISTORY-BOOK \?PRG28
	FSET	HISTORY-BOOK,TAKEBIT
	FCLEAR	HISTORY-BOOK,TRYTAKEBIT
	CALL	PRINTT,BOOKCASE
	JUMP	?CND16
?PRG28:	PRINTI	" a section of the "
	EQUAL?	OBJ,WYVERN \?PRG35
	PRINTD	WYVERN
	JUMP	?CND16
?PRG35:	PRINTI	"wall"
	JUMP	?CND16
?PRG37:	CALL	PRINTT,DR
?CND16:	CALL	OPEN-CLOSE,DR,FALSE-VALUE
	RSTACK	


	.FUNCT	TELESCOPE-F
	EQUAL?	PRSA,V?LOOK-THROUGH,V?LOOK-INSIDE \?CCL3
	PRINTR	"All you can see is the wall."
?CCL3:	EQUAL?	PRSA,V?TURN,V?TAKE,V?PUSH /?CCL7
	EQUAL?	PRSA,V?MOVE-DIR,V?MOVE,V?AIM \FALSE
?CCL7:	CALL	OPEN-SECRET,STR?259,TELESCOPE,SECRET-JACK-DOOR
	RSTACK	


	.FUNCT	LIBRARY-F,RARG=0
	EQUAL?	RARG,M-BEG \?CCL3
	CALL	SECRET-CHECK,RARG
	RSTACK	
?CCL3:	EQUAL?	RARG,P?NE,P?IN \?CCL5
	CALL	ENTER-PASSAGE
	RTRUE	
?CCL5:	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"Dusty bookcases tower all around you. There is a table with reading lamp and chair, and an armchair near the "
	PRINTD	FIREPLACE
	PRINTC	46
	CALL	OPEN-DOOR?,SECRET-LIBRARY-DOOR
	CRLF	
	RTRUE	


	.FUNCT	BOOKS-GLOBAL-F,X
	EQUAL?	PRSA,V?TAKE /?PRG6
	EQUAL?	PRSA,V?READ,V?OPEN,V?LOOK-INSIDE \?CCL3
?PRG6:	PRINTR	"You pick one at random. It's frightfully obscure, so you put it back."
?CCL3:	EQUAL?	PRSA,V?SEARCH-FOR,V?SEARCH,V?EXAMINE \FALSE
	PRINTI	"Some of the books date as far back as the 16th century. Although some are fiction, most of the books are scientific, covered with vellum or leather. Some are in foreign languages, and many have pictures of skulls or spirits."
	CRLF	
	CALL	FIND-FLAG,BOOKCASE,SECRETBIT >X
	ZERO?	X /?CCL14
	CALL	DISCOVER,X
	RTRUE	
?CCL14:	FIRST?	BOOKCASE >X \?CCL16
	FSET	X,TAKEBIT
	FCLEAR	X,NDESCBIT
	CALL	START-SENTENCE,X
	PRINTR	" catches your eye."
?CCL16:	IN?	JOURNAL,TABLE-LIBRARY \TRUE
	FCLEAR	JOURNAL,SECRETBIT
	PRINTI	"There are many books of adventure and exploration, as well as the bound volumes of "
	PRINTD	COUSIN
	PRINTR	"'s expedition journals."


	.FUNCT	BOOKCASE-F,X
	EQUAL?	PRSA,V?SEARCH,V?LOOK-INSIDE,V?EXAMINE \?CCL3
	CALL	PERFORM,V?EXAMINE,BOOKS-GLOBAL
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?TURN /?CCL5
	EQUAL?	PRSA,V?PUSH,V?MOVE-DIR,V?MOVE \FALSE
?CCL5:	FSET?	SECRET-LIBRARY-DOOR,OPENBIT \FALSE
	CALL	OPEN-SECRET,STR?261,BOOKCASE,SECRET-LIBRARY-DOOR
	RTRUE	


	.FUNCT	HISTORY-BOOK-F
	EQUAL?	PRSA,V?MOVE-DIR,V?MOVE /?CTR2
	EQUAL?	PRSA,V?PUT-IN \?CCL3
	EQUAL?	PRSI,BOOKCASE \?CCL3
	MOVE	HISTORY-BOOK,BOOKCASE
?CTR2:	CALL	OPEN-SECRET,STR?261,HISTORY-BOOK,SECRET-LIBRARY-DOOR
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?TAKE,V?READ /?CCL10
	EQUAL?	PRSA,V?LOOK-UP,V?OPEN,V?EXAMINE \FALSE
?CCL10:	IN?	HISTORY-BOOK,BOOKCASE \?CCL15
	MOVE	HISTORY-BOOK,WINNER
	CALL	OPEN-SECRET,STR?261,HISTORY-BOOK,SECRET-LIBRARY-DOOR
	RTRUE	
?CCL15:	EQUAL?	PRSA,V?TAKE /FALSE
	CALL	NOT-HOLDING?,HISTORY-BOOK
	ZERO?	STACK \TRUE
	PRINTI	"This book contains a detailed history of "
	PRINTD	CASTLE
	PRINTI	" and the "
	PRINT	TRESYLLIAN
	PRINTI	" family, including the bitter fate of Lady Arabella "
	PRINT	TRESYLLIAN
	PRINTI	", who was accused of infidelity and, by her husband's command, was buried alive in the wall of the tower keep. The book also describes the layout of the tower and residential wing, including the various rooms and "
	PRINTD	PASSAGE
	PRINTR	"s."


	.FUNCT	JOURNAL-F
	EQUAL?	PRSA,V?READ /?CCL3
	EQUAL?	PRSA,V?OPEN,V?LOOK-INSIDE,V?EXAMINE \FALSE
?CCL3:	CALL	NOT-HOLDING?,PRSO
	ZERO?	STACK \TRUE
	PRINTI	"This is a journal of Lionel's "
	EQUAL?	VARIATION,LORD-C \?CCL12
	PRINTI	"African"
	JUMP	?PRG21
?CCL12:	EQUAL?	VARIATION,DOCTOR-C \?PRG19
	PRINTI	"Amazon"
	JUMP	?PRG21
?PRG19:	PRINTI	"South Pacific"
?PRG21:	PRINTI	" expedition. As you leaf through it, "
	EQUAL?	VARIATION,PAINTER-C \?PRG27
	PRINTR	"no clues appear."
?PRG27:	PRINTI	"you find a description of a treasure: "
	EQUAL?	VARIATION,LORD-C \?CCL31
	CALL	DESCRIBE-WAR-CLUB
	PRINTR	"It also served as his royal sceptre."
?CCL31:	EQUAL?	VARIATION,FRIEND-C \?PRG38
	PRINTI	"a "
	PRINTD	NECKLACE
	PRINTR	"."
?PRG38:	PRINTD	MOONMIST
	PRINTI	", a drug taken from a rare Amazon plant called the Moonflower. The natives use it to tip their"
	PRINT	POISON-DART
	PRINTI	"s, but it could also be a valuable medicine. They insist that the plant should be gathered only when the "
	PRINTD	MOON
	PRINTI	" is misted over."
	CRLF	
	IN?	MOONMIST,INKWELL \TRUE
	FSET?	INKWELL,TOUCHBIT \TRUE
	FCLEAR	MOONMIST,SECRETBIT
	RTRUE	


	.FUNCT	OFFICE-F,ARG=0
	EQUAL?	ARG,M-LOOK \FALSE
	PRINTI	"This small office gets little light and less air. In one corner is a computer. By the "
	PRINTD	FIREPLACE
	PRINTI	", there is a tall "
	PRINTD	DESK
	PRINTI	" with"
	FIRST?	DESK \?PRG10
	CALL	PRINT-CONTENTS,DESK
	PRINTI	", and"
?PRG10:	PRINTR	" a tall stool."


	.FUNCT	INKWELL-F
	IN?	MOONMIST,INKWELL \FALSE
	EQUAL?	PRSA,V?EMPTY \?CCL6
	FCLEAR	MOONMIST,SECRETBIT
	CALL	PERFORM,V?POUR,MOONMIST,PRSI
	RTRUE	
?CCL6:	EQUAL?	PRSA,V?SEARCH-FOR,V?SEARCH /?CCL8
	EQUAL?	PRSA,V?OPEN,V?LOOK-INSIDE,V?EXAMINE \FALSE
?CCL8:	FSET?	MOONMIST,SECRETBIT \FALSE
	CALL	DISCOVER,MOONMIST
	RTRUE	


	.FUNCT	COMPUTER-F
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTR	"It looks just like the computer you're using now!"
?CCL3:	EQUAL?	PRSA,V?LAMP-OFF \?CCL7
	CALL	OKAY,COMPUTER,STR?65
	RTRUE	
?CCL7:	EQUAL?	PRSA,V?USE,V?PLAY,V?LAMP-ON \FALSE
	CALL	HE-SHE-IT,COMPUTER,TRUE-VALUE
	PRINTI	" starts running an interactive mystery from Infocom called """
	EQUAL?	VARIATION,LORD-C \?CCL15
	PRINTI	"DEADLINE (R"
	JUMP	?PRG28
?CCL15:	EQUAL?	VARIATION,PAINTER-C \?CCL19
	PRINTI	"THE WITNESS (R"
	JUMP	?PRG28
?CCL19:	EQUAL?	VARIATION,FRIEND-C \?PRG26
	PRINTI	"SUSPECT (TM"
	JUMP	?PRG28
?PRG26:	PRINTI	"BALLYHOO (TM"
?PRG28:	PRINTI	"),"" but you decide that "
	PRINTD	MOONMIST
	PRINTR	" (TM) is easier, so you turn it off."


	.FUNCT	TAMARA-ROOM-F,RARG=0
	EQUAL?	RARG,M-BEG,M-EXIT \?CCL3
	CALL	SECRET-CHECK,RARG
	RSTACK	
?CCL3:	EQUAL?	RARG,P?SE,P?IN,P?DOWN \?CCL5
	CALL	ENTER-PASSAGE
	RTRUE	
?CCL5:	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"The room is utterly feminine in its decoration, yet neater than you might expect for a young woman of "
	PRINTD	FRIEND
	PRINTI	"'s age. "
	CALL	DRESSING-TABLE-TAM
	CALL	OPEN-DOOR?,SECRET-TAMARA-DOOR
	CRLF	
	RTRUE	


	.FUNCT	DRESSING-TABLE-TAM
	PRINTI	"Even her "
	PRINTD	DRESSING-TABLE-LG
	PRINTI	" is in apple-pie order, with her hand mirror, comb, brush, makeup kit and "
	PRINTD	JEWELRY-CASE
	PRINTI	" all precisely placed on its gleaming surface."
	RTRUE	


	.FUNCT	TAMARA-BED-F,OBJ
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	PRINTD	FRIEND
	PRINTR	" has a curtained four-poster bed on a circular dais. You notice that the knob on one bedpost looks loose."
?CCL3:	EQUAL?	PRSA,V?SEARCH,V?LOOK-UNDER \?CCL7
	CALL	FIND-FLAG,TAMARA-BED,NDESCBIT,PLAYER >OBJ
	ZERO?	OBJ /FALSE
	CALL	DISCOVER,OBJ
	RSTACK	
?CCL7:	EQUAL?	PRSA,V?PUT-UNDER \?CCL12
	EQUAL?	PRSI,TAMARA-BED \FALSE
	FSET	PRSO,NDESCBIT
	MOVE	PRSO,TAMARA-BED
	CALL	OKAY
	RSTACK	
?CCL12:	EQUAL?	PRSA,V?TURN,V?RUB /?CCL17
	EQUAL?	PRSA,V?PUSH,V?MOVE-DIR,V?MOVE \FALSE
?CCL17:	CALL	OPEN-SECRET,STR?161,STR?162,SECRET-TAMARA-DOOR
	RSTACK	


	.FUNCT	JEWELRY-CASE-F
	EQUAL?	PRSA,V?TAKE \?CCL3
	EQUAL?	PRSO,JEWELRY-CASE \FALSE
	CALL	YOU-SHOULDNT
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?OPEN,V?LOOK-INSIDE,V?EXAMINE \FALSE
	CALL	TELL-AS-WELL-AS,JEWELRY-CASE,STR?262
	IN?	EARRING,JEWELRY-CASE \TRUE
	FSET?	EARRING,NDESCBIT \TRUE
	FCLEAR	EARRING,NDESCBIT
	FCLEAR	EARRING,SECRETBIT
	CALL	THIS-IS-IT,EARRING
	PRINTI	"Almost the first thing you notice is a delicate "
	PRINTD	EARRING
	PRINTR	"."


	.FUNCT	EARRING-F
	EQUAL?	PRSA,V?PUT-IN /?PRD5
	EQUAL?	PRSA,V?PUT,V?HOLD-UP,V?COMPARE \FALSE
?PRD5:	EQUAL?	JEWEL,PRSO,PRSI \FALSE
	FSET	EARRING,LOCKED
	PRINTI	"The jewel fits the empty "
	PRINTD	EARRING
	PRINTI	" perfectly."
	EQUAL?	PRSA,V?PUT-IN,V?PUT \?CND10
	PRINTI	" You remove the jewel again."
?CND10:	CRLF	
	ZERO?	EVIDENCE-FOUND \TRUE
	CALL	CONGRATS
	RTRUE	


	.FUNCT	CORR-3-F,RARG=0
	EQUAL?	RARG,M-LOOK \?CCL3
	PRINTI	"The "
	PRINTD	CORR-3
	PRINTR	" has doors leading to the north, south, and southeast. Stairways go up at the east end and down at the west end."
?CCL3:	EQUAL?	RARG,P?WEST,P?DOWN,P?OUT \?CCL7
	PRINT	STAIRS-DOWN-LEFT
	RTRUE	
?CCL7:	EQUAL?	RARG,P?EAST,P?UP \FALSE
	PRINT	STAIRS-UP-RIGHT
	RTRUE	


	.FUNCT	CAGE-PSEUDO
	EQUAL?	PRSA,V?OPEN,V?LOOK-INSIDE \?CCL3
	PRINTR	"It's empty."
?CCL3:	CALL	RANDOM-PSEUDO
	RSTACK	


	.FUNCT	LUMBER-ROOM-F,RARG=0
	EQUAL?	RARG,M-BEG \?CCL3
	CALL	SECRET-CHECK,RARG
	ZERO?	STACK \TRUE
	EQUAL?	PRSA,V?LOOK-DOWN \FALSE
	FSET?	LUMBER-RING,TOUCHBIT \?CCL11
	CALL	PERFORM,V?LOOK-THROUGH,PEEPHOLE-2
	RTRUE	
?CCL11:	FSET?	LUMBER-CHEST,TOUCHBIT \FALSE
	CALL	PERFORM,V?MOVE,LUMBER-RING
	RTRUE	
?CCL3:	EQUAL?	RARG,M-ENTER \?CCL15
	IN?	PEEPHOLE-2,LUMBER-ROOM \FALSE
	PUTP	LUMBER-ROOM,P?CORRIDOR,4
	RFALSE	
?CCL15:	EQUAL?	RARG,M-EXIT \?CCL19
	PUTP	LUMBER-ROOM,P?CORRIDOR,0
	RFALSE	
?CCL19:	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is lumber in the British sense, meaning useless stuff like old "
	PRINTD	MAGAZINE
	PRINTI	"s, an ornate bird cage, an "
	PRINTD	LUMBER-CHEST
	PRINTR	" from the 1700's, and a broken Victorian hobby horse."


	.FUNCT	LUMBER-CHEST-F
	EQUAL?	PRSA,V?OPEN,V?LOOK-INSIDE \?CCL3
	CALL	TOO-BAD-BUT,PRSO,STR?264
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?TURN /?CCL5
	EQUAL?	PRSA,V?PUSH,V?MOVE-DIR,V?MOVE \FALSE
?CCL5:	IN?	LUMBER-RING,LUMBER-ROOM /FALSE
	MOVE	LUMBER-RING,LUMBER-ROOM
	PRINTI	"You reveal"
	CALL	PRINTT,LUMBER-RING
	PRINTR	" in the stone floor."


	.FUNCT	LUMBER-RING-F,P
	EQUAL?	PRSA,V?TAKE,V?PUSH /?CTR2
	EQUAL?	PRSA,V?OPEN,V?MOVE-DIR,V?MOVE \?CCL3
?CTR2:	IN?	PEEPHOLE-2,LUMBER-ROOM \?CND6
	CALL	ALREADY,LUMBER-RING,STR?66
	RTRUE	
?CND6:	MOVE	PEEPHOLE-2,LUMBER-ROOM
	PUTP	LUMBER-ROOM,P?CORRIDOR,4
	PRINTI	"As you pull up on"
	CALL	PRINTT,LUMBER-RING
	PRINTI	", you reveal"
	CALL	PRINTT,PEEPHOLE-2
	PRINTI	", enabling you to peer directly downward at "
	PRINTD	TAMARA-ROOM
	PRINTI	" below.
"
	CALL	FIND-FLAG-HERE-NOT,PERSONBIT,MUNGBIT,PLAYER >P
	ZERO?	P /TRUE
	CALL	HE-SHE-IT,P,TRUE-VALUE
	PRINTI	" says, ""So that explains the ghostly face that "
	EQUAL?	P,FRIEND \?PRG19
	PRINTC	73
	JUMP	?PRG21
?PRG19:	PRINTD	FRIEND
?PRG21:	PRINTR	" saw peering down that night."""
?CCL3:	EQUAL?	PRSA,V?CLOSE \FALSE
	IN?	PEEPHOLE-2,LUMBER-ROOM /?CND25
	CALL	ALREADY,LUMBER-RING,STR?61
	RTRUE	
?CND25:	MOVE	PEEPHOLE-2,LOCAL-GLOBALS
	PUTP	LUMBER-ROOM,P?CORRIDOR,0
	CALL	OKAY,LUMBER-RING,STR?61
	RTRUE	


	.FUNCT	PEEPHOLE-2-F
	EQUAL?	PRSA,V?LOOK-THROUGH /?CTR2
	EQUAL?	PRSA,V?LOOK-OUTSIDE,V?LOOK-INSIDE,V?EXAMINE \?CCL3
?CTR2:	CALL	ROOM-PEEK,TAMARA-ROOM,TRUE-VALUE
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?THROUGH \FALSE
	CALL	TOO-BAD-BUT,PEEPHOLE-2,STR?265
	RTRUE	


	.FUNCT	MAGAZINE-F
	EQUAL?	PRSA,V?READ /?CCL3
	EQUAL?	PRSA,V?OPEN,V?LOOK-INSIDE,V?EXAMINE \FALSE
?CCL3:	CALL	NOT-HOLDING?,PRSO
	ZERO?	STACK \TRUE
	PRINTI	"This is a"
	EQUAL?	VARIATION,PAINTER-C \?PRG15
	PRINTR	" copy of ""Reader's Digest"" for Sept. 1976. As you leaf through it, you find an article about the skull of Peking Man, which disappeared after the Pearl Harbor Attack, when it was shipped from China. Once it was mysteriously offered for sale for a million dollars, as reported in the New York Times."
?PRG15:	PRINTR	"n old copy of ""Punch,"" good for a laugh or two."


	.FUNCT	CHAPEL-F,RARG=0
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"A bare and austere yet poignantly atmospheric relic of the medieval past, the chapel contains an altar, pulpit, font, and family pews of elaborately carved oak. The most memorable feature is a splendid "
	PRINTD	STAINED-WINDOW
	PRINTI	". "
	GETP	STAINED-WINDOW,P?TEXT
	PRINT	STACK
	CRLF	
	RTRUE	


	.FUNCT	STAINED-WINDOW-F
	EQUAL?	PRSA,V?SEARCH-FOR /?PRD5
	EQUAL?	PRSA,V?SEARCH,V?TAKE,V?EXAMINE \?CCL3
?PRD5:	IN?	CLUE-3,STAINED-WINDOW \?CCL3
	FSET?	CLUE-3,SECRETBIT \?CCL3
	CALL	DISCOVER,CLUE-3
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?MUNG \FALSE
	CALL	YOU-SHOULDNT
	RSTACK	


	.FUNCT	BILLIARD-PSEUDO
	EQUAL?	PRSA,V?LOOK-ON \?CCL3
	CALL	WONT-HELP
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?PLAY \FALSE
	CALL	HE-SHE-IT,WINNER,TRUE-VALUE,STR?267
	PRINTR	" the balls around for a minute before getting bored."


	.FUNCT	BUFFALO-HEAD-F
	CALL	NOUN-USED?,W?EYE
	ZERO?	STACK /FALSE
	CALL	ADJ-USED?,FALSE-VALUE
	ZERO?	STACK /FALSE
	CALL	VISIBLE?,GLASS-EYE
	ZERO?	STACK /FALSE
	CALL	DO-INSTEAD-OF,GLASS-EYE,BUFFALO-HEAD
	RTRUE	


	.FUNCT	RHINO-HEAD-F
	EQUAL?	PRSA,V?FIX,V?LOOK-INSIDE,V?OPEN /?CCL3
	EQUAL?	PRSA,V?SEARCH-FOR,V?SEARCH,V?EXAMINE \FALSE
?CCL3:	IN?	CLUE-3,RHINO-HEAD \FALSE
	FSET?	CLUE-3,SECRETBIT \FALSE
	FSET	GLASS-EYE,TAKEBIT
	FCLEAR	GLASS-EYE,TRYTAKEBIT
	FCLEAR	GLASS-EYE,NDESCBIT
	FSET	GLASS-EYE,SEENBIT
	PRINTI	"There's something odd about this trophy. One of the "
	PRINTD	GLASS-EYE
	PRINTR	"s is backwards."


	.FUNCT	GLASS-EYE-F
	EQUAL?	PRSO,GLASS-EYE \FALSE
	IN?	RHINO-HEAD,HERE \FALSE
	EQUAL?	PRSA,V?TAKE /?CCL3
	EQUAL?	PRSA,V?SEARCH-FOR,V?SEARCH,V?OPEN /?CCL3
	EQUAL?	PRSA,V?MOVE-DIR,V?MOVE,V?LOOK-INSIDE /?CCL3
	EQUAL?	PRSA,V?LOOK-BEHIND,V?FIX,V?EXAMINE \FALSE
?CCL3:	IN?	CLUE-3,RHINO-HEAD \FALSE
	FSET	RHINO-HEAD,OPENBIT
	FCLEAR	GLASS-EYE,NDESCBIT
	FCLEAR	GLASS-EYE,TRYTAKEBIT
	FSET	GLASS-EYE,TAKEBIT
	EQUAL?	PRSA,V?TAKE \?CND15
	CALL	V-TAKE
?CND15:	CALL	DISCOVER,CLUE-3
	RTRUE	


	.FUNCT	DECK-F,RARG=0
	EQUAL?	RARG,M-LOOK \?CCL3
	PRINTR	"The ""roof"" of the tower keep has a stone floor and battlements all around. Far below, the faint sound of the sea cries from the darkness. In the moonlight you see a huge bell mounted on a heavy frame."
?CCL3:	EQUAL?	RARG,P?SOUTH,P?DOWN,P?IN \FALSE
	PRINT	STAIRS-DOWN-LEFT
	RTRUE	


	.FUNCT	BELL-F,N=0,P,GT
	EQUAL?	PRSA,V?TURN /?CTR2
	EQUAL?	PRSA,V?PUSH,V?MOVE-DIR,V?MOVE \?CCL3
?CTR2:	CALL	TOO-BAD-BUT,BELL,STR?269
	RSTACK	
?CCL3:	EQUAL?	PRSA,V?SEARCH-FOR,V?SEARCH /?CTR6
	EQUAL?	PRSA,V?LOOK-UNDER,V?LOOK-INSIDE,V?EXAMINE \?CCL7
?CTR6:	EQUAL?	VARIATION,PAINTER-C \?CCL12
	FSET?	SKULL,SECRETBIT \?CCL12
	CALL	DISCOVER,SKULL
	RTRUE	
?CCL12:	IN?	CLUE-3,BELL \?CCL16
	FSET?	CLUE-3,SECRETBIT \?CCL16
	CALL	DISCOVER,CLUE-3
	RTRUE	
?CCL16:	CALL	TELL-AS-WELL-AS,BELL,STR?270
	RTRUE	
?CCL7:	EQUAL?	PRSA,V?RING \FALSE
	ZERO?	PLAYER-RANG-BELL? \?CND21
	IN?	BUTLER,LOCAL-GLOBALS /?CCL25
	IN?	BUTLER,KITCHEN /?CND21
	CALL	GO-TO-SOUND,KITCHEN,BUTLER
	JUMP	?CND21
?CCL25:	ZERO?	LIONEL-SPEAKS-COUNTER \?CND21
	SET	'MASS-SAID,FALSE-VALUE
?PRG29:	IGRTR?	'N,DEB-C /?CND21
	GET	CHARACTER-TABLE,N >P
	EQUAL?	P,CONFESSED,CAPTOR /?PRG29
	EQUAL?	P,GHOST-NEW,SEARCHER /?PRG29
	CALL	GO-TO-SOUND,DECK,P
	JUMP	?PRG29
?CND21:	SET	'PLAYER-RANG-BELL?,TRUE-VALUE
	PRINTI	"Its deep booming ""gong"" can be felt in every room of the castle."
	CRLF	
	EQUAL?	HERE,DECK \TRUE
	CALL	FIND-FLAG-HERE-NOT,PERSONBIT,MUNGBIT,PLAYER >P
	ZERO?	P /TRUE
	PRINTD	P
	PRINTI	" whispers, ""That's "
	FIRST?	BELL \?PRG49
	PRINTI	"not "
?PRG49:	PRINTR	"too loud for comfort!"""


	.FUNCT	GO-TO-SOUND,RM,P,GT,GF,L
	LOC	P >L
	IN?	P,RM /FALSE
	FSET?	P,MUNGBIT /FALSE
	GETP	P,P?CHARACTER
	GET	GOAL-TABLES,STACK >GT
	GET	GT,GOAL-FUNCTION >GF
	EQUAL?	P,BUTLER \?CND6
	EQUAL?	GF,X-TO-BELL /?CND6
	SET	'BUTLER-DUTY,GF
?CND6:	PUT	GT,GOAL-FUNCTION,X-TO-BELL
	CALL	IN-MOTION?,P,TRUE-VALUE
	ZERO?	STACK /?CCL12
	GET	GT,GOAL-F
	PUT	GT,GOAL-QUEUED,STACK
	JUMP	?CND10
?CCL12:	PUT	GT,GOAL-QUEUED,L
?CND10:	RANDOM	2
	EQUAL?	STACK,1 \?CND13
	FSET?	RM,WEARBIT \?PRD18
	FSET?	L,WEARBIT \?CCL14
?PRD18:	FSET?	RM,WEARBIT /?CND13
	FSET?	L,WEARBIT \?CND13
?CCL14:	MOVE	P,JUNCTION
?CND13:	CALL	ESTABLISH-GOAL,P,RM
	RSTACK	


	.FUNCT	X-TO-BELL,GARG=0,L,GT
	LOC	GOAL-PERSON >L
	GETP	GOAL-PERSON,P?CHARACTER
	GET	GOAL-TABLES,STACK >GT
	EQUAL?	GARG,G-REACHED /?CCL3
	EQUAL?	L,HERE \FALSE
?CCL3:	LESS?	BED-TIME,PRESENT-TIME \?CND6
	CALL	QUEUE,I-BEDTIME,15
?CND6:	GET	GT,ATTENTION-SPAN
	PUT	GT,ATTENTION,STACK
	EQUAL?	GOAL-PERSON,BUTLER \?CCL10
	PUT	GT,GOAL-FUNCTION,BUTLER-DUTY
	JUMP	?CND8
?CCL10:	PUT	GT,GOAL-FUNCTION,NULL-F
?CND8:	PUTP	GOAL-PERSON,P?LDESC,4
	EQUAL?	L,HERE \FALSE
	ZERO?	MASS-SAID \FALSE
	SET	'MASS-SAID,TRUE-VALUE
	CALL	HE-SHE-IT,GOAL-PERSON,TRUE-VALUE
	PRINTI	" appears and says, ""What's all this, then?""
"
	RETURN	2


	.FUNCT	LADDER-F,U=0,D=0
	EQUAL?	PRSA,V?CLIMB-DOWN \?CCL3
	CALL	DO-WALK,P?DOWN
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?CLIMB-UP \?CCL5
	CALL	DO-WALK,P?UP
	RTRUE	
?CCL5:	EQUAL?	PRSA,V?CLIMB-ON,V?BOARD \FALSE
	GETPT	HERE,P?UP >U
	ZERO?	U /?CND8
	PTSIZE	U
	EQUAL?	STACK,UEXIT /?CND8
	SET	'U,FALSE-VALUE
?CND8:	GETPT	HERE,P?DOWN >D
	ZERO?	D /?CND12
	PTSIZE	D
	EQUAL?	STACK,UEXIT /?CND12
	SET	'D,FALSE-VALUE
?CND12:	ZERO?	U \?CCL18
	CALL	DO-WALK,P?DOWN
	RTRUE	
?CCL18:	ZERO?	D \?CCL20
	CALL	DO-WALK,P?UP
	RTRUE	
?CCL20:	SET	'CLOCK-WAIT,TRUE-VALUE
	PRINTC	40
	PRINT	WHICH-DIR
	PRINTR	")"


	.FUNCT	LEVER-AND-DOOR,DR,DIR
	FSET	DR,SEENBIT
	PRINTC	65
	FSET?	DR,OPENBIT \?PRG7
	PRINTI	"n open"
?PRG7:	PRINTC	32
	PRINTD	DR
	PRINTI	" and a lever are on the "
	CALL	DIR-PRINT,DIR
	PRINTR	" wall."


	.FUNCT	SECRET-LANDING-JACK-F,RARG=0
	EQUAL?	RARG,M-LOOK \FALSE
	CALL	PASSAGE-DESC?,JACK-ROOM
	CALL	LEVER-AND-DOOR,SECRET-JACK-DOOR,P?IN
	PRINTR	"Stone steps curve down to the east."


	.FUNCT	PASSAGE-1-F,RARG=0
	EQUAL?	RARG,M-LOOK \?CCL3
	PRINTI	"Stone steps lead west, a "
	PRINTD	PASSAGE
	PRINTI	" leads east, and a ladder leads straight up"
	PRINT	INTO-DARKNESS
	RTRUE	
?CCL3:	EQUAL?	RARG,P?WEST,P?OUT,P?SW \FALSE
	PRINT	STAIRS-UP-RIGHT
	RTRUE	


	.FUNCT	SECRET-LANDING-TAM-F,RARG=0
	EQUAL?	RARG,M-LOOK \FALSE
	CALL	PASSAGE-DESC?,TAMARA-ROOM
	CALL	LEVER-AND-DOOR,SECRET-TAMARA-DOOR,P?IN
	PRINT	SECRET-TAM-LIB
	PRINTI	"north"
	PRINT	INTO-DARKNESS
	RTRUE	


	.FUNCT	SECRET-VIVIEN-PASSAGE-F,RARG=0
	EQUAL?	RARG,M-LOOK \?CCL3
	CALL	PASSAGE-DESC?,VIVIEN-ROOM
	CALL	LEVER-AND-DOOR,SECRET-VIVIEN-DOOR,P?NORTH
	PRINTI	"A "
	PRINTD	PASSAGE
	PRINTI	" leads west and east"
	PRINT	INTO-DARKNESS
	RTRUE	
?CCL3:	EQUAL?	RARG,P?EAST \FALSE
	PRINTI	"The "
	PRINTD	PASSAGE
	PRINTR	" turns north at the corner of the building."


	.FUNCT	DINING-PASSAGE-F,RARG=0
	EQUAL?	RARG,M-LOOK \FALSE
	CALL	LEVER-AND-DOOR,SECRET-DINING-DOOR,P?EAST
	PRINTI	"A ladder leads up"
	PRINT	INTO-DARKNESS
	RTRUE	


	.FUNCT	SECRET-LANDING-LIB-F,RARG=0
	EQUAL?	RARG,M-LOOK \FALSE
	CALL	PASSAGE-DESC?,LIBRARY
	CALL	LEVER-AND-DOOR,SECRET-LIBRARY-DOOR,P?IN
	PRINT	SECRET-TAM-LIB
	PRINTI	"south"
	PRINT	INTO-DARKNESS
	RTRUE	


	.FUNCT	SECRET-IAN-PASSAGE-F,RARG=0
	EQUAL?	RARG,M-LOOK \FALSE
	CALL	PASSAGE-DESC?,IAN-ROOM
	CALL	LEVER-AND-DOOR,SECRET-IAN-DOOR,P?SOUTH
	PRINT	PASSAGE-EAST-WEST
	RTRUE	


	.FUNCT	SITTING-PASSAGE-F,RARG=0
	EQUAL?	RARG,M-LOOK \FALSE
	FSET	SECRET-SITTING-DOOR,SEENBIT
	CALL	PASSAGE-DESC?,SITTING-ROOM
	CALL	SITTING-PASSAGE-LOSE
	PRINTI	"A "
	PRINTD	PASSAGE
	PRINTI	" leads up to the west"
	PRINT	INTO-DARKNESS
	RTRUE	


	.FUNCT	SITTING-PASSAGE-LOSE
	CALL	START-SENTENCE,SECRET-SITTING-DOOR
	PRINTI	" is overhead, too high to climb through.
"
	RFALSE	


	.FUNCT	YOUR-CLOSET-F,RARG=0
	EQUAL?	RARG,M-LOOK \?CCL3
	CALL	PASSAGE-DESC?,YOUR-ROOM
	PRINTI	"The "
	PRINTD	PASSAGE
	PRINTI	" leads north and south. "
	CALL	LEVER-AND-DOOR,SECRET-YOUR-DOOR,P?WEST
	PRINTI	"A narrow stairway snakes down"
	PRINT	INTO-DARKNESS
	RTRUE	
?CCL3:	EQUAL?	RARG,P?SOUTH \FALSE
	PRINTI	"The "
	PRINTD	PASSAGE
	PRINTR	" turns west at the corner of the building."


	.FUNCT	PASSAGE-DESC?,RM
	GET	FOUND-PASSAGES,PLAYER-C
	EQUAL?	HERE,STACK \FALSE
	PRINTI	"This is a musty and cobwebby "
	PRINTD	PASSAGE
	PRINTI	" between the wall of"
	CALL	PRINTT,RM
	PRINTR	" and the outside wall of the castle."


	.FUNCT	IRIS-CLOSET-F,RARG=0
	EQUAL?	RARG,M-BEG \?CCL3
	IN?	COSTUME,IRIS-CLOSET \FALSE
	FCLEAR	COSTUME,SECRETBIT
	RFALSE	
?CCL3:	EQUAL?	RARG,M-LOOK \?CCL8
	CALL	LEVER-AND-DOOR,SECRET-IRIS-DOOR,P?WEST
	PRINTI	"The "
	PRINTD	PASSAGE
	PRINTI	" leads north and south"
	PRINT	INTO-DARKNESS
	RTRUE	
?CCL8:	EQUAL?	RARG,P?NORTH \FALSE
	PRINTI	"The "
	PRINTD	PASSAGE
	PRINTR	" turns west at the corner of the building."


	.FUNCT	WENDISH-CORNER-F,RARG=0
	EQUAL?	RARG,M-LOOK \?CCL3
	CALL	PASSAGE-DESC?,WENDISH-ROOM
	CALL	LEVER-AND-DOOR,SECRET-WENDISH-DOOR,P?SOUTH
	PRINT	PASSAGE-EAST-WEST
	RTRUE	
?CCL3:	EQUAL?	RARG,P?EAST \FALSE
	PRINTI	"The "
	PRINTD	PASSAGE
	PRINTR	" turns south at the corner of the building."


	.FUNCT	MIDPOINT-F,RARG=0
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"At the "
	PRINTD	MIDPOINT
	PRINTI	" of the "
	PRINTD	PASSAGE
	PRINTI	", another "
	PRINTD	PASSAGE
	PRINTI	" leads south. "
	PRINT	PASSAGE-EAST-WEST
	RTRUE	


	.FUNCT	DRAWING-CLOSET-F,RARG=0
	EQUAL?	RARG,M-LOOK \FALSE
	CALL	PASSAGE-DESC?,DRAWING-ROOM
	CALL	LEVER-AND-DOOR,SECRET-DRAWING-DOOR,P?NORTH
	PRINTI	"A narrow stairway snakes up"
	PRINT	INTO-DARKNESS
	RTRUE	


	.FUNCT	GALLERY-CORNER-F,RARG=0
	EQUAL?	RARG,M-LOOK \FALSE
	FCLEAR	PEEPHOLE,SECRETBIT
	CALL	START-SENTENCE,PEEPHOLE
	PRINTI	" is in the south wall. A "
	PRINTD	PASSAGE
	PRINTR	" leads north."


	.FUNCT	PEEPHOLE-F
	EQUAL?	PRSA,V?LOOK-THROUGH /?CTR2
	EQUAL?	PRSA,V?LOOK-OUTSIDE,V?LOOK-INSIDE,V?EXAMINE \?CCL3
?CTR2:	EQUAL?	HERE,GALLERY-CORNER \?CCL8
	FCLEAR	PEEPHOLE,SECRETBIT
	CALL	ROOM-PEEK,GALLERY,TRUE-VALUE
	RTRUE	
?CCL8:	EQUAL?	HERE,GALLERY \FALSE
	CALL	SECRET-CHECK,M-BEG
	ZERO?	STACK \TRUE
	CALL	ROOM-PEEK,GALLERY-CORNER,TRUE-VALUE
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?THROUGH \FALSE
	CALL	TOO-BAD-BUT,PEEPHOLE,STR?265
	RTRUE	


	.FUNCT	HYDE-CLOSET-F,RARG=0
	EQUAL?	RARG,M-LOOK \FALSE
	CALL	LEVER-AND-DOOR,SECRET-HYDE-DOOR,P?SOUTH
	PRINT	PASSAGE-EAST-WEST
	RTRUE	

	.ENDI
