
global shadow := {}
shadow["i"] := "ai;o;i"
; shadow["i"] := "ai;a;b;c"
shadow["o"] := "si"
shadow["p"] := "s9;sp"

shadow[4] := "4"
shadow["s4"] := "s4;a4"
shadow[5] := "c5;5;s5;a5"
shadow["s5"] := "s5;a5"
shadow[6] := "c6;a6;6"

shadow[8] := "8;c8;7;c7"
shadow[9] := "9;c9;8;c8;s4;a4;4"

; Needs "shadow[6]" to be created first
shadow["si"] := shadow[6] . ";0;" . shadow["i"]



global havoc := {}
havoc["i"] := "co;ci;p;o;i"

havoc[4] := "c4;4"
havoc[5] := "5;c5"
havoc[6] := "6"

havoc["si"] := havoc[6] . ";" . havoc["i"]


global fury := {}
; fury["i"] := "si;cp;co;ci;p;5;i;o"
fury["i"] := "👆"
fury["👆"] := "👆;6;p;5;o;i"
fury["s👆"] := "s👆;a👆"


fury[4] := "4;c4"
fury[5] := "c5;5"
fury[6] := "5;c6"

fury[7] := "c7;7"
fury[8] := "8;c8"
fury[9] := "9;c9"

global max_fury := {}
; fury["i"] := "si;cp;co;ci;p;5;i;o"
max_fury["👆"] := "👈;👆;6;p;5;o;i"
max_fury["c👆"] := "👈;c👆;aci"
max_fury["i"] := "👈;👆"

max_fury["s👆"] := "s👆;a👆"


max_fury[8] := "8;c8"


global frost_dk := {}
frost_dk["👆"] := "ci;p;o;i;co"

frost_dk["o"] := "👆"


global shaman := {}
; shaman["i"] := "p;o;i;co"
shaman["👆"] := "ci;p;i;7;o"


global warlock := {}
; shaman["i"] := "p;o;i;co"
; warlock["👆"] := "ci;p;i;7;o"
; warlock["👆"] := "sp;so"
; warlock["s👆"] := "o;i"
warlock["👆"] := "ap;ao;ci;6;o;i"
warlock["👇"] := "👇;c👇"

warlock["i"] := "p"
warlock["o"] := "ai"

warlock[4] := "4"
warlock[5] := "a5"
warlock[6] := "co"

warlock[8] := "8;c8"
warlock[9] := "8;c8"

warlock["si"] := warlock["6"] . ";" . warlock["👆"]
warlock["so"] := "s9"

warlock["ao"] := "a9"



global druid := {}
; shaman["i"] := "p;o;i;co"
; warlock["👆"] := "ci;p;i;7;o"
global druid_bear_👆 := "ao;ai;i;o"
global druid_cat_👆 := "ao;ai;i"
global druid_cat_👆_spender := "o;i"

druid["👆"] := "ai;ao;i"
druid["o"] := "aci" ; alt + ctrl + o

druid["i"] := "ai;ci"


global rogue := {}
; shaman["i"] := "p;o;i;co"
; warlock["👆"] := "ci;p;i;7;o"
global rogue_i_single := "ci"
global rogue_i_poison := "co"
global rogue_i_aoe := "cp"

rogue["👆"] := "p;o;i"

rogue["i"] := "ci"
rogue["o"] := "co"
rogue["p"] := "cp"
rogue["si"] := "6;c6"

rogue[4] := "4;c4"
; rogue[5] := "5"
rogue[6] := rogue["si"]


rogue["s8"] := "c8"
rogue["s9"] := "c9"

