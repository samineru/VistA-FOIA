GMRYRP4 ;HIRMFO/YH-TMP FOR SUMMING UP PATIENT I/O ;3/27/97
 ;;4.0;Intake/Output;**2**;Apr 25, 1997
SUM ;
 S (GCURDT,GDATE)=0 F II=0:0 S GDATE=$O(^TMP($J,"GMRY",GDATE)) D:GDATE'>0 SDATE Q:GMROUT!(GDATE'>0)  D:GCURDT'=GDATE SDATE Q:GMROUT  S:GDATE>0 GNDATE=GDATE D SHIFT
 Q
SHIFT ;
 S (GCSHFT,GSHIFT)="" F II=0:0 S GSHIFT=$O(^TMP($J,"GMRY",GDATE,GSHIFT)) D:GSHIFT="" WSHIFT Q:GMROUT!(GSHIFT="")  D:GCSHFT'=GSHIFT WSHIFT Q:GMROUT  D IOSUM
 Q
IOSUM ;
 S GIO="" F II=0:0 S GIO=$O(^TMP($J,"GMRY",GDATE,GSHIFT,GIO)) Q:GIO=""  D IOTIME
 Q
IOTIME ;
 S GHR=0 F II=0:0 S GHR=$O(^TMP($J,"GMRY",GDATE,GSHIFT,GIO,GHR)) Q:GHR'>0  S GOPT=$S(GIO="IN"!(GIO="OUT"):"IOTYPE",GIO="IV":"SUMIV",1:"") Q:GOPT=""  D @GOPT
 Q
IOTYPE ;
 S GTYPE=0 F II=0:0 S GTYPE=$O(^TMP($J,"GMRY",GDATE,GSHIFT,GIO,GHR,GTYPE)) Q:GTYPE'>0  S GSUB=0 F  S GSUB=$O(^TMP($J,"GMRY",GDATE,GSHIFT,GIO,GHR,GTYPE,GSUB)) Q:GSUB'>0  D ADD
 Q
ADD ;
 I GIO="IN",'$D(GTYPI(GTYPE)) Q
 I GIO="OUT",'$D(GTYPO(GTYPE)) Q
 I GIO="IN" D  Q
 . S GIN=+GTYPI(GTYPE),GAMOUNT=$P(^TMP($J,"GMRY",GDATE,GSHIFT,GIO,GHR,GTYPE,GSUB),"^"),GIN(GIN)=GIN(GIN)+GAMOUNT,GTOTIN(GIN)=GTOTIN(GIN)+GAMOUNT
 . I GAMOUNT'>0,GAMOUNT'="0" S (GSIP(GIN),GDIP(GIN),GRNDIP)="+"
 I GIO="OUT" D  Q
 . S GOUT=+GTYPO(GTYPE),GAMOUNT=$P(^TMP($J,"GMRY",GDATE,GSHIFT,GIO,GHR,GTYPE,GSUB),"^"),GOUT(GOUT)=GOUT(GOUT)+GAMOUNT,GTOTOUT(GOUT)=GTOTOUT(GOUT)+GAMOUNT
 . I GAMOUNT'>0,GAMOUNT'="0" S (GSOP(GTYPE),GDOP(GTYPE),GRNDOP)="+"
 I GIO="IV" D  Q
 . S GAMOUNT=$P(^TMP($J,"GMRY",GDATE,GSHIFT,GIO,GHR,GIVDT,GTYPE,GSUB,GDA),"^") Q:GAMOUNT>2000000!(GDA=3)  S GIN(GIN)=GIN(GIN)+GAMOUNT,GTOTIN(GIN)=GTOTIN(GIN)+GAMOUNT
 . I $P(^TMP($J,"GMRY",GDATE,GSHIFT,GIO,GHR,GIVDT,GTYPE,GSUB,GDA),"^",6)="*" S (GSIP(GIN),GDIP(GIN),GRNDIP)="+"
 Q
SUMIV ;
 S GIVDT=0 F II=0:0 S GIVDT=$O(^TMP($J,"GMRY",GDATE,GSHIFT,GIO,GHR,GIVDT)) Q:GIVDT'>0  D IVLINE
 Q
IVLINE ;
 S GTYPE="" F II=0:0 S GTYPE=$O(^TMP($J,"GMRY",GDATE,GSHIFT,GIO,GHR,GIVDT,GTYPE)) Q:GTYPE=""  D IVSUB
 Q
IVSUB S GSUB=0 F  S GSUB=$O(^TMP($J,"GMRY",GDATE,GSHIFT,GIO,GHR,GIVDT,GTYPE,GSUB)) Q:GSUB'>0  S GIN=$S(GTYPE="B":2,GTYPE="A"!(GTYPE="P")!(GTYPE="L"):1,GTYPE="H"!(GTYPE="I"):3,1:0) D
 .S GDA=$O(^TMP($J,"GMRY",GDATE,GSHIFT,GIO,GHR,GIVDT,GTYPE,GSUB,0)) D:GIN>0 ADD
 Q
WSHIFT ;
 I GCSHFT="" S GCSHFT=GSHIFT Q
 I GRPT<5 D CKSH
 W:GRPT<5 !,$S(GCSHFT="SH-1":"N:",GCSHFT="SH-2":"D:",GCSHFT="SH-3":"E:",1:" "),$E(GLN(4),3,$L(GLN(4))),! S GX=1
 I GRPT<5 F II=1:1:GN(1) D
 . S GIN(II)=GIN(II)_GSIP(II) S:GIN(II)="0+" GIN(II)="+"
 . W ?GX,$E(GBLNK,1,4-$L(GIN(II)))_GIN(II)_"|" S GX=GX+6
 I GRPT<5 F II=1:1:GN(2) D
 . S GOUT(II)=GOUT(II)_GSOP(II) S:GOUT(II)="0+" GOUT(II)="+"
 . W ?GX,$E(GBLNK,1,4-$L(GOUT(II)))_GOUT(II)_"|" S GX=GX+6
 S:GSHIFT'="" GCSHFT=GSHIFT D INISHFT^GMRYRP3,SHFTP^GMRYRP3
 Q
SDATE ;
 S (GNSH(1),GNSH(2),GNSH(3))=0 I GCURDT=0 S GCURDT=GDATE S GY=$E(GCURDT,4,5)_"/"_$E(GCURDT,6,7)_"/"_$E(GCURDT,2,3) W:GRPT=1!(GRPT=4) GY,$E(GLN(4),9,$L(GLN(4))) Q
 D DAYTOT Q:GDATE'>0!GMROUT  S GCURDT=GDATE,GY=$E(GCURDT,4,5)_"/"_$E(GCURDT,6,7)_"/"_$E(GCURDT,2,3) W:GRPT<5 GY,$E(GLN(4),9,$L(GLN(4))) Q
 Q
DAYTOT ;
 I GRPT<5 D CKSH1
 W:GRPT<5 !!,"TOTAL:",$E(GLN(4),7,$L(GLN(4))),!
 S GTOTLI=0,GX=1 F II=1:1:GN(1) D
 . S GTOTIN(II)=GTOTIN(II)_GDIP(II) S:GTOTIN(II)="0+" GTOTIN(II)="+"
 . W:GRPT<5 ?GX,$E(GBLNK,1,4-$L(GTOTIN(II)))_GTOTIN(II)_"|" S:GRPT=5 ^TMP($J,"GMR","XI"_II,GCURDT,GTOTIN(II))="" S GX=GX+6,GTOTLI=GTOTLI+GTOTIN(II)
 S:GRPT=5 II=II+1,^TMP($J,"GMR","XI"_II,GCURDT,GTOTLI)=""
 S GTOTLO=0 F II=1:1:GN(2) D
 . S GTOTOUT(II)=GTOTOUT(II)_GDOP(II) S:GTOTOUT(II)="0+" GTOTOUT(II)="+"
 . W:GRPT<5 ?GX,$E(GBLNK,1,4-$L(GTOTOUT(II)))_GTOTOUT(II)_"|" S:GRPT=5 ^TMP($J,"GMR","XO"_II,GCURDT,GTOTOUT(II))="" S GX=GX+6,GTOTLO=GTOTLO+GTOTOUT(II)
 S:GRPT=5 II=II+1,^TMP($J,"GMR","XO"_II,GCURDT,GTOTLO)=""
 I GRPT<5 D
 . W !!,?15,"TOTAL INTAKE MEASURED: ",$S(GTOTLI=0&(GRNDIP="+"):"+",1:GTOTLI_GRNDIP),!,?15,"TOTAL OUTPUT MEASURED: ",$S(GTOTLO=0&(GRNDOP="+"):"+",1:GTOTLO_GRNDOP),!,$E(GMRX,1,GMRCOL),!
 D INITOT^GMRYRP3,DAYP^GMRYRP3 S (GRNGIP,GRNDOP)=""
 D:GRPT<5&(GDATE>0)&($E(IOST)="C"!($E(IOST)="P"&(($Y+5)>IOSL))) HEADER^GMRYRP3 Q
 Q
CKSH ;PRINT LINE FOR NO I/O DATA
 I $P(GCSHFT,"-",2)=2&'$D(^TMP($J,"GMRY",GNDATE,"SH-1"))&(GNSH(1)=0) W !,"N:",$E(GLN(4),3,$L(GLN(4))),!,GLN(5) S GNSH(1)=1 Q
 I $P(GCSHFT,"-",2)=3&'$D(^TMP($J,"GMRY",GNDATE,"SH-1"))&(GNSH(1)=0) W !,"N:",$E(GLN(4),3,$L(GLN(4))),!,GLN(5) S GNSH(1)=1
 I $P(GCSHFT,"-",2)=3&'$D(^TMP($J,"GMRY",GNDATE,"SH-2"))&(GNSH(2)=0) W !,"D:",$E(GLN(4),3,$L(GLN(4))),!,GLN(5) S GNSH(2)=1
 Q
CKSH1 ;PRINT LINE FOR NO I/O DATA
 I $P(GCSHFT,"-",2)=1&'$D(^TMP($J,"GMRY",GNDATE,"SH-2"))&'GNSH(2) W !,"D:",$E(GLN(4),3,$L(GLN(4))),!,GLN(5) S GNSH(2)=1
 I $P(GCSHFT,"-",2)=1&'$D(^TMP($J,"GMRY",GNDATE,"SH-3"))&'GNSH(3) W !,"E:",$E(GLN(4),3,$L(GLN(4))),!,GLN(5) S GNSH(3)=1
 I $P(GCSHFT,"-",2)=2&'$D(^TMP($J,"GMRY",GNDATE,"SH-3"))&'GNSH(3) W !,"E:",$E(GLN(4),3,$L(GLN(4))),!,GLN(5) S GNSH(3)=1
 Q