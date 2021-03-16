import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'details.dart';

main() async {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Upload()));
}

class MyApp extends StatefulWidget {
  var _image;
  MyApp(this._image);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _text = '';
  // PickedFile _image;
  // final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: Text('Text'),
          actions: [
            FlatButton(
              onPressed: scanText,
              child: Text(
                'Scan',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: widget._image != null
              ? Image.file(
                  File(widget._image.path),
                  fit: BoxFit.fitWidth,
                )
              : Container(),
        ));
  }

  Future scanText() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CircularProgressIndicator(
            backgroundColor: Colors.red,
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
          );
        });
    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(File(widget._image.path));
    final TextRecognizer textRecognizer =
        FirebaseVision.instance.textRecognizer();
    final VisionText visionText =
        await textRecognizer.processImage(visionImage);

    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        _text += line.text + '\n';
      }
    }

    Navigator.of(context).pop();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Details(_text)));
  }

/*  show() {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SimpleDialogOption(
                    child: Text(
                      'Camera',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      getImage();
                    },
                  ),
                  SimpleDialogOption(
                    child: Text(
                      'Gallery',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      getGallery();
                    },
                  ),
                  SimpleDialogOption(
                    child: Text(
                      'Cancel',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              )
            ],
          );
        });
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;
      } else {
        print('No image selected Yet');
      }
    });
  }

  Future getGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;
      } else {
        print('No image selected Yet');
      }
    });
  }*/
}

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  String _text = '';
  PickedFile _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;
        setState(() {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyApp(_image)));
        });
      } else {
        print('No image selected Yet');
      }
    });
  }

  Future getGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;
        setState(() {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyApp(_image)));
        });
      } else {
        print('No image selected Yet');
      }
    });
  }

  show() {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SimpleDialogOption(
                    child: Text(
                      'Camera',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      getImage();
                    },
                  ),
                  SimpleDialogOption(
                    child: Text(
                      'Gallery',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      getGallery();
                    },
                  ),
                  SimpleDialogOption(
                    child: Text(
                      'Cancel',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Scan"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: RaisedButton(
          child: Text("Upload"),
          onPressed: () {
            show();
          },
        ),
      ),
    );
  }
}
