import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';


class ImageInput extends StatefulWidget {
 final Function onSelectImage;
 ImageInput(this.onSelectImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}


class _ImageInputState extends State<ImageInput> {
  File? storedImage;

  Future<void> takePicture() async {
  final picker = ImagePicker();
  final imageFile = await picker.pickImage(source: ImageSource.camera,maxWidth: 600);
  if(imageFile == null) return;

  setState(() {
    storedImage = File(imageFile.path);
  });
  Directory appDir = await getApplicationDocumentsDirectory();
  final fileName = basename(imageFile.path);
  await imageFile.saveTo("${appDir.path}/$fileName");
  widget.onSelectImage(storedImage);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
          width: 150,
            height: 150,
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: storedImage != null ? Image.file(storedImage!,width: double.infinity, fit: BoxFit.cover,) : Text("Image Preview",textAlign: TextAlign.center,),
          ),
          SizedBox(width: 10,),
          FlatButton.icon(onPressed: () => takePicture(),textColor: Theme.of(context).primaryColor, icon: Icon(Icons.camera), label: Text("Take a picture")),
        ],
      ),
    );
  }
}
