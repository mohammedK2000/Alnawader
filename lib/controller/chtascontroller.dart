import 'dart:async';
 import 'package:intl/intl.dart' as dh;
import 'package:get/get.dart';
import 'package:purshases/adsinfo.dart';
 
import '../chats.dart';
 
class Chatcontroller extends GetxController {

String id="-9";
 List<chat> mychats ;
   void addnew(String sendername,String senderid,String senderimage,String reccivername,String recciverimage,String recciverid,String message,String time,String mytokens){

          chat p=new chat();
          p.add2(sendername, senderid, senderimage, reccivername, recciverimage, recciverid, message, time, mytokens);
          mychats.add(p);
          update();
   }
   void updatelast(String reciverid,String senderid,String lastdate,String mess){
    mychats.where((element) => (element.sender_id==senderid&&element.reciverid==reciverid)||(element.sender_id==reciverid&&element.reciverid==senderid)).first.lastdate=lastdate;
        mychats.where((element) => (element.sender_id==senderid&&element.reciverid==reciverid)||(element.sender_id==reciverid&&element.reciverid==senderid)).first.lastmessage=mess;     
    update();
   }
 
 
}