import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:purshases/utiles.dart';
import 'myglobals.dart' as globals;
import 'package:http/http.dart' as http;
class sendomola extends StatefulWidget {
 
 
 
  @override
sendomolaState createState() =>sendomolaState( );
}

 

class sendomolaState extends State<sendomola> {
      Future<int> getbank() async {
 
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
 
       banckname=jsonDecode(responsess.body)['data']['Bank_account'].toString();
 
 IBAN_number=jsonDecode(responsess.body)['data']['IBAN_number'].toString();
    } else {}
    setState(() {
   loadsocial=false;
    });
  }
  String banckname='';
  String IBAN_number='';
  bool loadsocial=true;
@override
  void initState() {
  getmyads();
getbank();
    super.initState();
  }
TextEditingController namec=new TextEditingController();
 TextEditingController prisec=new TextEditingController();
 TextEditingController prisec2=new TextEditingController();

// List<int> priseص=[332,22,43,443];
int primindex=-1;
int secindex=-1;
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
          bottomNavigationBar: bottombare(context,5,primarycolorc2,_scaffoldKey),
          body: !globals.login?Center(child: Text('يرجى تسجيل الدخول لتتمكن من الاستفادة من ميزات التطبيق',textAlign: TextAlign.center,style: TextStyle(color: primarycolor,fontWeight: FontWeight.bold),),) :Stack(
            children: [
                  Positioned(top: maxheight/3,left: 0,right: 0,child: Image.asset('assets/cover5.png',fit: BoxFit.fill,),),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  //  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                  
                     Align(
                      alignment: Alignment.topCenter,
                      child: Text( banckname ,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: size1),)),
                                    Align(
                      alignment: Alignment.topCenter,
                      child: Text( IBAN_number ,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: size1),)),       
                   SizedBox(height: 20,),
                      PopupMenuButton<int>(
                                  child:  Container(
                            width: double.infinity,
                            height: 65,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 15,
                                  left: 0,right: 0,
                                  child: Container(width: double.infinity,height: 45,
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 2,color: validate||primindex>=0? primarycolor:Colors.red),
                                            borderRadius: BorderRadius.circular(25)),
                                             child: Padding(
                                               padding: const EdgeInsets.only(left:20.0,right: 20, ),
                                               child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(child: Text(primindex==-1?'':globals.myads[primindex].name,style: TextStyle(fontSize: size1,fontWeight: FontWeight.w600 ),)),
                                                  Icon(Icons.arrow_drop_down,color: primarycolor,)
                                               ],),
                                             ),
                                           ),
                                ),
                                 Positioned(
                                  top: 0,
                                  right: 30,
                                  child:Text('   رقم الإعلان   ',style: TextStyle(fontSize: size2,backgroundColor: backecolor,color: primarycolor),)
                                ),
                              ],
                            ),
                          ),  
                               shape:   RoundedRectangleBorder(
                                
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                            itemBuilder:
                            (BuildContext context) =>
                            List.generate(
                                globals.myads
                            .length,
                            (index) =>
                            PopupMenuItem<
                            int>(

                            value: index,
                            child: Container(
                              width:MediaQuery.of(context).size.width-30,
                              decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1,color:backecolor)
                              
                              )),
                              child: Center(child: Text(globals.myads[index].name,style: TextStyle(fontSize: size2,fontWeight: FontWeight.w600,color: Colors.white),))),

                            )),
                              onSelected: (int value) {
                                 FocusScope.of(context).unfocus();
                            setState(() {
                               prisec.text='';
                            prisec2.text='';
                             primindex=value;
                             String prise= globals.myads[primindex].prise;
                             if(prise.contains('سوم'))prise='-1';
                             else
                             prise=prise.replaceAll('ر.س', '');
                            
                               int x=-1;
                             try {
                            x=int.parse(prise);
                            } on Exception catch (_) {
                              
                            }
                            some=true;
                            if(x>0)
                            {
                              some=false;
                            prisec.text=x.toString();
                            prisec2.text=(x*1/100).toString();
                            }
                         
                            });
                                setState(() {
                                  
                                });
                            },
                            elevation: 5,
                            tooltip: 'رقم الإعلان',
                            color: primarycolor,
                        offset: Offset( 2,35),
                       
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
                                          border: Border.all(width: 2,color:(validate||( some&&!prisec.text.isEmpty)||(!some&&primindex>=0))? primarycolor:Colors.red),
                                            borderRadius: BorderRadius.circular(25)),
                                             child: Padding(
                                               padding: const EdgeInsets.only(left:20.0,right: 20,bottom: 5),
                                               child: TextFormField(
                                                controller: prisec,
                                                onChanged: (v){
                                                 
                                                    try {
                                                     int x=int.parse(v);
                                                       prisec2.text= (x*1/100).toString();
                                                    } on Exception catch (_) {
                                                         prisec2.text='';
                                                    }
                                              setState(() {
                                                                                              
                                                                                            });
                                                

                                                },
                                                enabled: some,
                                                keyboardType: TextInputType.number,
                                                    inputFormatters:  [
    
                                                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), 
                                                          // for version 2 and greater youcan also use this
                                                          FilteringTextInputFormatter.digitsOnly

                                                            ],
                                                cursorColor: primarycolor,
                                                style: TextStyle( fontSize: size1,fontWeight: FontWeight.w600),
                                                decoration: InputDecoration(
                                                   border: InputBorder.none,
                                                   
                                                   ),),
                                             ),
                                           ),
                                ),
                                 Positioned(
                                  top: 0,
                                  right: 30,
                                  child:Text('   السعر   ',style: TextStyle(fontSize: size2,backgroundColor: backecolor,color: primarycolor),)
                                ),
                              ],
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
                                          border: Border.all(width: 2,color:(validate||( some&&!prisec2.text.isEmpty)||(!some&&primindex>=0))? primarycolor:Colors.red),
                                            borderRadius: BorderRadius.circular(25)),
                                             child: Padding(
                                               padding: const EdgeInsets.only(left:20.0,right: 20,bottom: 5),
                                               child: TextFormField(
                                                controller: prisec2,
                                                enabled: false,
                                                keyboardType: TextInputType.text,
                                                cursorColor: primarycolor,
                                                style: TextStyle( fontSize: size1,fontWeight: FontWeight.w600),
                                                decoration: InputDecoration(
                                                   border: InputBorder.none,
                                                   
                                                   ),),
                                             ),
                                           ),
                                ),
                                 Positioned(
                                  top: 0,
                                  right: 30,
                                  child:Text('   قيمة العمولة   ',style: TextStyle(fontSize: size2,backgroundColor: backecolor,color: primarycolor),)
                                ),
                              ],
                            ),
                          ),
                         
                         SizedBox(height: 20,),
                           Container(
                            width: double.infinity,
                            height: 130,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 10,
                                  left: 0,right: 0,
                                  child: InkWell(
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
                                    child: Container(width: double.infinity,height: 110,
                                          decoration: BoxDecoration(
                                            border: Border.all(width: 2,color:validate||_image!=null? primarycolor:Colors.red),
                                              borderRadius: BorderRadius.circular(25),
                                              image: DecorationImage(image: _image!=null?FileImage(_image):AssetImage('assetName'),
                                              fit: BoxFit.cover
                                              )

                                              ),
                                              child: Center(child: Visibility(
                                                visible: _image==null,
                                                child: Icon(Icons.photo_outlined,size: 50,color: primarycolorc,)),),

                                             ),
                                  ),
                                ),
                                 Positioned(
                                  top: 0,
                                  right: 30,
                                  child:Text('   صورة الوصل   ',style: TextStyle(fontSize: size2,backgroundColor: backecolor,color: primarycolor),)
                                ),
                              ],
                            ),
                          ),
                 
                        SizedBox(height: 30,),
                          InkWell(
                            borderRadius: BorderRadius.circular(25),
                            onTap: (){
                              if(!confirm())
                              {
                                setState(() {
                                  validate=false;
                                });
                                return;
                              }
                              sendcomess();
                            },
                            child: Container(width: double.infinity,height: 45,
                                          decoration: BoxDecoration(
                                           
                                              borderRadius: BorderRadius.circular(25),color:primarycolor),
                                              child: Center(child: Text('إرسال',style: TextStyle(color:backecolor,fontWeight: FontWeight.w800,fontSize: size1),),),
                                              ),
                          ),
                           
                  ],
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
                  Text(data,style: TextStyle(fontSize: size2,fontWeight: FontWeight.w600),
                  
                  ),
                  SizedBox(height: 10,),
                  InkWell(
                 borderRadius: BorderRadius.circular(5),
                 onTap: (){
                  setState(() {
                                   showload=false;
                      });
                      if( data=='لقد تم إرسال العمولة بنجاح')
                      {
                        Navigator.of(context).pop();
                      }
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
File _image;
final picker = ImagePicker();
bool validate=true;
bool confirm(){
   FocusScope.of(context).unfocus();
  if(some)if(prisec.text.isEmpty||prisec2.text.isEmpty)return false;
  if(primindex<0)return false;
  if(_image==null)return false;

  return true;
}


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
bool showload=false;
bool loaddata=false;
String data='';
String action='';
 bool some=false;
Future<int> sendcomess()async{
  setState(() {
      showload=true;
      loaddata=true;
    });
  http.MultipartRequest request = new http.MultipartRequest(
    'POST',
    Uri.parse( baseurl + "send_commission_request" ),
  );
  String token=globals.access_token;
  Map<String, String> header = {
    "Accept": "application/json",
    'Authorization': 'Bearer $token',
  };
  request.headers.addAll(header);

  request.files.add(
    new http.MultipartFile.fromBytes(
      'receipt_photo',
      _image.readAsBytesSync(),
      filename: _image.path, // optional
      // contentType: new MediaType('image', 'jpeg'),
    ),
  );


  Map<String, String> body = {
    'user_id':globals.user_id,
    'user_name':globals.name,
    'email':globals.email,
    'mobile_number':globals.mobile_number,
    'advertisement_number':globals.myads[primindex].id,

    'advertisement_price':prisec.text,
    'advertisement_commission':prisec2.text,
    'date':DateTime.now().toUtc().toString().substring(0,10),

  };
  request.fields.addAll(body);

  http.StreamedResponse r = await request.send();
 
  var responseData = await r.stream.toBytes();
  var responseString = String.fromCharCodes(responseData);
 print(responseString);
 print(r.statusCode);
  if(r.statusCode==200){
     setState(() {
            loaddata=false;
            data='لقد تم إرسال العمولة بنجاح';
            action='تم';
          });
  }else{
    setState(() {
              loaddata=false;
            data='يرجى إعادة المحاولة';
            action='تم';
        });
       
  }
}
  bool itsok=false;
  bool showconfirm=false; 
  List<String> messages=[];

bool loaddata2=true;

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
    loaddata2=false;
  });
}
}
