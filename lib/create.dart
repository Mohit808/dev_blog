import 'dart:convert';

import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/a11y-light.dart';
import 'package:flutter_highlight/themes/androidstudio.dart';
import 'package:flutter_highlight/themes/darcula.dart';
import 'package:flutter_highlight/themes/default.dart';
import 'package:flutter_highlight/themes/foundation.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:flutter_highlight/themes/googlecode.dart';
import 'package:highlight/languages/dart.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:syntax_highlighter/syntax_highlighter.dart';
import 'package:http/http.dart' as http;
import 'package:random_string/random_string.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  late CodeController _codeController;
  TextEditingController messageController=TextEditingController();
  List<String> list=[];
  late SyntaxHighlighterStyle style = Theme.of(context).brightness == Brightness.dark ? SyntaxHighlighterStyle.darkThemeStyle() : SyntaxHighlighterStyle.lightThemeStyle();
  bool altPressed=false;
  TextEditingController textEditingControllerTitle=TextEditingController();

  @override
  void initState() {
    _codeController=CodeController(language: dart,theme: monokaiSublimeTheme);

  }

  abcd() async {
    print(list.length);
    var url = Uri.parse('https://rajularar0.pythonanywhere.com/devBogFunc/');
    var map={};
    for(int i=0;i<list.length;i++){
      map['$i']=list[i];
    }
    map['count']='${map.length}';
    map['uniqueKeys']=randomAlphaNumeric(10).toString();
    map['title']=textEditingControllerTitle.text;
    var response = await http.post(url, body: map);
    // var response = await http.post(url, body: {'0':map.toString()});
    // var response = await http.post(url, body: {'title': textEditingControllerTitle.text, 'code': list.toSet().toString()});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(elevation: 0,backgroundColor: Colors.white,title:
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
        Icon(Icons.message_outlined,color: Colors.orange,size: 40,),
        // Icon(Icons.help_outline_rounded,color: Colors.black,),
        Icon(Icons.account_circle,color: Colors.black,size: 40,)
      ],),),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AppBar(elevation: 0,backgroundColor: Colors.white,
                title: Container(height: 40,decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),child: TextField(controller: textEditingControllerTitle,decoration: InputDecoration(focusedBorder:  UnderlineInputBorder(borderSide: BorderSide(color: Colors.orange),), hintText: "Title"),)),
                actions: [
                  InkWell(onTap: (){
                    abcd();
                  },
                    child: Container(margin: EdgeInsets.only(top: 8,left: 8,bottom: 8,right: 16),padding: EdgeInsets.all(8),decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.orange),
                      child: Row(children: [
                        Icon(Icons.send),SizedBox(width: 8,),
                        Text('Publish',style: TextStyle(fontWeight: FontWeight.bold),)
                      ],),
                    ),
                  )
                ],),
              SizedBox(height: 16,),
              RawKeyboardListener(focusNode: FocusNode(onKey: (FocusNode node,RawKeyEvent evt){
                if(evt.isKeyPressed(LogicalKeyboardKey.enter)){
                  if(altPressed==true && _codeController.text.isNotEmpty){

                    altPressed=false;
                    // print("ENTERRRRRRRR");
                    list.add(_codeController.rawText);
                    _codeController.text="";
                    setState(() {

                    });
                  }
                  return KeyEventResult.handled;
                }

                if(evt.isAltPressed){
                  altPressed=true;
                  // print("isAltPressed");
                  return KeyEventResult.handled;
                }
                return KeyEventResult.ignored;
              }),
                  child: CodeField(controller: _codeController,)),
              ListView.builder(shrinkWrap: true,primary: false,itemCount: list.length,itemBuilder: (BuildContext context,int index){
                return Container(padding: EdgeInsets.all(16),margin: EdgeInsets.only(top: 16),color: Colors.white,child:
                Stack(
                  children: [
                    // RichText(
                    //   text: TextSpan(
                    //     style: const TextStyle(fontFamily: 'monospace'),
                    //     children: <TextSpan>[ DartSyntaxHighlighter(style).format(list[index]),
                    //     ],
                    //   ),),
                    HighlightView(list[index],language: 'dart',theme: googlecodeTheme,padding: EdgeInsets.all(16)),
                    Container(alignment: Alignment.topRight,child: InkWell(onTap: (){
                      Clipboard.setData(ClipboardData(text: list[index])).then((_){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("copied to clipboard")));
                      });
                    },child: Icon(Icons.copy)))
                  ],
                ));
              }),




            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          list.add(_codeController.rawText);
          _codeController.text="";
          setState(() {

          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
