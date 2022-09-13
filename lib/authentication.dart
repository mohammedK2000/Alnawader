import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_offline/flutter_offline.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:purshases/adsinfo.dart';
import 'package:dio/dio.dart';
import 'package:purshases/searchable_dropdown.dart';
import 'countries.dart';
import 'home.dart';
import 'package:phone_number/phone_number.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'myglobals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:purshases/utiles.dart';
import 'package:http/http.dart' as http;
class authentication extends StatefulWidget {
 bool fromreg=false;
 String email2='';
 String pass2='';
 authentication({this.fromreg,this.email2,this.pass2});
 
  @override
authenticationState createState() =>authenticationState(fromreg: this.fromreg,email2: this.email2,pass2: this.pass2);
}

 

class authenticationState extends State<authentication> {
 bool fromreg=false;
  String email2='';
 String pass2='';
 authenticationState({this.fromreg,this.email2,this.pass2});
  Future<int> forget()async{
        setState(() {
          showload=true;
          loaddata=true;
        });
       
       Map<String, String> header = {
      "Accept": "application/json",
    };
    Map<String, String> body;
 
    body = {
      'email': loginname.text,
    };
  var responsess = await http.post(
      Uri.parse(baseurl + "forget_password"), headers: header,body: body
    );
 
 if(responsess.statusCode==200){
     setState(() {
              data='تم إرسال رابط تغيير كلمة المرور إلى الإيميل الخاص بك';
              action=' تم';
              loaddata=false;
            });
 }else if(responsess.statusCode==422){
    setState(() {
              data='هذ المستخدم غير مسجل لدينا';
              action='حاول مجدداً';
              loaddata=false;
            });
 }
 else {
     setState(() {
              data='يرجى المحاولة لاحقاً';
              action='حاول مجدداً';
              loaddata=false;
            });
 }
  }
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
 validateMobile();
setState(() {
  
});
   }
@override
  void initState() {
    if(fromreg){
      showload=true;
      loaddata=false;
      data='لقد تم إنشاء حسابك بنجاح,يرجى تفعيل الحساب من الرابط المرسل الى بريدك الالكتروني من ثم تسجيل الدخول';
      action='تم';
      loginname.text=email2;
      loginpass.text=pass2;
    }
   _countriesar = buildcountrires(cities);
   if(globals.login)
getdata();
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
          child: Text(i),
        ),
      );
    }
    return items;
  }

  onChangeDropdownTesten(_selectedcountriesar) {
    FocusScope.of(context).unfocus();
    setState(() {
 
      country = _selectedcountriesar ;
  
       
      validateMobile();
    });
  }
 
 TextEditingController namecontroller=new TextEditingController();
  TextEditingController emailcontroller=new TextEditingController();
   TextEditingController passcontroller=new TextEditingController();
  TextEditingController conpasscontroller=new TextEditingController();
  TextEditingController phonecontroller=new TextEditingController();
 
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
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
      bool connected =false;
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
            bottomNavigationBar:  bottombare(  context,  1,primarycolor,_scaffoldKey),
            appBar:AppBar(
              elevation: 0,
              bottom:  showload||globals.login? PreferredSize(preferredSize: Size(0.0, 0.0),child: Container(),):   TabBar(
       
        labelColor: Colors.white,
        labelStyle: TextStyle(fontSize: size1,fontWeight: FontWeight.bold),
        indicatorColor: Colors.white,
        indicatorWeight: 2,
        indicatorSize: TabBarIndicatorSize.label,
   
                tabs: [
            Text('تسجيل الدخول', style: TextStyle(fontFamily: 'Cairo'),),  
      
             Text('إنشاء حساب', style: TextStyle(fontFamily: 'Cairo'),
                  ),
                ],
              ),
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
            
            body: globals.login?
            Stack(children: [
                Positioned(top: maxheight/3,left: 0,right: 0,bottom:0,child: Image.asset('assets/cover4.png',fit: BoxFit.fill,height:(maxheight/3)+50 ,),),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child:      ListView(children: [
                      SizedBox(height: 20,),
                        InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: (){
                                   showDialog(
                                        context: context,
                                        builder: (_) => Dialog(
                                          child: Padding(
                                            padding: EdgeInsets.all(16),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          IconButton(
                                                            icon: Icon(Icons
                                                                .camera_alt_outlined),
                                                            onPressed:
                                                            getCameraImage, //pickVideo,
                                                          ),
                                                          Text(
                                                            "الكاميرا",
                                                            style: TextStyle(
                                                              color: Colors.black,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      flex: 1,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          IconButton(
                                                            icon:
                                                            Icon(Icons.image),
                                                            onPressed:
                                                            getGalleryImage,
                                                          ),
                                                          Text(
                                                            "المعرض",
                                                            style: TextStyle(
                                                              color: Colors.black,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      flex: 1,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                          },
                          child: Container(width: 100,height: 100,decoration: BoxDecoration(shape: BoxShape.circle,
                          color: Colors.grey[100],image: DecorationImage(image: _image==null?AssetImage('assets/cover.jpg'):FileImage(_image),fit: BoxFit.contain,


                            
                          ),
                          border: Border.all(width: 2,color: primarycolor)
                          ),),
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
                                        border: Border.all(width: 2,color:validater||namecontroller.text.length>=3? Colors.white60:Colors.red),
                                          borderRadius: BorderRadius.circular(25)),
                                           child: Padding(
                                             padding: const EdgeInsets.only(left:20.0,right: 20,bottom: 5),
                                             child: TextFormField(
                                              onChanged: (v){
                                                setState(() {
                                                                                                  
                                              });
                                              },
                                              controller: namecontroller,
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
                                child:Text('   الإسم   ',style: TextStyle(fontSize: size2,color: Colors.white,backgroundColor: primarycolor),)
                              ),
                            ],
                          ),
                        ),
                        AnimatedContainer(
                          height: validater||namecontroller.text.length>=3?0:30,
                          duration: Duration(milliseconds: 150),
                        child: Padding(
                          padding: const EdgeInsets.only(right:20.0),
                          child: Text('يرجى إدخال الإسم لايقل عن 3 محارف',style: TextStyle(color: Colors.red,fontSize: 11,fontWeight: FontWeight.w600),),
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
                                        border: Border.all(width: 2,color:validater||validateemail(emailcontroller.text)  ? Colors.white60:Colors.red),
                                          borderRadius: BorderRadius.circular(25)),
                                           child: Padding(
                                             padding: const EdgeInsets.only(left:20.0,right: 20,bottom: 5),
                                             child: TextFormField(
                                                onChanged: (v){
                                                setState(() {
                                                        validateemail(emailcontroller.text);                                          
                                              });
                                              },
                                              enabled: false,
                                              keyboardType: TextInputType.emailAddress,
                                              cursorColor: Colors.white,
                                              controller: emailcontroller,
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
                                child:Text('   البريد الإلكتروني   ',style: TextStyle(fontSize: size2,color: Colors.white,backgroundColor: primarycolor),)
                              ),
                            ],
                          ),
                        ),
                         AnimatedContainer(
                          height: validater|| validateemail(emailcontroller.text)?0:30,
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
                                        border: Border.all(width: 2,color:validater||country.length>=3 ? Colors.white60:Colors.red),
                                          borderRadius: BorderRadius.circular(25)),
                                           child: Padding(
                                             padding: const EdgeInsets.only(left:20.0,right: 20, ),
                                              child: SearchableDropdown.single(
                              items: _countriesar,
                           
                              hint:country,
                            
                              searchHint: 'المدينة',
                              onChanged: onChangeDropdownTesten,
                              doneButton: "تم",
                              closeButton: " إغلاق",
                              displayClearIcon: false,
                              style: TextStyle(
                                fontFamily: 'Cairo',
                               fontSize: size1,fontWeight: FontWeight.w600,
                                color: Colors.white
                              ),
                              
                              displayItem: (item, selected) {
                                return Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: (Row(children: [
                                    selected
                                        ? Icon(
                                            Icons.radio_button_checked,
                                            color: Colors.grey,
                                          )
                                        : Icon(
                                            Icons.radio_button_unchecked,
                                            color: Colors.grey,
                                          ),
                                    SizedBox(width: 7),
                                    Expanded(
                                      child: item,
                                    ),
                                  ])),
                                );
                              },

                              isExpanded: true,
                              underline: Container(
                                height: 0.0,
                              ),
                            ),
                                           ),
                                         ),
                              ),
                               Positioned(
                                top: 0,
                                right: 30,
                                child:Text('  المدينة    ',style: TextStyle(fontSize: size2,color: Colors.white,backgroundColor: primarycolor),)
                              ),
                            ],
                          ),
                        ),
                         AnimatedContainer(
                          height: validater||country.length>=3?0:30,
                          duration: Duration(milliseconds: 150),
                        child: Padding(
                          padding: const EdgeInsets.only(right:20.0),
                          child: Text('يرجى تحديد المدينة',style: TextStyle(color: Colors.red,fontSize: 11,fontWeight: FontWeight.w600),),
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
                                        border: Border.all(width: 2,  color:validater||validmop ? Colors.white60:Colors.red),
                                          borderRadius: BorderRadius.circular(25)),
                                           child: Padding(
                                             padding: const EdgeInsets.only(left:20.0,right: 20,bottom: 5),
                                             child: TextFormField(
                                                onChanged: (v){
                                              validateMobile();
                                              },
                                              keyboardType: TextInputType.number,
                                              cursorColor: Colors.white,
                                              controller: phonecontroller,
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
                                child:Text('   رقم الجوال   ',style: TextStyle(fontSize: size2,color: Colors.white,backgroundColor: primarycolor),)
                              ),
                            ],
                          ),
                        ),
                      AnimatedContainer(
                          height: validater||validmop?0:30,
                          duration: Duration(milliseconds: 150),
                        child: Padding(
                          padding: const EdgeInsets.only(right:20.0),
                          child: Text('يرجى إدخال رقم هاتف صحيح',style: TextStyle(color: Colors.red,fontSize: 11,fontWeight: FontWeight.w600),),
                        ),
                        ),
                                   SizedBox(height: 20,),
                                       Row(
                      children: <Widget>[
                          Checkbox(
                          value: editepass,
                          activeColor: primarycolor,
                          onChanged: (bool value) {
                            setState(() {
                              this.editepass = value;
                            });
                          },
                        ), 
                                              InkWell(
                                                onTap: (){
                                                  setState(() {
                                                                                                      editepass=!editepass;
                                                                                                    });
                                                },
                                                child: Text(
                          'تعديل كلمة المرور ',style: TextStyle(fontSize: size2,color: Colors.white,fontWeight: FontWeight.w700),
                     
                        ),
                                              ), //Text
                        
                     //Checkbox
                      ], //<Widget>[]
                    ),  
                     Visibility(
                            visible: editepass,
                            child: Container(
                            width: double.infinity,
                            height: 65,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 15,
                                  left: 0,right: 0,
                                  child: Container(width: double.infinity,height: 45,
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 2, color:validater|| passcontroller.text.length>=8  ? Colors.white60:Colors.red),
                                            borderRadius: BorderRadius.circular(25)),
                                             child: Padding(
                                               padding: const EdgeInsets.only(left:20.0,right: 20,bottom: 5),
                                               child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                 children: [
                                                   Expanded(
                                                     child: TextFormField(
                                                      keyboardType: TextInputType.text,
                                                         onChanged: (v){
                                                  setState(() {
                                                                                               
                                                });
                                                },
                                                      cursorColor: Colors.white,
                                                      controller: passcontroller,
                                                      obscureText: !showpass,
                                                      style: TextStyle(color: Colors.white,fontSize: size1,fontWeight: FontWeight.w600),
                                                      decoration: InputDecoration(
                                                         border: InputBorder.none,
                                                         
                                                         ),),
                                                   ),
                                                   Padding(
                                                     padding: const EdgeInsets.only(top:10.0),
                                                     child: InkWell(
                                                      borderRadius: BorderRadius.circular(10),

                                                      onTap: (){
                                                        setState(() {
                                                                  showpass=!showpass;
                                                          });
                                                      },
                                                      child: Icon(!showpass?  Icons.remove_red_eye:Icons.remove_red_eye_outlined,color: Colors.white,size: 20,)),
                                                   ),
                                                 ],
                                               ),
                                             ),
                                           ),
                                ),
                                 Positioned(
                                  top: 0,
                                  right: 30,
                                  child:Text('   كلمة المرور   ',style: TextStyle(fontSize: size2,color: Colors.white,backgroundColor: primarycolor),)
                                ),
                                
                              ],
                            ),
                        ),
                          ),
                        Visibility(
                            visible: editepass,
                          child: AnimatedContainer(
                            height: validater||passcontroller.text.length>=8?0:30,
                            duration: Duration(milliseconds: 150),
                          child: Padding(
                            padding: const EdgeInsets.only(right:20.0),
                            child: Text(' يرجى إدخال كلمة مرور لاتقل عن 8 محارف',style: TextStyle(color: Colors.red,fontSize: 11,fontWeight: FontWeight.w600),),
                          ),
                          ),
                        ),
                     
                     
                           SizedBox(height:editepass? 20:0,),
                           Visibility(
                            visible: editepass,
                            child: Container(
                            width: double.infinity,
                            height: 65,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 15,
                                  left: 0,right: 0,
                                  child: Container(width: double.infinity,height: 45,
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 2, color:validater||(conpasscontroller.text== passcontroller.text )  ? Colors.white60:Colors.red),
                                            borderRadius: BorderRadius.circular(25)),
                                             child: Padding(
                                               padding: const EdgeInsets.only(left:20.0,right: 20,bottom: 5),
                                               child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                 children: [
                                                   Expanded(
                                                     child: TextFormField(
                                                      keyboardType: TextInputType.text,
                                                      cursorColor: Colors.white,
                                                          onChanged: (v){
                                                  setState(() {
                                                                                               
                                                });
                                                },
                                                      controller: conpasscontroller,
                                                      obscureText: !showcon,
                                                      style: TextStyle(color: Colors.white,fontSize: size1,fontWeight: FontWeight.w600),
                                                      decoration: InputDecoration(
                                                         border: InputBorder.none,
                                                         
                                                         ),),
                                                   ),
                                                   Padding(
                                                     padding: const EdgeInsets.only(top:10.0),
                                                     child: InkWell(
                                                      borderRadius: BorderRadius.circular(10),

                                                      onTap: (){
                                                        setState(() {
                                                                  showcon=!showcon;
                                                          });
                                                      },
                                                      child: Icon(!showcon?  Icons.remove_red_eye:Icons.remove_red_eye_outlined,color: Colors.white,size: 20,)),
                                                   ),
                                                 ],
                                               ),
                                             ),
                                           ),
                                ),
                                 Positioned(
                                  top: 0,
                                  right: 30,
                                  child:Text('   تأكيد كلمة المرور   ',style: TextStyle(fontSize: size2,color: Colors.white,backgroundColor: primarycolor),)
                                ),
                                
                              ],
                            ),
                        ),
                          ),
                           Visibility(
                            visible: editepass,
                             child: AnimatedContainer(
                          height: validater||(passcontroller.text==conpasscontroller.text)?0:30,
                          duration: Duration(milliseconds: 150),
                        child: Padding(
                          padding: const EdgeInsets.only(right:20.0),
                          child: Text('غير متطابقة مع كلمة المرور',style: TextStyle(color: Colors.red,fontSize: 11,fontWeight: FontWeight.w600),),
                        ),
                        ),
                           ),
                        SizedBox(height: 30,),
                        InkWell(
                          onTap: (){
                          //  if(!connected)return;
                            if(!confirmupdate())
                            {
                              setState(() {
                                                              validater=false;
                                                            });
                                                            return;
                            }else
                            update();
                          },
                          child: Container(width: double.infinity,height: 45,
                                        decoration: BoxDecoration(
                                         
                                            borderRadius: BorderRadius.circular(25),color: Colors.white),
                                            child: Center(child: Text('تعديل',style: TextStyle(color: primarycolor,fontWeight: FontWeight.w800,fontSize: size1),),),
                                            ),
                        ),
                           SizedBox(height: 10,),
                            InkWell(
                          onTap: (){
                            //if(!connected)return;
                           setState(() {
                                                        delete=true;
                                                      });
                          //  update();
                          },
                          child: Container(width: double.infinity,height: 45,
                                        decoration: BoxDecoration(
                                            border: Border.all(width: 2,color: primarycolor),
                                            borderRadius: BorderRadius.circular(25),color: Colors.white),
                                            child: Center(child: Text('حذف الحساب',style: TextStyle(color: primarycolor,fontWeight: FontWeight.w800,fontSize: size1),),),
                                            ),
                        ),
                      ],),
                ),
            Positioned(top:0,right: 0,bottom: 0,left: 0,
             
             child: Visibility(
              visible: delete,
               child: Container(color: primarycolorc2,
               
               child: Center(child: Padding(padding: EdgeInsets.all(20),
               
               child: Padding(
                 padding: const EdgeInsets.all(20.0),
                 child:  Container(
                  width: 250,
                  height: 200,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
                   child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    Text('هل تريد بالتأكيد حذف الحساب؟', textAlign: TextAlign.center, style: TextStyle(fontSize: size2,fontWeight: FontWeight.w600),
                    
                    ),
                      Text(' تنبيه:عند حذف حسابك لن تسطيع استرجاعه لاحقاً, وسيتم حذف كامل البيانات المتعلقة به', textAlign: TextAlign.center, style: TextStyle (color: Colors.red, fontSize: size3,fontWeight: FontWeight.w600),
                    
                    ),
                    SizedBox(height: 10,),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                   borderRadius: BorderRadius.circular(5),
                   onTap: (){
                        setState(() {
                                         delete=false;
                            });
                   },
                          child: Card(
                            color: primarycolor,
                            
                            child: Container(
                              width: 70,
                              child: Center(child: Padding(
                              padding: const EdgeInsets.only(left:12.0,right: 12,top: 8,bottom: 8),
                              child: Text('لا',style: TextStyle(fontSize: size2,fontWeight: FontWeight.w600,color: Colors.white),),
                          ),),
                            ),),
                        ),
                        SizedBox(width: 30,),
                             InkWell(
                   borderRadius: BorderRadius.circular(5),
                   onTap: (){
                        deletacc();
                   },
                          child: Card(
                            color: primarycolor,
                            
                            child: Container(
                              width: 70,
                              child: Center(child: Padding(
                              padding: const EdgeInsets.only(left:12.0,right: 12,top: 8,bottom: 8),
                              child: Text('نعم',style: TextStyle(fontSize: size2,fontWeight: FontWeight.w600,color: Colors.white),),
                          ),),
                            ),),
                        ),
                      ],
                    )
                   ],),
                 ),
               ),
               ),),
               ),
             ),
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
             ),
            ],):Stack(
              children: [
               Positioned(top: maxheight/3,left: 0,right: 0, child: Image.asset('assets/cover4.png',fit: BoxFit.fill,height: (maxheight/3)+50,),),
                Column(
                  children: [
                                OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
         connected = connectivity != ConnectivityResult.none;
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
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
              
                          children: [
                        
                         ListView(children: [
                          
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
                                              border: Border.all(width: 2,color:validatel||validateemail(loginname.text)? Colors.white60:Colors.red),
                                                borderRadius: BorderRadius.circular(25)),
                                                 child: Padding(
                                                   padding: const EdgeInsets.only(left:20.0,right: 20,bottom: 5),
                                                   child: TextFormField(
                                                    controller: loginname,
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
                                height: validatel||validateemail(loginname.text)?0:30,
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
                                              border: Border.all(width: 2,color:validatel||loginpass.text.length>=8? Colors.white60:Colors.red),
                                                borderRadius: BorderRadius.circular(25)),
                                                 child: Padding(
                                                   padding: const EdgeInsets.only(left:20.0,right: 20,bottom: 5),
                                                   child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                     children: [
                                                       Expanded(
                                                         child: TextFormField(
                                                          onChanged: (v){
                                                            setState(() {
                                                                                                                    
                                                                                                                  });
                                                          },
                                                          keyboardType: TextInputType.text,
                                                          cursorColor: Colors.white,
                                                          controller: loginpass,
                                                          obscureText: !showpasslog,
                                                          style: TextStyle(color: Colors.white,fontSize: size1,fontWeight: FontWeight.w600),
                                                          decoration: InputDecoration(
                                                             border: InputBorder.none,
                                                             
                                                             ),),
                                                       ),
                                                       Padding(
                                                         padding: const EdgeInsets.only(top:10.0),
                                                         child: InkWell(
                                                          borderRadius: BorderRadius.circular(10),

                                                          onTap: (){
                                                            setState(() {
                                                                      showpasslog=!showpasslog;
                                                              });
                                                          },
                                                          child: Icon(!showpasslog?  Icons.remove_red_eye:Icons.remove_red_eye_outlined,color: Colors.white,size: 20,)),
                                                       ),
                                                     ],
                                                   ),
                                                 ),
                                               ),
                                    ),
                                     Positioned(
                                      top: 0,
                                      right: 30,
                                      child:Text('   كلمة المرور   ',style: TextStyle(fontSize: size2,color: Colors.white,backgroundColor: primarycolor),)
                                    ),
                                    
                                  ],
                                ),
                              ),
                                   AnimatedContainer(
                                height: validatel||loginpass.text.length>=8?0:30,
                                duration: Duration(milliseconds: 150),
                              child: Padding(
                                padding: const EdgeInsets.only(right:20.0),
                                child: Text('يرجى إدخال كلمة المرور لاتقل عن 8 محارف',style: TextStyle(color: Colors.red,fontSize: 11,fontWeight: FontWeight.w600),),
                              ),
                              ),
                              SizedBox(height: 10,),
                               InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap:(){
forget();
                                },
                                child: Container(child: Text('هل نسيت كلمة المرور؟',style: TextStyle(fontWeight: FontWeight.w700),),)),
                              SizedBox(height: 30,),
                              InkWell(
                                onTap:(){
                                   if(!connected)return;
                                  if(!confirmlog())
                                  {
                                    setState(() {
                                                                    validatel=false;
                                                                  });
                                                                  return;
                                  }
                                  login();
                                },
                                child: Container(width: double.infinity,height: 45,
                                              decoration: BoxDecoration(
                                               
                                                  borderRadius: BorderRadius.circular(25),color: Colors.white),
                                                  child: Center(child: Text('تسجيل الدخول',style: TextStyle(color: primarycolor,fontWeight: FontWeight.w800,fontSize: size1),),),
                                                  ),
                              ),
                            ],),
                         ListView(children: [
                            SizedBox(height: 20,),
                              InkWell(
                                borderRadius: BorderRadius.circular(30),
                                onTap: (){
                                         showDialog(
                                              context: context,
                                              builder: (_) => Dialog(
                                                child: Padding(
                                                  padding: EdgeInsets.all(16),
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Column(
                                                              children: [
                                                                IconButton(
                                                                  icon: Icon(Icons
                                                                      .camera_alt_outlined),
                                                                  onPressed:
                                                                  getCameraImage, //pickVideo,
                                                                ),
                                                                Text(
                                                                  "الكاميرا",
                                                                  style: TextStyle(
                                                                    color: Colors.black,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            flex: 1,
                                                          ),
                                                          Expanded(
                                                            child: Column(
                                                              children: [
                                                                IconButton(
                                                                  icon:
                                                                  Icon(Icons.image),
                                                                  onPressed:
                                                                  getGalleryImage,
                                                                ),
                                                                Text(
                                                                  "المعرض",
                                                                  style: TextStyle(
                                                                    color: Colors.black,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            flex: 1,
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                },
                                child: Container(width: 100,height: 100,decoration: BoxDecoration(
                                
                                  shape: BoxShape.circle,
                                color: Colors.grey[100],image: DecorationImage(image: _image==null?AssetImage('assets/cover.jpg'):FileImage(_image),fit: BoxFit.contain,


                                  
                                ),
                                border: Border.all(width: 2,color:  primarycolor )
                                ),),
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
                                              border: Border.all(width: 2,color:validater||namecontroller.text.length>=3? Colors.white60:Colors.red),
                                                borderRadius: BorderRadius.circular(25)),
                                                 child: Padding(
                                                   padding: const EdgeInsets.only(left:20.0,right: 20,bottom: 5),
                                                   child: TextFormField(
                                                    onChanged: (v){
                                                      setState(() {
                                                                                                        
                                                    });
                                                    },
                                                    controller: namecontroller,
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
                                      child:Text('   الإسم   ',style: TextStyle(fontSize: size2,color: Colors.white,backgroundColor: primarycolor),)
                                    ),
                                  ],
                                ),
                              ),
                              AnimatedContainer(
                                height: validater||namecontroller.text.length>=3?0:30,
                                duration: Duration(milliseconds: 150),
                              child: Padding(
                                padding: const EdgeInsets.only(right:20.0),
                                child: Text('يرجى إدخال الإسم لايقل عن 3 محارف',style: TextStyle(color: Colors.red,fontSize: 11,fontWeight: FontWeight.w600),),
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
                                              border: Border.all(width: 2,color:validater||validateemail(emailcontroller.text)  ? Colors.white60:Colors.red),
                                                borderRadius: BorderRadius.circular(25)),
                                                 child: Padding(
                                                   padding: const EdgeInsets.only(left:20.0,right: 20,bottom: 5),
                                                   child: TextFormField(
                                                      onChanged: (v){
                                                      setState(() {
                                                              validateemail(emailcontroller.text);                                          
                                                    });
                                                    },
                                                    keyboardType: TextInputType.emailAddress,
                                                    cursorColor: Colors.white,
                                                    controller: emailcontroller,
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
                                      child:Text('   البريد الإلكتروني   ',style: TextStyle(fontSize: size2,color: Colors.white,backgroundColor: primarycolor),)
                                    ),
                                  ],
                                ),
                              ),
                               AnimatedContainer(
                                height: validater|| validateemail(emailcontroller.text)?0:30,
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
                                              border: Border.all(width: 2,color:validater||country.length>=3 ? Colors.white60:Colors.red),
                                                borderRadius: BorderRadius.circular(25)),
                                                 child: Padding(
                                                   padding: const EdgeInsets.only(left:20.0,right: 20, ),
                                                    child: SearchableDropdown.single(
                                    items: _countriesar,
                                    hint: ' ',
                                    searchHint: 'المدينة',
                                    onChanged: onChangeDropdownTesten,
                                    doneButton: "تم",
                                    closeButton: " إغلاق",
                                    displayClearIcon: false,
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                     fontSize: size1,fontWeight: FontWeight.w600,
                                      color: Colors.white
                                    ),
                                    
                                    displayItem: (item, selected) {
                                      return Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: (Row(children: [
                                          selected
                                              ? Icon(
                                                  Icons.radio_button_checked,
                                                  color: Colors.grey,
                                                )
                                              : Icon(
                                                  Icons.radio_button_unchecked,
                                                  color: Colors.grey,
                                                ),
                                          SizedBox(width: 7),
                                          Expanded(
                                            child: item,
                                          ),
                                        ])),
                                      );
                                    },

                                    isExpanded: true,
                                    underline: Container(
                                      height: 0.0,
                                    ),
                                  ),
                                                 ),
                                               ),
                                    ),
                                     Positioned(
                                      top: 0,
                                      right: 30,
                                      child:Text('  المدينة    ',style: TextStyle(fontSize: size2,color: Colors.white,backgroundColor: primarycolor),)
                                    ),
                                  ],
                                ),
                              ),
                               AnimatedContainer(
                                height: validater||country.length>=3?0:30,
                                duration: Duration(milliseconds: 150),
                              child: Padding(
                                padding: const EdgeInsets.only(right:20.0),
                                child: Text('يرجى تحديد المدينة',style: TextStyle(color: Colors.red,fontSize: 11,fontWeight: FontWeight.w600),),
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
                                              border: Border.all(width: 2,  color:validater||validmop ? Colors.white60:Colors.red),
                                                borderRadius: BorderRadius.circular(25)),
                                                 child: Padding(
                                                   padding: const EdgeInsets.only(left:20.0,right: 20,bottom: 5),
                                                   child: TextFormField(
                                                      onChanged: (v){
                                                    validateMobile();
                                                    },
                                                    keyboardType: TextInputType.number,
                                                    cursorColor: Colors.white,
                                                    controller: phonecontroller,
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
                                      child:Text('   رقم الجوال   ',style: TextStyle(fontSize: size2,color: Colors.white,backgroundColor: primarycolor),)
                                    ),
                                  ],
                                ),
                              ),
                            AnimatedContainer(
                                height: validater||validmop?0:30,
                                duration: Duration(milliseconds: 150),
                              child: Padding(
                                padding: const EdgeInsets.only(right:20.0),
                                child: Text('يرجى إدخال رقم هاتف صحيح',style: TextStyle(color: Colors.red,fontSize: 11,fontWeight: FontWeight.w600),),
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
                                              border: Border.all(width: 2, color:validater|| passcontroller.text.length>=8  ? Colors.white60:Colors.red),
                                                borderRadius: BorderRadius.circular(25)),
                                                 child: Padding(
                                                   padding: const EdgeInsets.only(left:20.0,right: 20,bottom: 5),
                                                   child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                     children: [
                                                       Expanded(
                                                         child: TextFormField(
                                                          keyboardType: TextInputType.text,
                                                             onChanged: (v){
                                                      setState(() {
                                                                                                   
                                                    });
                                                    },
                                                          cursorColor: Colors.white,
                                                          controller: passcontroller,
                                                          obscureText: !showpass,
                                                          style: TextStyle(color: Colors.white,fontSize: size1,fontWeight: FontWeight.w600),
                                                          decoration: InputDecoration(
                                                             border: InputBorder.none,
                                                             
                                                             ),),
                                                       ),
                                                       Padding(
                                                         padding: const EdgeInsets.only(top:10.0),
                                                         child: InkWell(
                                                          borderRadius: BorderRadius.circular(10),

                                                          onTap: (){
                                                            setState(() {
                                                                      showpass=!showpass;
                                                              });
                                                          },
                                                          child: Icon(!showpass?  Icons.remove_red_eye:Icons.remove_red_eye_outlined,color: Colors.white,size: 20,)),
                                                       ),
                                                     ],
                                                   ),
                                                 ),
                                               ),
                                    ),
                                     Positioned(
                                      top: 0,
                                      right: 30,
                                      child:Text('   كلمة المرور   ',style: TextStyle(fontSize: size2,color: Colors.white,backgroundColor: primarycolor),)
                                    ),
                                    
                                  ],
                                ),
                              ),
                              AnimatedContainer(
                                height: validater||passcontroller.text.length>=8?0:30,
                                duration: Duration(milliseconds: 150),
                              child: Padding(
                                padding: const EdgeInsets.only(right:20.0),
                                child: Text(' يرجى إدخال كلمة مرور لاتقل عن 8 محارف',style: TextStyle(color: Colors.red,fontSize: 11,fontWeight: FontWeight.w600),),
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
                                              border: Border.all(width: 2, color:validater||(conpasscontroller.text== passcontroller.text )  ? Colors.white60:Colors.red),
                                                borderRadius: BorderRadius.circular(25)),
                                                 child: Padding(
                                                   padding: const EdgeInsets.only(left:20.0,right: 20,bottom: 5),
                                                   child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                     children: [
                                                       Expanded(
                                                         child: TextFormField(
                                                          keyboardType: TextInputType.text,
                                                          cursorColor: Colors.white,
                                                              onChanged: (v){
                                                      setState(() {
                                                                                                   
                                                    });
                                                    },
                                                          controller: conpasscontroller,
                                                          obscureText: !showcon,
                                                          style: TextStyle(color: Colors.white,fontSize: size1,fontWeight: FontWeight.w600),
                                                          decoration: InputDecoration(
                                                             border: InputBorder.none,
                                                             
                                                             ),),
                                                       ),
                                                       Padding(
                                                         padding: const EdgeInsets.only(top:10.0),
                                                         child: InkWell(
                                                          borderRadius: BorderRadius.circular(10),

                                                          onTap: (){
                                                            setState(() {
                                                                      showcon=!showcon;
                                                              });
                                                          },
                                                          child: Icon(!showcon?  Icons.remove_red_eye:Icons.remove_red_eye_outlined,color: Colors.white,size: 20,)),
                                                       ),
                                                     ],
                                                   ),
                                                 ),
                                               ),
                                    ),
                                     Positioned(
                                      top: 0,
                                      right: 30,
                                      child:Text('   تأكيد كلمة المرور   ',style: TextStyle(fontSize: size2,color: Colors.white,backgroundColor: primarycolor),)
                                    ),
                                    
                                  ],
                                ),
                              ),
                                 AnimatedContainer(
                                height: validater||(passcontroller.text==conpasscontroller.text)?0:30,
                                duration: Duration(milliseconds: 150),
                              child: Padding(
                                padding: const EdgeInsets.only(right:20.0),
                                child: Text('غير متطابقة مع كلمة المرور',style: TextStyle(color: Colors.red,fontSize: 11,fontWeight: FontWeight.w600),),
                              ),
                              ),
                             
                              SizedBox(height: 30,),
                              InkWell(
                                onTap: (){
                                   if(!connected)return;
                                  if(!confirmreg())
                                  {
                                    setState(() {
                                                                    validater=false;
                                                                  });
                                                                  return;
                                  }else
                                  register();
                                },
                                child: Container(width: double.infinity,height: 45,
                                              decoration: BoxDecoration(
                                               
                                                  borderRadius: BorderRadius.circular(25),color: Colors.white),
                                                  child: Center(child: Text('إنشاء حساب',style: TextStyle(color: primarycolor,fontWeight: FontWeight.w800,fontSize: size1),),),
                                                  ),
                              ),
                            ],),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              
            
              
                Positioned(top:0,right: 0,bottom: 0,left: 0,
             
             child: Visibility(
              visible: showload,
               child: Container(color: primarycolorc2,
               
               child: Center(child: Padding(padding: EdgeInsets.all(20),
               
               child: AnimatedContainer(
                duration: Duration(milliseconds: 100),
                 width:!loaddata? 250:80,
                 height: !loaddata? action.length<2?100:200:80,
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
bool delete=false;
bool editepass=false;
  bool confirmupdate(){
    FocusScope.of(context).unfocus();
    if(editepass){
      if(passcontroller.text.length<8)return false;
      if(conpasscontroller.text!=passcontroller.text)return false;
    }
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
    FocusScope.of(context).unfocus();
  
    if(!validmop)return false;
    if(country.length<3)return false;
    if(namecontroller.text.length<3)return false;

    if(!validateemail(emailcontroller.text))return false;

    if(!validatephone(phonecontroller.text)) return false;

    if(passcontroller.text.length<8) return false;

    if(conpasscontroller.text!=passcontroller.text)return false;

    return true;
  }
  bool validmop=false;
  bool validateMobile() {
    PhoneNumberUtil plugin = PhoneNumberUtil();
 
    try {
      plugin.validate('+966' + (phonecontroller.text??''), 'SA').then((result) {
        
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
  bool confirmlog(){
    FocusScope.of(context).unfocus();
   if(!validateemail(loginname.text)) return false;
   if(loginpass.text.length<8) return false;

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
  bool loaddata=false;
  String data='هذا الإيميل مستخدم';
  String action='حاول مجدداً';
   Future<int> login() async{
    setState(() {
          showload=true;
          loaddata=true;
        });
    Map<String, String> header = {
      "Accept": "application/json",
    };
    Map<String, String> body;
 
    body = {
      'email':loginname.text,
     
     'password':loginpass.text,
   
    };
  var responsess = await http.post(
      Uri.parse(baseurl + "auth/login" ),body:body,  headers: header
    );
 
    if(responsess.statusCode==200){
       if(jsonDecode(responsess.body)['user']['email_verified_at']==null||jsonDecode(responsess.body)['user']['email_verified_at']=='null'){
setState(() {
              data=' حسابك غير مفعل, قد تم إرسال رابط تفعيل الحساب إلى بريدك الإلكتروني' ;
              action='حاول مجدداً';
              loaddata=false;
            });
       }else{
      action='fd';
      Savedata( responsess.body ,0);
       }

    }
    else{
      if(responsess.body.contains('Unauthorized'))
      {
         
          setState(() {
              data='الإيميل وكلمة المرور غير صحيحتين';
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

   Future<int> deletacc () async{
    setState(() {
          delete=false;
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
      Uri.parse( baseurl + "auth/remove_account" ),
    );
   
    request.headers.addAll(header);
 
   

    http.StreamedResponse r = await request.send();
   
    var responseData = await r.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
   print(r.statusCode);
   print(responseString);
 
    if( r.statusCode==200){
      setState(() {
                data='تم حذف الحساب بنجاح';
                action='تم';
            });
              Hive.deleteFromDisk().then((value) {
                       globals.login=false;
                       globals.email='-1';
                       globals.name='-1';
                       globals.access_token='-1';
                       globals.myads=[];
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                builder: (BuildContext context) => MyHomePage(  ),
                                ) , (route) => false);
                                    Timer(Duration(seconds: action=='fd'?0: 1), () {
   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                              builder: (BuildContext context) => MyHomePage(  ),
                              ) , (route) => false);
       
    });
                              
                  });
  
    
    }else{
       
   data='عذراً, يرجى إعادة المحاولة';
      action='إعادة المحاولة';
     
   
      setState(() {
              loaddata=false;
            });
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
 
    'mobile_number': phonecontroller.text, 
    'country':country
    };
    if(editepass) body = {
      'user_id':globals.user_id,
      'user_name':namecontroller.text,
    'email':emailcontroller.text,
 
    'password':passcontroller.text,
     'password_confirmation':passcontroller.text,
    'mobile_number': phonecontroller.text, 
    'country':country
    };
 
    request.fields.addAll(body);

    http.StreamedResponse r = await request.send();
   
    var responseData = await r.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
  
 
    if( r.statusCode==201){
      setState(() {
                data='تم تعديل البيانات بنجاح';
                action='تم';
            });
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
  Future<File> getImageFileFromAssets(String path) async {
  final byteData = await rootBundle.load('assets/$path');

  final file = File('${(await getTemporaryDirectory()).path}/$path');
  await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
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
    else{
      File f= await getImageFileFromAssets('cover4.png');
      request.files.add(
      new http.MultipartFile.fromBytes(
        'profile_photo',
        f.readAsBytesSync(),
        filename: f.path, // optional
        // contentType: new MediaType('image', 'jpeg'),
      ),
    );
    } 
    Map<String, String> body;
 
    body = {
      'user_name':namecontroller.text,
    'email':emailcontroller.text,
   'password':passcontroller.text,
    'password_confirmation':passcontroller.text,
    'mobile_number': phonecontroller.text, 
    'country':country
    };
   
    request.fields.addAll(body);

    http.StreamedResponse r = await request.send();
 
    var responseData = await r.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
  
print(responseString);
 

 
    if( r.statusCode==201){
     
         Navigator.of(context).pushReplacement( MaterialPageRoute(
                              builder: (BuildContext context) => authentication(fromreg: true,email2: emailcontroller.text  ,pass2: passcontroller.text,),
                              ) );
     // Savedata(responseString,0);
    
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
 setState(() {
    loaddata=false;
  });

      Timer(Duration(seconds: action=='fd'?0: 1), () {
   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                              builder: (BuildContext context) => MyHomePage(  ),
                              ) , (route) => false);
       
    });
 
    return 0;
  }

  List<String> messages=[];
}
