// Try to change the sdk version to ">=2.7.0 <3.0.0" to remove null safety
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter API Integration'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key,  this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

     String stringResponse;
     Map mapResponse;
     Map dataResponse;
     List listResponse;

  Future apiCall() async {
    http.Response response;
    response = await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
    if (response.statusCode == 200) {
      setState(() {
         // stringResponse = response.body;
        mapResponse = json.decode(response.body);
        // dataResponse = mapResponse['data'];
        listResponse = mapResponse['data'];
      });
    }
  }

  @override
  void initState(){
    apiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child:ListView.builder(itemBuilder: (context,index){
          return Container(
            child: Row(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                    child: Image(image: NetworkImage(listResponse[index]['avatar']))),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Text(listResponse[index]['first_name'].toString()+" "+listResponse[index]['last_name'].toString(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text("Email: "+listResponse[index]['email'])
                ])
              ],
            ),
          );
      },
          itemCount: listResponse == null?0:listResponse.length

          // refer this code to get an idea on how to take value from each data individually
          /* Column(
             children:[
               Text(stringResponse.toString()),
               mapResponse==null?Text(""):Text(mapResponse['data'].toString(),
               style: TextStyle(fontSize: 20)),
               dataResponse==null?Text(""):Text(dataResponse['first_name'].toString())
             ]
           ),*/

      )
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
