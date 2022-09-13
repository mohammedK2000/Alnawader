import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:purshases/personalfile.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'imagegallery.dart';
import 'myglobals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:purshases/utiles.dart';
import 'package:http/http.dart' as http;
class adsinfo extends StatefulWidget {
 maincateg catid;
 adsinfo({this.catid});
 
 
  @override
 adsinfoState createState() =>adsinfoState(catid: this.catid);
}

 

class adsinfoState extends State<adsinfo> {
   maincateg catid;
 
    void launchWhatsApp({
    @required String phone,
    @required String message,
  }) async {
    String url() {
      if (Platform.isAndroid) {
        return "https://wa.me/$phone/?text=${Uri.parse(message)}"; // new line
      } else {
        return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message)}";
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }
adsinfoState({this.catid});
@override
  void initState() {
  showadverst();
print(catid.images[0]);

    super.initState();
  }
        final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ScrollController controller=new ScrollController ();
 FocusNode fnode=new FocusNode();
  @override
  Widget build(BuildContext context) {
    double maxwidth = MediaQuery.of(context).size.width;
    double maxheight = MediaQuery.of(context).size.height;
    
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: backecolor,
          appBar:AppBar(
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
            title:      Text(catid.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: size1),),
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
                   key: _scaffoldKey,
          drawer: drawer(context,  _scaffoldKey),
          bottomNavigationBar: bottombare(context,5,Colors.white,_scaffoldKey),
          body: Stack(
            children: [
              Positioned(bottom:globals.login? 70:0,top: 0,left: 0,right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                 
                    child: SingleChildScrollView(
                      controller: controller,
                      child: Column(
                        children: [
                       
                        
                          Container(
                         decoration: BoxDecoration(
                      border: Border.all(width: 2,color: Colors.grey[300]),
                      borderRadius:BorderRadius.circular(18),color: Colors.grey[200]),
                      child: Column(children: [
                            adsuser!=null? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: (){
                              
                                  Navigator.of(context).push( MaterialPageRoute(
                     builder: (BuildContext context) => personalfile(email:adsuser.email,
                      tokens: tokens,
                        personalid: adsuser.id,persimage: adsuser.image,persname: adsuser.name,),
                     ) );
                                  
                                },
                                child: Row(children: [
                                 
                                    Container(width: 40,height: 40,decoration: BoxDecoration(
                                      
                           borderRadius: BorderRadius.all ( Radius.circular(6),
                                      ),color: Colors.grey[500]
                                   , image: DecorationImage(image: NetworkImage(baseurlim+adsuser.image),fit: BoxFit.cover)
                                    ),
                                    
                                    ),
                                    SizedBox(width: 5,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(adsuser.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: size1,color: primarycolor),),
                                      Text(catid.city,style: TextStyle(fontWeight: FontWeight.w600,fontSize: size3,color: Colors.grey[700]),),
                                      ],
                                    ),
                Spacer(),
                Align(alignment: Alignment.topRight,
                child: Container(width: 90,height: 30,decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.grey[400]),
                child: Row(
                 
                 children: [
                  Container(width: 30,height: 30,decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: primarycolor),
                  child: Center(child: Icon(Icons.message,color: Colors.white,size: 15,),),
                  ),
                 Spacer(),
                  Text(catid.countrodod+" رد",style: TextStyle(fontSize: size2,fontWeight: FontWeight.w600),),
                   Spacer(),
                ],),
                ),
                ),
                                 
                                ],),
                              ),
                            ):Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor:primarycolorc2,
                                child: Row(children: [
                                   
                                      Container(width: 40,height: 40,decoration: BoxDecoration(
                                        
                           borderRadius: BorderRadius.all ( Radius.circular(6),
                                        ),color: Colors.grey[500]
                                     , image: DecorationImage(image: NetworkImage(baseurlim+'adsuser.image'),fit: BoxFit.cover)
                                      ),
                                      
                                      ),
                                      SizedBox(width: 5,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('',style: TextStyle(fontWeight: FontWeight.bold,fontSize: size1,color: primarycolor),),
                                        Text(catid.city,style: TextStyle(fontWeight: FontWeight.w600,fontSize: size3,color: Colors.grey[700]),),
                                        ],
                                      ),
                Spacer(),
                Align(alignment: Alignment.topRight,
                child: Container(width: 90,height: 30,decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.grey[400]),
                child: Row(
                 
                 children: [
                  Container(width: 30,height: 30,decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: primarycolor),
                  child: Center(child: Icon(Icons.message,color: Colors.white,size: 15,),),
                  ),
                 Spacer(),
                  Text(catid.countrodod+" رد",style: TextStyle(fontSize: size2,fontWeight: FontWeight.w600),),
                   Spacer(),
                ],),
                ),
                ),
                                   
                                  ],),
                              ),
                            ),
                          
                   Container(width: double.infinity,
                
                        child: GalleryImage(
                                                        titileGallery: ' ',
                                                      imageUrls:  catid.images, 
                                                      ), 
                   ),
                      
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Text( catid.details,textAlign: TextAlign.center ,style: TextStyle(fontWeight: FontWeight.w600,fontSize: size3,color: Colors.grey),),
                         ),
                  
                             
                         
                                 Text(catid.prise,style: TextStyle(fontWeight: FontWeight.bold,fontSize: size1,color: primarycolor),),
                                 SizedBox(height: 10,),
                            adsuser!=null? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                            catid.show_mobile_number=='show'?                     InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: (){
       launchWhatsApp(
                                            phone: adsuser.mobile_number,
                                            message: ' ');
                        },child: Container(child: Image.asset('assets/whatsapp.png',width: 40,height: 40,fit: BoxFit.contain,),)):Container(),
                             SizedBox(width:   catid.show_mobile_number=='show'?20:0,),
                              Visibility(
                            visible:    adsuser.id!=globals.user_id&&globals.login,
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
                            ],):Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor:primarycolorc2,
                              child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                            catid.show_mobile_number=='show'?                     InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: (){
      
                        },child: Container(child: Image.asset('assets/whatsapp.png',width: 40,height: 40,fit: BoxFit.contain,),)):Container(),
                             SizedBox(width:   catid.show_mobile_number=='show'?20:0,),
                              Visibility(
                            visible:  true||  adsuser.id!=globals.user_id&&globals.login,
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
                            ],)
                            ),
                                 SizedBox(height: 10,),
                      ],),
                          ),
                     
                          Column(children: [     loaddata?Shimmer.fromColors(
                        baseColor: Colors.grey[300],
                        highlightColor:primarycolorc2,child: Container(child:    Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: List.generate(8, (index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(''),
                                  ),
                                ),
                              ),),
                            ),
                          ), ))
                          :mess.length==0?
                          Center(child: Text('لاتوجد ردود بعد',style: TextStyle(color: primarycolor,fontSize: size1,fontWeight: FontWeight.w700),),)
                          :
                           InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: (){
                              fnode.unfocus();
                            },
                             child: Column(
                            
                               children: List.generate(mess.length, (index) => Padding(
                                 padding: const EdgeInsets.only(top:8.0),
                                 child:globals.user_id==mess[index].user_d?
                                 Container(
                                     decoration: BoxDecoration(
                                      
                                      borderRadius: BorderRadius.circular(15),color: primarycolorc2),
                                   child: Row(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Expanded(
                                         child: Padding(
                                           padding: const EdgeInsets.all(8.0),
                                           child: Text(mess[index].text,style: TextStyle(fontSize: size2),),
                                         ),
                                       ),
                                       InkWell(
                                         onTap: (){
                                           removereplay(mess[index].id);
                                         },
                                         child: Container(width: 25,height:25,
                                         decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(15),  bottomRight: Radius.circular(5)),color: Colors.red,),
                                         child: Center(child: Icon(Icons.delete,color: Colors.white,size: 20,),),
                                         ),
                                       ),
                                      
                                     ],
                                   ),
                                 )
                                 :
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        
                                       width: 70,
                                        child: InkWell(
                                          onTap:(){
                                                        Navigator.of(context).push( MaterialPageRoute(
                     builder: (BuildContext context) => personalfile( email: mess[index].email,
                      tokens: mess[index].tokens,
                       personalid:mess[index].user_d,persimage: mess[index].user_image,persname: mess[index].user_name,),
                     ) );
                                
                                          },
                                          child: Column(
                                           
                                           children: [
                                            Container(width: 40,height: 40,
                                            decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.grey,
                                            image: DecorationImage(image: NetworkImage(baseurlim+mess[index].user_image))),),
                                    
                                            Text(mess[index].user_name,maxLines: 1,overflow: TextOverflow. ellipsis,style: TextStyle(fontSize: size3-2,fontWeight: FontWeight.w600),),
                                          ],),
                                        ),
                                      ),
                                      SizedBox(width: 5,),
                                      Expanded(
                                        child: Container(
                                          constraints: BoxConstraints(minHeight: 70),
                                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.grey[100]),
                                         child: Padding(
                                           padding: const EdgeInsets.all(8.0),
                                           child: Text(mess[index].text,style: TextStyle(fontSize: size2),),
                                         ),
                                 ),
                                      ),
                                    ],
                                  ),
                               ),),
                             ),
                           ),],),
                 
                      
                         
                           SizedBox(height: 10,),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(bottom: 10,left: 15,right: 15,child:   Visibility(
                           visible: globals.login,
                           child: Container(
                            decoration: BoxDecoration(color: Colors.grey[200],borderRadius: BorderRadius.circular(10)),
                            
                            
                            width: double.infinity,
                     
                           child: Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Row(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                            
                               Expanded(
                                 child: Container(
                                   constraints: BoxConstraints(minHeight: 40,maxHeight: 200),
                                   decoration: BoxDecoration(color:backecolor,borderRadius: BorderRadius.circular(15)),
                                   child: Padding(
                                     padding: const EdgeInsets.only(left:8.0,right: 8, ),
                                     child: TextField(
                                       controller: repc,
                                       focusNode:fnode ,
                                       keyboardType: TextInputType.multiline,
                                       maxLines: null,
                                       decoration: InputDecoration(hintText: 'اكتب رداً',
                                       border: InputBorder.none
                                       ),
                                     ),
                                   ),
                                 ),
                               ),
                               SizedBox(width: 10,),
                               InkWell(
                                 onTap: (){
                                   fnode.unfocus();
                                   addreplay();
                                 },
                                 borderRadius: BorderRadius.circular(20),
                                 child: Container(width: 45,height: 55,decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                                 color: Colors.grey[100]
                                 ),child: Center(child: Icon(Icons.send,color: primarycolor,),),),
                               ),
                          
                             ],),
                           ),
                           ),
                         ),),
         
            Positioned(top:0,right: 0,bottom: 0,left: 0,
             
             child: Visibility(
              visible: showload,
               child: Container(color: primarycolorc2,
               
               child: Center(child: Padding(padding: EdgeInsets.all(20),
               
               child: AnimatedContainer(
                duration: Duration(milliseconds: 100),
                 width:!loaddata2? 250:80,
                 height: !loaddata2?200:80,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
               child: Padding(
                 padding: const EdgeInsets.all(20.0),
                 child: loaddata2? progres:Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  Text(data,style: TextStyle(fontSize: size2,fontWeight: FontWeight.w600),
                  
                  ),
                  SizedBox(height: 10,),
                  InkWell(
                 borderRadius: BorderRadius.circular(5),
                 onTap: (){
                  setState(() {
                                   showload=false;
                      });
                 },
                    child: Card(
                      color: primarycolor,
                      
                      child: Center(child: Padding(
                      padding: const EdgeInsets.only(left:12.0,right: 12,top: 8,bottom: 8),
                      child: Text(action,style: TextStyle(fontSize: size2,fontWeight: FontWeight.w600,color: Colors.white),),
                    ),),),
                  )
                 ],),
               ),
               ),
               ),),
               ),
             ),
             )
         
            ],
          ),
        ));
  }
  bool showload=false;
  bool loaddata2=true;
  String data='';
  String action='';
   Future<int> showadverst() async {

     Map<String, String> header = {
       "Accept": "application/json",
     };
     Map<String, String> body;
   print(catid.id);
     
     var responsess = await http.get(
         Uri.parse(baseurl + "show_advertisement/"+catid.id), headers: header
     );

   print(responsess.body);
   


     if (responsess.statusCode == 200) {
       var x=jsonDecode(responsess.body)['data']['replies'] ;
  
       for(int i=0;i<x.length;i++){
         
            message m=new message();
            m.text=x[i]['reply_text'].toString();
            m.id=x[i]['id'].toString();
            m.user_d=x[i]['user_id'].toString();
            m.email=x[i]['user']['email'].toString();
            m.user_name=x[i]['user']['user_name'].toString();
            m.user_image=x[i]['user']['profile_photo'].toString();
            if(x[i]['device_tokens']!=null&& x[i]['device_tokens'].toString().length>0)
            {
              for(int ii=0;ii<x[i]['device_tokens'].length;ii++){
                m.tokens.add(x[i]['device_tokens'][ii]['token'].toString());
              }
            }
            mess.add(m);
       }
    
       var f=jsonDecode(responsess.body)['data']['user'] ;
  
       adsuser =new user();
       adsuser.id=f['id'].toString();
       adsuser.mobile_number=f['mobile_number'].toString();
       adsuser.name=f['user_name'];
       adsuser.image=f['profile_photo'].toString();
       adsuser.email=f['email'].toString();
       for(int i=0;i<f['device_tokens'].length;i++){
        tokens.add(f['device_tokens'][i]['token']);
       }
 
     } else {}
     catid.countrodod=mess.length.toString();
     setState(() {
       loaddata=false;
     });
 
       
   }
   List<String> tokens=[];
   Function jumm(){controller.jumpTo(controller.position.maxScrollExtent);}
   bool loaddata=true;
TextEditingController repc=new TextEditingController();



 Future<int> addreplay() async{
    if(repc.text.length==0)return 0;
setState(() {
  showload=true;
  loaddata2=true;
});
     String token=globals.access_token;
     Map<String, String> header = {
       "Accept": "application/json",
       'Authorization': 'Bearer $token',
     };
     Map<String, String> body;

     body = {
       'reply_text':repc.text,

       'user_id':globals.user_id,
       'advertisement_id':catid.id,

     };
     var responsess = await http.post(
         Uri.parse(baseurl + "add_reply" ),body:body,  headers: header
     );
     
     if(responsess.statusCode==200){
         message m=new message();
                m.user_d=globals.user_id;
                m.id=jsonDecode(responsess.body)['data']['id'].toString();
                m.text=repc.text;
                mess.add(m);
                repc.clear();
                     catid.countrodod=mess.length.toString();
        setState(() {
                  showload=false;
                  loaddata2=false;
                });
                if(mess.length>0)
                controller.jumpTo(controller.position.maxScrollExtent+50);
             
     }
     else
     {
      setState(() {
              data='عذراً, يرجى المحاولة لاحقاً';
              action="حاول مجدداً";
              loaddata=false;
            });
     }
   }




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
                  image: DecorationImage(image: NetworkImage(baseurlim+adsuser.image)),
                  boxShadow: kElevationToShadow[2],
                  color: Colors.grey[200]),),
                  SizedBox(width: 20,),
                  Text(adsuser.name,style: TextStyle(color:primarycolor,fontSize: size1,fontWeight: FontWeight.w700),)
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

 
TextEditingController mesc=new TextEditingController();
 Future<int> removereplay(String id) async{
 
setState(() {
  showload=true;
  loaddata2=true;
});
     String token=globals.access_token;
     Map<String, String> header = {
       "Accept": "application/json",
       'Authorization': 'Bearer $token',
     };
     Map<String, String> body;

   
     var responsess = await http.delete(
         Uri.parse(baseurl + "remove_reply/"+id+'?user_id='+globals.user_id ),   headers: header, 
     );
 
     if(responsess.statusCode==200){
       mess.removeWhere((element) => element.id==id);
                     catid.countrodod=(int.parse(catid.countrodod)-1).toString();
        setState(() {
                  showload=false;
                  loaddata2=false;
                });
                
            
             
     }
     else
     {
      setState(() {
              data='عذراً, يرجى المحاولة لاحقاً';
              action="حاول مجدداً";
              loaddata=false;
            });
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
        'recciverimage':adsuser.image,
        'reccivername':adsuser.name,
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

 Future<int> senmes(String message) async{
 
 mesc.clear();
     String token=globals.access_token;
     Map<String, String> header = {
       "Accept": "application/json",
       'Authorization': 'Bearer $token',
     };
     Map<String, String> body={
            'sender_id':globals.user_id,
            'receiver_id':adsuser.id,
            'message_text':message
,     };

   
     var responsess = await http.post(
         Uri.parse(baseurl + "send_message" ), body: body,  headers: header
     );
 
     if(responsess.statusCode==200){
    
            sendpushup(tokens,message,adsuser.id,globals.user_id);
             
     }
     else
     {
     
     }
   }
  user adsuser;
   List<message> mess=[];
}
class user{
  String email;
  String name;
  String mobile_number;
  String image;
  String id;
}
class message{
  String text;
  List<String> tokens=[];
  String id;
  String user_d;
  String user_name='name';
  String user_image='ii';
  String email;
}
