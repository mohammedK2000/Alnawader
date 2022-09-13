import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:purshases/utiles.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'adsinfo.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
class seach extends StatefulWidget {
 
 
  @override
  seachState createState() =>seachState( );
}

 

class seachState extends State<seach> {
 
@override
  void initState() {
 

    super.initState();
  }
    FocusNode myFocusNode=new FocusNode();
    ButtonState stateTextWithIcon = ButtonState.idle;
         final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double maxwidth = MediaQuery.of(context).size.width;
    double maxheight = MediaQuery.of(context).size.height;
    
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
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
            key: _scaffoldKey,
          drawer: drawer(context,  _scaffoldKey),
          bottomNavigationBar: bottombare(context,5,Colors.white,_scaffoldKey),
          body: Stack(
                  children: [
                    

              AnimatedPositioned(
           top:loaddata?MediaQuery.of(context).size.height/3:lastsearch==searchtext?50: 110,
            left: 10,
            right: 10,
            duration: const Duration(milliseconds: 300),
            curve: Curves.fastOutSlowIn,
            child: AnimatedContainer(
                duration: const Duration(milliseconds: 1000),
                curve: Curves.fastOutSlowIn,
              height:lastsearch==searchtext?80: 133,
          child: Column(children: [
          
               
                    Visibility(
                  visible: lastsearch != searchtext,
                  child: ProgressButton.icon(
                      iconedButtons: {
                        ButtonState.idle: IconedButton(
                            text:
                               'بحث',
                            icon: Icon(Icons.search,
                                color: Colors.white),
                            color: primarycolor),
                        ButtonState.loading: IconedButton(
                            text: "Loading", color:primarycolor),
                        ButtonState.fail: IconedButton(
                            text: 'نتيجة البحث فارغة',
                            icon: Icon(Icons.cancel,
                                color: Colors.white),
                            color: Colors.red.shade300),
                        ButtonState.success: IconedButton(
                            text: "Success",
                            icon: Icon(
                              Icons.check_circle,
                              color: Colors.white,
                            ),
                            color: Colors.green.shade400)
                      },
                      onPressed: onPressedIconWithText,
                      state: stateTextWithIcon),
                ),
          ],),
          ),
          
          )  , 
                   Positioned(top: 30,left: 20,right: 20,child:   Card(
              shadowColor: primarycolorc2,
              elevation: 5,
              child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8),
                        child: Row(
                          children: [
                            Container(
                              width: 20,height: 30,
                              child: Center(child: Icon(Icons.search,color: primarycolor,))),
                              SizedBox(width: 15,),
                            Expanded(
                              child: TextFormField(
                                controller: searchtextc,
                                keyboardType: TextInputType.text,
                             //   textAlign: TextAlign.center,
                                autofocus: true,
                                decoration: InputDecoration(
                                  
                                  border: InputBorder.none,
                                  hintText:
                                    'بحث',
                                ),
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize:15,
                                  color: Color.fromRGBO(10, 37, 56, 3),
                                ),
                                focusNode: myFocusNode,
                                onChanged: (String txt) {
                                  setState(() {
                                    searchtext = txt;
                                    stateTextWithIcon = ButtonState.idle;
                                  });
                                },
                                textAlignVertical: TextAlignVertical.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
    ),),
                
               
          
                
                 AnimatedPositioned(

                       top:loaddata?MediaQuery.of(context).size.height:(lastsearch!=searchtext)?170: 110,
                       left: 0,
                       right: 0,
                       bottom: 0,
                      duration: const Duration(milliseconds: 300),
                        curve: Curves.fastOutSlowIn,
                    
                child: Column(children: [
             loaddata?Center(child: CircularProgressIndicator(),):(mcateg.length==0 )?Center(child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Image.asset('assets/emptyres.gif',width: 100,height: 100,),
              Text('نتيجة البحث فارغة',style: TextStyle(fontWeight: FontWeight.bold,color:primarycolor),),
             ],),)  : Container(),
                 (mcateg.length==0 )?Container(): 
                Expanded(child: ListView(children:    List.generate(mcateg.length, (index) =>
                 
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
                                           width: 90,
                                          height:90,
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
                                     
                                        Visibility(
                                          visible: false,
                                           child: Container(
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
                                         ),
                                       ],
                                     ),
                                   ),
                             ),
                                 ),
                               ) ),))
             
               
                 
                ],),
                )
                
                  
              
          
                  ],
                ),
        ));
  } 
  String lastsearch='';
  String searchtext='';
    void onPressedIconWithText() async {
    if (stateTextWithIcon == ButtonState.fail) {
      searchtext = '';
     searchtextc.text = '';
      lastsearch = searchtext;
      stateTextWithIcon = ButtonState.idle;
      setState(() {
        stateTextWithIcon = stateTextWithIcon;
      });
      return;
    }
    stateTextWithIcon = ButtonState.loading;
    setState(() {
      stateTextWithIcon = stateTextWithIcon;
    });
    search(searchtext).then((value) async {
      if (value == 0)
        stateTextWithIcon = ButtonState.fail;
      else {
        stateTextWithIcon = ButtonState.idle;
        setState(() {
          stateTextWithIcon = stateTextWithIcon;
          lastsearch=searchtext;
        });
        // Navigator.of(context).push(SwipeablePageRoute(
        //   canOnlySwipeFromEdge: true,
        //   builder: (BuildContext context) => searchres(x: value,res:search2),
        // ));
      }
      setState(() {
        stateTextWithIcon = stateTextWithIcon;
      });
    });
  }

  TextEditingController searchtextc=new TextEditingController();
      Future<int> search(String text) async {

        mcateg.clear();
      myFocusNode.unfocus();
      setState(() {
              loaddata=true;
            });
    Map<String, String> header = {
      "Accept": "application/json",
    };
    Map<String, String> body;
 
  
  var responsess = await http.get(
      Uri.parse(baseurl + "search?searchWord="+text), headers: header
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
   loaddata=false;
    });
  }
  bool loaddata=true;
  List<maincateg> mcateg=[];
}
 