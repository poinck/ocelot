/* see LICENSE and LICENSE-monsterwm for copyright and license */

#ifndef CONFIG_H
#define CONFIG_H

/** modifiers **/
#define MOD1            Mod1Mask    /* ALT key */
#define MOD4            Mod4Mask    /* Super/Windows key */
#define CONTROL         ControlMask /* Control key */
#define SHIFT           ShiftMask   /* Shift key */

/** generic settings **/
#define MASTER_SIZE     0.60
#define SHOW_PANEL      True      /* show panel by default on exec */
#define TOP_PANEL       True      /* False means panel is on bottom */
#define PANEL_HEIGHT    21        /* 0 for no space for panel, thus no panel */
#define PANEL_WIDTH     75        /* 0 for no space for side-panel, thus fallback to top-panel. otherwise space of side-panel on the left and PANEL-HEIGHT will be ignored, thus no space for top-panel */
#define DEFAULT_MODE    FLOAT     /* initial layout/mode: TILE MONOCLE BSTACK GRID FLOAT */
#define ATTACH_ASIDE    False     /* False means new window is master */
#define FOLLOW_WINDOW   False     /* follow the window when moved to a different desktop */
#define FOLLOW_MOUSE    False     /* focus the window the mouse just entered */
#define CLICK_TO_FOCUS  True      /* focus an unfocused window when clicked  */
#define FOCUS_BUTTON    Button3   /* mouse button to be used along with CLICK_TO_FOCUS */
#define BORDER_WIDTH    4         /* window border width */
#define FOCUS           "#bbbbbb" /* "#ff950e" - focused window border color    */
#define UNFOCUS         "#444444" /* unfocused window border color  */
#define MINWSZ          50        /* minimum window size in pixels  */
#define DEFAULT_DESKTOP 0         /* the desktop to focus initially */
#define DESKTOPS        20        /* number of desktops - edit DESKTOPCHANGE keys to suit */
#define USELESSGAP      0         /* the size of the useless gap in pixels */

/**
 * open applications to specified desktop with specified mode.
 * if desktop is negative, then current is assumed
 */
static const AppRule rules[] = { \
    /*  class     desktop  follow  float */
    { "thunderbird",     0,    False,  True  },
};

/* helper for spawning shell commands */
#define SHCMD(cmd) {.com = (const char*[]){"/bin/sh", "-c", cmd, NULL}}

/**
 * custom commands
 * must always end with ', NULL };'
 */
static const char *termcmd[] = { "urxvt", "+sb", "-fade", "15", "+si", "-bg", "#3f3f3f", "-fg", "white", "-fn", "xft:Monospace:pixelsize=13", NULL };
/* dmenu_run -b -nb "#292929" -nf "#bbbbbb" -sf "#292929" -sb "#4ad6d3" -fn "monospace:bold:size=10" */
static const char *menucmd[] = { "dmenu_run", "-b", "-nb", "#292929", "-nf", "#bbbbbb", "-sf", "#292929", "-sb", "#4ad6d3", "-fn", "monospace:size=10", NULL };
/* static const char *menucmd[] = { "dmenu_run", "-b", "-sf", "#000000", "-sb", "#ffffff", "-fn", "monospace:size=9", NULL }; */
static const char *lockcmd[] = { "olock", NULL };
static const char *brupcmd[] = { "obrightness", "up", NULL };
static const char *brdocmd[] = { "obrightness", "down", NULL };
static const char *voupcmd[] = { "ovolume", "up", NULL };
static const char *vodocmd[] = { "ovolume", "down", NULL };

#define DESKTOPCHANGE(K,N) \
    {  MOD4,             K,              change_desktop, {.i = N}}, \
    {  MOD4|ShiftMask,   K,              client_to_desktop, {.i = N}},

/**
 * keyboard shortcuts
 */
static Key keys[] = {
    /* modifier          key            function           argument */
    {  MOD4,             XK_b,          togglepanel,       {NULL}},
    {  MOD4,             XK_BackSpace,  focusurgent,       {NULL}},
    {  MOD4|SHIFT,       XK_c,          killclient,        {NULL}},
    {  MOD1,             XK_Tab,        next_win,          {NULL}},
    {  MOD4,             XK_j,          next_win,          {NULL}},
    {  MOD4,             XK_k,          prev_win,          {NULL}},
    {  MOD4,             XK_u,          resize_master,     {.i = -10}}, /* decrease size in px */
    {  MOD4,             XK_i,          resize_master,     {.i = +10}}, /* increase size in px */
    {  MOD4,             XK_o,          resize_stack,      {.i = -10}}, /* shrink   size in px */
    {  MOD4,             XK_p,          resize_stack,      {.i = +10}}, /* grow     size in px */
    {  MOD4,             XK_Left,       rotate,            {.i = -1}},
    {  MOD4,             XK_Right,      rotate,            {.i = +1}},
    {  MOD4|SHIFT,       XK_Left,       rotate_filled,     {.i = -1}},
    {  MOD4|SHIFT,       XK_Right,      rotate_filled,     {.i = +1}},
    {  MOD4,             XK_Up,         rotate,            {.i = -1}},
    {  MOD4,             XK_Down,       rotate,            {.i = +1}},
    {  MOD4|SHIFT,       XK_Up,         rotate_filled,     {.i = -1}},
    {  MOD4|SHIFT,       XK_Down,       rotate_filled,     {.i = +1}},
    {  MOD4,             XK_Tab,        last_desktop,      {NULL}},
    {  MOD4,             XK_Return,     swap_master,       {NULL}},
    {  MOD4|SHIFT,       XK_j,          move_down,         {NULL}},
    {  MOD4|SHIFT,       XK_k,          move_up,           {NULL}},
    {  MOD4|SHIFT,       XK_t,          switch_mode,       {.i = TILE}},
    {  MOD4|SHIFT,       XK_m,          switch_mode,       {.i = MONOCLE}},
    {  MOD4|SHIFT,       XK_b,          switch_mode,       {.i = BSTACK}},
    {  MOD4|SHIFT,       XK_g,          switch_mode,       {.i = GRID}},
    {  MOD4|SHIFT,       XK_f,          switch_mode,       {.i = FLOAT}},
    {  MOD4|CONTROL,     XK_r,          quit,              {.i = 0}}, /* quit with exit value 0 */
    {  MOD4|CONTROL,     XK_q,          quit,              {.i = 1}}, /* quit with exit value 1 */
    {  MOD4|SHIFT,       XK_Return,     spawn,             {.com = termcmd}},
    {  MOD1,             XK_F2,         spawn,             {.com = menucmd}},
    {  MOD4,             XK_l,          spawn,             {.com = lockcmd}},
    {  MOD4,             XK_s,          moveresize,        {.v = (int []){   0,  25,   0,   0 }}}, /* move down  */
    {  MOD4,             XK_w,          moveresize,        {.v = (int []){   0, -25,   0,   0 }}}, /* move up    */
    {  MOD4,             XK_d,          moveresize,        {.v = (int []){  25,   0,   0,   0 }}}, /* move right */
    {  MOD4,             XK_a,          moveresize,        {.v = (int []){ -25,   0,   0,   0 }}}, /* move left  */
    {  MOD4|SHIFT,       XK_s,          moveresize,        {.v = (int []){   0,   0,   0,  25 }}}, /* height grow   */
    {  MOD4|SHIFT,       XK_w,          moveresize,        {.v = (int []){   0,   0,   0, -25 }}}, /* height shrink */
    {  MOD4|SHIFT,       XK_d,          moveresize,        {.v = (int []){   0,   0,  25,   0 }}}, /* width grow    */
    {  MOD4|SHIFT,       XK_a,          moveresize,        {.v = (int []){   0,   0, -25,   0 }}}, /* width shrink  */
       DESKTOPCHANGE(    XK_1,                             0)
       DESKTOPCHANGE(    XK_2,                             1)
       DESKTOPCHANGE(    XK_3,                             2)
       DESKTOPCHANGE(    XK_4,                             3)
       DESKTOPCHANGE(    XK_5,                             4)
       DESKTOPCHANGE(    XK_6,                             5)
       DESKTOPCHANGE(    XK_7,                             6)
       DESKTOPCHANGE(    XK_8,                             7)
       DESKTOPCHANGE(    XK_9,                             8)
       DESKTOPCHANGE(    XK_0,                             9)
    {  0,            XF86XK_MonBrightnessUp,    spawn,   {.com = brupcmd}},
    {  0,            XF86XK_MonBrightnessDown,  spawn,   {.com = brdocmd}},
    {  0,            0x1008ff13,        spawn,              {.com = voupcmd}},
    {  0,            0x1008ff11,        spawn,              {.com = vodocmd}},
};

/* TODO  grab volume-buttons: 0x1008ff11 (down) and 0x1008ff13 (up)
 * - find out controls for speaker-mute-button
 * - find out controls for mic-mute-button */

/* XK_Super_L */

/**
 * mouse shortcuts
 */
static Button buttons[] = {
    {  MOD4,    Button1,     mousemotion,   {.i = MOVE}},
    {  MOD1,    Button3,     mousemotion,   {.i = RESIZE}},
    {  MOD4,    Button3,     spawn,         {.com = menucmd}},
};
#endif

/* vim: set expandtab ts=4 sts=4 sw=4 : */
