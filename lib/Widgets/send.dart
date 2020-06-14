import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:geolocator/geolocator.dart';
import 'package:trashapp/Widgets/start.dart';
import 'package:trashapp/helper/contacts.dart';

class SendPicture extends StatefulWidget {
  String imagePath;
  Position position;

  SendPicture(this.imagePath, this.position);

  @override
  _SendPictureState createState() =>
      _SendPictureState(this.imagePath, this.position);
}

class _SendPictureState extends State<SendPicture> {
  Position position;
  String imagePath;
  String emailAddress;
  String dropdownValue = 'McDonalds';

  _SendPictureState(this.imagePath, Position position) {
    if (position == null) {
      position = new Position(
        latitude: 200,
        longitude: 200,
      );
    } else {
      this.position = position;
    }
    print(position);
    //if (position)position.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Send the picture')),
        body: Center(
          child: Container(
              child: Column(children: <Widget>[
            SizedBox(height: 10),
            Text(
              "Wer ist der Verursacher?",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 30),
            DropdownButton<String>(
              value: dropdownValue,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.white),
              underline: Container(
                height: 2,
                color: Colors.white,
              ),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
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
            ),
            SizedBox(height: 10),
            RaisedButton(
              onPressed: sendMail,
              child: const Text('Send', style: TextStyle(fontSize: 20)),
            ),
            const SizedBox(height: 30),
          ])),
        ));
  }

  sendMail() async {
    var lat = position.latitude;
    var long = position.longitude;

    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Start(),
          ),
        );
      },
    );
    var emailText = '''Sehr geehrte Damen und Herren, 
    
    wie Sie dem mitgesendeten Bild entnehmen können, haben ich leider Müll ihrers Unternehmens gefunden.
    Es wäre sehr schön wenn Sie diesen beseitigen könnten.
    
    Genaue Fundstelle:
    Lat:$lat Long: $long
    
    Mit freundlichen Grüßen''';

    int count = 0;
    emailAddress = contacts[this.dropdownValue];
    final Email email = Email(
      body: emailText,
      subject: 'Unrat',
      recipients: [emailAddress],
      attachmentPaths: [this.imagePath],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
    await showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
            title: Text("Trash reported"),
            content: Text("Thanks for report"),
            actions: [
              okButton,
            ],
          );
        });

    //Navigator.of(context).popUntil((_) => count++ >= 2);
  }
}
