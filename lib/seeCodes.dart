// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_highlight/flutter_highlight.dart';
// import 'package:flutter_highlight/themes/googlecode.dart';
// import 'package:http/http.dart' as http;
//
// class SeeCodes extends StatefulWidget {
//   String uniqueKeys;
//   SeeCodes(this.uniqueKeys,{Key? key}) : super(key: key);
//
//   @override
//   State<SeeCodes> createState() => _SeeCodesState();
// }
//
// class _SeeCodesState extends State<SeeCodes> {
//   List list=[];
//
//   @override
//   void initState() {
//     abcd();
//   }
//
//   abcd() async {
//     var request=await http.read(Uri.parse('https://amityadavayx.pythonanywhere.com/getDevBlogSinglePostData/${widget.uniqueKeys}'));
//     list=jsonDecode(request);
//     print("liiiiiiii $list");
//     setState(() {
//
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(backgroundColor: Colors.blueGrey[100],
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         leading: InkWell(
//             onTap: () {
//               Navigator.of(context).pop();
//               // _scaffoldKey.currentState!.openDrawer();
//
//               // if (sideWidth == 0) {
//               //   sideWidth = 300;
//               // } else {
//               //   sideWidth = 0;
//               // }
//               // setState(() {});
//             },
//             child: Icon(
//               Icons.arrow_back_rounded,
//               color: Colors.black,
//             )),
//         title:
//         Text(list.isEmpty?'':list[0]['title'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,color: Colors.black),),
//       ),
//       body: ListView.builder(shrinkWrap: true,primary: false,itemCount: list.length,itemBuilder: (BuildContext context,int index){
//         return index==0?SizedBox(height: 16,)
//
//         // Padding(
//         //   padding: const EdgeInsets.only(left: 24.0,right: 24,top: 24),
//         //   child: Text(list[index]['title'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
//         // )
//             :Padding(
//               padding: const EdgeInsets.only(left: 24.0,right: 24),
//               child: Container(padding: EdgeInsets.all(16),margin: EdgeInsets.only(bottom: 16),color: Colors.white,child:
//         Stack(
//           children: [
//               // RichText(
//               //   text: TextSpan(
//               //     style: const TextStyle(fontFamily: 'monospace'),
//               //     children: <TextSpan>[ DartSyntaxHighlighter(style).format(list[index]),
//               //     ],
//               //   ),),
//               HighlightView(list[index]['code'],language: 'dart',theme: googlecodeTheme,padding: EdgeInsets.all(0)),
//               Container(alignment: Alignment.topRight,child: InkWell(onTap: (){
//                 Clipboard.setData(ClipboardData(text: list[index]['code'])).then((_){
//                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("copied to clipboard")));
//                 });
//               },child: Icon(Icons.copy)))
//           ],
//         )),
//             );
//       }),
//     );
//   }
// }
