import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:purshases/search.dart';
import 'package:purshases/utiles.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'adslist.dart';

class subcategory extends StatefulWidget {
 String catid;
 subcategory({this.catid});
 
 
  @override
  subcategoryState createState() => subcategoryState(catid: this.catid);
}

 

class subcategoryState extends State<subcategory> {
   String catid;
 subcategoryState({this.catid});
@override
  void initState() {
    gelallcate();
   
 

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
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: (){
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
            actions: [
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
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10,top: 30),
            child:  loaddata?Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor:primarycolorc2,
              child: Column(children: [
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
                          childAspectRatio: 0.8,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ), children: List.generate(8, (index) =>
                         Column(
                               children: [
                                 Container(
                                  
                                  height:120,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                                 
                                 image: DecorationImage(image: NetworkImage('d'),fit: BoxFit.scaleDown),
                                 border: Border.all(width: 2,color: primarycolor)
                                 ),
                                
                                 ),
                                 SizedBox(height: 10,),
                                 Container(
                                  
                                  height:  50,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),                          
                                
                                 border: Border.all(width: 2,color: primarycolor)
                                 ),
                                  child: Center(child: Text('',),),
                                 ),
                               ],
                             
                         )), ),)   
              ],),
            ):mcateg.length==0?Center(child: Text('لا توجد تصنيفات فرعية',style: TextStyle(fontSize: size1,fontWeight: FontWeight.w700,color: primarycolor),),): Column(
              //  mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                
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
                      
                     'بحث',
                    ),), 
                  ],),
                  ),
                ),
                   SizedBox(height: 20,),
                   Expanded(child: GridView(  gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ), children: List.generate(mcateg.length, (index) =>
                       InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: (){
                            Navigator.of(context).push( MaterialPageRoute(
                              builder: (BuildContext context) => adslist(catid: mcateg[index].id,),
                              ) );

                        },
                         child: LayoutBuilder  (
                           
                           builder: (context, snapshot) {
                             return Column(
                               children: [
                                 Container(
                                  width: 1000,
                                  height: snapshot.maxHeight-60,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                                 
                                
                                 border: Border.all(width: 2,color: primarycolor)
                                 ),
                                 child: Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Image.network(baseurlim+  mcateg[index].image,fit: BoxFit.contain,),
                                 ),
                                 ),
                                 SizedBox(height: 10,),
                                 Container(
                                  
                                  height:  50,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),                          
                                
                                 border: Border.all(width: 2,color: primarycolor)
                                 ),
                                  child: Center(child: Text(mcateg[index].name,style: TextStyle(fontSize: size2,fontWeight: FontWeight.w700),),),
                                 ),
                               ],
                             );
                           }
                         ),
                       )), ),)     
              ],
            ),
          ),
        ));
  } 
     Future<int> gelallcate() async {
 
    Map<String, String> header = {
      "Accept": "application/json",
    };
    Map<String, String> body;
 
    // body = {
    //   'token': globals.access_token,
    // };
  var responsess = await http.get(
      Uri.parse(baseurl + "show_section/"+catid), headers: header
    );
   
 
     
 
    if (responsess.statusCode == 200) {
   var x=jsonDecode(responsess.body)['data']['categories'];
  
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
class maincateg{
  String name;
  String image;
  String icon;
String id;
  void add(var json){
    name=json['translations'][0]['category_name'];
    id=json['id'].toString();
    image=json['photo_name'] ;
  }
}