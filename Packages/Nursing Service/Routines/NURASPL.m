NURASPL ;HIRMFO/MD-VIEW OF INDIVIDUAL STAFF POSITIONS
 ;;4.0;NURSING SERVICE;;Apr 25, 1997
A Q:'$D(^DIC(213.9,1,"OFF"))  Q:$P(^DIC(213.9,1,"OFF"),"^")=1
 W @IOF S DIC="^NURSF(210,",DIC(0)="AEQMZ",DIC("A")="Select Nursing Staff Name: " D ^DIC K DIC G:"^"[X QUIT
 I '+Y W $C(7),!!,"NO STAFF RECORD FOR THIS EMPLOYEE:",! G QUIT
 S NURSDBA=+Y,NUROUT=0,NURLS="A",NID=$S($D(^NURSF(210,+NURSDBA,0)):$P(^(0),"^"),1:""),X1=$O(^NURSF(211.8,"ASDT",+NID,"")),X2=-1 D C^%DTC S Y=X K X1,X2 S NURSTDT=Y
 D WRITE^NURAED1,WRT1^NURAED1,QC^NURAED1 K NURSDBA
 W !!,$C(7),"Press return to continue: " R X:DTIME
 G A
QUIT ;
 K NUR200C,NUROUT,X2,X1,NURSLS,NURSDBA,NID,NURSDT,X,Y,Z D:$D(NURSADD) ^%ZISC
 Q
EN1 ; ENTRY POINT TO DISPLAY CURRENT ASSIGNMENTS IN STAFF PRINT
 S NURSDBA=+D0,NUROUT=0,NURLS="C",NID=$S($D(^NURSF(210,+NURSDBA,0)):$P(^(0),"^"),1:""),NURSTDT=DT
 D WRITE^NURAED1,WRT1^NURAED1,QC^NURAED1 K NURSDBA
 D EN11^NURSUT0($G(D0))
 S Z=$$EN12^NURSUT0(D0) W !,?24,"SALARY: ",$J(+Z,6,2)
 D QUIT
 Q
