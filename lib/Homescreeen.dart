import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'PostDetails.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Connecting Firebase Firestore to our app

  //declaring Variables:
  StreamSubscription<QuerySnapshot>subscription;
  List<DocumentSnapshot>snapshot;
  CollectionReference collectionReference =
      Firestore.instance.collection("post");

  //creating some Colors
  Color gradientStart = Colors.deepPurple[700];
  Color  gradientEnd = Colors.purple[500];
  passData(DocumentSnapshot snap){
    Navigator.of(context)
        .push(new MaterialPageRoute
      (builder: (context)=>PostDetails(snapshot:snap,)));
  }

  //Overriding Method to get Data from firestore
  @override
  void initState() {
    super.initState();
    subscription = collectionReference.snapshots()
                   .listen((datasnapshot) {
                     setState(() {
                       snapshot = datasnapshot.documents;
                     });
    });
  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      //Designing App bar
      appBar: new AppBar(
        title: new Text("Flutter blog App"),
        backgroundColor: Colors.lightBlue,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.search),
              onPressed: () => debugPrint("Search button pressed")
          ),
          new IconButton(
              icon: new Icon(Icons.add),
              onPressed: () => debugPrint("Add button pressed")
          ),
         ],
      ),//End of AppBar

      //Creating Navigation Drawer
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              //this is the upper part of Nav.Drawer
                accountName: new Text("Yogesh Singh"),
                accountEmail: new Text("flutter235@gmail.com")
            ),
            new ListTile(
              title: new Text("first option"),
              leading: new Icon(Icons.cake,color: Colors.purple,),
            ),
            new ListTile(
              title: new Text("Second Option"),
              leading: new Icon(Icons.search,color: Colors.redAccent,),
            ),
            new ListTile(
              title: new Text("Third Options"),
              leading: new Icon(Icons.cached,color: Colors.orange,),
            ),
            new ListTile(
              title: new Text("Fourth Options"),
              leading: new Icon(Icons.menu,color: Colors.green,),
            ),
            //Let's make a seperator:
            new Divider(
              height: 10.0,
              color: Colors.black,
            ),
            //Close button list (ListTitle)
            new ListTile(
              title: new Text("Close"),
              trailing: new Icon(Icons.close),
              onTap: (){
                Navigator.of(context).pop();
              },
            ) 
          ],
        ),
      ),
      //Navabar Complete

      //Creating Body Container of app it contains ListView that display the  retrieved data
      body:  new Container(
        decoration: BoxDecoration(
          gradient: new LinearGradient(colors: [gradientStart,gradientEnd],
            begin: const FractionalOffset(0.5, 0.0),
            end: const FractionalOffset(0.0, 0.5),
            stops: [0.0,1.0],
          )
        ),
        child:  new ListView.builder(
          itemCount: snapshot.length,
            itemBuilder: (context,index){
            return new Card(
              elevation: 0.0,
              color: Colors.transparent.withOpacity(0.1),
              margin: EdgeInsets.all(10.0),

              //Card Container
              child: new Container(
                padding: EdgeInsets.all(10.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    //Circle:
                    new CircleAvatar(
                      child: new Text(
                        snapshot[index].data["title"][0]),
                      backgroundColor:Colors.yellow,
                      foregroundColor: Colors.black,
                    ),

                    //Divider :
                    new SizedBox(width:6.0,),

                    //Container of texts
                    new Container(
                      width: 210.0,
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //Adding Click Events
                          new InkWell(
                            child: new Text(
                              snapshot[index].data["title"],

                              //Color of text
                              style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.white),
                              //Maximum lines
                              maxLines: 1,
                            ),
                            onTap: (){
                              //we want to [ass data to details  Screen
                              //we will create a method called : passData to sent details to  other Screen
                              passData(snapshot[index]);
                            },
                          ),

                          //Space between 2 Texts:
                          new SizedBox(height: 5.0,),

                          //new Text (Description)
                          new Text(
                            snapshot[index].data["content"],
                            style: TextStyle(fontSize: 14,
                            color: Colors.white70),
                            maxLines: 2,
                          ),
                        ],

                      ),
                    )

                  ],
                ),
              ),
            );
            },
        ),
      ),

    );
  }
}
