import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:purshases/search.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'controller/chtascontroller.dart';
import 'myglobals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:purshases/subcatergory.dart';
import 'package:purshases/utiles.dart';
import 'package:http/http.dart' as http;
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
 

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum Pet { dog, cat }
enum type { a, b, c, d }
enum akedt { a, b }

class _MyHomePageState extends State<MyHomePage> {
@override
  void initState() {
  
    gelallcate();
    getdata();
    super.initState();
  }
void getdata() async {

  var box = await Hive.openBox("mydata");

  globals.name = box.get('name');
  globals.email = box.get('email');
  globals.access_token = box.get('access_token');
  globals.mobile_number = box.get('mobile_number');
  globals.user_id= box.get('user_id');
  globals.image=box.get('profile_photo'); 
    globals.country=box.get('country')??''; 
   
 
 

  if (globals.email != null) globals.login = true;
 registerNotification();
 
 
}
      final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double maxwidth = MediaQuery.of(context).size.width;
    double maxheight = MediaQuery.of(context).size.height;
    
    return   
    
    Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: backecolor,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: backecolor,
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap:(){
                  _scaffoldKey.currentState.openDrawer();
                },
                child: Container(width: 30,height: 30,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(13),
                border: Border.all(width: 2,color: primarycolor),

                ),
                child: Center(child: Icon(Icons.menu,color: primarycolor,),),
                ),
              ),
            ),
          ),
          key: _scaffoldKey,
          drawer: drawer(context,  _scaffoldKey),
          bottomNavigationBar: bottombare(context,0,Colors.white,_scaffoldKey),
          body:  
                Padding(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 10,top: 30),
                child: loaddata?Column(
                  children: [
                     OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          return new Container(
           child: Visibility(
            visible:!connected ,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                height: 30,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.red),
                child: Center(child: Text(connected?'onnline':'غير متصل',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),))),
            )),
          );
        },
        child:  new Text(
              ' ',
            ),
      ),
                    Expanded(
                      child: Shimmer.fromColors(
                          baseColor: Colors.grey[300],
                          highlightColor:primarycolorc2,
                        child: Column(
      children: [
          
       Container(width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 2,color: primarycolor)
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                                   SizedBox(width: 10,),
                            Icon(Icons.search,color: primarycolor,),
                            SizedBox(width: 10,),
                            Expanded(child: TextFormField(
                              enabled: false,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(border: InputBorder.none,
                            hintText: 'بحث',
                            ),),)
                          ],),
                          ),
                             SizedBox(height: 20,),
                             Expanded(child: GridView(  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1.0,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ), children: List.generate(8, (index) =>
                                 Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                                 
                                 image: DecorationImage(image: AssetImage('assets/cover.jpg'),fit: BoxFit.cover)
                                 ),
                                 child: Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(children: [
                                      Container(width: 25,height: 25,
                                      decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white),
                                      child: Center(child: Icon(Icons.ac_unit_outlined,color: primarycolor,),),
                                      ),
                                      SizedBox(width: 10,),
                                 
                                    ],),
                                  ),
                                  Spacer(),
                                  Row(children: [
                                    Spacer(),
                                     Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Container(width: 25,height: 25,
                                    decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(width: 2,color: Colors.white)),
                                    child: Center(child: Icon(Icons.arrow_forward,color: Colors.white,size: 20,),),
                                    ),
                                     ),
                                  ],)
                                 ],),
                                 )), ),)  
],

                        ),
                      ),
                    ),
                  ],
                ): Column(
                  //  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                     OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          return new Container(
           child: Visibility(
            visible:!connected ,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                height: 30,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.red),
                child: Center(child: Text(connected?'onnline':'غير متصل',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),))),
            )),
          );
        },
        child:  new Text(
              ' ',
            ),
      ),
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap:(){
                             Navigator.of(context).push( MaterialPageRoute(
                                  builder: (BuildContext context) => seach( ),
                                  ) );
                      },
                      child: Container(width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 2,color: primarycolor)
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                               SizedBox(width: 10,),
                        Icon(Icons.search,color: primarycolor,),
                        SizedBox(width: 10,),
                        Expanded(child: Text(
                          'بحث'
                         ),)
                      ],),
                      ),
                    ),
                       SizedBox(height: 20,),
                       Expanded(child: GridView(  gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.0,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ), children: List.generate(mcateg.length, (index) =>
                           InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: (){ 
                               Navigator.of(context).push( MaterialPageRoute(
                                  builder: (BuildContext context) => subcategory(catid: mcateg[index].id,),
                                  ) );
                                  
                                  },
                             child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),border: Border.all(width: 2,color: primarycolor),
                             
                             image: DecorationImage(image: NetworkImage(baseurlim+ mcateg[index].image),fit: BoxFit.cover)
                             ),
                             child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(children: [
                                  Container(width: 35,height: 35,
                                  decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Center(child: Image.network(baseurlim+mcateg[index].icon_name, ) ),
                                  ),
                                  ),
                                  SizedBox(width: 10,),
                                  Expanded(child: Text(mcateg[index].name,style: TextStyle(fontSize: size1,fontWeight: FontWeight.w900,color: Colors.white),))
                                ],),
                              ),
                              Spacer(),
                              Row(children: [
                                Spacer(),
                                 Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Container(width: 25,height: 25,
                                decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(width: 2,color: Colors.white)),
                                child: Center(child: Icon(Icons.arrow_forward,color: primarycolor,size: 20,),),
                                ),
                                 ),
                              ],)
                             ],),
                             ),
                           )), ),)     
                  ],
                ),
              ),
            
        ));
  } 
    FirebaseMessaging _messaging;
  PushNotification _notificationInfo;
  String token1='';
    Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {}
       Future<int> sendmytoken(String device_key) async{
  
     String token=globals.access_token;
     Map<String, String> header = {
       "Accept": "application/json",
       'Authorization': 'Bearer $token',
     };
     Map<String, String> body;

     body = {
    

       'user_id':globals.user_id,
       'device_key':device_key,

     };
     var responsess = await http.post(
         Uri.parse(baseurl + "assign_device_key_to_user" ),body:body,  headers: header
     );
     
 
 
    if(responsess.body.toString().contains('is not verified')||responsess.statusCode!=200)
    {
          Hive.deleteFromDisk().then((value) {
                       globals.login=false;
                       globals.email='-1';
                       globals.name='-1';
                       globals.access_token='-1';
                       globals.myads=[];
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                builder: (BuildContext context) => MyHomePage(  ),
                                ) , (route) => false);
                              
                  });
    }
  
   }
   final pagcontroller = Get.put(Chatcontroller());
 Future<int> registerNotification() async {
   
 

    try {
      await Firebase.initializeApp();
    var  _messaging = FirebaseMessaging.instance;

      if (!globals.login) {
        _messaging.deleteToken();
        return 1;
      }
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);

      NotificationSettings settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        provisional: false,
        sound: true,
      );

      try {
        await _messaging.getToken().then((token) {
          token1 = token;
          globals.mytokens=token1;
sendmytoken(token1);
    

        });
      } catch (error) {print(error);}
 

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
          PushNotification notification = PushNotification(
            title: message.notification?.title,
            body: message.notification?.body,
            dataTitle: message.data['title'],
            dataBody: message.data['body'],
          );

          _notificationInfo = notification;

          if (globals.login) if (_notificationInfo != null) {
         
            try {
              String mes = _notificationInfo.title + _notificationInfo.body;

              if (mes != globals.lastmessage ||
                  DateTime.now().difference(globals.lastdate).inSeconds > 5) {
                globals.lastmessage = mes;
            
                globals.lastdate = DateTime.now();
              }
            } catch (e) {
            
              return 0;
            }
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
         if(ismessage=='1')
         {
                    Timer(Duration(milliseconds: 200), () {
                 if(pagcontroller.mychats!=null){
                  
                  if(pagcontroller.mychats.where((element) => (element.sender_id==senderid&&element.reciverid==reciverid)||(element.sender_id==reciverid&&element.reciverid==senderid)).length>0)
                  {
                        if(pagcontroller.mychats.where((element) => (element.sender_id==senderid&&element.reciverid==reciverid)||(element.sender_id==reciverid&&element.reciverid==senderid)).first.lastdate!=time)
                        {
                                 showSimpleNotification(
              InkWell(
                onTap:(){
                  
                      
                },
                child: Text(_notificationInfo.title,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 13,
                        color:Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
              leading:InkWell(
                onTap: (){  
                    
                              
                              },
                child: Icon(Icons.message,color: Colors.blue[100],size: 40,)),
              subtitle: InkWell(
                onTap:(){
                  
                },
                child: Text(_notificationInfo.body,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 11,color:  Colors.grey[700],
                        fontWeight: FontWeight.w600)),
              ),
              background: Colors.white,
              elevation: 9,
              duration: Duration(seconds: 6),
            
              slideDismissDirection: DismissDirection .horizontal,
            );
                        }
                          pagcontroller.updatelast(reciverid, senderid, time, msg);
                  }
                  else{
                         pagcontroller.addnew(name, senderid, image, reccivername, recciverimage, reciverid, msg, time, token) ;
                           showSimpleNotification(
              InkWell(
                onTap:(){
                  
                      
                },
                child: Text(_notificationInfo.title,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 13,
                        color:Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
              leading:InkWell(
                onTap: (){  
                    
                              
                              },
                child: Icon(Icons.message,color: Colors.blue[100],size: 40,)),
              subtitle: InkWell(
                onTap:(){
                  
                },
                child: Text(_notificationInfo.body,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 11,  color:  Colors.grey[700],
                        fontWeight: FontWeight.w600)),
              ),
              background: Colors.white,
              elevation: 9,
              duration: Duration(seconds: 6),
            
              slideDismissDirection: DismissDirection .horizontal,
            );
                  }
                }else{           showSimpleNotification(
              InkWell(
                onTap:(){
                  
                      
                },
                child: Text(_notificationInfo.title,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 13,
                        color:Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
              leading:InkWell(
                onTap: (){  
                    
                              
                              },
                child: Icon(Icons.message,color: Colors.blue[100],size: 40,)),
              subtitle: InkWell(
                onTap:(){
                  
                },
                child: Text(_notificationInfo.body,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 11,  color:  Colors.grey[700],
                        fontWeight: FontWeight.w600)),
              ),
              background: Colors.white,
              elevation: 9,
              duration: Duration(seconds: 6),
            
              slideDismissDirection: DismissDirection .horizontal,
            );}
         
     
 
 {
      //    FlutterRingtonePlayer.playNotification();

          
         
 }
 
  });
 }else
{
 //    FlutterRingtonePlayer.playNotification();
        showSimpleNotification(
              Text(_notificationInfo.title,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 16,
                      color:Colors.black,
                      fontWeight: FontWeight.bold)),
              leading: Image.asset(
                'assets/images/logo2.png',
                fit: BoxFit.scaleDown,
              ),
              subtitle: Text(_notificationInfo.body,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 13,  color:  Colors.grey[700],
                      fontWeight: FontWeight.w600)),
              background: Colors.white,
              elevation: 9,
              duration: Duration(seconds: 4),
            );
}
         
          }
        });
      } else {}
      return -1;
    } on Error catch (e) {
 
      return -1;
    } on Exception catch (e) {
    
      return -1;
    }
  }
  List<maincateg> mcateg=[];
    Future<int> gelallcate() async {
 try{
    Map<String, String> header = {
      "Accept": "application/json",
    };
    Map<String, String> body;
 
  var responsess = await http.get(
      Uri.parse(baseurl + "all_sections"), headers: header
    );
   
 
     
 
    if (responsess.statusCode == 200) {
   var x=jsonDecode(responsess.body)['data'];
 
     for(int i=0;i<x.length;i++){
         maincateg p=new maincateg();
         p.add(x[i]);
         mcateg.add(p);
     }
    
     
    } else {}
    setState(() {
   loaddata=false;
    });
 }on Exception catch(e){
  return gelallcate();
 }
 on Error catch(e){
   return gelallcate();
 }
  }
  bool loaddata=true;
}
class maincateg{
  String name;
  String image;
  String icon;
  String id;
  String icon_name;
  void add(var json){
    name=json['translations'][0]['section_name'];
    id=json['id'].toString();
    image=json['photo_name'] ;
    icon_name=json['icon_name'];
  }

}
class PushNotification {
  PushNotification({
    this.title,
    this.body,
    this.dataTitle,
    this.dataBody,
  });

  String title;
  String body;
  String dataTitle;
  String dataBody;
}
