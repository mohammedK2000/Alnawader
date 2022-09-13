import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart' as dh;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purshases/myad.dart';
import 'package:purshases/utiles.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'adsinfo.dart';
import 'controller/chtascontroller.dart';
import 'home.dart';
import 'myglobals.dart' as globals;
class mymessages extends StatefulWidget {
 List<String> reccivertokens=[];
 String senderid;
 String reciverid;
 String otherimage;
 String othername;
 mymessages({this.senderid,this.reciverid,this.otherimage,this.othername,this.reccivertokens});
  @override
  mymessagesState createState() =>mymessagesState(senderid: this.senderid,reciverid: this.reciverid ,otherimage: this.otherimage,othername: this.othername,reccivertokens: this.reccivertokens);
}

 

class mymessagesState extends State<mymessages> {
  String senderid;
 String reciverid;
 String otherimage;
 String othername;
 mymessagesState({this.senderid,this.reciverid,this.otherimage,this.othername,this.reccivertokens});
@override
  void initState() {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      

         var ismessage=message.data ['ismessage'];
         var name= message.data['name'];
         var image= message.data['image'].toString();
         var msg= message.data['msg'].toString();
         var time= message.data['time'].toString();
        var reciverid= message.data['reciverid'].toString();
        var senderid= message.data['senderid'].toString();
        var recciverimage= message.data['recciverimage'].toString();
         var reccivername= message.data['reccivername'].toString();
         var token=message.data['token'].toString();
 
          if(ModalRoute.of(context).isCurrent) 
        
          
            if((this.reciverid==reciverid&&this.senderid==senderid)||(this.reciverid==senderid&&this.senderid==reciverid))
            {
    chat p=new chat();
    p.date=DateTime.parse(time).add(DateTime.now().timeZoneOffset).toString().substring(0,16);
    p.message=msg;
 
    p.sender_id=senderid;
    
      mychats.add(p);
 
                if(pagcontroller.mychats!=null){
                  
                  if(pagcontroller.mychats.where((element) => (element.sender_id==senderid&&element.reciverid==reciverid)||(element.sender_id==reciverid&&element.reciverid==senderid)).length>0)
                  {
                          pagcontroller.updatelast(reciverid, senderid, time, msg);
                  }
                  else{
                         pagcontroller.addnew(name, senderid, image, reccivername, recciverimage, reciverid, msg, time, token) ;
                  }
                }
    setState(() {
     
    });
    if (controller.position.maxScrollExtent > 0)
      Timer(Duration(milliseconds: 100), () {
        controller
          ..jumpTo(
            controller.position.maxScrollExtent

          );
      }); 
            }


       
        });
 getspecificshat();
    super.initState();
  }
   final pagcontroller = Get.put(Chatcontroller());
     final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double maxwidth = MediaQuery.of(context).size.width;
    double maxheight = MediaQuery.of(context).size.height;
    
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: backecolor,
               key: _scaffoldKey,
          drawer: drawer(context,  _scaffoldKey),
          appBar: AppBar(
         
          backgroundColor: backecolor,
          elevation: 2,
        leading:  Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap:(){
           _scaffoldKey.currentState.openDrawer();
                },
                child: Container(width: 30,height: 30,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(13),color: Colors.white,
                border: Border.all(width: 2,color: primarycolor),

                ),
                child: Center(child: Icon(Icons.menu,color: primarycolor,),),
                ),
              ),
            ),
          actions: [
                    Row(
                      children: [
              Text(othername,style: TextStyle(fontSize: size1,fontWeight: FontWeight.w800,color: Colors.black),),

                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(width: 70,height: 70,decoration: BoxDecoration(
                                       boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          offset: Offset(0, 6),
                                          blurRadius: 6,
                                          spreadRadius: 1,
                                        )
                                      ],
                              shape: BoxShape.circle,
                              color: Colors.grey[100],
                              image: DecorationImage(image: NetworkImage(baseurlim+otherimage))
                            ),),
                        ),
                      ],
                    ),
                   
                    
            
             InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  borderRadius: BorderRadius.circular(45),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(width: 30,height: 30,child: Center(child: Icon(Icons.arrow_forward,color: primarycolor,),),),
            ),
            )],
            
          ),
          bottomNavigationBar: bottombare(context,5,Colors.white,_scaffoldKey),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child:!globals.login?Center(child: Text('يرجى تسجيل الدخول لتتمكن من الاستفادة من ميزات التطبيق',textAlign: TextAlign.center,style: TextStyle(color: primarycolor,fontWeight: FontWeight.bold),),) :loaddata?Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor:primarycolorc2,
              child: ListView(   
                  children: List.generate(5, (index) =>
              
                         Align(
                                alignment: index%2==0?Alignment.topRight:Alignment.topLeft,
                                child: Column(
                                  crossAxisAlignment:  index%2==0?CrossAxisAlignment.start:CrossAxisAlignment.end,
                                  children: [
                                    Container(
                        width: 200,
                             decoration: BoxDecoration(
                                    color: index%2==0?primarycolor:Colors.grey[300],
                                     borderRadius: BorderRadius.only(
                                      topLeft: index%2==0? Radius.circular(20):Radius.zero,

                                      topRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight:  index%2!=0?Radius.circular(20):Radius.zero
                                     
                                     )
                                    
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only (left:20,right: 20,top: 10,bottom: 10),
                                      child: Text('',
                                      
                                       
                                      style: TextStyle(fontSize:size2 ,fontWeight: FontWeight.w800),),
                                    ),
                            ),   Text( ''  ,maxLines: 1, overflow: TextOverflow.clip,
                            textDirection: TextDirection.ltr,
                            style: TextStyle(fontSize:size2 ,fontWeight: FontWeight.w600,color: Colors.grey),),
                                  ],
                                ),
                              )), ),
            ):mychats.length==0?Center(child: Text('لاتوجد دردشات لديك بعد',style: TextStyle(fontWeight: FontWeight.w700,color: primarycolor,fontSize: size1),),): 
            
            Column(
              children: [
               
                SizedBox(height: 20,),
                Expanded(
                  child: SingleChildScrollView(
                  controller: controller,
                    child: Column(   
                    mainAxisSize: MainAxisSize.min,

                        children: List.generate(mychats.length, (index) =>
                    
                              Align(
                                alignment: mychats[index].sender_id==globals.user_id?Alignment.topRight:Alignment.topLeft,
                                child: Column(
                                  crossAxisAlignment: mychats[index].sender_id==globals.user_id?CrossAxisAlignment.start:CrossAxisAlignment.end,
                                  children: [
                                    Container(
                        
                             decoration: BoxDecoration(
                                    color: mychats[index].sender_id==globals.user_id?primarycolor:Colors.grey[300],
                                     borderRadius: BorderRadius.only(
                                      topLeft:mychats[index].sender_id==globals.user_id? Radius.circular(20):Radius.zero,

                                      topRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: mychats[index].sender_id!=globals.user_id?Radius.circular(20):Radius.zero
                                     
                                     )
                                    
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only (left:20,right: 20,top: 10,bottom: 10),
                                      child: Text(mychats[index].message,
                                      
                                       
                                      style: TextStyle(fontSize:size2 ,fontWeight: FontWeight.w800),),
                                    ),
                            ), 
                              index==mychats.length-1||mychats[index+1].sender_id!=mychats[index].sender_id?
                              Text( dh.DateFormat('hh:mm a').format(DateTime.parse( mychats[index].date)).replaceAll('PM','م').replaceAll('AM','ص')   ,maxLines: 1, overflow: TextOverflow.clip,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(fontSize:size2-2 ,fontWeight: FontWeight.w600,color: Colors.grey),):Container(),
                            SizedBox(height: 10,),
                                  ],
                                ),
                              ) ), ),
                  ),
                ),
                Card(color: Colors.grey[100],
                child: Row(children: [
                  SizedBox(width: 20,),
                  Expanded(child: TextFormField(
                    controller: mesc,
                    cursorColor: primarycolor,

                    decoration: InputDecoration(border: InputBorder.none,hintText: 'أدخل رسالتك'),
                  
                  )),
                  InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: (){
                         if(mesc.text.length==0)return;
                         senmes();
                    },
                    child: Container(
                      width: 55,height: 55,
                      child: Icon(Icons.send,color: primarycolor,)),
                  ),
                   
                ],),
                )
              ],
            ),
          ),
        ));
  } 
  ScrollController controller=new ScrollController ();
    String constructFCMPayload(String name,String image,List<String> tokens,String title,String message,String recciverid,String senderid ) {

    return jsonEncode({
      'registration_ids':  tokens ,
      'data': {
        'ismessage':'1',
        
        'name':name,
        'image':image,
        'msg':message,
        'token':globals.mytokens,
        'recciverimage':otherimage,
        'reccivername':othername,
        'time':DateTime.now().toUtc().toString().replaceAll("T"," ").substring(0,16),
        'reciverid':recciverid,
        'senderid':senderid,
      },
      'notification':{
        'title':title,
        'body': message
      }

    });
  }
  Future<void> sendPushMessage(String name,String image,List<String> tokens,String title,String message,String recciverid,String senderid ) async {

    try {
      var re=   await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'key=AAAAvcYTHxk:APA91bE4prK4zFWngygk7E-qqM5uhvEjsq7GTCifDOXoZv5VaYksq1Zow_7AoKN2CsHqcBgZQx5XYwNFQipP3rB1LBlfRzhNbbPfuuHVVIbgs0h9yUHInglZwBSlCY2GEkTurIToGsk9'
        },
        body: constructFCMPayload(name,image,tokens,title,message,recciverid,senderid ),
      );
 
    } catch (e) {
          
    }
  }

  List<String> reccivertokens=[];

  void sendpushup(List<String> fcmtoken,String message,String recciverid,String senderid ){
       Timer(Duration(seconds: 1), () {
     sendPushMessage(globals.name,globals.image, fcmtoken ,'رسالة من '+globals.name,message,recciverid,senderid );
    });
  }
   Future<int> senmes( ) async{
 
 String message=mesc.text;
     String token=globals.access_token;
     Map<String, String> header = {
       "Accept": "application/json",
       'Authorization': 'Bearer $token',
     };
     Map<String, String> body={
            'sender_id':globals.user_id,
            'receiver_id':senderid==globals.user_id?reciverid:senderid,
            'message_text':mesc.text
,     };

            chat p=new chat();
             p.date=DateTime.now().toString().substring(0,16);
             p.message=mesc.text;
             p.sender_id=globals.user_id;
              pagcontroller.updatelast(reciverid, senderid, DateTime.now().toUtc().toString().substring(0,16), mesc.text);
             mychats.add(p);
                Timer(Duration(milliseconds: 200), jumm   );
             mesc.clear();
             setState(() {
                            
                          });
     var responsess = await http.post(
         Uri.parse(baseurl + "send_message" ), body: body,  headers: header
     );
 
     if(responsess.statusCode==200){
     
    sendpushup(reccivertokens,message,senderid==globals.user_id?reciverid:senderid,globals.user_id);
        
     }
     else
     {
     
     }
     setState(() {
            
          });
          
        
   }
   Function jumm(){  controller.jumpTo(controller.position.maxScrollExtent);}
TextEditingController mesc=new TextEditingController();
  Color getcolor(String x){
      if(x.toLowerCase()=='active')return Colors.green;
  if(x.toLowerCase()=='inactive')return Colors.grey[800];
  if(x.toLowerCase()=='deleted') return Colors.red;
  if(x.toLowerCase()=='banned') return Colors.red;
  return Colors.red;
  }
String getstatus(String x){
  if(x.toLowerCase()=='active')return 'نشط';
  if(x.toLowerCase()=='inactive')return 'غير نشط';
  if(x.toLowerCase()=='deleted') return 'محذوف';
  if(x.toLowerCase()=='banned') return 'محظور';
  return x;
}
Future<int> getspecificshat() async {
  if(!globals.login) return 0;
  globals.myads.clear();
  String token=globals.access_token;
  Map<String, String> header = {
    "Accept": "application/json",
    'Authorization': 'Bearer $token',
  };
  Map<String, String> body={
    'sender_id':senderid,
    'receiver_id':reciverid,
  };


  var responsess = await http.get(
      Uri.parse(baseurl + "specific_chat?sender_id="+senderid+'&receiver_id='+reciverid ), headers: header
  );
 

 

  if (responsess.statusCode == 200) {
    var x=jsonDecode(responsess.body)['data'] ['messages'] ;
 
    for(int i=0;i<x.length;i++){
      chat p=new chat();
      p.add(x[i]);
      mychats.add(p);
    }
 

  } else {}
  setState(() {
    loaddata=false;
  });
         Timer(Duration(milliseconds: 500), jumm   );
}
 
bool loaddata=true;
List<chat> mychats=[];
}
 class chat{
 
  String sender_id;
 
  String message;
  String date;
 
 

  void add(var x){
    
    sender_id=x['sender_id'] .toString();
    
 

    message=x['message_text'] .toString();
    date= DateTime.parse( x['created_at'] .toString().replaceAll("T"," ").substring(0,16)).add(DateTime.now().timeZoneOffset).toString().substring(0,16);
     

  }
 }