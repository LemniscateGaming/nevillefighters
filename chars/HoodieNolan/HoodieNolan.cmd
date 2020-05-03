
; The CMD file.
;
; Two parts: 1. Command definition and  2. State entry
; (state entry is after the commands def section)
;
; 1. Command definition
; ---------------------
; Note: The commands are CASE-SENSITIVE, and so are the command names.
; The eight directions are:
;   B, DB, D, DF, F, UF, U, UB     (all CAPS)
;   corresponding to back, down-back, down, downforward, etc.
; The six buttons are:
;   a, b, c, x, y, z               (all lower case)
;   In default key config, abc are are the bottom, and xyz are on the
;   top row. For 2 button characters, we recommend you use a and b.
;   For 6 button characters, use abc for kicks and xyz for punches.
;
; Each [Command] section defines a command that you can use for
; state entry, as well as in the CNS file.
; The command section should look like:
;
;   [Command]
;   name = some_name
;   command = the_command
;   time = time (optional)
;   buffer.time = time (optional)
;
; - some_name
;   A name to give that command. You'll use this name to refer to
;   that command in the state entry, as well as the CNS. It is case-
;   sensitive (QCB_a is NOT the same as Qcb_a or QCB_A).
;
; - command
;   list of buttons or directions, separated by commas. Each of these
;   buttons or directions is referred to as a "symbol".
;   Directions and buttons can be preceded by special characters:
;   slash (/) - means the key must be held down
;          egs. command = /D       ;hold the down direction
;               command = /DB, a   ;hold down-back while you press a
;   tilde (~) - to detect key releases
;          egs. command = ~a       ;release the a button
;               command = ~D, F, a ;release down, press fwd, then a
;          If you want to detect "charge moves", you can specify
;          the time the key must be held down for (in game-ticks)
;          egs. command = ~30a     ;hold a for at least 30 ticks, then release
;   dollar ($) - Direction-only: detect as 4-way
;          egs. command = $D       ;will detect if D, DB or DF is held
;               command = $B       ;will detect if B, DB or UB is held
;   plus (+) - Buttons only: simultaneous press
;          egs. command = a+b      ;press a and b at the same time
;               command = x+y+z    ;press x, y and z at the same time
;   greater-than (>) - means there must be no other keys pressed or released
;                      between the previous and the current symbol.
;          egs. command = a, >~a   ;press a and release it without having hit
;                                  ;or released any other keys in between
;   You can combine the symbols:
;     eg. command = ~30$D, a+b     ;hold D, DB or DF for 30 ticks, release,
;                                  ;then press a and b together
;
;   Note: Successive direction symbols are always expanded in a manner similar
;         to this example:
;           command = F, F
;         is expanded when MUGEN reads it, to become equivalent to:
;           command = F, >~F, >F
;
;   It is recommended that for most "motion" commads, eg. quarter-circle-fwd,
;   you start off with a "release direction". This makes the command easier
;   to do.
;
; - time (optional)
;   Time allowed to do the command, given in game-ticks. The default
;   value for this is set in the [Defaults] section below. A typical
;   value is 15.
;
; - buffer.time (optional)
;   Time that the command will be buffered for. If the command is done
;   successfully, then it will be valid for this time. The simplest
;   case is to set this to 1. That means that the command is valid
;   only in the same tick it is performed. With a higher value, such
;   as 3 or 4, you can get a "looser" feel to the command. The result
;   is that combos can become easier to do because you can perform
;   the command early. Attacks just as you regain control (eg. from
;   getting up) also become easier to do. The side effect of this is
;   that the command is continuously asserted, so it will seem as if
;   you had performed the move rapidly in succession during the valid
;   time. To understand this, try setting buffer.time to 30 and hit
;   a fast attack, such as KFM's light punch.
;   The default value for this is set in the [Defaults] section below.
;   This parameter does not affect hold-only commands (eg. /F). It
;   will be assumed to be 1 for those commands.
;
; If you have two or more commands with the same name, all of them will
; work. You can use it to allow multiple motions for the same move.
;
; Some common commands examples are given below.
;
; [Command] ;Quarter circle forward + x
; name = "QCF_x"
; command = ~D, DF, F, x
;
; [Command] ;Half circle back + a
; name = "HCB_a"
; command = ~F, DF, D, DB, B, a
;
; [Command] ;Two quarter circles forward + y
; name = "2QCF_y"
; command = ~D, DF, F, D, DF, F, y
;
; [Command] ;Tap b rapidly
; name = "5b"
; command = b, b, b, b, b
; time = 30
;
; [Command] ;Charge back, then forward + z
; name = "charge_B_F_z"
; command = ~60$B, F, z
; time = 10
;
; [Command] ;Charge down, then up + c
; name = "charge_D_U_c"
; command = ~60$D, U, c
; time = 10

;-| Button Remapping |-----------------------------------------------------
; This section lets you remap the player's buttons (to easily change the
; button configuration). The format is:
;   old_button = new_button
; If new_button is left blank, the button cannot be pressed.
[Remap]
x = x
y = y
z = z
a = a
b = b
c = c
s = s

;-| Default Values |-------------------------------------------------------
[Defaults]
; Default value for the "time" parameter of a Command. Minimum 1.
command.time = 15

; Default value for the "buffer.time" parameter of a Command. Minimum 1,
; maximum 30.
command.buffer.time = 1

;Super Attacks or whatever we're calling them



;-| Special commands |-----------------------------------------------------

[Command]
name = "DoIt"
command = a+b+c
time = 50

[Command]
name = "NotreWallSummon"
command = ~B, DB, D, DF, F, z
time = 40

[Command]
name = "MerchAd"
command = x+z
time = 40

[Command]
name = "MNGA Hat"
command = B, DB, D, b
time = 20

[Command]
name = "GenkaiCharge"
command = a+c
time = 5

[Command]
name = "TestCharge"
command = b+c
time = 5

[Command]
name = "PunchFinisher"
command = ~x,~x,~x,~x,x+y
time = 70

[Command]
name = "CrouchPunchFinisher"
command = ~x,~x,~x,~x,x+y
time = 200

[Command]
name = "PunchBarrage"
command = x,y,z
time = 500

;-| Standard |------------------------------------------------------
;Quarter Circles

[Command]
name = "QCF_x"
command = ~D, DF, F, x
time= 10

[Command]
name = "QCF_y"
command = ~D, DF, F, y
time= 10

[Command]
name = "QCF_z"
command = ~D, DF, F, z
time= 10

[Command]
name = "QCF_a"
command = ~D, DF, F, a
time= 10

[Command]
name = "QCF_b"
command = ~D, DF, F, b
time= 10

[Command]
name = "QCF_c"
command = ~D, DF, F, c
time= 10

;-| Double Tap |-----------------------------------------------------------
[Command]
name = "FF"     ;Required (do not remove)
command = F, F
time = 10

[Command]
name = "BB"     ;Required (do not remove)
command = B, B
time = 10

;-| 2/3 Button Combination |-----------------------------------------------
[Command]
name = "recovery" ;Required (do not remove)
command = x+y
time = 1

[Command]
name = "recovery"
command = y+z
time = 1

[Command]
name = "recovery"
command = x+z
time = 1

[Command]
name = "recovery"
command = a+b
time = 1

[Command]
name = "recovery"
command = b+c
time = 1

[Command]
name = "recovery"
command = a+c
time = 1

;-| Dir + Button |---------------------------------------------------------
[Command]
name = "back_x"
command = /$B,x
time = 1

[Command]
name = "back_y"
command = /$B,y
time = 1

[Command]
name = "back_z"
command = /$B,z
time = 1

[Command]
name = "down_x"
command = /$D,x
time = 1

[Command]
name = "down_y"
command = /$D,y
time = 1

[Command]
name = "down_z"
command = /$D,z
time = 1

[Command]
name = "fwd_x"
command = /$F,x
time = 1

[Command]
name = "fwd_y"
command = /$F,y
time = 1

[Command]
name = "fwd_z"
command = /$F,z
time = 1

[Command]
name = "up_x"
command = /$U,x
time = 1

[Command]
name = "up_y"
command = /$U,y
time = 1

[Command]
name = "up_z"
command = /$U,z
time = 1

[Command]
name = "back_a"
command = /$B,a
time = 1

[Command]
name = "back_b"
command = /$B,b
time = 1

[Command]
name = "back_c"
command = /$B,c
time = 1

[Command]
name = "down_a"
command = /$D,a
time = 1

[Command]
name = "down_b"
command = /$D,b
time = 1

[Command]
name = "down_c"
command = /$D,c
time = 1

[Command]
name = "fwd_a"
command = /$F,a
time = 1

[Command]
name = "fwd_b"
command = /$F,b
time = 1

[Command]
name = "fwd_c"
command = /$F,c
time = 1

[Command]
name = "up_a"
command = /$U,a
time = 1

[Command]
name = "up_b"
command = /$U,b
time = 1

[Command]
name = "up_c"
command = /$U,c
time = 1

;-| Single Button |---------------------------------------------------------
[Command]
name = "a"
command = a
time = 1

[Command]
name = "b"
command = b
time = 1

[Command]
name = "c"
command = c
time = 1

[Command]
name = "x"
command = x
time = 1

[Command]
name = "y"
command = y
time = 1

[Command]
name = "z"
command = z
time = 1

[Command]
name = "s"
command = s
time = 1

;-| Single Dir |------------------------------------------------------------
[Command]
name = "fwd" ;Required (do not remove)
command = $F
time = 1

[Command]
name = "downfwd"
command = $DF
time = 1

[Command]
name = "down" ;Required (do not remove)
command = $D
time = 1

[Command]
name = "downback"
command = $DB
time = 1

[Command]
name = "back" ;Required (do not remove)
command = $B
time = 1

[Command]
name = "upback"
command = $UB
time = 1

[Command]
name = "up" ;Required (do not remove)
command = $U
time = 1

[Command]
name = "upfwd"
command = $UF
time = 1

;-| Hold Button |--------------------------------------------------------------
[Command]
name = "hold_x"
command = /x
time = 1

[Command]
name = "hold_y"
command = /y
time = 1

[Command]
name = "hold_z"
command = /z
time = 1

[Command]
name = "hold_a"
command = /a
time = 1

[Command]
name = "hold_b"
command = /b
time = 1

[Command]
name = "hold_c"
command = /c
time = 1

[Command]
name = "hold_s"
command = /s
time = 1

;-| Hold Dir |--------------------------------------------------------------
[Command]
name = "holdfwd" ;Required (do not remove)
command = /$F
time = 1

[Command]
name = "holddownfwd"
command = /$DF
time = 1

[Command]
name = "holddown" ;Required (do not remove)
command = /$D
time = 1

[Command]
name = "holddownback"
command = /$DB
time = 1

[Command]
name = "holdback" ;Required (do not remove)
command = /$B
time = 1

[Command]
name = "holdupback"
command = /$UB
time = 1

[Command]
name = "holdup" ;Required (do not remove)
command = /$U
time = 1

[Command]
name = "holdupfwd"
command = /$UF
time = 1
;---------------------------------------------------------------------------
; 2. State entry
; For more info look at the CNS documentation

;It is recommended you label commands you make thoroughly so it is easier to track.
; --------------
;Don't remove this 
[Statedef -1]

;======Special Command moves================================================
;---------------------------------------------------------------------------
;Do It
[State -1, Do It]
type = ChangeState
value = 850
triggerall = power >= 3000
triggerall = command = "DoIt"
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------
;Notre Wall Summon
[State -1, Notre Wall Summon]
type = ChangeState
value = 860
triggerall = power >= 1000
triggerall = command = "NotreWallSummon"
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------
;Merch Ad
[State -1, Merch Ad]
type = ChangeState
value = 860
triggerall = command = "MerchAd"
triggerall = power >= 100
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------
;Air Merch Ad
[State -1, Air Merch Ad]
type = ChangeState
value = 861
triggerall = command = "MerchAd"
trigger1 = statetype = A
trigger1 = ctrl

;---------------------------------------------------------------------------
;MNGA Hat
[State -1, MNGA Hat]
type = ChangeState
value = 880
triggerall = command = "MNGA Hat"
triggerall = power >= 500
triggerall = var(9) + 200 < GameTime
trigger1 = statetype != A
trigger1 = ctrl

;=========Genkai============================================================

;---------------------------------------------------------------------------
;Genkai Charge
[State -1, Genkai Charge]
type = ChangeState
value = 840
triggerall = command = "GenkaiCharge"
triggerall = var(2) < 100
trigger1 = statetype != A
trigger1 = ctrl

;---------------------------------------------------------------------------
;Test  Charge (only enable for testing purposes)
;[State -1, Test Charge]
;type = ChangeState
;value = 69420
;triggerall = command = "TestCharge"
;triggerall = var(2) < 100
;trigger1 = statetype != A
;trigger1 = ctrl

;---------------------------------------------------------------------------
;Genkai Fireball
[State -1, Genkai Fireball]
type = ChangeState
value = 821
triggerall = command = "QCF_z"
triggerall = var(2) >= 100
trigger1 = statetype != A
trigger1 = ctrl
;---------------------------------------------------------------------------
;Air Genkai Fireball
[State -1, Air Genkai Fireball]
type = ChangeState
value = 823
triggerall = command = "QCF_z"
triggerall = var(2) >= 100
trigger1 = statetype = A
trigger1 = ctrl

;---------------------------------------------------------------------------
; Stand Genkai Punch
[State -1, Stand Genkai Punch]
type = ChangeState
value = 221
triggerall = command = "z"
triggerall = command != "holddown"
triggerall = var(2) >= 100
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------
; Stand Genkai Kick
[State -1, Stand Genkai Kick]
type = ChangeState
value = 251
triggerall = command = "c"
triggerall = command != "holddown"
triggerall = var(2) >= 100
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------
; Crouching Genkai Punch
[State -1, Crouching Genkai Punch]
type = ChangeState
value = 421
triggerall = command = "z"
triggerall = command = "holddown"
triggerall = var(2) >= 100
trigger1 = statetype = C
trigger1 = ctrl

;---------------------------------------------------------------------------
; Crouching Genkai Kick
[State -1, Crouching Genkai Kick]
type = ChangeState
value = 451
triggerall = command = "c"
triggerall = command = "holddown"
triggerall = var(2) >= 100
trigger1 = statetype = C
trigger1 = ctrl

;---------------------------------------------------------------------------
; Jump Genkai Punch
[State -1, Jump Genkai Punch]
type = ChangeState
value = 621
triggerall = command = "z"
triggerall = var(2) >= 100
trigger1 = statetype = A
trigger1 = ctrl

;---------------------------------------------------------------------------
; Jump Genkai Kick
[State -1, Jump Genkai Kick]
type = ChangeState
value = 651
triggerall = command = "c"
triggerall = var(2) >= 100
trigger1 = statetype = A
trigger1 = ctrl

;=========Fireballs======================================================
;---------------------------------------------------------------------------
;Light Fireball
[State -1, Light Fireball]
type = ChangeState
value = 800
triggerall = command = "QCF_x"
trigger1 = statetype != A
trigger1 = ctrl
;---------------------------------------------------------------------------
;Air Light Fireball
[State -1, Air Light Fireball]
type = ChangeState
value = 802
triggerall = command = "QCF_x"
trigger1 = statetype = A
trigger1 = ctrl

;---------------------------------------------------------------------------
;Medium Fireball
[State -1, Medium Fireball]
type = ChangeState
value = 810
triggerall = command = "QCF_y"
trigger1 = statetype != A
trigger1 = ctrl
;---------------------------------------------------------------------------
;Air Medium Fireball
[State -1, Air Medium Fireball]
type = ChangeState
value = 812
triggerall = command = "QCF_y"
trigger1 = statetype = A
trigger1 = ctrl

;---------------------------------------------------------------------------
;Strong Fireball
[State -1, Strong Fireball]
type = ChangeState
value = 820
triggerall = command = "QCF_z"
trigger1 = statetype != A
trigger1 = ctrl
;---------------------------------------------------------------------------
;Air Strong Fireball
[State -1, Air Strong Fireball]
type = ChangeState
value = 822
triggerall = command = "QCF_z"
trigger1 = statetype = A
trigger1 = ctrl

;===========================================================================
;---------------------------------------------------------------------------
; Run Fwd
[State -1, Run Fwd]
type = ChangeState
value = 100
trigger1 = command = "FF"
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------
; Run Back
[State -1, Run Back]
type = ChangeState
value = 105
trigger1 = command = "BB"
trigger1 = statetype = S
trigger1 = ctrl

;===========================================================================
;---------------------------------------------------------------------------
; Taunt
[State -1, Taunt]
type = ChangeState
value = 195
triggerall = command = "s"
trigger1 = statetype != A
trigger1 = ctrl

;===========================================================================
;STANDARD MOVES
;---------------------------------------------------------------------------
; Stand Light Punch
[State -1, Stand Light Punch]
type = ChangeState
value = 200
triggerall = command = "x"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------
; Stand Light Punch Finisher
[State -1, Stand Light Punch Finisher]
type = ChangeState
value = 203
triggerall = command = "PunchFinisher"
trigger1 = stateno = 200 && MoveHit

;---------------------------------------------------------------------------
; Stand Medium Punch
[State -1, Stand Medium Punch]
type = ChangeState
value = 210
triggerall = command = "y"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------
; Stand Strong Punch
[State -1, Stand Strong Punch]
type = ChangeState
value = 220
triggerall = command = "z"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------
; Punch Barrage
[State -1, Stand Strong Punch]
type = ChangeState
value = 222
triggerall = command = "PunchBarrage"
trigger1 = stateno = 210 && MoveHit

;---------------------------------------------------------------------------
; Stand Light Kick
[State -1, Stand Light Kick]
type = ChangeState
value = 230
triggerall = command = "a"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------
; Standing Medium Kick
[State -1, Standing Medium Kick]
type = ChangeState
value = 240
triggerall = command = "b"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------
; Standing Strong Kick
[State -1, Standing Strong Kick]
type = ChangeState
value = 250
triggerall = command = "c"
triggerall = command != "holddown"
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------
; Crouching Light Punch
[State -1, Crouching Light Punch]
type = ChangeState
value = 400
triggerall = command = "x"
triggerall = command = "holddown"
trigger1 = statetype = C
trigger1 = ctrl

;---------------------------------------------------------------------------
; Crouching Light Punch Finisher
[State -1, Crouching Light Punch Finisher]
type = ChangeState
value = 403
triggerall = command = "CrouchPunchFinisher"
trigger1 = stateno = 400 && MoveHit



;---------------------------------------------------------------------------
; Crouching Medium Punch
[State -1, Crouching Medium Punch]
type = ChangeState
value = 410
triggerall = command = "y"
triggerall = command = "holddown"
trigger1 = statetype = C
trigger1 = ctrl

;---------------------------------------------------------------------------
; Crouching Strong Punch
[State -1, Crouching Strong Punch]
type = ChangeState
value = 420
triggerall = command = "z"
triggerall = command = "holddown"
trigger1 = statetype = C
trigger1 = ctrl

;---------------------------------------------------------------------------
; Crouching Light Kick
[State -1, Crouching Light Kick]
type = ChangeState
value = 430
triggerall = command = "a"
triggerall = command = "holddown"
trigger1 = statetype = C
trigger1 = ctrl

;---------------------------------------------------------------------------
; Crouching Medium Kick
[State -1, Crouching Medium Kick]
type = ChangeState
value = 440
triggerall = command = "b"
triggerall = command = "holddown"
trigger1 = statetype = C
trigger1 = ctrl

;---------------------------------------------------------------------------
; Crouching Strong Kick
[State -1, Crouching Strong Kick]
type = ChangeState
value = 450
triggerall = command = "c"
triggerall = command = "holddown"
trigger1 = statetype = C
trigger1 = ctrl

;---------------------------------------------------------------------------
; Jump Light Punch
[State -1, Jump Light Punch]
type = ChangeState
value = 600
triggerall = command = "x"
trigger1 = statetype = A
trigger1 = ctrl

;---------------------------------------------------------------------------
; Jump Medium Punch
[State -1, Jump Medium Punch]
type = ChangeState
value = 610
triggerall = command = "y"
trigger1 = statetype = A
trigger1 = ctrl

;---------------------------------------------------------------------------
; Jump Strong Punch
[State -1, Jump Strong Punch]
type = ChangeState
value = 620
triggerall = command = "z"
trigger1 = statetype = A
trigger1 = ctrl

;---------------------------------------------------------------------------
; Jump Light Kick
[State -1, Jump Light Kick]
type = ChangeState
value = 630
triggerall = command = "a"
trigger1 = statetype = A
trigger1 = ctrl

;---------------------------------------------------------------------------
; Jump Medium Kick
[State -1, Jump Medium Kick]
type = ChangeState
value = 640
triggerall = command = "b"
trigger1 = statetype = A
trigger1 = ctrl

;---------------------------------------------------------------------------
; Jump Strong Kick
[State -1, Jump Strong Kick]
type = ChangeState
value = 650
triggerall = command = "c"
trigger1 = statetype = A
trigger1 = ctrl