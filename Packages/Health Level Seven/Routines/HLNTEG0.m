HLNTEG0 ;ISC/XTSUMBLD KERNEL - Package checksum checker ;2950912.142601
 ;;1.6;HEALTH LEVEL SEVEN;;Oct 13, 1995
 ;;7.3;2950912.142601
 S XT4="I 1",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,$S('XT3:"Routine not in UCI",XT3'=Y:"Calculated "_$C(7)_Y_", off by "_(Y-XT3),1:"ok")
 ;
 K %1,%2,%3,X,Y,XT1,XT2,XT3,XT4 Q
ONE S XT4="I $D(^UTILITY($J,X))",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
 W !,"Check a subset of routines:" K ^UTILITY($J) X ^%ZOSF("RSEL")
 W ! G CONT
ROU ;;
HLINI02M ;;9275464
HLINI02N ;;11459443
HLINI02O ;;9427882
HLINI02P ;;6027409
HLINI02Q ;;10293885
HLINI02R ;;7757452
HLINI02S ;;10198154
HLINI02T ;;7325413
HLINI02U ;;7046467
HLINI02V ;;8301282
HLINI02W ;;6905022
HLINI02X ;;5922992
HLINI02Y ;;3168490
HLINIS ;;2129328
HLINIT ;;10216312
HLINIT1 ;;4920297
HLINIT2 ;;5232061
HLINIT3 ;;16802193
HLINIT4 ;;3357231
HLINIT5 ;;2876409
HLLM ;;10329188
HLLM1 ;;3316521
HLLP ;;13196280
HLMA ;;3791837
HLMA0 ;;603501
HLMA1 ;;4194174
HLMA2 ;;1082489
HLONI001 ;;7503778
HLONI002 ;;8735162
HLONI003 ;;6432025
HLONI004 ;;7866718
HLONI005 ;;8087954
HLONI006 ;;7933359
HLONI007 ;;9360681
HLONI008 ;;8744626
HLONI009 ;;8315666
HLONI010 ;;8282845
HLONI011 ;;833649
HLONIT ;;973222
HLONIT1 ;;1682976
HLONIT2 ;;82275
HLONIT3 ;;10576036
HLPOST ;;4060423
HLPOST16 ;;7441421
HLPOSTQ ;;4443120
HLPRE16 ;;997068
HLSERV ;;3192635
HLTASK ;;2348227
HLTF ;;8479084
HLTF0 ;;4497673
HLTF1 ;;12182659
HLTP ;;5313409
HLTP0 ;;3059568
HLTP01 ;;3910226
HLTP1 ;;4281970
HLTP2 ;;1168795
HLTPCK1 ;;3874944
HLTPCK1A ;;9780503
HLTRANS ;;11965538
HLUOPT ;;11331726
HLUOPT1 ;;7058881
HLUTIL1 ;;1134063
HLUTIL2 ;;3877956
HLUTIL3 ;;424284