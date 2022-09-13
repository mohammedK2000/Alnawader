import 'dart:convert';
import 'package:intl/intl.dart' as dh;
import 'package:flutter/material.dart';
import 'package:purshases/myad.dart';
import 'package:purshases/utiles.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'adsinfo.dart';
import 'myglobals.dart' as globals;
class notification extends StatefulWidget {
 
 
  @override
  notificationState createState() =>notificationState( );
}

 

class notificationState extends State<notification> {
 
@override
  void initState() {
  getmyads();

    super.initState();
  }
  
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
          bottomNavigationBar: bottombare(context,3,Colors.white,_scaffoldKey),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child:!globals.login?Center(child: Text('يرجى تسجيل الدخول لتتمكن من الاستفادة من ميزات التطبيق',textAlign: TextAlign.center,style: TextStyle(color: primarycolor,fontWeight: FontWeight.bold),),) :loaddata?Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor:primarycolorc2,
              child: ListView(   
                  children: List.generate(5, (index) =>
              
                        Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 1,
                          color: Colors.grey[100],
                          child: Container(
                     width: double.infinity,
                   
                      
                          child: Padding(
                            padding: const EdgeInsets.all ( 8.0),
                            child: Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text('',style: TextStyle(fontSize:size2 ,fontWeight: FontWeight.w800,color: primarycolor),),
                             Align(
                              alignment: Alignment.bottomLeft,
                               child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                 children: [
                               
                                   Text(      ''
                            ,style: TextStyle(fontSize:size2-3 ,fontWeight: FontWeight.w600,color: Colors.grey[600]),),
                                SizedBox(width: 5,),
                                   Icon(Icons.timelapse,size: 20,color: Colors.grey[600]),
                                 ],
                               ),
                             ),
                            ],),
                          ),
                    ),
                        ),
                      ) ), ),
            ):mynotif.length==0?Center(child: Text('لاتوجد إشعارات لديك بعد',style: TextStyle(fontWeight: FontWeight.w700,color: primarycolor,fontSize: size1),),): ListView(   
                children: List.generate(mynotif.length, (index) =>
            
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 1,
                          color: Colors.grey[100],
                          child: Container(
                     width: double.infinity,
                   
                      
                          child: Padding(
                            padding: const EdgeInsets.all ( 8.0),
                            child: Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(mynotif[index].text,style: TextStyle(fontSize:size2 ,fontWeight: FontWeight.w800,color: primarycolor),),
                             Align(
                              alignment: Alignment.bottomLeft,
                               child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                 children: [
                               
                                   Text(           mynotif[index].date
                            ,style: TextStyle(fontSize:size2-3 ,fontWeight: FontWeight.w600,color: Colors.grey[600]),),
                                SizedBox(width: 5,),
                                   Icon(Icons.timelapse,size: 20,color: Colors.grey[600]),
                                 ],
                               ),
                             ),
                            ],),
                          ),
                    ),
                        ),
                      ) ), ),
          ),
        ));
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
Future<int> getmyads() async {
  if(!globals.login) return 0;
  globals.myads.clear();
  String token=globals.access_token;
  Map<String, String> header = {
    "Accept": "application/json",
    'Authorization': 'Bearer $token',
  };
  Map<String, String> body;


  var responsess = await http.get(
      Uri.parse(baseurl + "get_notifications?user_id=" +globals.user_id),  headers: header
  );


 

  if (responsess.statusCode == 200) {
    var x=jsonDecode(responsess.body)['data']  ;
 
    for(int i=0;i<x.length;i++){
      notific p=new notific();
      p.add(x[i]);
     mynotif.add(p);
    }


  } else {}
  setState(() {
    loaddata=false;
  });
}
List<notific> mynotif=[];
bool loaddata=true;
}
 class notific{
  String id;
  String text;
  String date;
  void add(dynamic x){
    id=x['id'].toString();
    text=x['notification'].toString();
    date=x['created_at'] ;
    String d = date;
 
    d = d.replaceAll("T", " ");
    d = d.replaceAll("Z", " ");
  DateTime  createdtime= dh.DateFormat("yyyy-MM-dd HH:mm:ss").parse(d);
    DateTime last = dh.DateFormat("yyyy-MM-dd HH:mm:ss").parse(d);
    last = last.add(DateTime.now().timeZoneOffset);

    int passed = dh.DateFormat("yyyy-MM-dd HH:mm:ss")
        .parse(dh.DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()))
        .difference(last)
        .inSeconds;
    if (passed >= 60) {
      passed = dh.DateFormat("yyyy-MM-dd HH:mm:ss")
          .parse(dh.DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()))
          .difference(last)
          .inMinutes;
      if (passed >= 60) {
        passed = dh.DateFormat("yyyy-MM-dd HH:mm:ss")
            .parse(dh.DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()))
            .difference(last)
            .inHours;
        if (passed >= 24) {
          passed = dh.DateFormat("yyyy-MM-dd HH:mm:ss")
              .parse(
                  dh.DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()))
              .difference(last)
              .inDays;
          d = passed.toString();

          d = d + " يوم";
        } else {
          d = passed.toString();
          d = d + " ساعة";
        }
      } else {
        d = passed.toString();

        d = d + " دقيقة";
      }
    } else {
      d = passed.toString();

      d = d + "  ثانية";
    }
    date= d;
  }
 }