import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class PostDetails extends StatefulWidget {
  //Some Variables --  FireStore --
  DocumentSnapshot snapshot;
  PostDetails({this.snapshot});
  @override
  _PostDetailsState createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      //Creating AppBar
      appBar: new AppBar(
        title: new Text("Post Details"),
        backgroundColor: Colors.green,
      ),

      //Creating App Card: -- To Disolay the Data
      body: new Card(
        elevation: 10.0,
        margin: EdgeInsets.all(10.0),
        child: new ListView(
          children: <Widget>[
            new Container(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    new CircleAvatar(
                      child: new Text(widget.snapshot.data["title"][0]),
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),

                    //Adding Space
                    new SizedBox(width: 10.0,),
                    //Text:
                    new Text(widget.snapshot.data["title"],
                      style: TextStyle(fontSize: 22.0, color: Colors.green),
                    ),
                  ],
                )
            ),
            //Just For Spacing
            new SizedBox(height: 7.0,),

            //Text For Content "Details"
            new Container(
              margin: EdgeInsets.all(1.0),
              child: new Text(widget.snapshot.data["content"],
                style: TextStyle(fontSize: 18.0,),),
            )
          ],
        ),
      ),

    );
  }
}



