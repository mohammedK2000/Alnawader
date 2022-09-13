import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:purshases/searchable_dropdown.dart';
import 'package:shimmer/shimmer.dart';

import 'adsinfo.dart';
import 'myglobals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:purshases/utiles.dart';
import 'package:purshases/utiles.dart' as ff;
import 'package:http/http.dart' as http;
class addads extends StatefulWidget {
 
 
 
  @override
addadsState createState() =>addadsState( );
}

 

class addadsState extends State<addads> {
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

@override
  void initState() {
 gelallcate();
   _countriesar = buildcountrires(cities);
    super.initState();
  }
TextEditingController namec=new TextEditingController();
 TextEditingController prisec=new TextEditingController();
TextEditingController descc=new TextEditingController();
List<String> primtype=['ماعز','خيول','خيول عربية أصيلة','الإبل'];
List<String> sectype=['كبيرة','متوسط','صغير','وليد'];
int primindex=-1;
int secindex=-1;
File _image;
List<File> images=[];
final picker = ImagePicker();

Future getGalleryImage() async {
  var image = await picker.getImage(
      source: ImageSource.gallery,
      maxHeight: 800,
      maxWidth: 800,
      imageQuality: 50);


  setState(() {
    _image =File( image.path);
        images.add(_image);
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
    images.add(_image);
    Navigator.pop(this.context);
  });
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
          appBar:AppBar(
            elevation: 0,
            backgroundColor: backecolor,
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
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
               key: _scaffoldKey,
          drawer: drawer(context,  _scaffoldKey),
          bottomNavigationBar: bottombare(context,5,primarycolorc2,  _scaffoldKey),
          body:!globals.login?Center(child: Text('يرجى تسجيل الدخول لتتمكن من الاستفادة من ميزات التطبيق',textAlign: TextAlign.center,style: TextStyle(color: primarycolor,fontWeight: FontWeight.bold),),) : Stack(
            children: [
                  Positioned(top: maxheight/3,left: 0,right: 0,bottom:0,child: Image.asset('assets/cover5.png',fit: BoxFit.fill,),),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  //  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                  
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
                                          border: Border.all(width: 2,color:validate||namec.text.length>=3? primarycolor:Colors.red),
                                            borderRadius: BorderRadius.circular(25)),
                                             child: Padding(
                                               padding: const EdgeInsets.only(left:20.0,right: 20,bottom: 5),
                                               child: TextFormField(
                                                controller: namec,
                                                onChanged: (v){setState(() {
                                                                                                  
                                                                                                });},
                                                keyboardType: TextInputType.text,
                                                cursorColor:primarycolor,
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
                                  child:Text('   إسم الإعلان   ',style: TextStyle(fontSize: size2,backgroundColor: backecolor,color: primarycolor),)
                                ),
                              ],
                            ),
                          ),
                                AnimatedContainer(
                          height: validate||namec.text.length>=3?0:30,
                          duration: Duration(milliseconds: 150),
                        child: Padding(
                          padding: const EdgeInsets.only(right:20.0),
                          child: Text('يرجى إدخال إسم الإعلان لايقل عن 3 محارف',style: TextStyle(color: Colors.red,fontSize: 11,fontWeight: FontWeight.w600),),
                        ),
                        ),
                       
                          SizedBox(height: 20,),
                   Container(
                            width: double.infinity,
                            height: 130,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 15,
                                  left: 0,right: 0,
                                  child: Container(width: double.infinity,height: 100,
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 2,color:validate||(descc.text.length>=5&&descc.text.length<=250)? primarycolor:Colors.red),
                                            borderRadius: BorderRadius.circular(25)),
                                             child: Padding(
                                               padding: const EdgeInsets.only(left:20.0,right: 20,bottom: 5),
                                               child: TextFormField(
                                                controller: descc,
                                                   onChanged: (v){setState(() {
                                                                                                  
                                                                                                });},
                                                keyboardType: TextInputType.multiline,
                                                maxLines: null,
                                                cursorColor:primarycolor,
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
                                  child:Text('   وصف الإعلان   ',style: TextStyle(fontSize: size2,backgroundColor: backecolor,color: primarycolor),)
                                ),
                              ],
                            ),
                          ),
                      AnimatedContainer(
                          height: validate||(descc.text.length>=5&&descc.text.length<=250)?0:30,
                          duration: Duration(milliseconds: 150),
                        child: Padding(
                          padding: const EdgeInsets.only(right:20.0),
                          child: Text('يرجى إدخال الوصف بين 5 إلى 250 محرف',style: TextStyle(color: Colors.red,fontSize: 11,fontWeight: FontWeight.w600),),
                        ),
                        ),
               
               
                          SizedBox(height: 20,),
                           Container(
                            width: double.infinity,
                            height: 150,
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
                                    child: Container(width: double.infinity,height: 130,
                                          decoration: BoxDecoration(
                                            border: Border.all(width: 2,color:validate||images.length>0? primarycolor:Colors.red),
                                              borderRadius: BorderRadius.circular(25),                                    

                                              ),
                                              child:images.length==0?
                                               Center(child: Icon(Icons.photo_outlined,size: 50,color: primarycolorc,),):
                                               ListView(
                                                scrollDirection: Axis.horizontal,
                                                children: List.generate(images.length, (index) =>
                                                InkWell(
                                                  onTap:(){},
                                                  child: Padding(padding:EdgeInsets.all(4),
                                                  child: Container(width: 90,height: 90,
                                                  child: Stack(children: [
                                                    Positioned(top: 20,left: 20,right: 0,bottom: 0,
                                                    child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                                                    image: DecorationImage(image: FileImage(images[index]),fit: BoxFit.cover)),),),
                                                    Positioned(top: 0,left: 0,child: InkWell(
                                                      onTap: (){
                                                        setState(() {
                                                                                                                images.removeAt(index);
                                                                                                              });
                                                      },
                                                      child: Container(width: 40,height: 40,
                                                    child: Center(child: Icon(Icons.delete,color: Colors.red,),),),),)
                                                  ],),),),
                                                )),)

                                             ),
                                  ),
                                ),
                                 Positioned(
                                  top: 0,
                                  right: 30,
                                  child:Container(
                                    color: Colors.white,
                                    child:images.length==0?
                                     Text('   صور الإعلان   ',style: TextStyle(fontSize: size2,backgroundColor: backecolor,color: primarycolor),)
                                     :Row(children: [            Text('   صور الإعلان   ',style: TextStyle(fontSize: size2,backgroundColor: backecolor,color: primarycolor),),
                                     Visibility(
                                      visible: images.length<15,
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
                                        child: Icon(Icons.add,color: primarycolor,),
                                       ),
                                     )],))
                                ),
                              ],
                            ),
                          ),
                      AnimatedContainer(
                          height: validate||images.length>0?0:30,
                          duration: Duration(milliseconds: 150),
                        child: Padding(
                          padding: const EdgeInsets.only(right:20.0),
                          child: Text('يرجى إضافة صورة على الأقل للإعلان',style: TextStyle(color: Colors.red,fontSize: 11,fontWeight: FontWeight.w600),),
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
                                  left: 5,right: 0,
                                  child: Container(
                                
                                    width: double.infinity,height: 45,
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 2,color:validate||prisec.text.length>=1||some? primarycolor:Colors.red),
                                            borderRadius: BorderRadius.circular(25)),
                                             child: Padding(
                                               padding: const EdgeInsets.only(left:20.0,right: 20,bottom: 5),
                                               child: Row(
                                                 children: [
                                                   Expanded(
                                                     child: some?Container(): TextFormField(
                                                      controller: prisec,
                                                      keyboardType: TextInputType.number,
                                                         inputFormatters:  [
    
                                                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), 
                                                          // for version 2 and greater youcan also use this
                                                          FilteringTextInputFormatter.digitsOnly

                                                            ],
                                                      focusNode:fnode ,
                                                      cursorColor: primarycolor,   onChanged: (v){setState(() {
                                                                                                         
                                                                                                      });},
                                                      style: TextStyle( fontSize: size1,fontWeight: FontWeight.w600),
                                                      decoration: InputDecoration(
                                                         border: InputBorder.none,
                                                         
                                                         ),),
                                                   ),
                                                                    AnimatedContainer(
                                                  duration: Duration(milliseconds: 500),
                                                  width: some?MediaQuery.of(context).size.width-81:108,
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                          Checkbox(
                          value: some,
                          activeColor: primarycolor,
                          onChanged: (bool value) {
                            setState(() {
                              this.some = value;
                             
                            });
                             if(!some)fnode.requestFocus();
                          },
                        ), 
                                              InkWell(
                                                onTap: (){
                                                  setState(() {
                                             some=!some;
                                             
                                            });
                                             if(!some)fnode.requestFocus();
                                                },
                                                child: Text(
                          'على السوم',style: TextStyle(fontSize: size2,color: Colors.grey,fontWeight: FontWeight.w700),
                     
                        ),
                                              ), //Text
                        
                     //Checkbox
                      ], //<Widget>[]
                    ),
                                                                      ),  
                                                 ],
                                               ),
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
                      AnimatedContainer(
                          height: validate||prisec.text.length>0||some?0:30,
                          duration: Duration(milliseconds: 150),
                        child: Padding(
                          padding: const EdgeInsets.only(right:20.0),
                          child: Text('يرجى تحديد سعر الإعلان',style: TextStyle(color: Colors.red,fontSize: 11,fontWeight: FontWeight.w600),),
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
                                        border: Border.all(width: 2,color:validate||country.length>=3 ? primarycolor:Colors.red),
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
                                color: Colors.black
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
                                child:Text('  المدينة    ',style: TextStyle(fontSize: size2,color: primarycolor,backgroundColor: Colors.white),)
                              ),
                            ],
                          ),
                        ),
                         AnimatedContainer(
                          height: validate||country.length>=3?0:30,
                          duration: Duration(milliseconds: 150),
                        child: Padding(
                          padding: const EdgeInsets.only(right:20.0),
                          child: Text('يرجى تحديد المدينة',style: TextStyle(color: Colors.red,fontSize: 11,fontWeight: FontWeight.w600),),
                        ),
                        ),
                      
                           SizedBox(height: 20,),
                           loadmain?Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor:primarycolorc2,
              child: Container(
                            width: double.infinity,
                            height: 55,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 10,
                                  left: 0,right: 0,
                                  child: Container(width: double.infinity,height: 45,
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 2,color:validate||primindex>=0? primarycolor:Colors.red),
                                            borderRadius: BorderRadius.circular(25)),
                                             child: Padding(
                                               padding: const EdgeInsets.only(left:20.0,right: 20, ),
                                               child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(child: Text('',style: TextStyle(fontSize: size1,fontWeight: FontWeight.w600,color: primarycolor),)),
                                                  Icon(Icons.arrow_drop_down,color: primarycolor,)
                                               ],),
                                             ),
                                           ),
                                ),
                                 Positioned(
                                  top: 0,
                                  right: 30,
                                  child:Text('   التصنيف الرئيسي   ',style: TextStyle(fontSize: size2,backgroundColor: backecolor,color: primarycolor),)
                                ),
                              ],
                            ),
                          ), ):
               PopupMenuButton<int>(
                                  child:  Container(
                            width: double.infinity,
                            height: 55,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 10,
                                  left: 0,right: 0,
                                  child: Container(width: double.infinity,height: 45,
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 2,color:validate||primindex>=0? primarycolor:Colors.red),
                                            borderRadius: BorderRadius.circular(25)),
                                             child: Padding(
                                               padding: const EdgeInsets.only(left:20.0,right: 20,top: 5 ),
                                               child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(child: Text(primindex==-1?'':mcateg[primindex].name,style: TextStyle(fontSize: size1,fontWeight: FontWeight.w600, ),)),
                                                  Icon(Icons.arrow_drop_down,color: primarycolor,)
                                               ],),
                                             ),
                                           ),
                                ),
                                 Positioned(
                                  top: 0,
                                  right: 30,
                                  child:Text('   التصنيف الرئيسي   ',style: TextStyle(fontSize: size2,backgroundColor: backecolor,color: primarycolor),)
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
                            mcateg
                            .length,
                            (index) =>
                            PopupMenuItem<
                            int>(

                            value: index,
                            child: Container(
                              width:MediaQuery.of(context).size.width-30,
                              decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1,color:backecolor)
                              
                              )),
                              child: Center(child: Text(mcateg[index].name,style: TextStyle(fontSize: size2,fontWeight: FontWeight.w600,color: Colors.white),))),

                            )),
                              onSelected: (int value) {
                                FocusScope.of(context).unfocus();
                            setState(() {
                            primindex=value;
                            secindex=-1;
                            loadsec=true;
                            gelallsub();
                            });

                            },
                            elevation: 5,
                            tooltip: 'التصنيف الرئيسي',
                            color: primarycolor,
                        offset: Offset( 2,35),
                       
                            ),
                  AnimatedContainer(
                          height: validate||primindex>=0 ?0:30,
                          duration: Duration(milliseconds: 150),
                        child: Padding(
                          padding: const EdgeInsets.only(right:20.0),
                          child: Text('يرجى تحديد التصنيف الرئيسي للإعلان',style: TextStyle(color: Colors.red,fontSize: 11,fontWeight: FontWeight.w600),),
                        ),
                        ),
            SizedBox(height: 20,),
            primindex<0?Container():      loadsec?Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor:primarycolorc2,
                child:  Container(
                            width: double.infinity,
                            height: 55,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 10,
                                  left: 0,right: 0,
                                  child: Container(width: double.infinity,height: 45,
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 2,color:validate||secindex>=0? primarycolor:Colors.red),
                                            borderRadius: BorderRadius.circular(25)),
                                             child: Padding(
                                               padding: const EdgeInsets.only(left:20.0,right: 20, ),
                                               child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(child: Text('')),
                                                  Icon(Icons.arrow_drop_down,color: primarycolor,)
                                               ],),
                                             ),
                                           ),
                                ),
                                 Positioned(
                                  top: 0,
                                  right: 30,
                                  child:Text('   التصنيف الفرعي   ',style: TextStyle(fontSize: size2,backgroundColor: backecolor,color: primarycolor),)
                                ),
                              ],
                            ),
                          ), ):   
                       PopupMenuButton<int>(
                                  child:  Container(
                            width: double.infinity,
                            height: 55,
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 10,
                                  left: 0,right: 0,
                                  child: Container(width: double.infinity,height: 45,
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 2,color:validate||secindex>=0? primarycolor:Colors.red),
                                            borderRadius: BorderRadius.circular(25)),
                                             child: Padding(
                                               padding: const EdgeInsets.only(left:20.0,right: 20,top: 5 ),
                                               child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(child: Text(secindex==-1?'':msubcate[secindex].name,style: TextStyle(fontSize: size1,fontWeight: FontWeight.w600 ),)),
                                                  Icon(Icons.arrow_drop_down,color: primarycolor,)
                                               ],),
                                             ),
                                           ),
                                ),
                                 Positioned(
                                  top: 0,
                                  right: 30,
                                  child:Text('   التصنيف الفرعي   ',style: TextStyle(fontSize: size2,backgroundColor: backecolor,color: primarycolor),)
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
                            msubcate
                            .length,
                            (index) =>
                            PopupMenuItem<
                            int>(

                            value: index,
                            child: Container(
                              width:MediaQuery.of(context).size.width-30,
                              decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1,color:backecolor)
                              
                              )),
                              child: Center(child: Text(msubcate[index].name,style: TextStyle(fontSize: size2,fontWeight: FontWeight.w600,color: Colors.white),))),

                            )),
                              onSelected: (int value) {
                                FocusScope.of(context).unfocus();
                            setState(() {
                            secindex=value;
                           
                            });

                            },
                            elevation: 5,
                            tooltip: 'التصنيف الفرعي',
                            color: primarycolor,
                        offset: Offset( 2,35),
                       
                            ),
                       AnimatedContainer(
                          height: validate||secindex>=0 ?0:30,
                          duration: Duration(milliseconds: 150),
                          child: Padding(
                          padding: const EdgeInsets.only(right:20.0),
                          child: Text('يرجى تحديد التصنيف الفرعي للإعلان',style: TextStyle(color: Colors.red,fontSize: 11,fontWeight: FontWeight.w600),),
                        ),
                        ),
                        SizedBox(height: 20,),
                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                          Checkbox(
                          value: whats,
                          activeColor: primarycolor,
                          onChanged: (bool value) {
                            setState(() {
                              this.whats = value;
                             
                            });
                          
                          },
                        ), 
                                              InkWell(
                                                onTap: (){
                                                  setState(() {
                                             whats=!whats;
                                             
                                            });
                                          
                                                },
                                                child: Text(
                          'إظهار رقم الواتس',style: TextStyle(fontSize: size2,color: Colors.black38,fontWeight: FontWeight.w700),
                     
                        ),
                                              ), //Text
                        
                     //Checkbox
                      ], //<Widget>[]
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

                              _myAlertDialogRating();
                            },
                            child: Container(width: double.infinity,height: 45,
                                          decoration: BoxDecoration(
                                           
                                              borderRadius: BorderRadius.circular(25),color:primarycolor),
                                              child: Center(child: Text('إضافة الإعلان',style: TextStyle(color:backecolor,fontWeight: FontWeight.w800,fontSize: size1),),),
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
                  Text(data,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: size2,fontWeight: FontWeight.w600),
                  
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



bool whats=false;
String country='';

bool some=false;


bool validate=true;
bool confirm(){
    FocusScope.of(context).unfocus();
 
  if(namec.text.length<3)return false;
  if(country.length==0)return false;
  if( !(descc.text.length>=5&&descc.text.length<=250)) return false;
  if(images.length==0) return false;
  if(prisec.text.length==0&&!some)return false;
  if(primindex<0) return false;
  if(secindex<0)return false;
  return true;
}
bool showload=false;
bool loaddata=false;
String data='';
String action='';
  Future<int> addads()async{
  

    setState(() {
          showload=true;
          loaddata=true;
        });
    http.MultipartRequest request = new http.MultipartRequest(
      'POST',
      Uri.parse( baseurl + "add_advertisement" ),
    );
    String token=globals.access_token;
    Map<String, String> header = {
      "Accept": "application/json",
      'Authorization': 'Bearer $token',
    };
    request.headers.addAll(header);
 await Future.forEach(
      images,
      (file) async => {
        request.files.add(
          http.MultipartFile(
            'images[]',
            (http.ByteStream(file.openRead())).cast(),
            await file.length(),
            filename: (file.path),
          ),
        )
      },
    );
 
 
    Map<String, String> body = {
      'advertisement_name_en':namec.text,
      'advertisement_name_ar':namec.text,
      'text_ar':descc.text,
      'text_en':descc.text,
      'user_id':globals.user_id,
       'city':country,
       'show_mobile_number':whats?'show':'hidden',

      'price':some?'-1':prisec.text,
      'section_id':mcateg[primindex].id,
      'category_id':msubcate[secindex].id,

    };
    request.fields.addAll(body);

    http.StreamedResponse r = await request.send();
    
    var responseData = await r.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
  print(responseString);
    if(r.statusCode==200){
         setState(() {
                    loaddata=false;
                    if( mcateg[primindex].name.contains('الإبل')&&msubcate[secindex].name.contains('المزاين'))
                     
                    data='تمت إضافة الاعلان بنجاح, يرجة انتظار موافقة الإدارة';
                    else
                    {
                         var json=jsonDecode(responseString)['data'];
                         data='تم إضافة الإعلان بنجاح';
                       ff.maincateg pp=new ff.maincateg();
                  pp.id=json['id'].toString();
                  pp.advertisement_status='active';
                  pp.category_id=msubcate[secindex].id;
                  pp.countrodod='0';
                  pp.details=descc.text;
                  pp.name=namec.text;
                  pp.show_mobile_number=whats?'show':'hidden';
                  pp.prise=some?'السعر على السوم':(prisec.text+'ر.س');
                  pp.city=country;

                 
                for(int i=0;i<json['images'].length;i++){
                pp.images.add( baseurlim+ json['images'][i]['image_name']);
              
              }
           
              pp.image=pp.images[0];
                    Navigator.of(context).pushReplacement( MaterialPageRoute(
                              builder: (BuildContext context) => adsinfo(catid:pp  ,),
                              ) );
                    }
                         
                    action='تم';
                    namec.clear();
                    descc.clear();
                    prisec.clear();
                    primindex=-1;
                    secindex=-1;
                    _image=null;
                    images=[];
                    validate=true;
                  });
    }else{
    setState(() {
                    loaddata=false;
                    data='عذراً, يرجى المحاولة لاحقاً';
                    action='محاولة مجدداً';
                   
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
    
                   
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            'معاهدة النوادر',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                   SizedBox(height: 10,),
                     Text(
                          'بسم الله الرحمن الرحيم\n قال الله تعالى وأوفو بعهد الله إذا عاهدتم ولاتنقضو الأيمان بعد توكيدهاوقد جعلتم الله عليكم كفيلا\n صدق الله العظيم',
                          textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w700, fontSize: size2,color: Colors.grey[600]),
                        ),

                         SizedBox(height: 10,),
                     Text(
                          '-أتعهد و أقسم بالله أنا المعلن ان ادفع عمولة الموقع وهي 1% من قيمة البيع سواء تم البيع عن طريق الموقع أو بسببه.',
                          textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.w700, fontSize: size2, ),
                        ),
                             SizedBox(height: 10,),
                     Text(
                          '-كما أتعهد بدفع العمولة خلال 10 أيام من استلام مبلغ المبايعة.',
                          textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.w700, fontSize: size2, ),
                        ),
                  Text(
                          '- وأتعهد بأن جميع الصور المرفقة في الإعلان هي صور حديثة لنفس الإعلان وليست لصور أخرى أو مشابه لها .',
                          textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.w700, fontSize: size2, ),
                        ),
                       
                      SizedBox(height: 20),
                      Row(children: [
                        Checkbox(value: itsok,onChanged: (value){snapshot(() {
                                              itsok=value;
                                            });},activeColor: primarycolor, ),
                                            SizedBox(width: 10,),
                                             Text(
                          'اتعهد بذلك',
                          textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.w700, fontSize: size2, ),
                        ),

                      ],),
                       Text(
                          'قيمة العمولة تدفع من صاحب الإعلان البائع وليست من المشتري',
                          textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w800, fontSize: size2,color: primarycolor ),
                        ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                          if(!itsok)return;
                          addads();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey,
                          ),
                          child:Center(child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text('نشر الإعلان',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: size1),),
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
   onChangeDropdownTesten(_selectedcountriesar) {
      FocusScope.of(context).unfocus();
    setState(() {
 
      country = _selectedcountriesar ;
  
       
 
    });
  }
  FocusNode fnode=new FocusNode ();
  bool itsok=false;
  bool showconfirm=false; 
  List<String> messages=[];
  List<maincateg> mcateg=[];
  
bool loadmain=true;
bool loadsec=true;

 Future<int> gelallcate() async {
 
    Map<String, String> header = {
      "Accept": "application/json",
    };
    Map<String, String> body;
 
    // body = {
    //   'token': globals.access_token,
    // };
  var responsess = await http.get(
      Uri.parse(baseurl + "all_sections"), headers: header
    );
   
 
     
 
    if (responsess.statusCode == 200) {
   var x=jsonDecode(responsess.body)['data'];
  
     for(int i=0;i<x.length;i++){
         maincateg p=new maincateg();
         p.add(x[i]);
         mcateg.add(p);
     }
    
     
    } else {}
    setState(() {
   loadmain=false;
    });
  }
   
  Future<int> gelallsub() async {
 msubcate=[];
    Map<String, String> header = {
      "Accept": "application/json",
    };
    Map<String, String> body;
 
    // body = {
    //   'token': globals.access_token,
    // };
  var responsess = await http.get(
      Uri.parse(baseurl + "show_section/"+mcateg[primindex].id), headers: header
    );
   
 
  
 
    if (responsess.statusCode == 200) {
   var x=jsonDecode(responsess.body)['data']['categories'];
  
     for(int i=0;i<x.length;i++){
         subcate p=new subcate();
         p.add(x[i]);
         msubcate.add(p);
     }
    
     
    } else {}
    setState(() {
   loadsec=false;
    });
  }
   
  List<subcate> msubcate=[];
}
class subcate{
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
class maincateg{
  String name;
  String image;
  String icon;
  String id;
  void add(var json){
    name=json['translations'][0]['section_name'];
    id=json['id'].toString();
    image=json['photo_name'] ;
  }

}