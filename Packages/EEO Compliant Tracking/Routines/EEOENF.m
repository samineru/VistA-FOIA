EEOENF ;HISC/JWR - Informal complaint edit/manipulation routine ;Apr 20, 1995
 ;;2.0;EEO Complaint Tracking;**1,2,5**;Apr 27, 1995
 D ^EEOEOSE
EN S DIC("S")="I $$SCREEN^EEOEOSE(Y)"
 K DO,DD,D0 S DIC="^EEO(785,",DIC(0)="AELMQZ"
 S DIC("A")="Select NAME: "
 S DLAYGO=785 D ^DIC Q:X="^"!(X="")  S EEOY=Y,DA=+Y,DIE=785
 I $TR($G(^EEO(785,DA,4)),"^")'="" D MSG^EEOEOE2 W ! G EN
 I $P(Y,U,3)=1 S DR="98///"_DUZ_";14///"_DUZ_";2///"_EEOYSPTR D ^DIE
 E  I '$D(^EEO(785.5,+EEOY)) K DR S EEOFF=785,EEOCTF=785.5 D GATHER
 K DR D CASENO^EEOEOSE
 S (DLAYGO,DIE)=785.5,(DA,DINUM)=+EEOY
 D DRS S EEOFF=785.5,EEOCTF=785 D GATHER,FORMAL^EEOEOE2
 D COUNTER K EEOY,DIC,DR,DIE,DLAYGO,CN,EEO2,EEOF,EEOINF W ! G EN
GATHER ;
 Q:$P($G(^EEO(EEOFF,+EEOY,1)),U,3)>0!($P($G(^EEO(EEOCTF,+EEOY,1)),U,3)>0)
 F EEO=0,1,5,6 S EEOF(EEO)=$G(^EEO(EEOCTF,+EEOY,EEO))
 F EEO=0,1,5,6 S EEOINF(EEO)=$G(^EEO(EEOFF,+EEOY,EEO))
 F EEO=8,9,10 I $D(^EEO(EEOCTF,+EEOY,EEO)) S EEO1=0 F  S EEO1=$O(^(EEO,EEO1)) Q:EEO1'>0  D
 .S EEOF(EEO,EEO1)=$G(^EEO(EEOCTF,+EEOY,EEO,EEO1,0))
 F EEO=8,9,10 I $D(^EEO(EEOFF,+EEOY,EEO)) S EEO1=0 F  S EEO1=$O(^EEO(EEOFF,+EEOY,EEO,EEO1)) Q:EEO1'>0  D
 .S EEOINF(EEO,EEO1)=$G(^EEO(EEOFF,+EEOY,EEO,EEO1,0))
 F EEO=0,1,5,6 D
 .Q:$G(EEOINF(EEO))=$G(EEOF(EEO))
 .F CN=1:1:35 D
 ..Q:$P(EEOINF(EEO),U,CN)=$P(EEOF(EEO),U,CN)
 ..Q:'$D(^DD(785,"GL",EEO,CN))
 ..S FLD=$O(^DD(785,"GL",EEO,CN,"")) Q:'$D(^DD(EEOFF,FLD))
 ..S DR=FLD_"///"_$S($P(EEOINF(EEO),U,CN)]"":"/"_$P(EEOINF(EEO),U,CN),1:"@") D DIE
 D MULT Q
DIE Q:$G(DR)=""  S DIE=EEOCTF,DA=+EEOY D ^DIE K DR Q
MULT ; wipe out multiples and reset based on new values
 F EEO=8,9,10 D
 . K ^EEO(EEOCTF,+EEOY,EEO)
 . N %X,%Y
 . S %X="^EEO(EEOFF,+EEOY,EEO,",%Y="^EEO(EEOCTF,+EEOY,EEO,"
 . D %XY^%RCR
 Q
MULT01 ;
 S MFILE=$S(EEO=8:785.2,EEO=10:786,EEO=9:785.1,1:"")
 S EEOMU=$P(^EEO(MFILE,$P(EEOINF(EEO,EEO2),U),0),U)
 Q
DRS ;
 S DR="I $G(^EEO(785,DA,""SEC""))'>0 S Y=.01;98////"_DUZ_";14////"_DUZ_";.01///"_$P(EEOY,U,2)_";1.3///"_EEOZ_";2///"_EEOYSPTR D ^DIE K DR
 S DR=".01;14;.05:.091;5;6.5;6;8;I X="""" S Y=14.5;9:13;14.5;14.7;15.7;I X="""" S Y=16.05;15.9;16.05;16.07;15.5;15;18.5;17.5;19;61;60.5;60;16.5;16.7",DIE=785
 I $G(EEOCOUNS)'>0&($P($G(^EEO(785,D0,1)),U,3)>0) D STATE
 I $G(EEOCOUNS)>0!($P($G(^EEO(785,D0,1)),U,3)'>0) D DRS1
DIEDR D ^DIE K DR,DIE,EEOFF,EEOCFT,EEOMU Q
DRS1 ;Entry point to update informal complaint file (785.5)
 S DIE=785.5,DR=".01;14;.05:.091;5;6.5;6;8;I X="""" S Y=14.5;9:13;14.5;14.7;15.7;I X="""" S Y=16.05;15.9;16.05;16.07;15.5;15;18.5;17.5;19;61;60.5;60;16.5;16.7"
 Q
COUNTER ;
 Q:'$D(^EEO(785.5))  Q:'$D(^(785.5,"ANODE"))
 S EEOIEN=$O(^EEO(785.5,"ANODE","")),(EOIEN,EONUM)=0
 F  S EOIEN=$O(^EEO(785.5,"ANODE",EOIEN)) Q:EOIEN'>0  D
 . S EONUM=EONUM+1 Q
 S:EONUM'>0 (EONUM,EEOIEN)=""
 S $P(^EEO(785.5,0),U,3)=EEOIEN,$P(^(0),U,4)=EONUM
 K EEOIEN,EOIEN,EONUM Q
STATE ;
 S $P(EEO9NF,"*",79)=""
 W !!,EEO9NF,!,"This complaint is now formal, further edits will not be reflected on the",!,"Complaint Intake Form (FORM 0210).",!,EEO9NF,!! K EEO9NF