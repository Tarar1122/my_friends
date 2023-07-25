import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddFriends extends StatefulWidget {
  const AddFriends({super.key});

  @override
  State<AddFriends> createState() => _AddFriendsState();
}

class _AddFriendsState extends State<AddFriends> {
  final addNumberController = TextEditingController();
  final addNameController = TextEditingController();
  final addDescriptonController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 154, 49, 49),
        title: const Text('Add Friend'),
        centerTitle: true,
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
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    onTap: () {
                      showSheet();
                    },
                    child: const CircleAvatar(
                      backgroundImage: AssetImage('assets/images/dummy.png'),
                      radius: 80,
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'Add Name', border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'Add Number', border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    controller: addDescriptonController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'bhai is main description likh lo';
                      }
                    },
                    maxLines: 12,
                    decoration: const InputDecoration(
                        hintText: 'Add Description',
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    height: 50.0,
                    width: 150.0,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        if (_formkey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('saved succesfully'),
                            ),
                          );
                        }
                      },
                      child: const Center(
                          child: Text(
                        'SAVE',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
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
                  height: 15.0,
                ),
                Text(
                  'PIC IMAGE FROM',
                  style: TextStyle(
                      color: Colors.amber,
                      fontSize: 19,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        ImagePicker().pickImage(source: ImageSource.gallery);
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/gallery.png',
                            height: 60.0,
                            width: 60.0,
                          ),
                          Text(
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
                        ImagePicker().pickImage(source: ImageSource.camera);
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/camera.png',
                            height: 60.0,
                            width: 60.0,
                          ),
                          Text(
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
}
