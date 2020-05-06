[Statedef -2]

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