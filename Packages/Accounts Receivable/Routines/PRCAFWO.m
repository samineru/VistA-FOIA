PRCAFWO ;WASH-ISC@ALTOONA,PA/CLH-FMS WRITE OFF DOCUMENT  ;8/2/95  3:20 PM
V ;;4.5;Accounts Receivable;**16,48,89,90,204**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
EN(BN,DATE,AMOUNT,SITE,TN) ;entry point for auto-creation of FMS write off document
 NEW GECSFMS,FMSNUM,DA,TYPE,NUM,FMSNUM1 KILL ^TMP("PRCAWR",$J)
 SET NUM=$PIECE(^PRCA(430,BN,0),U),NUM=$PIECE(NUM,"-")_$PIECE(NUM,"-",2)
 SET FMSNUM=$$ENUM^RCMSNUM
 SET TYPE=$$RECTYP^PRCAFUT(BN)
 DO CONTROL^GECSUFMS("A",SITE,FMSNUM,"WR",10,"","N","WRITE OFF")
 S FMSNUM1=$P($G(GECSFMS("DOC")),U,3)_"-"_$P($G(GECSFMS("DOC")),U,4)
 DO OPEN^RCFMDRV1(FMSNUM1,1,"T"_TN,.ENT,.ERR,BN,TN)
 N FMSDT S FMSDT=$$FMSDATE^RCBEUTRA(DT)
 SET ^TMP("PRCAWR",$J,1)="CR2^"_$EXTRACT(FMSDT,2,3)_U_$EXTRACT(FMSDT,4,5)_U_$EXTRACT(FMSDT,6,7)_"^^^^^^E^^^999999999999^^"_$JUSTIFY(AMOUNT,0,2)_"^^"_$EXTRACT(DT,2,3)_U_$EXTRACT(DT,4,5)_U_$EXTRACT(DT,6,7)_"^~"
 I "^30^32^"[("^"_$P($G(^PRCA(430,+BN,0)),"^",2)_"^") S $P(^TMP("PRCAWR",$J,1),"^",15)=$TR($P(^TMP("PRCAWR",$J,1),"^",15),"-","")
 SET ^TMP("PRCAWR",$J,2)="LIN^~"
 SET ^TMP("PRCAWR",$J,3)="CRA^001^^^^^^^^^^^^^^^^^"_$JUSTIFY(AMOUNT,0,2)_"^I^^"_$P($$DTYPE^PRCAFBD1(TYPE),U,4)_"^BD^"_NUM_"^"_$$LINE^RCXFMSC1(BN)_"^~"
 ;Tricare document
 I "^30^32^"[("^"_$P($G(^PRCA(430,+BN,0)),"^",2)_"^") S $P(^TMP("PRCAWR",$J,3),"^",22)="06",$P(^TMP("PRCAWR",$J,3),"^",19)=$TR($P(^TMP("PRCAWR",$J,3),"^",19),"-","")
 SET DA=0 FOR  SET DA=$ORDER(^TMP("PRCAWR",$J,DA)) QUIT:'DA  DO SETCS^GECSSTAA(GECSFMS("DA"),^(DA))
 DO SETCODE^GECSSDCT(GECSFMS("DA"),"D RETN^RCFMFN02")
 DO SETSTAT^GECSSTAA(GECSFMS("DA"),"Q")
 DO SSTAT^RCFMFN02("T"_TN,1)
 WRITE !,"WRITE OFF Document Created.  Number # ",GECSFMS("DA"),".",!
 SET $PIECE(^PRCA(430,BN,11),U,22)=$P(FMSNUM,"-")_$P(FMSNUM,"-",2)
 KILL ^TMP("PRCAWR",$J)
 QUIT
 ;
MODWR(BN,AMOUNT,FMSNUM,TN,MOD) ;send modified write-off document
 W !!,"Creating Modified WR document..."
 NEW GECSFMS,DA,TYPE,NUM,FMSNUM1 KILL ^TMP("PRCAWR",$J)
 S NUM=$P(^PRCA(430,BN,0),U),NUM=$P(NUM,"-")_$P(NUM,"-",2)
 S TYPE=$$RECTYP^PRCAFUT(BN)
 D CONTROL^GECSUFMS("A",$$SITE^RCMSITE,FMSNUM,"WR",10,$S(MOD=1:1,1:""),"N","MODIFIED WRITE OFF")
 I MOD S FMSNUM1=$P($G(GECSFMS("DOC")),U,3)_"-"_$P($G(GECSFMS("DOC")),U,4)_"-"_$P($G(GECSFMS("BAT")),U,3)
 D OPEN^RCFMDRV1($S($D(FMSNUM1):FMSNUM1,1:FMSNUM),1,"T"_TN,.ENT,.ERR,BN,TN)
 N FMSDT S FMSDT=$$FMSDATE^RCBEUTRA(DT)
 S ^TMP("PRCAWR",$J,1)="CR2^"_$E(FMSDT,2,3)_U_$E(FMSDT,4,5)_U_$E(FMSDT,6,7)_"^^^^^^M^^^999999999999^^"_$J(AMOUNT,0,2)_"^^"_$E(DT,2,3)_U_$E(DT,4,5)_U_$E(DT,6,7)_"^~"
 S ^TMP("PRCAWR",$J,2)="LIN^~"
 S ^TMP("PRCAWR",$J,3)="CRA^001^^^^^^^^^^^^^^^^^"_$J(AMOUNT,0,2)_"^D^^"_$P($$DTYPE^PRCAFBD1(TYPE),U,4)_"^BD^"_NUM_"^"_$$LINE^RCXFMSC1(BN)_"^~"
 S DA=0 FOR  S DA=$O(^TMP("PRCAWR",$J,DA)) Q:'DA  D SETCS^GECSSTAA(GECSFMS("DA"),^(DA))
 D SETCODE^GECSSDCT(GECSFMS("DA"),"D RETN^RCFMFN02")
 D SETSTAT^GECSSTAA(GECSFMS("DA"),"Q")
 D SSTAT^RCFMFN02("T"_TN,1)
 W !,"Document Created.  Number # ",GECSFMS("DA"),".",!
 I '$G(REFMS)&(DT>$$LDATE^RCRJR(DT)) S Y=$E($$FPS^RCAMFN01(DT,1),1,5)_"01" D DD^%DT W !!,"   * * * * Transmission will be held until "_Y_" * * * *"
 S $P(^PRCA(430,BN,11),U,22)=FMSNUM
 K ^TMP("PRCAWR",$J)
 Q
 ;