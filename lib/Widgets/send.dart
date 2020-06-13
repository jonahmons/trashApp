import 'package:flutter/material.dart';

class SendPicture extends StatefulWidget {
  String imagePath;

  SendPicture(this.imagePath);

  @override
  _SendPictureState createState() => _SendPictureState(this.imagePath);
}

class _SendPictureState extends State<SendPicture> {
  String imagePath;
  String dropdownValue = 'McDonalds';

  _SendPictureState(this.imagePath);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Send the picture')),
      body: Container(
        child: Column(children: <Widget>[
          Text("Bild: " + imagePath),
          Text("Wer ist der Verursacher?"),
          DropdownButton<String>(
            value: dropdownValue,
            icon: Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String newValue) {
              setState(() {
                dropdownValue = newValue;
              });
            },
            // 'McDonalds', 'Burger King', 'Nordsee', 'Subway','Pizza Hut', 'Kentucky Fried Chicken'
            items: <String>[
              'McDonalds',
              'Burger King',
              'Nordsee',
              'Subway',
              'Pizza Hut',
              'Kentucky Fried Chicken'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.send),
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SendPicture(this.imagePath),
              ),
            );
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
      ),
    );
  }
}
