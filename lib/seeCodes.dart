import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/googlecode.dart';
import 'package:http/http.dart' as http;

class SeeCodes extends StatefulWidget {
  String uniqueKeys;
  SeeCodes(this.uniqueKeys,{Key? key}) : super(key: key);

  @override
  State<SeeCodes> createState() => _SeeCodesState();
}

class _SeeCodesState extends State<SeeCodes> {
  List list=[];

  @override
  void initState() {
    abcd();
  }

  abcd() async {
    var request=await http.read(Uri.parse('https://rajularar0.pythonanywhere.com/getDevBogSinglePostData/${widget.uniqueKeys}'));
    list=jsonDecode(request);
    print("liiiiiiii $list");
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(elevation: 0,backgroundColor: Colors.white,title:
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
        Icon(Icons.message_outlined,color: Colors.orange,size: 40,),
        Container(decoration: BoxDecoration(color: Colors.grey[200],borderRadius: BorderRadius.circular(5)),width: MediaQuery.of(context).size.width/1.5,padding: EdgeInsets.all(0),child: TextField(decoration: InputDecoration(border: InputBorder.none,hintText: "Search posts",prefixIcon: Icon(Icons.search,color: Colors.black,),suffixIcon: Icon(Icons.info_outline)),)),
        Icon(Icons.help_outline_rounded,color: Colors.black,),
        Icon(Icons.account_circle,color: Colors.black,size: 40,)
      ],),),
      body: ListView.builder(shrinkWrap: true,primary: false,itemCount: list.length,itemBuilder: (BuildContext context,int index){
        return index==0?Padding(
          padding: const EdgeInsets.only(left: 24.0,right: 24,top: 24),
          child: Text(list[index]['title'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
        )
            :Padding(
              padding: const EdgeInsets.only(left: 24.0,right: 24),
              child: Container(padding: EdgeInsets.all(16),margin: EdgeInsets.only(bottom: 16),color: Colors.white,child:
        Stack(
          children: [
              // RichText(
              //   text: TextSpan(
              //     style: const TextStyle(fontFamily: 'monospace'),
              //     children: <TextSpan>[ DartSyntaxHighlighter(style).format(list[index]),
              //     ],
              //   ),),
              HighlightView(list[index]['code'],language: 'dart',theme: googlecodeTheme,padding: EdgeInsets.all(0)),
              Container(alignment: Alignment.topRight,child: InkWell(onTap: (){
                Clipboard.setData(ClipboardData(text: list[index]['code'])).then((_){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("copied to clipboard")));
                });
              },child: Icon(Icons.copy)))
          ],
        )),
            );
      }),
    );
  }
}
