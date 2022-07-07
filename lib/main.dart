import 'dart:convert';

import 'package:dev_blog/create.dart';
import 'package:dev_blog/seeCodes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List list=[];
  double sideWidth=300;

  @override
  void initState() {
    abcd();
  }

  abcd() async {
    var request=await http.read(Uri.parse('https://rajularar0.pythonanywhere.com/getDevBogData/'));
    list=jsonDecode(request);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(key: _scaffoldKey,appBar: AppBar(elevation: 0,backgroundColor: Colors.white,leading: InkWell(onTap: (){
      // _scaffoldKey.currentState!.openDrawer();

      if(sideWidth==0){
        sideWidth=300;
      }else{
        sideWidth=0;
      }
      setState(() {

      });
    },child: Icon(Icons.menu,color: Colors.black,)),title:
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
      Icon(Icons.message_outlined,color: Colors.orange,size: 40,),
      Container(decoration: BoxDecoration(color: Colors.grey[200],borderRadius: BorderRadius.circular(5)),width: MediaQuery.of(context).size.width/1.5,padding: EdgeInsets.all(0),child: TextField(decoration: InputDecoration(border: InputBorder.none,hintText: "Search posts",prefixIcon: Icon(Icons.search,color: Colors.black,),suffixIcon: Icon(Icons.info_outline)),)),
      Icon(Icons.help_outline_rounded,color: Colors.black,),
      Icon(Icons.account_circle,color: Colors.black,size: 40,)
    ],),),

      body: Row(
        children: [
          Container(width: sideWidth,height: MediaQuery.of(context).size.height,padding: EdgeInsets.all(16),decoration: BoxDecoration(border: Border.all(width: .5,color: Colors.grey)),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
              Text('Amit',style: TextStyle(fontSize: 20),),
              Icon(Icons.arrow_drop_down,size: 34,color: Colors.grey,)
            ],),
            SizedBox(height: 16,),

            Row(
              children: [
                InkWell(onTap:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CreatePage()));
                },
                  child: Container(width: 150,padding: EdgeInsets.only(top: 10,bottom: 8),child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                    Icon(Icons.add,color: Colors.orange,),
                    SizedBox(width: 4,),
                    Text("NEW POST",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.orange),)
                  ],),decoration: BoxDecoration(color: Colors.white,boxShadow: [BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                    offset: Offset(1.0, 1.0), // shadow direction: bottom right
                  )],borderRadius: BorderRadius.all(Radius.circular(20)),),),
                ),
              ],
            ),
            SizedBox(height: 16,),
            Row(
              children: [
                Container(width: 250,height: .5,color: Colors.grey,),
              ],
            ),

            SizedBox(height: 16,),
            Row(children: [
              SizedBox(width: 16,),
              Icon(Icons.local_post_office_outlined,color: Colors.orange,),
              SizedBox(width: 16,),
              Text('Posts',style: TextStyle(color: Colors.orange),)
            ],),
            SizedBox(height: 16,),
            Row(children: [
              SizedBox(width: 16,),
              Icon(Icons.comment,),
              SizedBox(width: 16,),
              Text('Comments',)
            ],),

            SizedBox(height: 16,),
            Row(children: [
              SizedBox(width: 16,),
              Icon(Icons.bar_chart,),
              SizedBox(width: 16,),
              Text('Stats',)
            ],),

            SizedBox(height: 16,),
            Row(children: [
              SizedBox(width: 16,),
              Icon(Icons.settings,),
              SizedBox(width: 16,),
              Text('Settings',)
            ],),
          ],),),
          Expanded(
            child: Container(decoration: BoxDecoration(border: Border.all(width: .5,color: Colors.grey)),
              child: ListView.builder(itemCount: list.length,itemBuilder: (BuildContext context,int index){return
                InkWell(onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SeeCodes(list[index]['uniqueKeys'])));
                },
                  child: Container(margin:EdgeInsets.only(top: 24,left: MediaQuery.of(context).size.width/15,right:  MediaQuery.of(context).size.width/15),padding: EdgeInsets.all(16),decoration: BoxDecoration(border: Border.all(color: Colors.blueGrey,width: .5)),
                  child: Row(children: [
                    Container(decoration: BoxDecoration(border:Border.all(color: Colors.blueGrey,width: .5)),padding: EdgeInsets.only(top: 16,bottom: 16,left: 24,right: 24),margin: EdgeInsets.only(right: 16),child: Text(list[index]['title'][0],style: TextStyle(fontSize: 24),)),

                    Expanded(
                      child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(list[index]['title'],style: TextStyle(fontSize: 18),),
                            Wrap(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0,right: 4),
                                  child: Text("Amit",style: TextStyle(),),
                                ),
                                Icon(Icons.account_circle,size: 30,color: Colors.blueGrey,)
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 8,),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Published | 4 jun",style: TextStyle(color: Colors.blueGrey),),

                            Wrap(children: [
                              Icon(Icons.share,color: Colors.blueGrey,),
                              SizedBox(width: 16,),
                              Padding(
                                padding: const EdgeInsets.only(right: 4.0,top: 2),
                                child: Text("0"),
                              ),
                              Icon(Icons.insert_comment,color: Colors.blueGrey,),
                              SizedBox(width: 16,),
                              Padding(
                                padding: const  EdgeInsets.only(right: 4.0,top: 2),
                                child: Text("0"),
                              ),
                              Icon(Icons.bar_chart,color: Colors.blueGrey,)
                            ],)
                          ],
                        ),
                      ],),
                    )
                  ],),
              ),
                );
              }),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CreatePage()));
      },
      child: Icon(Icons.edit),),
    );
  }

}







