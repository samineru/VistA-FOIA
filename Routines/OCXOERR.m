OCXOERR ;SLC/RJS,CLA - External Interface - PROCESS OERR ORDER EVENT ;10/29/98  12:37
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**32**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
 ;
 Q
SILENT(OCXORD,OUTMSG) ;
 ;
 N OCXRDT,OCXOZZT
 S OCXRDT=($H*86400+$P($H,",",2))
 S:'$D(OUTMSG) OUTMSG=""
 D CHECK(OCXORD,.OUTMSG)
 Q
VERBOSE(OCXORD) ;
 ;
 N OCXX,OUTMSG,OCXOZZT
 S OCXRDT=($H*86400+$P($H,",",2))
 S OUTMSG=""
 D CHECK(OCXORD,.OUTMSG)
 W:$O(OUTMSG(0)) !,"Order Check Message: ",$C(7)
 S OCXX=0 F  S OCXX=$O(OUTMSG(OCXX)) Q:'OCXX  W !,OUTMSG(OCXX)
 W:$O(OUTMSG(0)) !,$C(7)
 Q
 ;
CHECK(OCXORD,OUTMSG) ;
 ;
 I $$RTEST D  Q
 .N OMSG,OTMOUT,OCXM
 .S OMSG="^25^^Order Checking is recompiling and momentarily disabled"
 .S OCXM=0 F  S OCXM=$O(OUTMSG(OCXM)) Q:'OCXM  Q:(OUTMSG(OCXM)[OMSG)
 .Q:OCXM
 .S OUTMSG($O(OUTMSG(""),-1)+1)=OMSG
 ;
 N OCXSUB,OCXTEST,OCXDATA,OCXEL,OCXSEG0,DFN,%DT,X,Y
 N OCXOLOG,OCXORDT,OCXOSRC
 ;
 S DFN=+OCXORD
 S X="N",%DT="T" D ^%DT S OCXORDT=+Y
 Q:'DFN
 ;
 S (OCXTEST,OCXDATA)=""
 S OCXOSRC="CPRS ORDER PROTOCOL"
 ;
 S OCXOLOG=$$LOG(OCXORD)
 ;
 D UPDATE^OCXOZ01(DFN,OCXOSRC,.OUTMSG)
 ;
 D FINISH^OCXOLOG(OCXOLOG)
 ;
 Q
 ;
RTEST() ;
 N DATE,TMOUT
 Q:'$L($T(^OCXOZ01)) 1
 I '($P($G(^OCXD(861,1,0)),U,1)="SITE PREFERENCES") K ^OCXD(861,1) S ^OCXD(861,1,0)="SITE PREFERENCES"
 S DATE=$P($G(^OCXD(861,1,0)),U,3)
 I DATE,((+DATE)=(+$H)),(((+$P($H,",",2))-(+$P(DATE,",",2)))<1800) Q 1
 Q 0
 ;
LOG(OCXORD) ;
 ;   Log Messages
 ;
 I $G(OCXTRACE),$$CDATA^OCXOZ01 Q 0
 Q:'$L($T(LOG^OCXOZ01)) 0 Q:'$$LOG^OCXOZ01 0
 N OCXDFN,OCXNL
 S OCXARY="OCXNL"
 S OCXNL(1)="OCXORD="_OCXORD
 Q $$NEW^OCXOLOG(OCXARY,"OERR",+$G(DUZ),+OCXORD)
 ;
ERROR Q
 ;
 ; **** Old Labels to insure backwards compatibility ****
 ;
PROC(OCXORD,OUTMSG) ;
 D SILENT(OCXORD,.OUTMSG)
 Q
 ;
EN(OCXORD) ;
 N OUTMSG S OUTMSG=""
 D SILENT(OCXORD,.OUTMSG) Q
 ;