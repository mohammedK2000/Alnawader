import 'dart:convert';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart' as dh;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:purshases/myad.dart';
import 'package:purshases/utiles.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'adsinfo.dart';
import 'package:intl/date_symbol_data_local.dart' as df;
import 'controller/chtascontroller.dart';
import 'myglobals.dart' as globals;
import 'mymessage.dart';
class chats extends StatefulWidget {
 
 
  @override
  chatsState createState() =>chatsState( );
}

 

class chatsState extends State<chats> {
 
@override
  void initState() {
    pagcontroller.mychats=null;
  getmychats();
 
    super.initState();
  }
  
     final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double maxwidth = MediaQuery.of(context).size.width;
    double maxheight = MediaQuery.of(context).size.height;
    
    return GetBuilder<Chatcontroller>(
        init: Chatcontroller(),
      builder: (contex)  {
        return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              backgroundColor: backecolor,
                   key: _scaffoldKey,
              drawer: drawer(context,  _scaffoldKey),
              appBar: AppBar(
                elevation: 0,
              backgroundColor: backecolor,
              
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
              actions: [ InkWell(
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
              bottomNavigationBar: bottombare(context,2,Colors.white,_scaffoldKey),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child:!globals.login?Center(child: Text('يرجى تسجيل الدخول لتتمكن من الاستفادة من ميزات التطبيق',textAlign: TextAlign.center,style: TextStyle(color: primarycolor,fontWeight: FontWeight.bold),),) :loaddata?Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor:primarycolorc2,
                  child: ListView(   
                      children: List.generate(5, (index) =>
                  
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                           width: double.infinity,
                           height: 100,
                           decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 2,color: Colors.grey[200]))),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom:8.0),
                                child: Row(
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 100,
                                     height:100,
                                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                                    color: Colors.grey[200],
                                    image: DecorationImage(image: NetworkImage(' '),fit: BoxFit.cover),
                                
                                    ),
                                   
                                    ),
                                    SizedBox(width: 10,),
                                    Column(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Text( ''),
                                       Container(decoration: BoxDecoration(color: primarycolor,borderRadius: BorderRadius.circular(15),
                                       
                                       ),
                                       
                                       child: Padding(
                                         padding: const EdgeInsets.all(5.0),
                                         child: Icon(Icons.edit,color: Colors.white,size: 20,),
                                       ),
                                       )
                                    ],),
                                 
                                  ],
                                ),
                              ),
                          ),
                            ) ), ),
                ):pagcontroller.mychats.length==0?Center(child: Text('لاتوجد دردشات لديك بعد',style: TextStyle(fontWeight: FontWeight.w700,color: primarycolor,fontSize: size1),),): 
                
                Column(
                  children: [
                    Row(children: [
                          Container(width: 70,height: 70,decoration: BoxDecoration(
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
                            image: DecorationImage(image: NetworkImage(baseurlim+globals.image.toString()))
                          ),),
                          SizedBox(width: 20,),
                          Text('الرسائل',style: TextStyle(fontSize: size1,fontWeight: FontWeight.w800),)
                    ],),
                    SizedBox(height: 20,),
                    Expanded(
                      child: ListView(   
                          children: List.generate(pagcontroller.mychats.length, (index) =>
                      
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                   borderRadius: BorderRadius.circular(15),
                                   onTap: ()async{
                                Navigator.of(context).push( MaterialPageRoute(
                                builder: (BuildContext context) => mymessages(senderid:pagcontroller. mychats[index].sender_id,reciverid:pagcontroller. mychats[index].reciverid,otherimage:pagcontroller. mychats[index].otherimage,othername:pagcontroller.  mychats[index].othername ,reccivertokens:pagcontroller.mychats[index].devicetoken,),
                                ) );
 
                                   },
                                    child: Container(
                               width: double.infinity,
                               height: 100,
                               decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 2,color: Colors.grey[200]))),
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom:8.0),
                                      child: Row(
                                       crossAxisAlignment: CrossAxisAlignment.start,

                                        children: [
                                          Container(
                                            width: 80,
                                           height:80,
                                           decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                          color: Colors.grey[500],
                                          image: DecorationImage(
                                            image:pagcontroller. mychats[index].otherimage.length<8?AssetImage('assets/cover.jpg'):NetworkImage(baseurlim+ pagcontroller.mychats[index].otherimage),fit: BoxFit.cover),
                                      
                                          ),
                                         
                                          ),
                                          SizedBox(width: 10,),
                                          Expanded(
                                            child: Column(
                                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [
                                               Text(pagcontroller.mychats[index].othername,maxLines: 1, overflow: TextOverflow.clip,style: TextStyle(fontSize:size2 ,fontWeight: FontWeight.w800),),
                                              Text(pagcontroller.mychats[index].lastmessage,maxLines: 1, overflow: TextOverflow.clip,style: TextStyle(fontSize:size2 ,fontWeight: FontWeight.w600,color: Colors.grey),),
                                            ],),
                                          ),
                                       
                                          Card(
                                          elevation: 0,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text( pagcontroller. mychats[index].arabdate+" "+ dh.DateFormat('hh:mm a').format(DateTime.parse( pagcontroller. mychats[index].getlast())).replaceAll('PM','م').replaceAll('AM','ص')  ,
                                              textDirection: TextDirection.ltr
                                              ,style: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.w700,fontSize: size2,),),
                                            ),)
                                       
                                        ],
                                      ),
                                    ),
                              ),
                                  ),
                                ) ), ),
                    ),
                  ],
                ),
              ),
            ));
      }
    );
  } 

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
    'sender_id':globals.user_id,
    'receiver_id':globals.user_id,
  };


  var responsess = await http.get(
      Uri.parse(baseurl + "specific_chat?sender_id="+globals.user_id+'&receiver_id='+globals.user_id ), headers: header
  );
 

 

  if (responsess.statusCode == 200) {
    var x=jsonDecode(responsess.body)['data']  ;
   
    for(int i=0;i<x.length;i++){
      maincateg p=new maincateg();
      p.add(x[i]);
      globals.myads.add(p);
    }


  } else {}
  setState(() {
    loaddata=false;
  });
}
 
Future<int> getmychats() async {
  if(!globals.login) return 0;
 
 if(pagcontroller.mychats!=null){
   setState(() {
    loaddata=false;
  });
  return 0;}
  String token=globals.access_token;
  Map<String, String> header = {
    "Accept": "application/json",
    'Authorization': 'Bearer $token',
  };
  Map<String, String> body;


  var responsess = await http.get(
      Uri.parse(baseurl + "my_chats/" +globals.user_id),  headers: header
  );
 

 
pagcontroller.mychats=[];
  if (responsess.statusCode == 200) {
    var x=jsonDecode(responsess.body)['data']  ;
 
    for(int i=0;i<x.length;i++){
      chat p=new chat();
      p.add(x[i]);
    pagcontroller. mychats.add(p);
    }


  } else {}
  setState(() {
    loaddata=false;
  });
}
 final pagcontroller = Get.put(Chatcontroller());
bool loaddata=true;
 
}
 class chat{
  String sendername;
  String reccivername;
  String sender_id;
  String reciverid;
  String senderimage;
  String reciverimage;
  String lastmessage;
  String lastdate;
  String lastid;
  List<String> devicetoken=[];
  String othername;
  String otherimage;
  String arabdate='';
  String getlast(){
    return DateTime.parse(lastdate).add(DateTime.now().timeZoneOffset).toString();
  }
  void add2(String sendername,String senderid,String senderimage,String reccivername,String recciverimage,String recciverid,String message,String time,String mytokens){
  sendername=sendername;
    sender_id=senderid;
    senderimage=senderimage;

    reccivername=reccivername;
    reciverid=recciverimage;
    reciverimage=recciverid;
    if(globals.user_id!=sender_id)
   
      
      devicetoken.add(mytokens);
    
    lastmessage=message;
    lastdate=time;
    lastdate=lastdate.replaceAll('T',' ');
    lastdate=lastdate.substring(0,16);
    lastid=senderid;
   
         otherimage=senderimage;
         othername=sendername;
    
 df.initializeDateFormatting("ar_SA", null).then((_) {
      var now = DateTime.now();
     
      var formatter = dh.DateFormat.MMMd('ar_SA');
   
      String formatted = formatter.format(now);
   
      arabdate=formatted;
    });

  }

  void add(var x){
    sendername=x['sender']['name'];
    sender_id=x['sender']['id'].toString();
    senderimage=x['sender']['img'].toString();

    reccivername=x['reciver']['name'];
    reciverid=x['reciver']['id'].toString();
    reciverimage=x['reciver']['img'].toString();
    if(globals.user_id==sender_id)
    for(int i=0;i<x['reciver']['device_key'].length;i++){
      
      devicetoken.add(x['reciver']['device_key'][i]['token'].toString());
    }
    else 
     for(int i=0;i<x['sender']['device_key'].length;i++)
    {
        devicetoken.add(x['sender']['device_key'][i]['token'].toString());
    }
    lastmessage=x['last_message']['message_text'].toString();
    lastdate=x['last_message']['created_at'].toString();
    lastdate=lastdate.replaceAll('T',' ');
    lastdate=lastdate.substring(0,16);
    df.initializeDateFormatting("ar_SA", null).then((_) {
      var now = DateTime.now();
        
      var formatter = dh.DateFormat.MMMd('ar_SA');
 
      String formatted = formatter.format(now);
 
      arabdate=formatted;
    });
    lastid=x['last_message']['sender_id'].toString();
    if(globals.user_id==sender_id){
         otherimage=reciverimage;
         othername=reccivername;
    }else{
         otherimage=senderimage;
         othername=sendername;
    }

  }
 }