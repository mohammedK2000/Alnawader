import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:purshases/privacypolicy.dart';
import 'package:purshases/sendomola.dart';
import 'package:purshases/sentcomession.dart';
import 'package:purshases/termscondition.dart';

import 'aboutus.dart';
import 'add_ads.dart';
import 'authentication.dart';
import 'chats.dart';
import 'contactus.dart';
import 'home.dart';
import 'myads.dart';
import 'myglobals.dart' as globals;
import 'notification.dart';
Widget progres=CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(
    primarycolor, //<-- SEE HERE
  ),);
Widget bottombare(BuildContext context,int index,Color c,GlobalKey<ScaffoldState> _scaffoldKey){
  return Container(
    color: c,
    child: Container(
      width: double.infinity,
      height: 63,
      decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(13),topRight: Radius.circular(13)),
     
     boxShadow: [
          BoxShadow(
                      color: Colors.grey[300],
                      offset: const Offset(
                        0.0,
                        -2.0,
                      ),
                      blurRadius: 5.0,
                      spreadRadius: 1.0,
                    ), 
     ],
      color: Colors.white
      ),
      child: Row(
        
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
         InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: (){
            if(index==0)return;
               Navigator.of(context).push( MaterialPageRoute(
                              builder: (BuildContext context) => MyHomePage(  ),
                              ) );
          },
           child: Container(
            width: 90,
            height: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              Icon(Icons.home,color: index==0?primarycolor:Colors.grey[500],),
              Text('الرئيسية',style: TextStyle(fontSize: size3,fontWeight: index==0?FontWeight.w600:FontWeight.normal,color: index==0?primarycolor:Colors.grey[500]),)
            ],),
           ),
         ),
         InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: (){
            if(index==1)return;
               Navigator.of(context).push( MaterialPageRoute(
                              builder: (BuildContext context) => authentication(fromreg: false,  ),
                              ) );
          },
           child: Container(
            width: 90,
            height: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              Icon(Icons.person,color: index==1?primarycolor:Colors.grey[500],),
              Text('الملف الشخصي',style: TextStyle(fontSize: size3,fontWeight: index==1?FontWeight.w600:FontWeight.normal,color: index==1?primarycolor:Colors.grey[500]),)
            ],),
           ),
         ),

         InkWell(
          onTap: (){
              if(index==2)return;
               Navigator.of(context).push( MaterialPageRoute(
                              builder: (BuildContext context) => chats(  ),
                              ) );
          },
           child: Container(
            width: 90,
            height: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              Icon(Icons.email,color: index==2?primarycolor:Colors.grey[500],),
              Text('الرسائل',style: TextStyle(fontSize: size3,fontWeight: index==2?FontWeight.w600:FontWeight.normal,color: index==2?primarycolor:Colors.grey[500]),)
            ],),
           ),
         ),
         InkWell(
          onTap: (){
               if(index==3)return;
               Navigator.of(context).push( MaterialPageRoute(
                              builder: (BuildContext context) => notification(  ),
                              ) );
          },
           child: Container(
            width: 90,
            height: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              Icon(Icons.notifications,color: index==3?primarycolor:Colors.grey[500],),
              Text('الإشعارات',style: TextStyle(fontSize: size3,fontWeight: index==3?FontWeight.w600:FontWeight.normal,color: index==3?primarycolor:Colors.grey[500]),)
            ],),
           ),
         ),
      ],),

    ),
  );



}
Color backecolor=Colors.white;
Color primarycolor=Color.fromRGBO(251, 176, 59, 1);
Color primarycolorc=Color.fromRGBO(251, 176, 59, 0.5);
Color primarycolorc2=Color.fromRGBO(251, 176, 59, 0.8);
double size1=14;
double size2=13;
double size3=11;
String baseurl='https://alnawader1.com/api/';
String baseurlim='https://alnawader1.com/';
class maincateg{
  String name;
 
  String city;
  String image='ss';
  List<String> images=[];
  String icon;
  String details;
  String countrodod;
  String prise ;
  String id;
  String advertisement_status;
  String section_id;
  String category_id;
  String show_mobile_number;
  void add(var json){
   
    countrodod=json['replies_count'].toString();
    city=json['city'].toString();
     name=json['translations'].length>0?json['translations'][0]['advertisement_name']:'لايوجد';
     for(int i=0;i<json['images'].length;i++){
      images.add(json['images'][i]['image_name']);
     }
     if(images.length>0)
          image=images[0];
     show_mobile_number=json['show_mobile_number'].toString();
       for(int i=0;i<images.length;i++){
      images[i]=baseurlim+images[i];
     
     }
     id=json['id'].toString();
     advertisement_status=json['advertisement_status'].toString();
     section_id=json['section_id'].toString();
     category_id=json['category_id'].toString();
     details=json['translations'].length>0?json['translations'][0]['text']:'لايوجد';
     prise=json['price'].toString();
    prise=prise=='-1'?'السعر على السوم':(prise+'ر.س');
  }

}
Widget drawer(BuildContext context,GlobalKey<ScaffoldState> _scaffoldKey){
  return SafeArea(
    top: true,
    child: Container(width: MediaQuery.of(context).size.width-80,height: double.infinity,color: Colors.white,
    child: Column(children: [
      Container(width:  MediaQuery.of(context).size.width-80,height: 250,
      decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/cover6.png'),fit: BoxFit.fill)),

      child: Center(child:
       Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.grey[100]
            ,image: DecorationImage(image:globals.image!=null&&globals.image.length>9?NetworkImage(baseurlim+globals.image) :AssetImage('assets/cover.jpg'),fit: BoxFit.cover)
            ),),
            SizedBox(height: 10,),
            Text( globals.login?globals.name:'النوادر',style: TextStyle(fontSize: size1,fontWeight: FontWeight.w800),),


        ],
      ),
      
      
      ),
      ),
      SizedBox(height: 20,),
      Expanded(child: Padding(
            padding: const EdgeInsets.all(20.0),
        child: ListView(children: [
          InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: (){
                 Navigator.of(context).push( MaterialPageRoute(
                                builder: (BuildContext context) => authentication(fromreg: false,  ),
                                ) );
                            _scaffoldKey.currentState.openEndDrawer();   
            },
            child: Container(width: 250,height: 40,decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: primarycolor),
            
            child: Row(children: [
                  SizedBox(width: 20,),
            globals.login?  ImageIcon(AssetImage('assets/user (1).png'),color: Colors.white,): Icon(Icons.login,color: Colors.white,),
              SizedBox(width: 10,),
              Text(globals.login?'الملف الشخصي':'تسجيل الدخول',style: TextStyle(fontWeight: FontWeight.w600,fontSize: size2,color: Colors.white),),
              Spacer(),
              Icon(Icons.arrow_forward_ios_sharp,color: Colors.white,size: 20,),
              SizedBox(width: 10,),
            ],),),
          ),
          
            SizedBox(height: 10,),
           InkWell(
            onTap: (){    Navigator.of(context).push( MaterialPageRoute(
                                builder: (BuildContext context) => sendomola(  ),
                                ) );   _scaffoldKey.currentState.openEndDrawer();  },
            borderRadius: BorderRadius.circular(25),
             child: Container(width: 250,height: 40,decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: backecolor),
          
           child: Row(children: [
                  SizedBox(width: 20,),
             ImageIcon(AssetImage('assets/money.png'),color: primarycolor,),
              SizedBox(width: 10,),
              Text('إرسال عمولة',style: TextStyle(fontWeight: FontWeight.w600,fontSize: size2,color: Colors.black87),),
              Spacer(),
              Icon(Icons.arrow_forward_ios_sharp,color: Colors.black87,size: 20,),
              SizedBox(width: 10,),
          ],),),
           ),
           SizedBox(height: 10,),
           InkWell(
            onTap: (){    Navigator.of(context).push( MaterialPageRoute(
                                builder: (BuildContext context) => sentcomession(  ),
                                ) );   _scaffoldKey.currentState.openEndDrawer();  },
            borderRadius: BorderRadius.circular(25),
             child: Container(width: 250,height: 40,decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: backecolor),
          
           child: Row(children: [
                  SizedBox(width: 20,),
             ImageIcon(AssetImage('assets/get-money.png'),color: primarycolor,),
              SizedBox(width: 10,),
              Text('العمولات المرسلة',style: TextStyle(fontWeight: FontWeight.w600,fontSize: size2,color: Colors.black87),),
              Spacer(),
              Icon(Icons.arrow_forward_ios_sharp,color: Colors.black87,size: 20,),
              SizedBox(width: 10,),
          ],),),
           ),
                  SizedBox(height: 10,),
           InkWell(
                   onTap: (){
                 Navigator.of(context).push( MaterialPageRoute(
                                builder: (BuildContext context) => myads(  ),
                                ) );   _scaffoldKey.currentState.openEndDrawer();  
            },
            borderRadius: BorderRadius.circular(25),
          
             child: Container(width: 250,height: 40,decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: backecolor),
          
           child: Row(children: [
                  SizedBox(width: 20,),
                  ImageIcon(AssetImage('assets/promotion.png'),color: primarycolor,),
              SizedBox(width: 10,),
              Text('إعلاناتي',style: TextStyle(fontWeight: FontWeight.w600,fontSize: size2,color: Colors.black87),),
              Spacer(),
              Icon(Icons.arrow_forward_ios_sharp,color: Colors.black87,size: 20,),
              SizedBox(width: 10,),
          ],),),
           ),
                 SizedBox(height: 10,),
           InkWell(
            onTap: (){
                 Navigator.of(context).push( MaterialPageRoute(
                                builder: (BuildContext context) => addads(  ),
                                ) );   _scaffoldKey.currentState.openEndDrawer();  
            },
            borderRadius: BorderRadius.circular(25),
             child: Container(width: 250,height: 40,decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: backecolor),
          
           child: Row(children: [
                  SizedBox(width: 20,),
              ImageIcon(AssetImage('assets/advertising.png'),color: primarycolor,),
              SizedBox(width: 10,),
              Text('إضافة إعلان',style: TextStyle(fontWeight: FontWeight.w600,fontSize: size2,color: Colors.black87),),
              Spacer(),
              Icon(Icons.arrow_forward_ios_sharp,color: Colors.black87,size: 20,),
              SizedBox(width: 10,),
          ],),),
           ),
             
             SizedBox(height: 10,),
           InkWell(
            onTap: (){   _scaffoldKey.currentState.openEndDrawer();
                Navigator.of(context).push( MaterialPageRoute(
                              builder: (BuildContext context) => privacypolicy(  ),
                              ) );
            
              },
            borderRadius: BorderRadius.circular(25),
             child: Container(width: 250,height: 40,decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: backecolor),
          
           child: Row(children: [
                  SizedBox(width: 20,),
               ImageIcon(AssetImage('assets/privacy-policy.png'),color: primarycolor,),
              SizedBox(width: 10,),
              Text('سياسة الخصوصية',style: TextStyle(fontWeight: FontWeight.w600,fontSize: size2,color: Colors.black87),),
              Spacer(),
              Icon(Icons.arrow_forward_ios_sharp,color: Colors.black87,size: 20,),
              SizedBox(width: 10,),
          ],),),
           ),
             SizedBox(height: 10,),
           InkWell(
            onTap: (){   _scaffoldKey.currentState.openEndDrawer(); 
                  Navigator.of(context).push( MaterialPageRoute(
                              builder: (BuildContext context) => termscondition(  ),
                              ) );
            
             },
            borderRadius: BorderRadius.circular(25),
             child: Container(width: 250,height: 40,decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: backecolor),
          
           child: Row(children: [
                  SizedBox(width: 20,),
            ImageIcon(AssetImage('assets/terms-and-conditions.png'),color: primarycolor,),
              SizedBox(width: 10,),
              Text('الشروط والأحكام',style: TextStyle(fontWeight: FontWeight.w600,fontSize: size2,color: Colors.black87),),
              Spacer(),
              Icon(Icons.arrow_forward_ios_sharp,color: Colors.black87,size: 20,),
              SizedBox(width: 10,),
          ],),),
           ),
              SizedBox(height: 10,),
           InkWell(
            onTap: (){   _scaffoldKey.currentState.openEndDrawer();
                 Navigator.of(context).push( MaterialPageRoute(
                              builder: (BuildContext context) => contactus(  ),
                              ) );
            
              },
            borderRadius: BorderRadius.circular(25),
             child: Container(width: 250,height: 40,decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: backecolor),
          
           child: Row(children: [
                  SizedBox(width: 20,),
                    ImageIcon(AssetImage('assets/contact.png'),color: primarycolor,),
              SizedBox(width: 10,),
              Text('تواصل معنا',style: TextStyle(fontWeight: FontWeight.w600,fontSize: size2,color: Colors.black87),),
              Spacer(),
              Icon(Icons.arrow_forward_ios_sharp,color: Colors.black87,size: 20,),
              SizedBox(width: 10,),
          ],),),
           ),
              SizedBox(height: 10,),
           InkWell(
            onTap: (){   _scaffoldKey.currentState.openEndDrawer(); 
            
             Navigator.of(context).push( MaterialPageRoute(
                              builder: (BuildContext context) => aboutauss(  ),
                              ) );
             },
            borderRadius: BorderRadius.circular(25),
             child: Container(width: 250,height: 40,decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: backecolor),
          
           child: Row(children: [
                  SizedBox(width: 20,),
                      ImageIcon(AssetImage('assets/information.png'),color: primarycolor,),
              SizedBox(width: 10,),
              Text('عن التطبيق',style: TextStyle(fontWeight: FontWeight.w600,fontSize: size2,color: Colors.black87),),
              Spacer(),
              Icon(Icons.arrow_forward_ios_sharp,color: Colors.black87,size: 20,),
              SizedBox(width: 10,),
          ],),),
           ),
            SizedBox(height: 10,),
           Visibility(
            visible: globals.login,
             child: InkWell(
              onTap: ()async{
                 
                  Hive.deleteFromDisk().then((value) {
                       globals.login=false;
                       globals.email='-1';
                       globals.name='-1';
                       globals.access_token='-1';
                       globals.myads=[];
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                                builder: (BuildContext context) => MyHomePage(  ),
                                ) , (route) => false);
                              
                  });
              },
              borderRadius: BorderRadius.circular(25),
               child: Container(width: 250,height: 40,decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: backecolor),
          
             child: Row(children: [
                    SizedBox(width: 20,),
                Icon(Icons.logout,color: primarycolor,),
                SizedBox(width: 10,),
                Text('تسجيل الخروج',style: TextStyle(fontWeight: FontWeight.w600,fontSize: size2,color: Colors.black87),),
                Spacer(),
                Icon(Icons.arrow_forward_ios_sharp,color: Colors.black87,size: 20,),
                SizedBox(width: 10,),
          ],),),
             ),
           ),
        ],),
      ))
    ],),
    
    ),
  );
}
List<String> cities=[
  'الرياض','جدة','مكة المكرمة','المدينة المنورة','	الأحساء','الدمام','الطائف','بريدة','تبوك','القطيف','خميس مشيط','الخبر','حفر الباطن','الجبيل','الخرج','أبها','حائل','نجران','ينبع','	صبيا','الدوادمي','بيشة','أبو عريش','القنفذة','محايل','سكاكا','عرعر','عنيزة','القريات','صامطة','جازان','المجمعة','القويعية','احد المسارحه','الرس','وادي الدواسر','بحرة','الباحة','الجموم','رابغ','	أحد رفيدة','شرورة','الليث',
  'رفحاء','عفيف','العرضيات','العارضة','الخفجي','بلقرن','الدرعية','ضمد','طبرجل','بيش','الزلفي','الدرب','الافلاج','سراة عبيدة','رجال المع','بلجرشي','الحائط','ميسان','بدر','أملج','رأس تنورة','المهد','الدائر','البكيرية','البدائع','خليص','الحناكية','العلا','الطوال','النماص','المجاردة','بقيق','	تثليث','المخواة','النعيرية','الوجه','ضباء','بارق','طريف','خيبر','أضم','النبهانية','رنية','دومة الجندل','المذنب','تربة','ظهران الجنوب','حوطة بني تميم','الخرمة','قلوة','شقراء','المويه','المزاحمية','الأسياح','بقعاء','السليل','تيماء'];