import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_friends/about.dart';
import 'package:my_friends/add_frind2.dart';
import 'package:my_friends/contact.dart';
import 'package:my_friends/models/friends_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final addNameController = TextEditingController();
  final addNumberController = TextEditingController();
  final desController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  Uint8List? userImage;
  XFile? tempImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 243, 3, 3),
        title: const Text(
          'Add Friends',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddFriends(),
            ),
          );
        },
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
          ),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40.0,
                ),
                InkWell(
                  onTap: () {
                    showSheet();
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: userImage == null
                        ? const AssetImage('assets/images/dummy.png')
                        : MemoryImage(userImage!) as ImageProvider,
                    radius: 60.0,
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                TextFormField(
                  controller: addNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'bhai is main name likh lo';
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'Add Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  controller: addNumberController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'bhai is main number likh lo';
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'Add Number',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  controller: desController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'bhai is main description likh lo';
                    }
                  },
                  maxLines: 12,
                  decoration: const InputDecoration(
                    hintText: 'Add Description',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Container(
                  height: 50.0,
                  width: 150.0,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(
                      15.0,
                    ),
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        if (_formkey.currentState!.validate()) {
                          saveFriendToDB().then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('apka freind save ho gya ha'),
                              ),
                            );
                          });
                        }
                      },
                      child: const Text(
                        'save',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                )
              ],
            ),
          ),
        )),
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/00.png'),
                ),
              ),
              child: Text(
                'Friends',
                style:
                    TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                );
              },
              child: const ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const About(),
                  ),
                );
              },
              child: const ListTile(
                leading: Icon(Icons.person),
                title: Text('About'),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Contact(),
                    ));
              },
              child: const ListTile(
                leading: Icon(Icons.contact_support),
                title: Text(
                  'Contact us',
                  style: TextStyle(),
                ),
              ),
            ),
          ],
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
                const SizedBox(
                  height: 15.0,
                ),
                const Text(
                  'Pick Image From',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 40.0,
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
                            height: 60.0,
                            width: 60.0,
                          ),
                          const Text(
                            'Gallery',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 50.0,
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
                            height: 60.0,
                            width: 60.0,
                          ),
                          const Text(
                            'Camera',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  Future<void> pickUserImage(ImageSource source) async {
    XFile? fileImage = await ImagePicker().pickImage(source: source);

    if (fileImage != null) {
      tempImage = fileImage;
      userImage = await tempImage!.readAsBytes();
      setState(() {});
    } else {
      return;
    }
  }

  Future saveFriendToDB() async {
    var friendsBox = Hive.box<FriendsModel>('friends');
    FriendsModel friendsModel = FriendsModel(
      userImage,
      addNameController.text,
      addNumberController.text,
      desController.text,
    );

    friendsBox.add(friendsModel).then((value) {
      userImage == null;
      addNameController.clear();
      addNumberController.clear();
      desController.clear();

      setState(() {});
    });
  }
}
