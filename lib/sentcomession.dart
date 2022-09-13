import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:purshases/myad.dart';
import 'package:purshases/utiles.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'adsinfo.dart';
import 'myglobals.dart' as globals;
class sentcomession extends StatefulWidget {
 
 
  @override
  myadsState createState() =>myadsState( );
}

 

class myadsState extends State<sentcomession> {
 
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
          bottomNavigationBar: bottombare(context,5,Colors.white,_scaffoldKey),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child:!globals.login?Center(child: Text('يرجى تسجيل الدخول لتتمكن من الاستفادة من ميزات التطبيق',textAlign: TextAlign.center,style: TextStyle(color: primarycolor,fontWeight: FontWeight.bold),),) :loaddata?
            Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor:primarycolorc2,
              child: ListView(   
                  children: List.generate(5, (index) =>
              
                         Card(
                            elevation: 2,
                            child: Container(
                     width: double.infinity,
                     height: 240,
                  
                            child: Padding(
                              padding: const EdgeInsets.only(bottom:8.0),
                              child: Column(
                               crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: double.infinity,
                                   height:150,
                                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey[200],
                                  image: DecorationImage(image: NetworkImage(baseurlim+ 'd'),fit: BoxFit.cover),
                              
                                  ),
                                 
                                  ),
                                  SizedBox(height: 10,),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Column(
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Text("رقم الإعلان :"+ '',style: TextStyle(fontSize:size2 ,fontWeight: FontWeight.w800),),
                                            Text("قيمة العمولة :"+ '',style: TextStyle(fontSize:size2 ,fontWeight: FontWeight.w800),),
                                           
                                        ],),   Spacer(),
                                    Card(
                                      color:Colors.blue,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('d',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: size2),),
                                      ),)
                                      ],
                                    ),
                                  ),
                               
                               
                                ],
                              ),
                            ),
                    ),
                          ), ), ),
            ):mycomess.length==0?Center(child: Text('لاتوجد عمولات مرسلة بعد',style: TextStyle(fontWeight: FontWeight.w700,color: primarycolor,fontSize: size1),),): ListView(   
                children: List.generate(mycomess.length, (index) =>
            
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                         borderRadius: BorderRadius.circular(15),
                         onTap: ()async{
     
                         },
                          child: Card(
                            elevation: 2,
                            child: Container(
                     width: double.infinity,
                     height: 240,
                  
                            child: Padding(
                              padding: const EdgeInsets.only(bottom:8.0),
                              child: Column(
                               crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: double.infinity,
                                   height:134,
                                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey[200],
                                  image: DecorationImage(image: NetworkImage(baseurlim+ mycomess[index].image),fit: BoxFit.cover),
                              
                                  ),
                                 
                                  ),
                                  SizedBox(height: 10,),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Column(
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Text("رقم الإعلان :"+ mycomess[index].comessionid,style: TextStyle(fontSize:size2 ,fontWeight: FontWeight.w800),),
                                     Text("سعر الإعلان :"+ mycomess[index].prise +'ر.س',style: TextStyle(fontSize:size2 ,fontWeight: FontWeight.w800),),
                                            Text("قيمة العمولة :"+ mycomess[index].comess,style: TextStyle(fontSize:size2 ,fontWeight: FontWeight.w800),),
                                           
                                        ],),   Spacer(),
                                    Card(
                                      color:Colors.blue,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(mycomess[index].date,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: size2),),
                                      ),)
                                      ],
                                    ),
                                  ),
                               
                               
                                ],
                              ),
                            ),
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
      Uri.parse(baseurl + "all_commission_request/" +globals.user_id),  headers: header
  );


 
  if (responsess.statusCode == 200) {
    var x=jsonDecode(responsess.body)['data']['data']  ;
 
    for(int i=0;i<x.length;i++){
      comession p=new comession();
     p.comess=x[i]['advertisement_commission'];
     p.date=x[i]['date'];
     p.prise=x[i]['advertisement_price'].toString();
     p.image=x[i]['receipt_photo'];
     p.comessionid=x[i]['advertisement_number'];
    mycomess.add(p);
    }


  } else {}
  setState(() {
    loaddata=false;
  });
}
List<comession> mycomess=[];
bool loaddata=true;
}
 class comession{
    String image;
    String comess;
    String prise;
    String date;
    String comessionid;
 }