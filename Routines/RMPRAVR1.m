RMPRAVR1 ;PHX/JLT-ENTER EDIT AUTO ADAPTIVE TRANS ;8/29/1994
 ;;3.0;PROSTHETICS;;Feb 09, 1996
DIC K DIC,RMPRG D HOME^%ZIS W !!,@IOF D DIV4^RMPRSIT G:$D(X) QUIT K DIC S DIC=667,DIC(0)="AEQMZN",DIC("A")="Please Enter Patient Name or Vehicle ID#: ",DIC("W")="D LK^RMPRAVR"
 S DIC("S")="I $D(^(2)) I $P(^(2),U,1)=1,$P(^RMPR(667,+Y,0),U,10)=RMPR(""STA"")" I RMPRSITE=1 S DIC("S")=DIC("S")_"!($P(^(0),U,10)="""")"
 D ^DIC I +Y'>0 K DIC G:$D(RMPRED)!($D(RMPREP)) QUIT G EDT
 L +^RMPR(667,+Y,0):1 I $T=0 W !,$C(7),?5,"Someone else is Editing this entry!" G QUIT
 S RMPRDA=+Y I +$P(^RMPR(667,+Y,0),U,2),$D(^DPT($P(^(0),U,2),0)) S RMPRDFN=$P(^RMPR(667,+Y,0),U,2)
 G:$D(RMPRED) EDIT G:$D(RMPREP) REP
ENT W ! K DIR,DIC S DIC="^RMPR(667.1,",DIC(0)="AEQZ",DIC("A")="ITEM: ",DIC("W")="I $D(DZ) W:DZ[""?"" $E(^(0),31,70)" D ^DIC G:+Y'>0 EDT S RMPRC(3)=+Y
 K DIR,DIC S DIR(0)="667.3,.01" D ^DIR G:$D(DTOUT)!($D(DIRUT)) EDT S RMPRC(5)=Y
 K Y,DA,DIR S DIR(0)="667.3,8",DIR("B")="INITIAL ISSUE" D ^DIR G:$D(DTOUT)!(X["^") EDT S RMPRC(8)=Y
 K Y,DA,DIR S DIR(0)="667.3,9",DIR("B")="SC/OP" D ^DIR G:$D(DTOUT)!(X["^") EDT S RMPRC(9)=Y
 K DIR I $D(RMPRC(9)),RMPRC(9)=4 S DIR(0)="667.3,10" D ^DIR G:$D(DTOUT)!(X["^") EDT S RMPRC(10)=Y
 K DIR,DA,Y S DIR(0)="667.3,11",DIR("B")="COMMERCIAL" D ^DIR G:$D(DTOUT)!(X["^") EDT S RMPRC(11)=Y
 K DA,Y,DIR S DIR(0)="667.3,6" D ^DIR G:$D(DTOUT)!(X["^") EDT S RMPRC(6)=Y
 K DA,Y,DIR S DIR(0)="667.3,3" D ^DIR G:$D(DTOUT)!($D(DIRUT)) EDT S RMPRC(4)=Y
 K DA,Y S DIR(0)="667.3,2.5",DIR("B")=1 D ^DIR G:$D(DTOUT)!($D(DIRUT)) EDT S QTY=Y
FILE I $D(RMPRG) G GGC
 L +^RMPR(669.9,RMPRSITE,0):999 I $T=0 S RMPRG=DT_99 G GGC
 S RMPRG=$P(^RMPR(669.9,RMPRSITE,0),U,7),RMPRG=RMPRG-1,$P(^RMPR(669.9,RMPRSITE,0),U,7)=RMPRG L -^RMPR(669.9,RMPRSITE,0)
GGC S X=RMPRC(5),DIC(0)="Z",DIC="^RMPR(667.3," K DD,DO D FILE^DICN I +Y'>0 W !!,$C(7),"RECORD NOT ENTERED SEE YOUR IRM SERVICE" G EDT
 S RDA=+Y,$P(^RMPR(667.3,RDA,0),U,2)=RMPRDA,$P(^(0),U,3)=RMPRC(3),$P(^(0),U,4)=RMPRC(4),$P(^(0),U,5)=RMPRAM,$P(^(0),U,6)=RMPRC(6),$P(^(0),U,7)=QTY,$P(^(0),U,8)=RMPRC(8),$P(^(0),U,9)=RMPRC(9)
 S $P(^RMPR(667.3,RDA,0),U,11)=RMPRC(11) S:$D(RMPRC(10)) $P(^(0),U,10)=RMPRC(10) S ^(2)=RMPR("STA")_"^"_DUZ,^(3)=RMPRG,DA=RDA,DIK="^RMPR(667.3," D IX1^DIK K DA S RMPRADD=1
 S DA=+Y,DR="5",DIE=DIC D ^DIE K DA G ENT
EDT I '$D(RMPRADD) W !!,$C(7),?5,"< NO RECORD ADDED >" G QUIT
 W ! K DIR S DIR(0)="Y",DIR("B")="NO",DIR("A")="Would you like to Edit/Delete an item " D ^DIR G:$D(DTOUT)!($D(DIRUT))!(Y=0) EXIT
LP K RID D DSP^RMPRAVR G:'$D(RID) EXIT
 S DA=+Y,DR=".01;8;9;S:$P(^RMPR(667.3,DA,0),U,9)=""4"" Y=""@5"";10///@;11;2;6;4;3;2.5;5;S Y="""";@5;10;11;2;6;4;3;2.5;5",DIE="^RMPR(667.3," D ^DIE K:'$D(DA) RID(RY) G:$O(RID(0)) EDT
EXIT ;ASK ADD ANOTHER ITEM BEFORE KILLING VARIABLES
 K DIR,DIC,DA,Y S DIR(0)="Y",DIR("B")="NO",DIR("A")="Would you like to add an another Item " W ! D ^DIR I +Y=1 G ENT
QUIT ;KILL VARIABLES
 L:$D(RMPRDA) -^RMPR(667,RMPRDA,0) D:'$D(DTOUT) LINK^RMPRS K X,Y,DA,RMPRDA,RMPRC,RDA,DR,DIE,DIC,DIR,DIK,RMPREP,RMPRED,RMPRDFN,RID,RMPRR,RMPRINFO,RZZZ,RC,RJ,RK,RT,RMPRG,RMPRITM,RMPRAM,RV,RE,RI,RY,QTY,RA,RMPRADD Q
EDIT I '$D(^RMPR(667.3,"AD",RMPRDA)) W !,"No Item for this V.O.R",$C(7) G QUIT
 D DSPR^RMPRAVR G:'$D(RID) DIC S RMPRITM=$P(RMPRR,U,3)
 S DIE="^RMPR(667.3,",(RDA,DA)=+Y,DR=".01;8;9;S:$P(^RMPR(667.3,DA,0),U,9)=""4"" Y=""@5"";10///@;11;2;6;4;3;2.5;5;S Y="""";@5;10;11;2;6;4;3;2.5;5" D ^DIE L:$D(DA) -^RMPR(667.3,DA,0) W ! G EDIT
REP I $D(RMPRG) G RLP
 L +^RMPR(669.9,RMPRSITE,0):999 I $T=0 S RMPRG=DT_99 G RLP
 S RMPRG=$P(^RMPR(669.9,RMPRSITE,0),U,7),RMPRG=RMPRG-1,$P(^RMPR(669.9,RMPRSITE,0),U,7)=RMPRG L -^RMPR(669.9,RMPRSITE,0)
RLP I '$D(^RMPR(667.3,"AD",RMPRDA)) W !!,"No Item for V.O.R",$C(7) H 3 G QUIT
 W !! D DSPR^RMPRAVR G:'$D(RID) DIC S:$D(RID) RMPRITM=$P(RMPRR,U,3)
 S X=DT,DIC(0)="Z",DIC="^RMPR(667.3," K DD,DO D FILE^DICN I +Y'>0 W !!,$C(7),"RECORD NOT ENTERED SEE YOUR IRM SERVICE" G QUIT
 S RDA=+Y,$P(^RMPR(667.3,RDA,0),U,2)=RMPRDA,$P(^(0),U,3)=RMPRITM,$P(^(0),U,5)=RMPRAM,$P(^(0),U,6)=$P(RMPRR,U,6),$P(^(0),U,7)=1,$P(^(0),U,8)="X"
 S $P(^RMPR(667.3,RDA,0),U,9)=$P(RMPRR,U,9),$P(^(0),U,10)=$P(RMPRR,U,10),$P(^(0),U,11)=$P(RMPRR,U,11),^(2)=RMPR("STA")_"^"_DUZ,^(3)=$S($D(RMPRG):RMPRG,1:0),DA=RDA,DIK="^RMPR(667.3," D IX1^DIK
 S DA=+Y,DIE=DIC,DR=".01;8;9;S:$P(^RMPR(667.3,DA,0),U,9)=""4"" Y=""@5"";10///@;11;2;6;3;2.5;5;S Y="""";@5;10;11;2;6;3;2.5;5" D ^DIE
 I $D(^RMPR(667.3,+RDA,0)),'$P(^(0),U,4) S DA=RDA,DIK="^RMPR(667.3," D ^DIK W !!,?5,$C(7),"Deleted..." H 3
 W @IOF G REP