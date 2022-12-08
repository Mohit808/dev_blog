import 'dart:convert';
import 'dart:io';
import 'package:dev_blog/create.dart';
import 'package:dev_blog/seeCodes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());

  HttpOverrides.global = MyHttpOverrides();
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
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
  List list = [];
  List listSearch = [];
  bool isSearchOpen=false;
  double sideWidth = 300;
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  TextEditingController textEditingController=TextEditingController();

  @override
  void initState() {
    getData();
  }

  getData() async {
    try{
      var request = await http.get(
        Uri.parse('https://amityadavayx.pythonanywhere.com/getDevBlogData/'),
        // Uri.parse('http://localhost:8000/getDevBlogData/'),
        // Uri.parse('http://164.92.74.152/api'),
      );
      list = jsonDecode(request.body);
      setState(() {});
    }catch(e){}
    _refreshController.refreshCompleted();
  }

  _onRefresh(){
    list=[];
    setState(() {

    });
    getData();
  }

  myDrawer(){
    return Container(
      width: sideWidth,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(width: .5, color: Colors.grey)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Amit',
                style: TextStyle(fontSize: 20),
              ),
              Icon(
                Icons.arrow_drop_down,
                size: 34,
                color: Colors.grey,
              )
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreatePage()));
                },
                child: Container(
                  width: 150,
                  padding: EdgeInsets.only(top: 10, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: Colors.orange,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        "NEW POST",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.0,
                        spreadRadius: 0.0,
                        offset: Offset(1.0,
                            1.0), // shadow direction: bottom right
                      )
                    ],
                    borderRadius:
                    BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Container(
                width: 250,
                height: .5,
                color: Colors.grey,
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              SizedBox(
                width: 16,
              ),
              Icon(
                Icons.local_post_office_outlined,
                color: Colors.orange,
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                'Posts',
                style: TextStyle(color: Colors.orange),
              )
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              SizedBox(
                width: 16,
              ),
              Icon(
                Icons.comment,
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                'Comments',
              )
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              SizedBox(
                width: 16,
              ),
              Icon(
                Icons.bar_chart,
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                'Stats',
              )
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              SizedBox(
                width: 16,
              ),
              Icon(
                Icons.settings,
              ),
              SizedBox(
                width: 16,
              ),
              Text(
                'Settings',
              ),
              Text("v1")
            ],
          ),
        ],
      ),
    );
  }

  searchMethod(String value) async {
    if(value.isEmpty){
      isSearchOpen=false;
      setState(() {});
      return;
    }
    try{
      var request = await http.get(
        Uri.parse('https://amityadavayx.pythonanywhere.com/search/$value'),
        // Uri.parse('http://localhost:8000/getDevBlogData/'),
        // Uri.parse('http://164.92.74.152/api'),
      );
      listSearch = jsonDecode(request.body);
      isSearchOpen=true;
      setState(() {});
    }catch(e){}
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print(" MediaQuery.of(context).size.width ${MediaQuery.of(context).size.width}");
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: InkWell(
            onTap: () {
              _scaffoldKey.currentState!.openDrawer();

              if (sideWidth == 0) {
                sideWidth = 300;
              } else {
                sideWidth = 0;
              }
              setState(() {});
            },
            child: Icon(
              Icons.menu,
              color: Colors.black,
            )),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Icon(
            //   Icons.message_outlined,
            //   color: Colors.orange,
            //   size: 40,
            // ),
            Flexible(
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5)),
                  // width: MediaQuery.of(context).size.width / 1.5,
                  padding: EdgeInsets.all(0),
                  child: TextField(
                    controller: textEditingController,
                    // autofocus: false,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search posts",
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        suffixIcon: isSearchOpen?InkWell(onTap: (){
                          isSearchOpen=false;
                          textEditingController.text="";
                          setState(() {});
                        },child: Icon(Icons.close)):null),
                    onSubmitted: (value){
                      searchMethod(value);
                    },
                  )),
            ),
            // Icon(
            //   Icons.help_outline_rounded,
            //   color: Colors.black,
            // ),
          ],
        ),
        actions: [
          Icon(
            Icons.account_circle,
            color: Colors.black,
            size: 40,
          ),
          SizedBox(width: 16,)
        ],
      ),
      drawer: MediaQuery.of(context).size.width < 800?Drawer(child: SafeArea(child: myDrawer(),),):null,
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _onRefresh,

        // enablePullUp: nextPage != null ? true : false,
        // onLoading: _onLoading,

        child: Stack(
          children: [
            Row(
              children: [
                MediaQuery.of(context).size.width < 800
                    ? SizedBox()
                    :myDrawer(),


                Expanded(
                  child: ListView.builder(
                    primary: false,
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 16.0,left: 16,right: 16),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SeeCodes(list[index]['uniqueKeys'])));
                            },
                            child: Container(

                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.blueGrey, width: .5)),
                              child: Row(
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.blueGrey, width: .5)),
                                      padding: EdgeInsets.only(
                                          top: 16, bottom: 16, left: 24, right: 24),
                                      margin: EdgeInsets.only(right: 16),
                                      child: Text(
                                        list[index]['title'][0],
                                        style: TextStyle(fontSize: 24),
                                      )),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              list[index]['title'],
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            Row(mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  "Amit",
                                                  style: TextStyle(),
                                                ),
                                                SizedBox(width: 8,),
                                                Icon(
                                                  Icons.account_circle,
                                                  size: 30,
                                                  color: Colors.blueGrey,
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Published | 4 jun",
                                              style:
                                                  TextStyle(color: Colors.blueGrey),
                                            ),
                                            Row(mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.share,
                                                  color: Colors.blueGrey,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text("0"),
                                                Icon(
                                                  Icons.insert_comment,
                                                  color: Colors.blueGrey,
                                                ),
                                                SizedBox(
                                                  width: 16,
                                                ),
                                                Text("0"),
                                                Icon(
                                                  Icons.bar_chart,
                                                  color: Colors.blueGrey,
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
            isSearchOpen==false?const SizedBox():Container(color: Colors.white,child:
              listSearch.isEmpty?const Center(child: Text("No result found"),):ListView.builder(itemCount: listSearch.length,itemBuilder: (BuildContext context, int index){
                return InkWell(onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SeeCodes(listSearch[index]['uniqueKeys'])));
                },
                  child: ListTile(
                    title: Text(listSearch[index]['code']),
                    subtitle: Text(listSearch[index]['title']),
                    trailing: Text(listSearch[index]['uniqueKeys']),
                  ),
                );
              }),)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreatePage()));
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
