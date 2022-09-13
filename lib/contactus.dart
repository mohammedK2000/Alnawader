import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:purshases/adsinfo.dart';
import 'package:dio/dio.dart';
import 'package:purshases/searchable_dropdown.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'countries.dart';
import 'home.dart';
import 'package:phone_number/phone_number.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'myglobals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:purshases/utiles.dart';
import 'package:http/http.dart' as http;
class contactus extends StatefulWidget {
 
 
  @override
contactusState createState() =>contactusState( );
}

 

class contactusState extends State<contactus> {

  Future<int> forget()async{
       Map<String, String> header = {
      "Accept": "application/json",
    };
    Map<String, String> body;
 
    // body = {
    //   'token': globals.access_token,
    // };
  // var responsess = await http.get(
  //     Uri.parse(baseurl + "show_category/"+catid), headers: header
  //   );
   
 
  }
  bool loadsocial=true;
     Future<int> getsocial() async {
 
    Map<String, String> header = {
      "Accept": "application/json",
    };
    Map<String, String> body;
 
    // body = {
    //   'token': globals.access_token,
    // };
  var responsess = await http.get(
      Uri.parse(baseurl + "social_media"), headers: header
    );
   
 
 
 
    if (responsess.statusCode == 200) {
 
       whats=jsonDecode(responsess.body)['data']['WhatsApp'].toString();
 
 
    } else {}
    setState(() {
   loadsocial=false;
    });
  }
  String face='';
  String whats='';
  String insta='';

  bool loaddata=true;
   void getdata(){
    if(globals.image!=null&&globals.image.length>10)
urlToFile(baseurlim+globals.image).then((value) {

  setState(() {
      _image=value;
    });
});
namecontroller.text=globals.name;
emailcontroller.text=globals.email;
country=globals.country;
 
phonecontroller.text=globals.mobile_number;
 for (int i = 0; i < codesar.length; i++) {
      if (phonecontroller.text.contains(codesar[i]['dial_code'])) {
        code = codesar[i]['dial_code'];
   

        code3 = codesar[i]['code'].toString();
    phonecontroller.text=     phonecontroller.text.replaceAll(code,'');
    validateMobile();
      }
    }
setState(() {
  
});
   }
  void getdataa(){
    emailcontroller.text=globals.email;
  
     namecontroller.text=globals.name;
     phonecontroller.text=globals.mobile_number;

     
   }
@override
  void initState() {
   _countriesar = buildcountrires(codesar);
   getsocial(); 
 if(globals.login)getdataa();
    super.initState();
  }
  final picker = ImagePicker();
 
Future getGalleryImage() async {
  var image = await picker.getImage(
      source: ImageSource.gallery,
      maxHeight: 800,
      maxWidth: 800,
      imageQuality: 50);


  setState(() {
    _image =File( image.path);
    Navigator.pop(this.context);
  });
}

Future getCameraImage() async {
  var image = await picker.getImage(
      source: ImageSource.camera,
      maxHeight: 800,
      maxWidth: 800,
      imageQuality: 50);

  setState(() {
    _image =File( image.path);
    Navigator.pop(this.context);
  });
}
  int selected=0;
    List<DropdownMenuItem> _countriesar;
  List<DropdownMenuItem> buildcountrires(List _testList4) {
    List<DropdownMenuItem> items = List();

    for (var i in _testList4) {
      items.add(
        DropdownMenuItem(
          value: i,
          child: Text(i['name']),
        ),
      );
    }
    return items;
  }

  onChangeDropdownTesten(_selectedcountriesar) {
    setState(() {
 
      country = _selectedcountriesar['name'];
       code  = _selectedcountriesar['dial_code'];
       code3= _selectedcountriesar['code'];
      validateMobile();
    });
  }
  String code3='-1';
 TextEditingController namecontroller=new TextEditingController();
  TextEditingController emailcontroller=new TextEditingController();
 
  TextEditingController messagecontroller=new TextEditingController();
  TextEditingController phonecontroller=new TextEditingController();
  String code='';
  bool showpass=false;
  bool showcon=false;
  String country='-1';
   TextEditingController loginname=new TextEditingController();
  TextEditingController loginpass=new TextEditingController();
  bool showpasslog=false;
  bool validatephone(String text){
    return true;
  }
  File _image;
      Future<File> urlToFile(String imageUrl) async {
// generate random number.
    var rng = new Random();
// get temporary directory of device.
    Directory tempDir = await getTemporaryDirectory();
// get temporary path from temporary directory.
    String tempPath = tempDir.path;
// create a new file in temporary path with random file name.
    File file = new File('$tempPath' + (rng.nextInt(100)).toString() + '.png');
// call http.get method and pass imageUrl into it to get response.
    http.Response response = await http.get(imageUrl);
// write bodyBytes received in response to file.
    await file.writeAsBytes(response.bodyBytes);
// now return the file which is created with random name in
// temporary directory and image bytes from response is written to // that file.
    return file;
  }

  //  void launchWhatsApp({
  //   @required String phone,
  //   @required String message,
  // }) async {
  //   String url() {
  //     if (Platform.isAndroid) {
  //       return "https://wa.me/$phone/?text=${Uri.parse(message)}"; // new line
  //     } else {
  //       return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message)}";
  //     }
  //   }

  //   if (await canLaunch(url())) {
  //     await launch(url());
  //   } else {
  //     throw 'Could not launch ${url()}';
  //   }
  // }
   void _launchSocial(String url, String fallbackUrl) async {
    // Don't use canLaunch because of fbProtocolUrl (fb://)
    try {
      bool launched =
          await launch(url, forceSafariVC: false, forceWebView: false);
      if (!launched) {
        await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
    }
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double maxwidth = MediaQuery.of(context).size.width;
    double maxheight = MediaQuery.of(context).size.height;
    
    return Directionality(
        textDirection: TextDirection.rtl,
        child:  DefaultTabController(
        length: 2,
          child: Scaffold(
            backgroundColor: primarycolor,
                  key: _scaffoldKey,
          drawer: drawer(context,  _scaffoldKey),
            bottomNavigationBar:  bottombare(  context,  44,primarycolor,_scaffoldKey),
            appBar:AppBar(
              elevation: 0,
          
              backgroundColor: primarycolor,
              centerTitle: true,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: (){
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
              actions: [
                InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  borderRadius: BorderRadius.circular(45),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(width: 30,height: 30,child: Center(child: Icon(Icons.arrow_forward,color: Colors.white,),),),
              ),
              )],
            ),
         body:   
         Stack(
              children: [
               Positioned(top: maxheight/3,left: 0,right: 0,bottom:0,child: Image.asset('assets/cover4.png',fit: BoxFit.fill,),),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(children: [
                      Container(
                         width: double.infinity,
                         height: 65,
                         child: Stack(
                           children: [
                             Positioned(
                               top: 15,
                               left: 0,right: 0,
                               child: Container(width: double.infinity,height: 45,
                                     decoration: BoxDecoration(
                                       border: Border.all(width: 2,color:validatel|| namecontroller.text.length>3 ? Colors.white60:Colors.red),
                                         borderRadius: BorderRadius.circular(25)),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left:20.0,right: 20,bottom: 5),
                                            child: TextFormField(
                                             controller: namecontroller,
                                             onChanged: (v){
                                              
                                               setState(() {
                                                                                                 
                                                                                               });
                                             },
                                             keyboardType: TextInputType.text,
                                             cursorColor: Colors.white,
                                             style: TextStyle(color: Colors.white,fontSize: size1,fontWeight: FontWeight.w600),
                                             decoration: InputDecoration(
                                                border: InputBorder.none,
                                                
                                                ),),
                                          ),
                                        ),
                             ),
                              Positioned(
                               top: 0,
                               right: 30,
                               child:Text('     الإسم   ',style: TextStyle(fontSize: size2,color: Colors.white,backgroundColor: primarycolor),)
                             ),
                           ],
                         ),
                       ),
                      AnimatedContainer(
                         height: validatel||namecontroller.text.length>3 ?0:30,
                         duration: Duration(milliseconds: 150),
                       child: Padding(
                         padding: const EdgeInsets.only(right:20.0),
                         child: Text('يرجى إدخال الاسم',style: TextStyle(color: Colors.red,fontSize: 11,fontWeight: FontWeight.w600),),
                       ),
                       ),
                       SizedBox(height: 20,),
                       Container(
                         width: double.infinity,
                         height: 65,
                         child: Stack(
                           children: [
                             Positioned(
                               top: 15,
                               left: 0,right: 0,
                               child: Container(width: double.infinity,height: 45,
                                     decoration: BoxDecoration(
                                       border: Border.all(width: 2,color:validatel||validateemail(emailcontroller.text)? Colors.white60:Colors.red),
                                         borderRadius: BorderRadius.circular(25)),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left:20.0,right: 20,bottom: 5),
                                            child: TextFormField(
                                             controller: emailcontroller,
                                             onChanged: (v){
                                               validateemail(v);
                                               setState(() {
                                                                                                 
                                                                                               });
                                             },
                                             keyboardType: TextInputType.text,
                                             cursorColor: Colors.white,
                                             style: TextStyle(color: Colors.white,fontSize: size1,fontWeight: FontWeight.w600),
                                             decoration: InputDecoration(
                                                border: InputBorder.none,
                                                
                                                ),),
                                          ),
                                        ),
                             ),
                              Positioned(
                               top: 0,
                               right: 30,
                               child:Text('    البريد الإلكتروني   ',style: TextStyle(fontSize: size2,color: Colors.white,backgroundColor: primarycolor),)
                             ),
                           ],
                         ),
                       ),
                      AnimatedContainer(
                         height: validatel||validateemail(emailcontroller.text)?0:30,
                         duration: Duration(milliseconds: 150),
                       child: Padding(
                         padding: const EdgeInsets.only(right:20.0),
                         child: Text('يرجى إدخال بريد إلكتروني صحيح',style: TextStyle(color: Colors.red,fontSize: 11,fontWeight: FontWeight.w600),),
                       ),
                       ),
                      
                        SizedBox(height: 20,),
                 
                      Container(
                         width: double.infinity,
                         height: 65,
                         child: Stack(
                           children: [
                             Positioned(
                               top: 15,
                               left: 0,right: 0,
                               child: Container(width: double.infinity,height: 45,
                                     decoration: BoxDecoration(
                                       border: Border.all(width: 2,color:validatel|| phonecontroller.text.length>8 ? Colors.white60:Colors.red),
                                         borderRadius: BorderRadius.circular(25)),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left:20.0,right: 20,bottom: 5),
                                            child: TextFormField(
                                             controller: phonecontroller,
                                             onChanged: (v){
                                              
                                               setState(() {
                                                                                                 
                                                                                               });
                                             },
                                             keyboardType: TextInputType.text,
                                             cursorColor: Colors.white,
                                             style: TextStyle(color: Colors.white,fontSize: size1,fontWeight: FontWeight.w600),
                                             decoration: InputDecoration(
                                                border: InputBorder.none,
                                                
                                                ),),
                                          ),
                                        ),
                             ),
                              Positioned(
                               top: 0,
                               right: 30,
                               child:Text('     رقم الهاتف   ',style: TextStyle(fontSize: size2,color: Colors.white,backgroundColor: primarycolor),)
                             ),
                           ],
                         ),
                       ),
                      AnimatedContainer(
                         height: validatel|| phonecontroller.text.length>8 ?0:30,
                         duration: Duration(milliseconds: 150),
                       child: Padding(
                         padding: const EdgeInsets.only(right:20.0),
                         child: Text('يرجى إدخال رقم الهاتف',style: TextStyle(color: Colors.red,fontSize: 11,fontWeight: FontWeight.w600),),
                       ),
                       ),
                        SizedBox(height: 20,),
                 
                      Container(
                         width: double.infinity,
                     
                         constraints: BoxConstraints(minHeight: 120
                         ,maxHeight: 120),
                         child: Stack(
                           children: [
                             Positioned(
                               top: 15,
                               left: 0,right: 0,
                               child: Container(width: double.infinity,     constraints: BoxConstraints(minHeight: 100
                         ,maxHeight: 100),
                                     decoration: BoxDecoration(
                                       border: Border.all(width: 2,color:validatel|| messagecontroller.text.length>1 ? Colors.white60:Colors.red),
                                         borderRadius: BorderRadius.circular(25)),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left:20.0,right: 20,bottom: 5),
                                            child: TextFormField(
                                             controller: messagecontroller,
                                             
                                             onChanged: (v){
                                              
                                               setState(() {
                                                                                                 
                                                                                               });
                                             },
                                             keyboardType: TextInputType.multiline,
                                             maxLines: null,
                                             cursorColor: Colors.white,
                                             style: TextStyle(color: Colors.white,fontSize: size1,fontWeight: FontWeight.w600),
                                             decoration: InputDecoration(
                                                border: InputBorder.none,
                                                
                                                ),),
                                          ),
                                        ),
                             ),
                              Positioned(
                               top: 0,
                               right: 30,
                               child:Text('       نص الرسالة   ',style: TextStyle(fontSize: size2,color: Colors.white,backgroundColor: primarycolor),)
                             ),
                           ],
                         ),
                       ),
                      AnimatedContainer(
                         height: validatel|| messagecontroller.text.length>1 ?0:30,
                         duration: Duration(milliseconds: 150),
                       child: Padding(
                         padding: const EdgeInsets.only(right:20.0),
                         child: Text('يرجى إدخال نص الرسالة',style: TextStyle(color: Colors.red,fontSize: 11,fontWeight: FontWeight.w600),),
                       ),
                       ),
                      SizedBox(height: 20,),
                       InkWell(
                         onTap:(){
                           if(!confirmsend())
                           {
                             setState(() {
                                                             validatel=false;
                                                           });
                                                           return;
                           }
                           send() ;
                         },
                         child: Container(width: double.infinity,height: 45,
                                       decoration: BoxDecoration(
                                        
                                           borderRadius: BorderRadius.circular(25),color: Colors.white),
                                           child: Center(child: Text('إرسال',style: TextStyle(color: primarycolor,fontWeight: FontWeight.w800,fontSize: size1),),),
                                           ),
                       ),
                     SizedBox(height: 20,),
                loadsocial?Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor:primarycolorc2,
              child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
    
                           InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: (){

                        },child: Container(child: Image.asset('assets/whatsapp.png',width: 40,height: 40,fit: BoxFit.contain,),)),
                    
 
                     ],), ): 
                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
  //                     InkWell(
  //                       borderRadius: BorderRadius.circular(15),
  //                       onTap: (){
  //  _launchSocial( 
  //                                       face,'');
  //                       },
  //                       child: Container(child: Image.asset('assets/facebook.png',width: 40,height: 40,fit: BoxFit.contain,),)),
                           InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: (){
                           FlutterOpenWhatsapp.sendSingleMessage(whats, "");
      //  launchWhatsApp(
      //                                       phone: whats,
      //                                       message: ' ');
                        },child: Container(child: Image.asset('assets/whatsapp.png',width: 40,height: 40,fit: BoxFit.contain,),)),
                    
  //                                          InkWell(
  //                       borderRadius: BorderRadius.circular(15),
  //                       onTap: (){
  //  _launchSocial(
  //                                           insta,
  //                                           "");
  //                       },child: Container(child: Image.asset('assets/instagram.png',width: 40,height: 40,fit: BoxFit.contain,),)),
                     ],),
                     
                     ],),
                ),
              
            
              
                Positioned(top:0,right: 0,bottom: 0,left: 0,
             
             child: Visibility(
              visible: showload,
               child: Container(color: primarycolorc2,
               
               child: Center(child: Padding(padding: EdgeInsets.all(20),
               
               child: AnimatedContainer(
                duration: Duration(milliseconds: 100),
                 width:!loaddata? 250:80,
                 height: !loaddata?200:80,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
               child: Padding(
                 padding: const EdgeInsets.all(20.0),
                 child: loaddata? progres:Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  Text(data, textAlign: TextAlign.center, style: TextStyle(fontSize: size2,fontWeight: FontWeight.w600),
                  
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
          ),
        ));
  } 

bool editepass=false;
  bool confirmupdate(){
   
    if(!validmop)return false;
    if(country.length<3)return false;
    if(namecontroller.text.length<3)return false;

    if(!validateemail(emailcontroller.text))return false;

    if(!validatephone(phonecontroller.text)) return false;

    // if(passcontroller.text.length<8) return false;

    // if(conpasscontroller.text!=passcontroller.text)return false;

    return true;
  }
  bool confirmreg(){
    if(!validmop)return false;
    if(country.length<3)return false;
    if(namecontroller.text.length<3)return false;

    if(!validateemail(emailcontroller.text))return false;

    if(!validatephone(phonecontroller.text)) return false;

    
    return true;
  }
  bool validmop=false;
  bool validateMobile() {
    PhoneNumberUtil plugin = PhoneNumberUtil();
 
    try {
      plugin.validate((code??'') + (phonecontroller.text??''), code3??'').then((result) {
        
          validmop = result;

       setState(() {
                
              });

        return validmop;
      });
    } on Exception catch (_) {
      //  SavedState.of(context).putBool("phoneb", false);
      return false;
    }
  }
  bool confirmsend(){
   if(!validateemail(emailcontroller.text)) return false;
    if(namecontroller.text.length<3)return false;
    if(phonecontroller.text.length<8)return false;
    if(messagecontroller.text.length<1)return false;

   return true;


  }

  bool validater=true;
  bool validatel=true;
    bool validateemail(String txt) {
    var email = txt;

    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.com")
        .hasMatch(email);
  }
 
  bool showload=false;
   
  String data='هذا الإيميل مستخدم';
  String action='حاول مجدداً';
   Future<int> send() async{
    setState(() {
          showload=true;
          loaddata=true;
        });
    Map<String, String> header = {
      "Accept": "application/json",
    };
    Map<String, String> body;
 
    body = {
      'email':emailcontroller.text,
     'user_name':namecontroller.text,
     'phone':phonecontroller.text,

     'message':messagecontroller.text,
   
    };
  var responsess = await http.post(
      Uri.parse(baseurl + "sent_message_to_email" ),body:body,  headers: header
    );
 
    if(responsess.statusCode==200){
             data='تم الإرسال بنجاح';
              action='تم';
              loaddata=false;
              setState(() {
                              
                            });
    }
    else{
      if(responsess.body.contains('Unauthorized'))
      {
          setState(() {
              data='عذراً, يرجى المحاولة لاحقاً';
              action='حاول مجدداً';
              loaddata=false;
            });
      }
      else{
 setState(() {
              data='عذراً, يرجى المحاولة مجدداً';
              action='حاول مجدداً';
              loaddata=false;
            });
      }
     
    }
  }
     Future<int> update () async{
    setState(() {
          showload=true;
          loaddata=true;
        });
     String token=globals.access_token;
    Map<String, String> header = {
      "Accept": "application/json",
      'Authorization': 'Bearer $token',
    };
     http.MultipartRequest request = new http.MultipartRequest(
      'POST',
      Uri.parse( baseurl + "auth/user-update-profile" ),
    );
   
    request.headers.addAll(header);

 if(_image!=null)   request.files.add(
      new http.MultipartFile.fromBytes(
        'profile_photo',
        _image.readAsBytesSync(),
        filename: _image.path, // optional
        // contentType: new MediaType('image', 'jpeg'),
      ),
    );
 
    Map<String, String> body;
 
    body = {
      'user_id':globals.user_id,
      'user_name':namecontroller.text,
    'email':emailcontroller.text,
 
   //'password':passcontroller.text,
   // 'password_confirmation':passcontroller.text,
    'mobile_number':code+phonecontroller.text, 
    'country':country
    };
    if(editepass) body = {
      'user_id':globals.user_id,
      'user_name':namecontroller.text,
    'email':emailcontroller.text,
 
 
    'mobile_number':code+phonecontroller.text, 
    'country':country
    };
  
    request.fields.addAll(body);

    http.StreamedResponse r = await request.send();
  
    var responseData = await r.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
 






 
    if( r.statusCode==201){
      Savedata(responseString,1);
    
    }else{
      if(responseString.contains('has already been taken'))
      {
       data='هذا الإيميل مستخدم مسبقاً';
      action='إعادة المحاولة';
      }else{
   data='عذراً, يرجى إعادة المحاولة';
      action='إعادة المحاولة';
      }
   
      setState(() {
              loaddata=false;
            });
    }
  }
   Future<int> register () async{
    setState(() {
          showload=true;
          loaddata=true;
        });
    Map<String, String> header = {
      "Accept": "application/json",
    };

     http.MultipartRequest request = new http.MultipartRequest(
      'POST',
      Uri.parse( baseurl + "auth/register" ),
    );
   
    request.headers.addAll(header);

 if(_image!=null)   request.files.add(
      new http.MultipartFile.fromBytes(
        'profile_photo',
        _image.readAsBytesSync(),
        filename: _image.path, // optional
        // contentType: new MediaType('image', 'jpeg'),
      ),
    );
 
    Map<String, String> body;
 
    body = {
      'user_name':namecontroller.text,
    'email':emailcontroller.text,
 
    'mobile_number':code+phonecontroller.text, 
    'country':country
    };
   
    request.fields.addAll(body);

    http.StreamedResponse r = await request.send();
 
    var responseData = await r.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
 





 
    if( r.statusCode==201){
      Savedata(responseString,0);
    
    }else{
      if(responseString.contains('has already been taken'))
      {
       data='هذا الإيميل مستخدم مسبقاً';
      action='إعادة المحاولة';
      }else{
   data='عذراً, يرجى إعادة المحاولة';
      action='إعادة المحاولة';
      }
   
      setState(() {
              loaddata=false;
            });
    }
  }
 
   Future<int> Savedata(String responseString,int x) async {
    var box = await Hive.openBox("mydata");
 
 
   if(x==0)  box.put("access_token", json.decode(responseString)['access_token'] );
    box.put("email", json.decode(responseString)['user']['email']);
       box.put("country", json.decode(responseString)['user']['country']);
    box.put("name", json.decode(responseString)['user']['user_name']);
    box.put("user_id", json.decode(responseString)['user']['id'].toString());
    box.put("mobile_number", json.decode(responseString)['user']['mobile_number']);
    box.put("profile_photo", json.decode(responseString)['user']['profile_photo']);
     globals.country=json.decode(responseString)['user']['country'].toString();
     globals.image=json.decode(responseString)['user']['profile_photo'].toString();
    globals.user_id=json.decode(responseString)['user']['id'].toString();
 
    globals.email=json.decode(responseString)['user']['email'];
    globals.name=json.decode(responseString)['user']['user_name'];
  if(x==0)  globals.access_token=json.decode(responseString)['access_token'];
    globals.mobile_number=json.decode(responseString)['user']['mobile_number'].toString();
  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                              builder: (BuildContext context) => MyHomePage(  ),
                              ) , (route) => false);
       
    return 0;
  }

  List<String> messages=[];
}
