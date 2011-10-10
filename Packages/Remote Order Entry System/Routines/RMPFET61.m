RMPFET61 ;DDC/KAW-EVALUATE LINE ITEM STATUS [ 06/16/95   3:06 PM ]
 ;;2.0;REMOTE ORDER/ENTRY SYSTEM;;JUN 16, 1995
 ;; input: RMPFX,RMPFY,RMPFTYP,RMPFSTR0,RMPFSTR2,RMPFSTR3
 ;;output: RMPFERR
 Q:'$D(^RMPF(791810,RMPFX,101,RMPFY,0))
 K RMPFEDIT,RMPFERR S RMPFSTP=""
 S X=$P(^RMPF(791810,RMPFX,101,RMPFY,0),U,18)
 I X,$D(^RMPF(791810.2,X,0)) S RMPFSTP=$P(^(0),U,2)
 F I=4,8,9,10:1:16 I X=I G END
 S:RMPFSTP="" RMPFSTP="I" I RMPFSTP="I" S RMPFEDIT=""
 F I=0,2,3 S X=$G(^RMPF(791810,RMPFX,101,RMPFY,I)) I X'=@("RMPFSTR"_I) S RMPFEDIT="" Q
 G END:'$D(RMPFEDIT)
CK2 S ST="" I $D(^RMPF(791810.1,RMPFTYP,2)) S ST=$P(^(2),U,1) I ST'="" D
 .Q:'$D(^RMPF(791810,RMPFX,101,RMPFY,0))
 .F J=1:1 S D=$P(ST,";",J) Q:D=""  D  Q:D=9999
 ..I D?1"I ".E X D Q:'$T  S D=9999 Q
 ..S ND=$$GET1^DID(791810.0101,D,"","GLOBAL SUBSCRIPT LOCATION") S A=$P(ND,U,4),B=$P(A,";",1),C=$P(A,";",2) Q:B=""!(C="")
 ..I $D(^RMPF(791810,RMPFX,101,RMPFY,B)),C=0,$O(^RMPF(791810,RMPFX,101,RMPFY,B,0)) Q
 ..I $D(^RMPF(791810,RMPFX,101,RMPFY,B)),C'=0,$P(^RMPF(791810,RMPFX,101,RMPFY,B),U,C)'="" Q
 ..S E=$$GET1^DID(791810.0101,D,"","LABEL") S:E'="" RMPFERR(E)=""
 I ST[".01",'$O(^RMPF(791810,RMPFX,101,0)) S RMPFERR("NO ITEM SELECTED")=""
 S DIE="^RMPF(791810,"_RMPFX_",101,",DA(1)=RMPFX,DA=RMPFY
 I RMPFTYP'=5 S S=$S('$D(RMPFERR):"PENDING",1:"INCOMPLETE")
 E  S S=$S('$D(RMPFERR):"ISSUE DATE PENDING",1:"ERROR")
 S %DT="T",X="NOW" D ^%DT
 S DR=".17////"_Y_";.18///"_S_";.2////1"
 I $D(RMPFLA) S DR=DR_";.19////"_RMPFLA
 D ^DIE
END K RMPFSTP,RMPFSTR0,RMPFSTR2,RMPFSTR3,I,J,X,ST,RMPFEDIT,%DT,A,B,C,D,S
 K D0,DA,DI,DIC,DIE,DQ,DR,RMPFLA Q
PRIOR ;;Record data strings prior to editing
 ;; input: RMPFX,RMPFY
 ;;output: RMPFSTR0,RMPFSTR2,RMPFSTR3
 F I=0,2,3 S @("RMPFSTR"_I)=$G(^RMPF(791810,RMPFX,101,RMPFY,I))
 K I Q
CLEAR ;;Clear errors and disapprovals by line item
 ;; input: RMPFX,RMPFY,RMPFSTO
 ;;output: None
 W !!,"The status of this line item order is "
 W $P(^RMPF(791810.2,$P(^RMPF(791810,RMPFX,101,RMPFY,0),U,18),0),U,1)
CL1 W !!,"Do you wish to clear this status and edit the order? NO// "
 D READ Q:$D(RMPFOUT)
CL11 I $D(RMPFQUT) W !!,"Enter a <Y> to clear the status and edit the order",!?5,"an <N> to leave the status as it is" G CL1
 S YX=Y S:YX="" YX="N" S YX=$E(YX,1) I "NnYy"'[YX S RMPFQUT="" G CL11
 I "Nn"[YX K RMPFSTO G CLEARE
 S %DT="T",X="NOW" D ^%DT
 S ST=$S(RMPFSTO="S":"ISSUE DATE PENDING",1:"INCOMPLETE")
 S DIE="^RMPF(791810,"_RMPFX_",101,",DA(1)=RMPFX,DA=RMPFY
 S DR=".17////"_Y_";.18///"_ST_";.19////O;.2////1" D ^DIE
CLEARE K X,Y,YX,%DT,D0,DA,DI,DIC,DIE,DQ,DR,ST Q
READ K RMPFOUT,RMPFQUT
 R Y:DTIME I '$T W $C(7) R Y:5 G READ:Y="." S:'$T Y=U
 I Y?1"^".E S (RMPFOUT,Y)="" Q
 S:Y?1"?".E (RMPFQUT,Y)=""
 Q