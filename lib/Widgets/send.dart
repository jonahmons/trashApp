import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:geolocator/geolocator.dart';

import 'camera.dart';

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

  _SendPictureState(this.imagePath, this.position);

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
            ),
            RaisedButton(
              onPressed: sendMail,
              child: const Text('Send', style: TextStyle(fontSize: 20)),
            ),
            const SizedBox(height: 30),
          ]),
        ));
  }

  sendMail() async {
    var lat = position.latitude;
    var long = position.longitude;

    var emailText = '''Sehr geehrte Damen und Herren, 
    
    wie Sie dem mitgesendeten Bild entnehmen können, haben ich leider Müll ihrers Unternehmens gefunden.
    Es wäre sehr schön wenn Sie diesen beseitigen könnten.
    
    Genaue Position Lat:$lat Long: $long
    
    Mit freundlichen Grüßen''';

    int count = 0;
    getEmail();
    final Email email = Email(
      body: emailText,
      subject: 'Unrat',
      recipients: [emailAddress],
      attachmentPaths: [this.imagePath],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);

    Navigator.of(context).popUntil((_) => count++ >= 2);
  }

  getEmail() {
    switch (this.dropdownValue) {
      case "McDonalds":
        {
          emailAddress = "jonah.mons@mons-bonn.de";
        }
        break;
      case "Burger King":
        {
          emailAddress = "BurgerKing@test.de";
        }
        break;
      case "Nordsee":
        {
          emailAddress = "Nordsee@test.de";
        }
        break;
      case "Subway":
        {
          emailAddress = "Subway@test.de";
        }
        break;
      case "Pizza Hut":
        {
          emailAddress = "PizzaHut@test.de";
        }
        break;
      case "Kentucky Fried Chicken":
        {
          emailAddress = "Kentucky Fried Chicken";
        }
        break;
      default:
        {
          print("Invalid choice");
        }
        break;
    }
  }

  void makeRoutePage({BuildContext context, Widget pageRef}) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => pageRef),
        (Route<dynamic> route) => false);
  }
}
