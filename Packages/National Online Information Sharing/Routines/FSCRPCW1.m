FSCRPCW1 ;SLC/STAFF-NOIS RPC Web Page Main ;7/22/98  15:16
 ;;1.1;NOIS;;Sep 06, 1998
 ;
MAIN(CNT) ; from FSCRPCWP
 N ADDRESS,LINE,NUM,PACK,PACKNAME,ZERO
 S ADDRESS=$P($G(^FSC("PARAM",1,1.8)),U,2)
 D SET("{MAIN}",.CNT)
 D SET("main.htm",.CNT)
 D SET("<HTML>",.CNT)
 D SET("<HEAD>",.CNT)
 D SET("<TITLE>NOIS Solution Index</TITLE>",.CNT)
 D SET("</HEAD>",.CNT)
 D SET("<BODY TEXT=""#000000"" BGCOLOR=""#FFFFFF"">",.CNT)
 D SET("<H1><CENTER>Solution Index</CENTER></H1>",.CNT)
 D SET("<HR>",.CNT)
 D SET("<P><B>Packages:</B></P>",.CNT)
 S PACKNAME="" F  S PACKNAME=$O(^FSC("PACK","B",PACKNAME)) Q:PACKNAME=""  D
 .S PACK=0 F  S PACK=$O(^FSC("PACK","B",PACKNAME,PACK)) Q:PACK<1  D
 ..I '$O(^FSCD("WEB","C",PACK,0)) Q
 ..S LINE="<a href="""_ADDRESS_"pack"_PACK_".htm"">"_PACKNAME_"</a>"
 ..D SET(LINE_"<BR>",.CNT)
 D SET("</BODY>",.CNT)
 D SET("</HTML>",.CNT)
 D SET("{{{}}}",.CNT)
 Q
 ;
SET(LINE,CNT) ;
 S CNT=CNT+1
 S ^TMP("FSCRPC",$J,"OUTPUT",CNT)=LINE
 Q
