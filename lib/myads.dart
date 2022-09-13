import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:purshases/myad.dart';
import 'package:purshases/utiles.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'adsinfo.dart';
import 'myglobals.dart' as globals;
class myads extends StatefulWidget {
 
 
  @override
  myadsState createState() =>myadsState( );
}

 

class myadsState extends State<myads> {
 
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
            ):globals.myads.length==0?Center(child: Text('لاتوجد إعلانات لديك بعد',style: TextStyle(fontWeight: FontWeight.w700,color: primarycolor,fontSize: size1),),): ListView(   
                children: List.generate(globals.myads.length, (index) =>
            
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                         borderRadius: BorderRadius.circular(15),
                         onTap: ()async{
       if(globals.myads[index].advertisement_status!='active')return;
               await     Navigator.of(context).push( MaterialPageRoute(
                     builder: (BuildContext context) => myadd( myad: globals.myads[index],),
                     ) );
setState(() {
  
});
                         },
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
                                  width: 80,
                                 height:80,
                                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                                color: Colors.grey[200],
                                image: DecorationImage(image: NetworkImage(baseurlim+ globals.myads[index].image),fit: BoxFit.cover),
                            
                                ),
                               
                                ),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text(globals.myads[index].name,style: TextStyle(fontSize:size2 ,fontWeight: FontWeight.w800),),
                                     SizedBox(height: 5,),
                                     Container(decoration: BoxDecoration(color: primarycolor,borderRadius: BorderRadius.circular(15),
                                     
                                     ),
                                     
                                     child: Padding(
                                       padding: const EdgeInsets.all(5.0),
                                       child: Icon(Icons.edit,color: Colors.white,size: 20,),
                                     ),
                                     )
                                  ],),
                                ),
                                
                                Card(
                                  color: getcolor(globals.myads[index].advertisement_status),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(getstatus( globals.myads[index].advertisement_status),style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700,fontSize: size2),),
                                  ),)
                             
                              ],
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
  
  globals.myads.clear();
  String token=globals.access_token;
  Map<String, String> header = {
    "Accept": "application/json",
    'Authorization': 'Bearer $token',
  };
  Map<String, String> body;


  var responsess = await http.get(
      Uri.parse(baseurl + "my_advertisements?user_id=" +globals.user_id),  headers: header
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
bool loaddata=true;
}
 