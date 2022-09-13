 
  
 
 import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:purshases/search.dart';
import 'package:purshases/utiles.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'adsinfo.dart';

class privacypolicy extends StatefulWidget {
  
 
 
  @override
privacypolicyState createState() =>privacypolicyState( );
}

 

class privacypolicyState extends State<privacypolicy> {
 
@override
  void initState() {
    gelallads();

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
          backgroundColor: primarycolor,
          appBar: AppBar(
            elevation: 0,
          backgroundColor: primarycolor,
          toolbarHeight: 0,
          
            
          ),
            key: _scaffoldKey,
          drawer: drawer(context,  _scaffoldKey),
          bottomNavigationBar: bottombare(context,5,Colors.white,_scaffoldKey),
          body: Column(
            //  mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
               Container(width: double.infinity,
               height: 150,

               child: Stack(children: [
                Positioned(
                  top: 20,
                  left: 0,right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
               Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: (){
                  _scaffoldKey.currentState.openDrawer();
                },
                child: Container(width: 30,height: 30,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(13),color: Colors.white,
                border: Border.all(width: 2,color: Colors.white),

                ),
                child: Center(child: Icon(Icons.menu,color: primarycolor,),),
                ),
              ),
            ),
              InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  borderRadius: BorderRadius.circular(45),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(width: 30,height: 30,child: Center(child: Icon(Icons.arrow_forward,color: Colors.white,),),),
            ),
            )
                  ],),
                ),
                Positioned(top: 40,
                left: maxwidth/2-60,
                right: maxwidth/2-60,
                child: Container(width: 55,height: 55,
                 
                child: Image.asset('assets/privacy-policy.png',color: Colors.white,),
                ),
                ),
                  Positioned(top: 120,
                left: maxwidth/2-60,
                right: maxwidth/2-60,
                child:Center(child: Text('سياسة الخصوصية',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),))
                ),
               ],),
               ),
              
                 Expanded(child: 
                 
           
                 SingleChildScrollView(
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Container(
               
                       child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, bottom: 10,top: 30),
                         child:  loaddata?Center(child: CircularProgressIndicator(),):  
                               Text(messgae,style: TextStyle(fontWeight: FontWeight.w600),),
                              
                       ),
                     ),
                   ),
                 ),)     
            ],
          ),
        ));
  } 
      Future<int> gelallads() async {
 
    Map<String, String> header = {
      "Accept": "application/json",
    };
    Map<String, String> body;
 
    // body = {
    //   'token': globals.access_token,
    // };
  var responsess = await http.get(
      Uri.parse(baseurl + "privacy_policy_page"), headers: header
    );
   
  
 
    if (responsess.statusCode == 200) {
  messgae=jsonDecode(responsess.body)['data']['translations'][0]['content'] ??'' ;
  
     
     
    } else {}
    setState(() {
   loaddata=false;
    });
  }
  bool loaddata=true;
 String messgae='';
}
 