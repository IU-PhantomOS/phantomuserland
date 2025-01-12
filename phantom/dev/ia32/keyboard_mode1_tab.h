//#include <compat/uos/keyboard.h>
//#include "uos_keyboard.h"
//#include "uos_i8042.h"

static const unsigned short scan_to_key [256] = {
    /* 00 */	0,		KEY_ESCAPE,	'1',		'2',
    /* 04 */	'3',		'4',		'5',		'6',
    /* 08 */	'7',		'8',		'9',		'0',
    /* 0C */	'-',		'=',		KEY_BACKSPACE,	KEY_TAB,
    /* 10 */	'Q',		'W',		'E',		'R',
    /* 14 */	'T',		'Y',		'U',		'I',
    /* 18 */	'O',		'P',		'[',		']',
    /* 1C */	KEY_ENTER,	KEY_LCTRL,	'A',		'S',
    /* 20 */	'D',		'F',		'G',		'H',
    /* 24 */	'J',		'K',		'L',		';',
    /* 28 */	'\'',		'`',		KEY_LSHIFT,	'\\',
    /* 2C */	'Z',		'X',		'C',		'V',
    /* 30 */	'B',		'N',		'M',		',',
    /* 34 */	'.',		'/',		KEY_RSHIFT,	KEY_KP_MULTIPLY,
    /* 38 */	KEY_LALT,	' ',		KEY_CAPSLOCK,	KEY_F1,
    /* 3C */	KEY_F2,		KEY_F3,		KEY_F4,		KEY_F5,
    /* 40 */	KEY_F6,		KEY_F7,		KEY_F8,		KEY_F9,
    /* 44 */	KEY_F10,	KEY_NUMLOCK,	KEY_SCROLLOCK,	KEY_KP7,
    /* 48 */	KEY_KP8,	KEY_KP9,	KEY_KP_MINUS,	KEY_KP4,
    /* 4C */	KEY_KP5,	KEY_KP6,	KEY_KP_PLUS,	KEY_KP1,
    /* 50 */	KEY_KP2,	KEY_KP3,	KEY_KP0,	KEY_KP_PERIOD,
    /* 54 */	0,		0,		0,		KEY_F11,
    /* 58 */	KEY_F12,	0,		0,		0,
    /* 5C */	0,		0,		0,		0,
    /* 60 */	0,		0,		0,		0,
    /* 64 */	0,		0,		0,		0,
    /* 68 */	0,		0,		0,		0,
    /* 6C */	0,		0,		0,		0,
    /* 70 */	0,		0,		0,		0,
    /* 74 */	0,		0,		0,		0,
    /* 78 */	0,		0,		0,		0,
    /* 7C */	0,		0,		0,		0,
    /* E0,00 */	0,		0,		0,		0,
    /* E0,04 */	0,		0,		0,		0,
    /* E0,08 */	0,		0,		0,		0,
    /* E0,0C */	0,		0,		0,		0,
    /* E0,10 */	KEY_TRACK_PREV,	0,		0,		0,
    /* E0,14 */	0,		0,		0,		0,
    /* E0,18 */	0,		KEY_TRACK_NEXT,	0,		0,
    /* E0,1C */	KEY_KP_ENTER,	KEY_RCTRL,	0,		0,
    /* E0,20 */	KEY_MUTE,	/*Calc*/ 0,	KEY_PLAY,	0,
    /* E0,24 */	KEY_STOP,	0,		0,		0,
    /* E0,28 */	0,		0,		0,		0,
    /* E0,2C */	0,		0,		KEY_VOLUME_DOWN, 0,
    /* E0,30 */	KEY_VOLUME_UP,	0,		/*WWWHome*/ 0,	0,
    /* E0,34 */	0,		KEY_KP_DIVIDE,	0,		KEY_PRINT,
    /* E0,38 */	KEY_RALT,	0,		0,		0,
    /* E0,3C */	0,		0,		0,		0,
    /* E0,40 */	0,		0,		0,		0,
    /* E0,44 */	0,		0,		0,		KEY_HOME,
    /* E0,48 */	KEY_UP,		KEY_PAGEUP,	0,		KEY_LEFT,
    /* E0,4C */	0,		KEY_RIGHT,	0,		KEY_END,
    /* E0,50 */	KEY_DOWN,	KEY_PAGEDOWN,	KEY_INSERT,	KEY_DELETE,
    /* E0,54 */	0,		0,		0,		0,
    /* E0,58 */	0,		0,		0,		KEY_LMETA,
    /* E0,5C */	KEY_RMETA,	KEY_MENU,	KEY_POWER,	/*Sleep*/ 0,
    /* E0,60 */	0,		0,		0,		/* Wake */ 0,
    /* E0,64 */	0,		/*WWWSearch*/0,	/*WWWFavor*/ 0,	/*WWWRefresh*/0,
    /* E0,68 */	/*WWWStop*/ 0,	/*WWWForw*/ 0,	/*WWWBack*/ 0,	/*MyComp*/ 0,
    /* E0,6C */	/*EMail*/ 0,	/*MediaSel*/ 0,	0,		0,
    /* E0,70 */	0,		0,		0,		0,
    /* E0,74 */	0,		0,		0,		0,
    /* E0,78 */	0,		0,		0,		0,
    /* E0,7C */	0,		0,		0,		0,
};
