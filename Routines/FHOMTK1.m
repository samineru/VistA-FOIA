FHOMTK1 ;Hines OIFO/RTK OUTPATIENT MEALS TRAY TICKETS  ;7/02/03  14:05
 ;;5.5;DIETETICS;**5**;Jan 28, 2005;Build 53
 ;
START S RM="",FHBY=$E($G(FHBY),1) I FHBY="" Q
 S FHDTE=D1
 S X1=D1,X2=-1 D C^%DTC S FHRMDTE=X
 S X1=D1,X2=1 D C^%DTC S FHDTQ=X
 ;NEW CODE FOR SORTING
BLDTMP ; First build data in ^TMP global
 K ^TMP($J,"OPTX")
 ; Recurring Meals
 F FHOMDT=FHRMDTE:0 S FHOMDT=$O(^FHPT("RM",FHOMDT)) Q:FHOMDT=""!(FHOMDT'<FHDTQ)  D
 .F FHDFN=0:0 S FHDFN=$O(^FHPT("RM",FHOMDT,FHDFN)) Q:FHDFN=""  D
 ..D PATNAME^FHOMUTL I DFN'="" I $G(^DPT(DFN,.1))'="" Q
 ..F FHRNUM=0:0 S FHRNUM=$O(^FHPT("RM",FHOMDT,FHDFN,FHRNUM)) Q:FHRNUM=""  D
 ...S FHZN=$G(^FHPT(FHDFN,"OP",FHRNUM,0)),FHLOC=$P(FHZN,U,3) Q:FHLOC=""
 ...S FHSTAT=$P(FHZN,U,15) Q:FHSTAT="C"
 ...S FHMEAL=$P(FHZN,U,4)
 ...I FHOMEAL'="A",FHOMEAL'[FHMEAL Q
 ...I FHBY="P",FHDFN'=FHTTDFN Q
 ...I FHBY="L",W1'=FHLOC Q
 ...I FHBY="C" S FHCOMM=$P($G(^FH(119.6,FHLOC,0)),U,8) I FHP'=FHCOMM Q
 ...S FHLOCNM=$P($G(^FH(119.6,FHLOC,0)),U,1) I FHMEAL="E" S FHMEAL="Z"
 ...I SRT="R" S ^TMP($J,"OPTX",FHLOCNM,FHMEAL_"~"_FHPTNM_"~"_FHDFN_"~R~"_FHRNUM)=FHZN
 ...I SRT'="R" S ^TMP($J,"OPTX",FHPTNM,FHMEAL_"~"_FHLOCNM_"~"_FHDFN_"~R~"_FHRNUM)=FHZN
 ...Q
 ..Q
 .Q
 ; Special Meals
 F FHOMDT=FHDTE:0 S FHOMDT=$O(^FHPT("SM",FHOMDT)) Q:FHOMDT=""!(FHOMDT>FHDTQ)  D
 .F FHDFN=0:0 S FHDFN=$O(^FHPT("SM",FHOMDT,FHDFN)) Q:FHDFN=""  D
 ..D PATNAME^FHOMUTL I DFN'="" I $G(^DPT(DFN,.1))'="" Q
 ..S FHZN=$G(^FHPT(FHDFN,"SM",FHOMDT,0)),FHLOC=$P(FHZN,U,3) Q:FHLOC=""
 ..S FHSTAT=$P(FHZN,U,2) Q:FHSTAT'="A"
 ..S FHMEAL=$P(FHZN,U,9)
 ..I FHOMEAL'="A",FHOMEAL'[FHMEAL Q
 ..I FHBY="P",FHDFN'=FHTTDFN Q
 ..I FHBY="L",W1'=FHLOC Q
 ..I FHBY="C" S FHCOMM=$P($G(^FH(119.6,FHLOC,0)),U,8) I FHP'=FHCOMM Q
 ..S FHLOCNM=$P($G(^FH(119.6,FHLOC,0)),U,1) I FHMEAL="E" S FHMEAL="Z"
 ..I SRT="R" S ^TMP($J,"OPTX",FHLOCNM,FHMEAL_"~"_FHPTNM_"~"_FHDFN_"~S")=FHZN
 ..I SRT'="R" S ^TMP($J,"OPTX",FHPTNM,FHMEAL_"~"_FHLOCNM_"~"_FHDFN_"~S")=FHZN
 ..Q
 .Q
 ; Guest Meals
 F FHOMDT=FHDTE:0 S FHOMDT=$O(^FHPT("GM",FHOMDT)) Q:FHOMDT=""!(FHOMDT>FHDTQ)  D
 .F FHDFN=0:0 S FHDFN=$O(^FHPT("GM",FHOMDT,FHDFN)) Q:FHDFN=""  D
 ..D PATNAME^FHOMUTL I DFN'="" I $G(^DPT(DFN,.1))'="" Q
 ..S FHZN=$G(^FHPT(FHDFN,"GM",FHOMDT,0)),FHLOC=$P(FHZN,U,5) Q:FHLOC=""
 ..S FHSTAT=$P(FHZN,U,9) Q:FHSTAT="C"
 ..S FHMEAL=$P(FHZN,U,3)
 ..I FHOMEAL'="A",FHOMEAL'[FHMEAL Q
 ..I FHBY="P",FHDFN'=FHTTDFN Q
 ..I FHBY="L",W1'=FHLOC Q
 ..I FHBY="C" S FHCOMM=$P($G(^FH(119.6,FHLOC,0)),U,8) I FHP'=FHCOMM Q
 ..S FHLOCNM=$P($G(^FH(119.6,FHLOC,0)),U,1) I FHMEAL="E" S FHMEAL="Z"
 ..I SRT="R" S ^TMP($J,"OPTX",FHLOCNM,FHMEAL_"~"_FHPTNM_"~"_FHDFN_"~G")=FHZN
 ..I SRT'="R" S ^TMP($J,"OPTX",FHPTNM,FHMEAL_"~"_FHLOCNM_"~"_FHDFN_"~G")=FHZN
 ..Q
 .Q
 ;
 ;Now process sorted OM tray tickets
 I '$D(^TMP($J,"OPTX")) Q
 S FHINDX="" F  S FHINDX=$O(^TMP($J,"OPTX",FHINDX)) Q:FHINDX=""  D
 .S FHINDX2="" F  S FHINDX2=$O(^TMP($J,"OPTX",FHINDX,FHINDX2)) Q:FHINDX2=""  D
 ..S FHZN=$G(^TMP($J,"OPTX",FHINDX,FHINDX2)),FHOMDT=$P(FHZN,U,1)
 ..S FHMEAL=$P(FHINDX2,"~",1)  I FHMEAL="Z" S FHMEAL="E"  ;for sorting
 ..S FHDFN=$P(FHINDX2,"~",3),FHOMTYP=$P(FHINDX2,"~",4)
 ..S FHLOC=$P(FHZN,U,3) I FHOMTYP="G" S FHLOC=$P(FHZN,U,5)
 ..I FHOMTYP="R" S FHRNUM=$P(FHINDX2,"~",5)
 ..I UPD,FHOMTYP="R",$P(FHZN,U,16)<$P(FHZN,U,13) Q
 ..I UPD,FHOMTYP="S",$P(FHZN,U,10)'="" Q
 ..I FHOMEAL'="A" D BLD^FHOMTK2 Q
 ..S MEAL=FHMEAL D BLD^FHOMTK2
 ..Q
 .Q
 I $G(NBR) D PRT^FHMTK1C Q
 K FHTTDFN Q