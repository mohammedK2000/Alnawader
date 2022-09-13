import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:purshases/search.dart';
import 'package:purshases/utiles.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'adsinfo.dart';

class adslist extends StatefulWidget {
 String catid;
 adslist({this.catid});
 
 
  @override
  adslistState createState() =>adslistState(catid: this.catid);
}

 

class adslistState extends State<adslist> {
   String catid;
 adslistState({this.catid});
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
               height: 200,

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
                child: Container(width: 120,height: 120,
                decoration: BoxDecoration(shape: BoxShape.circle
                ,image: DecorationImage(image: AssetImage('assets/cover.jpg'),fit: BoxFit.cover)
                ),
                ),
                ),
                  Positioned(top: 170,
                left: maxwidth/2-60,
                right: maxwidth/2-60,
                child:Center(child: Text('الإعلانات',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),))
                ),
               ],),
               ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child:    InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap:(){
                         Navigator.of(context).push( MaterialPageRoute(
                              builder: (BuildContext context) => seach( ),
                              ) );
                  },
                  child: Container(width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: backecolor,
                  border: Border.all(width: 2,color: primarycolor)
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                           SizedBox(width: 10,),
                    Icon(Icons.search,color: primarycolor,),
                    SizedBox(width: 10,),
                    Expanded(child: Text(
                    'بحث',
                    ),), 
                  ],),
                  ),
                ),
              ),
                 SizedBox(height: 10,),
                 Expanded(child: 
                 
           
                 Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25),),color: backecolor),
                   child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10,top: 30),
                     child:  loaddata?Shimmer.fromColors(
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
                                 image: DecorationImage(image: NetworkImage( 'd'),fit: BoxFit.cover),
                             
                                 ),
                                
                                 ),
                                 SizedBox(width: 10,),
                                 Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(' '),
                                     Text(' '),
                                 ],),
                               Spacer(),
                                 Container(
                                  width: 90,
                                  height:  30,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),                          
                                color: primarycolor,
                                 border: Border.all(width: 2,color: primarycolor)
                                 ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.message,size: 15,color: Colors.white,),
                                     SizedBox(width: 5,),
                                      Text('r'),
                                    ],
                                  ),
                                 ),
                               ],
                             ),
                           ),
                       ),
                         ) ), ),
             ):mcateg.length==0?Center(child: Text('قائمة الإعلانات فارغة',style: TextStyle(fontSize: size1,fontWeight: FontWeight.w700,color: primarycolor),),): ListView(   
                         children: List.generate(mcateg.length, (index) =>
                 
                               Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: InkWell(
                                  borderRadius: BorderRadius.circular(15),
                                  onTap: (){

                             Navigator.of(context).push( MaterialPageRoute(
                              builder: (BuildContext context) => adsinfo(catid: mcateg[index]  ,),
                              ) );

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
                                           width: 100,
                                          height:100,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                                         color: Colors.grey[200],
                                         image: DecorationImage(image: NetworkImage( baseurlim+ mcateg[index].image),fit: BoxFit.cover),
                                     
                                         ),
                                        
                                         ),
                                         SizedBox(width: 10,),
                                         Expanded(
                                           child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(mcateg[index].name,overflow: TextOverflow.clip,style: TextStyle(fontSize:size2 ,fontWeight: FontWeight.w800),),
                                               Text(mcateg[index].prise,style: TextStyle(fontSize:size2 ,fontWeight: FontWeight.w600,color: primarycolor),),
                                           ],),
                                         ),
                                      
                                         Container(
                                          width: 90,
                                          height:  30,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),                          
                                        color: primarycolor,
                                         border: Border.all(width: 2,color: primarycolor)
                                         ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.message,size: 15,color: Colors.white,),
                                             SizedBox(width: 5,),
                                              Text(mcateg[index].countrodod+" رد",style: TextStyle(fontSize: size2,color: Colors.white),),
                                            ],
                                          ),
                                         ),
                                       ],
                                     ),
                                   ),
                             ),
                                 ),
                               ) ), ),
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
      Uri.parse(baseurl + "show_category/"+catid), headers: header
    );
   
 
 
 
    if (responsess.statusCode == 200) {
   var x=jsonDecode(responsess.body)['data'] ;
 
     for(int i=0;i<x.length;i++){
         maincateg p=new maincateg();
         p.add(x[i]);
         mcateg.add(p);
     }
    
     
    } else {}
    setState(() {
   loaddata=false;
    });
  }
  bool loaddata=true;
  List<maincateg> mcateg=[];
}
 