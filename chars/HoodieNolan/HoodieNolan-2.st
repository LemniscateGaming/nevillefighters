; ---- STATE OVERRIDES ---------

;---------------------------------------------------------------------------
;Build Wall
[Statedef 925]
type    = C
movetype = I
physics = C
anim = 925
poweradd = -500

[State 925, ChangeState] ;Note: Does not deconstruct wall 
type = ChangeState
trigger1 = animelem = 5
value = 11

[State 925, Helper]
type = Helper
trigger1 = time = 0
trigger1 = NumHelper(1250) = 0
name = "Wall"
ID = 1250
stateno = 1250
pos = -7,0
facing = 1
ownpal = 1

;-------------------------------------------------------
;Wall (Helper)

[Statedef 1250]
type = C
movetype = I
physics = N
ctrl = 0
velset = 0,0
sprpriority = -1
anim = 1127 ;the animation can be visible (to represent the reflector FX) or invisible (if the FX is part of the character animation already), but it must have both a blue and red CLSN overlapping each other

[State 0, ChangeAnim]
type = ChangeAnim
trigger1 = var(25) = 1
trigger1 = time = 0
value = 1127
elem = 5

[State 0, VarSet] ;Wall's max life
type = VarSet
trigger1 = var(25) = 0
trigger1 = time = 0
v = 27
value = 750

[State 0, LifeSet]
type = LifeSet
trigger1 = var(25) = 0
trigger1 = time = 0
value = 500

[State 0, VarSet]
type = VarSet
trigger1 = var(25) = 0
trigger1 = time = 0
v = 26    ;fv = 10
value = GameTime

[State 1250, ChangeAnim]
type = ChangeAnim
trigger1 = GetHitVar(xvel)>10
value = 1128
elem = 6-animelemno(0)
ignorehitpause = 1
persistent = 0

[State 1250, Invuln]
type = nothitby
trigger1 = 1
value = SCA
time = -1 

[State 1250, Vuln]
type = hitby
trigger1 = anim = 1127
value = SCA,NP,SP,HP
time = -1

[State 1250, Reversaldef]
type = reversaldef
trigger1 = anim = 1127
reversal.attr = SCA,NP,SP,HP
pausetime = 0,0
sparkno = -1
sparkxy = 0,0
p2stateno = 1251
hitsound = S21,1+floor(random/(999/7))
ignorehitpause = 1 ;this takes care of helper based projectiles and sends them to custom state

[State 1250, Hitoverride]
type = hitoverride
trigger1 = 1
slot = 0
slot = 5
attr = SCA,NP,SP,HP
time = 1
forceair = 0
stateno = 1252
ignorehitpause = 1

[State 1250, End]
type = destroyself
trigger1 = anim = 1128
trigger1 = animelem = 5

[State 0, PosAdd]
type = PosAdd
trigger1 = facing != root,facing
x = 57.5

[State 0, Turn]
type = Turn
trigger1 = facing != root,facing

[State 0, Trans]
type = Trans
trigger1 = var(26) + var(27) - 100 < GameTime
trigger1 = Time%20 > 10
trans = Add     ;None, Add, AddAlpha, Add1, Sub
alpha = 128,192

[State 1250, ChangeAnim]
type = ChangeAnim
triggerall = time > 1
trigger1 = var(26) + var(27) < GameTime
;trigger2 = root,movetype = H
;trigger3 = (Pos X - root,Pos X)*facing < -10
trigger4 = Life <= 0
value = 1128
elem = 6-animelemno(0)
ignorehitpause = 1
persistent = 0

;---------------------------------------------------------------------------

; Reflected Helper
[Statedef 1251]
type = C
ctrl = 0
movetype = A
physics = N
sprpriority = 2 

[State 0, VarAdd]
type = VarAdd
trigger1 = time = 0
v = 26    ;fv = 
value = -1 * floor(GetHitVar(damage) * 0.75)

[State 1251, Hitoverride]
type = HitOverride
trigger1 = 1
attr = SCA,AA,AP,AT
time = 1
stateno = 1251
ignorehitpause = 1

[State 1251, Invuln]
type = nothitby
trigger1 = 1
value = SCA
time = -1

[State 1251, StopSnd]
type = StopSnd
trigger1 = time = 180
channel = -1
ignorehitpause = 1
persistent = 0 ;this is a just in case measure if the helper projectile's sound plays infinitely 

[State 1251, Changeanime]
type = ChangeAnim
trigger1 = !time
value = anim ;mimics the helper projectiles animation

[State 1251, Turn]
type = Turn
triggerall = numenemy > 0
trigger1 = facing =1 && enemy,facing !=1
trigger2 = facing != 1 && enemy,facing =1 ;turns the reflected helper projectile around so that it looks like it was properly reflected

[State 1251, Velset]
type = VelSet
triggerall = vel x
trigger1 = !time
trigger2 = pos y>=0
x = (ifelse(vel x>0,vel x,vel x*-1))
y = vel y

[State 1251, Velset]
type = VelSet
triggerall = vel x = 0
trigger1 = !time
x = 3  ;a just in case measure if the projectile happens to not use velsets/veladds for velocity

[State 1251, Projectile]
type = hitdef
trigger1 = time = 1
persistent = 0
attr = A,SP
animtype = Hard
damage = ceil(60),30
hitflag = MAF
guardflag = MA
pausetime = 0,10
sparkxy = -5,0
hitsound = 5,2
guardsound = 6,0
ground.type = Low
ground.slidetime = 16
ground.hittime = 16
ground.velocity = -8.2,0
air.velocity = -8.2,-7
affectteam = F ;<--- Important if you want the reflected projectile to hit the opponent
air.fall = 1
fall.recover = 0
hitonce = 1
yaccel = 0.4

[State 1251, Remove FX]
type = removeexplod
trigger1 = IsHelper
trigger1 = time = 1
ignorehitpause = 1 ;removes any explods the projectile may have just in case they have infinite removetime

[State 1252, End]
type = SelfState
trigger1 = !IsHelper
value = 0
ctrl = 1 ;a just in case measure in the event you accidentally send the opponent into the reflector custom state

[State 1251, End]
type = DestroySelf
trigger1 = time > 240
trigger2 = frontedgedist <-100
trigger3 = backedgedist <-100
trigger4 = movecontact
ignorehitpause=1

;---------------------------------------------------------------------------
;[everything below here handles projectile SCTRLs stated from the hitoverride earlier]

; Reflected Projectile
[Statedef 1252]
type = C
physics = N
movetype = I
ctrl = 0 

[State 0, VarAdd]
type = VarAdd
trigger1 = time = 0
v = 26    ;fv = 
value = -1 * floor(GetHitVar(damage) * 0.75)

[State 0, VarSet]
type = VarSet
trigger1 = 1
v = 25    ;fv = 10
value = 1
ignorehitpause = 1

[State 1252, PSND]
type = PlaySnd
trigger1 = time = 0
value = S21,1+floor(random/(999/7))
ignorehitpause = 1
persistent = 0

[State 1252, Hitoverride]
type = HitOverride
trigger1 = 1
attr = SCA,AA,AP,AT
time = 1
stateno = 1252
ignorehitpause = 1

[State 1252, Projectile] ;XVEL BELOW/EQUAL TO 10
type = projectile
trigger1 = time = 0
persistent = 0
projID = 1252
projanim = 815
projhitanim = 817
projpriority = 7
projremovetime = -1
offset = 0,-30
attr = A,SP
animtype = Hard
damage = ceil(1.1*GetHitVar(damage))
hitflag = MAF
;guardflag = MA
pausetime = 0,ceil(1.05*GetHitVar(hitshaketime))
velocity = 4.5,0
sparkno = -1
guard.sparkno = -1
sparkxy = 0,-70
hitsound = 5,2
guardsound = 6,0
ground.type = High
air.type = High
ground.slidetime = ceil(1.025*GetHitVar(slidetime))
ground.hittime = ceil(1.05*GetHitVar(hittime))
ground.velocity = 1.025*facing*GetHitVar(xvel)-0.5,GetHitVar(yvel)
ignorehitpause = 1

[State 1252, Remove FX]
type = removeexplod
trigger1 = IsHelper
trigger1 = time = 1
ignorehitpause = 1

[State 1252, ChangeState]
type = ChangeState
trigger1 = time = 1
value = 1250
anim = 127
ignorehitpause = 1



; ---- PASSIVE STATES --------

[Statedef -2]

;[State 0, VelSet]
;type = VelAdd
;trigger1 = NumHelper(1250) > 0
;trigger1 = helper(1250),stateno = 1252
;trigger1 = helper(1250),time = 0
;trigger1 = helper(1250),GetHitVar(xvel) != 0
;x = GetHitVar(xvel) * -0.5
;y = 0

[State 0, AssertSpecial]
type = AssertSpecial
trigger1 = NumHelper(1250) > 0
flag = nocrouchguard
ignorehitpause = 1


[State 0, DisplayToClipboard]
type = DisplayToClipboard
trigger1 = NumHelper(1250)
text = "WALL TIME LEFT: %d"
params = (helper(1250),var(26) + helper(1250),var(27)) - GameTime

[State -2, Guard Dist]
type = projectile
trigger1 = numhelper(1250) = 1
trigger1 = !numprojID(1250)
projID = 1250
projanim = 1
velocity = 0,0
guard.dist = 300
postype = p2
offset = 0,5000
projremovetime = 240
ignorehitpause = 1


[State -2, PlaySnd]
type = PlaySnd
trigger1 = var(2) >= 100
trigger1 = var(3) = 0
value = 1,2
volumescale = 100
channel = 3
ignorehitpause = 1

[State -2, PlaySnd]
type = PlaySnd
trigger1 = var(2) >= 100
trigger1 = var(3) = 0
value = 0,0
volumescale = 100
channel = 10
ignorehitpause = 1

[State -2, AfterImage]
type = AfterImage
trigger1 = var(2) >= 100
trigger1 = var(3) = 0
time = -1
length = 20
palcolor = 256
palinvertall = 0
palbright = 30,30,30
palcontrast = 120,120,220
palpostbright = 0,0,0
paladd = 10,10,25
palmul = .65,.65,.75
timegap = 1
framegap = 4
trans = Add ;None, Add1, Sub
ignorehitpause = 1

[State -2, PalFX]
type = PalFX
trigger1 = var(2) >= 100
trigger1 = var(3) = 0
time = -1
add = 48,48,64
mul = 200,200,200
;sinadd = 0,0,0,10
invertall = 0
color = 256
;ignorehitpause = 
;persistent = 
ignorehitpause = 1

[State -2, PalFX]
type = PalFX
trigger1 = var(2) < 100
trigger1 = var(3) = 1
time = 0
ignorehitpause = 1

[State -2, VarSet]
type = VarSet
trigger1 = var(2) >= 100
trigger1 = var(3) = 0
v = 3    ;fv = 10
value = 1
ignorehitpause = 1

[State -2, VarSet]
type = VarSet
trigger1 = var(2) < 100
trigger1 = var(3) = 1
v = 3    ;fv = 10
value = 0
ignorehitpause = 1

[State -2, AfterImageTime]
type = AfterImageTime
trigger1 = var(2) < 100
time = 0
ignorehitpause = 1

[State -2, Pause]
type = Pause
trigger1 = ProjHit821 = 1, = 1
trigger1 = ProjContact821 = 1, = 1
trigger2 = ProjHit823 = 1, = 1
trigger2 = ProjContact823 = 1, = 1
time = 30
ignorehitpause = 1

[State -2, BGPalFX]
type = BGPalFX
trigger1 = ProjHit821 = 1, = 1
trigger1 = ProjContact821 = 1, = 1
trigger2 = ProjHit823 = 1, = 1
trigger2 = ProjContact823 = 1, = 1 
triggerall = p2life > 0
time = 30
mul = 120,120,140
ignorehitpause = 1

[State -2, BGPalFX]
type = BGPalFX
trigger1 = ProjHit821 = 1, = 1 
trigger1 = ProjContact821 = 1,  = 1 
trigger2 = ProjHit823 = 1, = 1 
trigger2 = ProjContact823 = 1, = 1 
triggerall = p2life <= 0
time = 30
add = 32,0,0
mul = 256,64,64
ignorehitpause = 1

[State -2, EnvShake]
type = EnvShake
trigger1 = ProjHit821 = 1, = 1
trigger1 = ProjContact821 = 1, = 1
trigger2 = ProjHit823 = 1, = 1
trigger2 = ProjContact823 = 1, = 1
time = 30
freq = 90
ignorehitpause = 1

[State -2, StopSnd]
type = StopSnd
trigger1 = stateno != 840 && stateno != 69420
trigger1 = var(2) < 100
channel = 3
ignorehitpause = 1

[State -2, VarAdd]
type = VarAdd
triggerall = stateno = [5000,5301]
triggerall = time = 0
trigger1 = GetHitVar(damage) >= 7.5
trigger2 = GetHitVar(damage) < 7.5
trigger2 = (random/(999/7.5)) < GetHitVar(damage)
var(2) = ceil(GetHitVar(damage) * 0.133)
ignorehitpause = 1

[State -2, Helper]
Type = Helper
Triggerall = NumHelper(7800)=0
trigger1 = Roundstate <= 2
Id = 7800
Name = "HelperExplodManager"
Pos = 0,0
Postype = p1
Stateno = 7800
Pausemovetime = 99999
Supermovetime = 99999
Ownpal = 0

[Statedef 7800] ;Helper/Explod Manager (Helper)
Type = S
Ctrl = 0
Anim = 9999
Velset = 0,0
MoveType = I
Physics = N
Sprpriority = 200

[State 0, RemoveExplod]
type = RemoveExplod
trigger1 = NumExplod(2100)
trigger1 = root,var(2)>=100
id = 2100

[State 0, RemoveExplod]
type = RemoveExplod
trigger1 = NumExplod(2101)
trigger1 = root,var(2)<1004
id = 2101

[State 0, RemoveExplod]
type = RemoveExplod
trigger1 = NumExplod(2102)
trigger1 = root,stateno < 220 || root,stateno%10 != 1 || root,stateno = 401
trigger1 = root,var(2)<100
id = 2102

[State 0, RemoveExplod]
type = RemoveExplod
trigger1 = NumExplod(2105)
trigger1 = root,var(2)>=100
id = 2105

[State 7800, Explod] ;Meter
type = Explod
triggerall = root,var(2)<100
triggerall = !NumExplod(2100)
trigger1 = TeamSide = 1
trigger2 = TeamSide = 2
anim = 2100
ID = 2100
pos = ifelse(TeamSide=1,42,252),20.5
scale = 0.75,0.5
space = screen
facing = 1
removetime = -1
supermovetime = 99999
pausemovetime = 99999
sprpriority = 20
ownpal = 1
removeongethit = 0

[State 7800, Explod] ;Meter (genkai ready)
type = Explod
triggerall = root,var(2)>=100
triggerall = !NumExplod(2101)
triggerall = root,stateno < 220 || root,stateno >= 5000 || root,stateno%10 != 1 || root,stateno = 401 ;genkai moves
trigger1 = TeamSide = 1
trigger2 = TeamSide = 2
anim = 2101
ID = 2101
pos = ifelse(TeamSide=1,42,252),20.5
scale = 0.75,0.5
space = screen
facing = 1
removetime = -1
supermovetime = 99999
pausemovetime = 99999
sprpriority = 21
ownpal = 1
removeongethit = 0

[State 7800, Explod] ;Meter (genkai use)
type = Explod
triggerall = root,var(2)=0
triggerall = !NumExplod(2102)
triggerall = root,stateno > 220 && root,stateno <= 5000 && root,stateno%10 = 1 && root,stateno != 401 ;genkai moves
scale = 0.75,0.5
trigger1 = TeamSide = 1
trigger2 = TeamSide = 2
anim = 2102
ID = 2102
pos = ifelse(TeamSide=1,42,252),20.5
space = screen
facing = 1
removetime = -1
supermovetime = 99999
pausemovetime = 99999
sprpriority = 22
ownpal = 1
removeongethit = 0

[State 7800, Explod] ;Bar
type = Explod
triggerall = root,var(2)<100
trigger1 = TeamSide = 1 && !NumExplod(2105)
trigger2 = TeamSide = 2 && !NumExplod(2105)
anim = 2105
ID = 2105
pos = ifelse(TeamSide=1,42,252),20.5
scale = 0.75,0.5
space = screen
facing = 1
scale = 1,1
removetime = -1
supermovetime = 99999
pausemovetime = 99999
sprpriority = 23
ownpal = 1
removeongethit = 0

[State 7800, ModifyExplod]
type = ModifyExplod
trigger1 = TeamSide = 1 && NumExplod(2105)
trigger2 = TeamSide = 2 && NumExplod(2105)
id = 2105
;scale = floor(0.20 * (ifelse(root,var(2) > 100, 100, root,var(2)))) * 0.05, 1
scale = 0.75 * ifelse(root,var(2) > 100, 100, root,var(2)) * 0.01, 0.5

[State 7800, ModifyExplod]
type = ModifyExplod
trigger1 = NumExplod(2100)
id = 2100
;scale = floor(0.20 * (ifelse(root,var(2) > 100, 100, root,var(2)))) * 0.05, 1
trans = Add
alpha = ifelse(root,stateno=840,64,256),ifelse(root,stateno=840,192,0)
[State 7800, ModifyExplod]
type = ModifyExplod
trigger1 = NumExplod(2105)
id = 2105
;scale = floor(0.20 * (ifelse(root,var(2) > 100, 100, root,var(2)))) * 0.05, 1
trans = Add
alpha = ifelse(root,stateno=840,64,256),ifelse(root,stateno=840,192,0)