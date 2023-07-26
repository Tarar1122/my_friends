import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_friends/add_friendas.dart';

class FirstPage extends StatefulWidget {
  FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final addNameController = TextEditingController();
  final addNumberController = TextEditingController();
  final addDesController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  Uint8List? userImage;
  XFile? tempImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Notes'),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      showSheet();
                    },
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: userImage == null
                          ? AssetImage('assets/images/dummy.png')
                          : MemoryImage(userImage!) as ImageProvider,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: addNameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'bhai jan ke krda pe o kucj likho anda wich';
                      }
                    },
                    decoration: InputDecoration(
                        hintText: 'Add Name', border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: addNumberController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'bhai jan ke krda pe o kucj likho anda wich';
                      }
                    },
                    decoration: InputDecoration(
                        hintText: ' Add Number', border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: addDesController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'bhai jan ke krda pe o kucj likho anda wich';
                      }
                    },
                    maxLines: 12,
                    decoration: InputDecoration(
                        hintText: 'Add Description',
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(14)),
                    height: 45,
                    width: 120,
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          if (_formkey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('saved succesfuly'),
                              ),
                            );
                          }
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showSheet() async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height / 3.5,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Pic Image From',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      pickUserImage(ImageSource.gallery).then((value) {
                        Navigator.pop(context);
                      });
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/gallery.png',
                          height: 60,
                          width: 60,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text('Gallery'),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  InkWell(
                    onTap: () {
                      pickUserImage(ImageSource.camera).then((value) {
                        Navigator.pop(context);
                      });
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/camera.png',
                          height: 60,
                          width: 60,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Camera',
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> pickUserImage(ImageSource source) async {
    XFile? FileImage = await ImagePicker().pickImage(source: source);
    if (FileImage != null) {
      tempImage = FileImage;
      userImage = await tempImage!.readAsBytes();
      setState(() {});
    } else {
      return;
    }
  }
}
