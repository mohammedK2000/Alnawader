import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:purshases/search.dart';
import 'package:purshases/utiles.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'adsinfo.dart';
import 'myglobals.dart' as globals;
class personalfile extends StatefulWidget {
  String email;
   List<String> tokens=[];
 String personalid;
 String persname;
 String persimage;
 personalfile({this.personalid,this.persimage,this.persname,this.tokens,this.email});
 
 
  @override
  adslistState createState() =>adslistState(
    tokens: this.tokens,
    personalid: this.personalid,persimage: this.persimage,persname: this.persname,email: this.email);
}

 

class adslistState extends State<personalfile> {
 String email;
   String personalid; String persname;
 String persimage;
 adslistState({this.personalid,this.persimage,this.persname,this.tokens,this.email});
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
        SizedBox(height: 40,),
                 Expanded(child: 
                 
           
                 Stack(
                   children: [
                  
                     Positioned(
                      top: 50,
                      left: 0,right: 0,bottom: 0,
                       child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25),),color: backecolor),
                         child: Padding(
                            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10,top: 100),
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
                               children: List.generate(mcateg.where((element) => element.city==selectedcity).length, (index) =>
                       
                                     Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: InkWell(
                                        borderRadius: BorderRadius.circular(15),
                                        onTap: (){

                                   Navigator.of(context).push( MaterialPageRoute(
                                    builder: (BuildContext context) => adsinfo(catid: mcateg.where((element) => element.city==selectedcity).elementAt(index)  ,),
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
                                               image: DecorationImage(image: NetworkImage( baseurlim+ mcateg.where((element) => element.city==selectedcity).elementAt(index).image),fit: BoxFit.cover),
                                           
                                               ),
                                              
                                               ),
                                               SizedBox(width: 10,),
                                               Expanded(
                                                 child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text( mcateg.where((element) => element.city==selectedcity).elementAt(index).name,overflow: TextOverflow.clip,style: TextStyle(fontSize:size2 ,fontWeight: FontWeight.w800),),
                                                     Text( mcateg.where((element) => element.city==selectedcity).elementAt(index).prise,style: TextStyle(fontSize:size2 ,fontWeight: FontWeight.w600,color: primarycolor),),
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
                                                    Text( mcateg.where((element) => element.city==selectedcity).elementAt(index).countrodod+" رد",style: TextStyle(fontSize: size2,color: Colors.white),),
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
                       ),
                     ),
                 
                 
                 
                   Positioned(top: 0,left: 10,right: 10,child: Container(height: 140,
                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                   image: DecorationImage(image: AssetImage('assets/cover6.png'),fit: BoxFit.cover)),
                   child: Row(children: [
                    Container(width: 100,height: 140,decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                   image: DecorationImage(image: NetworkImage(baseurlim+persimage),fit: BoxFit.cover)),),
                     SizedBox(width: 10,),
                   Expanded(
                     child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Row(
                           children: [
                             Expanded(child: Text(persname,style: TextStyle(fontWeight: FontWeight.w700,color: Colors.white),)),
                          
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(decoration: BoxDecoration(
                              border: Border.all(width: 2,color: Colors.white),
                              color: primarycolorc,
                              borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.only(left:8.0,right: 8,top: 3,bottom: 3),
                              child: Text(mcateg.length.toString()+' إعلان',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: size3),),
                            ),),
                          )
                           ],
                         ),
                             Row(
                               children: [
                                   Expanded(child: Text(email,style: TextStyle(fontWeight: FontWeight.w700,color: Colors.grey[800]),)),
                                 Align(
                                  alignment: Alignment.bottomLeft,
                                   child: Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Visibility(
                            visible:    personalid!=globals.user_id&&globals.login,
                                        child: InkWell(
                                          borderRadius: BorderRadius.circular(5),
                                          onTap: (){
                                          _myAlertDialogRating();
                                          },
                                          child: Container(
                                            width: 40,height: 40,decoration: BoxDecoration(shape: BoxShape.circle,color: primarycolor),
                                            child: Icon(Icons.message,color: Colors.white,size: 20,)),
                                        ),
                                      ),
                                   ),
                                 ),
                               ],
                             ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(cities.length, (index) => 
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: InkWell(
                                onTap: (){
                                  setState(() {
                                                                      selectedcity=cities[index];
                                                                    });
                                },
                                child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                                border: Border.all(width: 2,color: cities[index]==selectedcity?primarycolor:Colors.transparent),color: Colors.grey[300]),
                                child: Padding(
                                  padding: const EdgeInsets.only(left:8.0,right: 8,top: 3,bottom: 3),
                                  child: Text(cities[index],style: TextStyle(
                                    fontWeight: FontWeight.w600,fontSize: size3, color: cities[index]==selectedcity?primarycolor:Colors.  grey[800])  ),
                                ),),
                              ),
                            ),),),
                          ),
                         
                       ],
                     ),
                   )],),),),
                 
                   ],
                 ),)     
            ],
          ),
        ));
  } 
  TextEditingController mesc=new TextEditingController();
    void _myAlertDialogRating() {
    Dialog dialog = Dialog(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.white,
      child: StatefulBuilder(
       
        builder: (context, snapshot) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                  
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 33,height: 33,
                            decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(width: 1,color: primarycolor)),
                            child: Center(
                              child: IconButton(
                                splashColor: primarycolorc,
                                onPressed: () => Navigator.pop(context),
                                icon:   Icon(
                                  Icons.close,
                                  color:primarycolor,size: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                        
                      ],
                    ),
    
                   
                   
                Row(children: [
                  Container(width: 50,height: 50,decoration: BoxDecoration(shape: BoxShape.circle,
                   image: DecorationImage(image: NetworkImage(baseurlim+persimage)),
                  boxShadow: kElevationToShadow[2],
                  color: Colors.grey[200]),),
                  SizedBox(width: 20,),
                  Text(persname,style: TextStyle(color:primarycolor,fontSize: size1,fontWeight: FontWeight.w700),)
                ],),

                         SizedBox(height: 10,),
                       Container(width: double.infinity,
        height: 100,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.grey[200]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: mesc,
              decoration: InputDecoration(
              hintText: 'إكتب رسالتك',
              border: InputBorder.none,
            ),),
          ),
        ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                        
                          senmes(mesc.text);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: primarycolor,
                          ),
                          child:Center(child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('إرسال',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: size1),),
                            SizedBox(width: 11,),
                             Icon(Icons.send,color: Colors.white,size: 20,),
                              ],
                            ),
                          ),)
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }
   Future<int> senmes(String message) async{
 
 mesc.clear();
     String token=globals.access_token;
     Map<String, String> header = {
       "Accept": "application/json",
       'Authorization': 'Bearer $token',
     };
     Map<String, String> body={
            'sender_id':globals.user_id,
            'receiver_id':personalid,
            'message_text':message
,     };

   
     var responsess = await http.post(
         Uri.parse(baseurl + "send_message" ), body: body,  headers: header
     );
 
     if(responsess.statusCode==200){
    
            sendpushup(tokens,message,personalid,globals.user_id);
             
     }
     else
     {
     
     }
   }
    List<String> tokens=[];
  void sendpushup(List<String> fcmtoken,String message,String recciverid,String senderid ){
       Timer(Duration(seconds: 1), () {
     sendPushMessage(globals.name,globals.image, fcmtoken ,'رسالة من '+globals.name,message,recciverid,senderid );
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

 String constructFCMPayload(String name,String image,List<String> tokens,String title,String message,String recciverid,String senderid ) {

    return jsonEncode({
      'registration_ids':  tokens ,
      'data': {
        'ismessage':'1',
        
        'name':name,
        'image':image,
        'msg':message,
        'token':globals.mytokens,
        'recciverimage':persimage,
        'reccivername':persname,
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
      Future<int> gelallads() async {
 
  String token=globals.access_token;
  Map<String, String> header = {
    "Accept": "application/json",
    'Authorization': 'Bearer $token',
  };
  Map<String, String> body;


  var responsess = await http.get(
      Uri.parse(baseurl + "my_advertisements?user_id=" +personalid),  headers: header
  );

 
 
    if (responsess.statusCode == 200) {
   var x=jsonDecode(responsess.body)['data'] ;
 
     for(int i=0;i<x.length;i++){
        if(x[i]['advertisement_status']=='inactive')continue;
         maincateg p=new maincateg();
         p.add(x[i]);
         if(!cities.contains(p.city))cities.add(p.city);
         mcateg.add(p);
     }
    
     
    } else {}
    setState(() {
   loaddata=false;
   if(cities.length>0)selectedcity=cities[0];
    });
  }
  String selectedcity='';
  List<String> cities=[];
  bool loaddata=true;
  List<maincateg> mcateg=[];
}
 