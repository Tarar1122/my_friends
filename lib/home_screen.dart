import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_friends/add_friendas.dart';
import 'package:my_friends/models/friends_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Uint8List? userImage;
  XFile? tempImage;
  Box<FriendsModel>? friendsBox;
  List<FriendsModel> friendsList = [];

  @override
  void initState() {
    friendsBox = Hive.box<FriendsModel>('friends');
    //getDataFromDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Home Screen'),
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
      body: ValueListenableBuilder(
          valueListenable: friendsBox!.listenable(),
          builder: (context, _, __) {
            friendsList = friendsBox!.values.toList().cast<FriendsModel>();
            return ListView.builder(
              itemCount: friendsList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    tileColor: Colors.black26,
                    leading: CircleAvatar(
                      //radius: 40.0,
                      backgroundImage: friendsList[index].friendImage == null
                          ? const AssetImage('assets/images/dummy.png')
                          : MemoryImage(friendsList[index].friendImage!)
                              as ImageProvider,
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        deleteFriend(index);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                    title: Text(friendsList[index].name ?? 'Friend Name'),
                    subtitle: Text(friendsList[index].number ?? '00000000000'),
                  ),
                );
              },
            );
          }),
    );
  }

  Future deleteFriend(int index) async {
    friendsList.removeAt(index);
    friendsBox!.deleteAt(index);
    setState(() {});
  }

  // Future getDataFromDB() async {
  //   //final box = Hive.openBox<FriendsModel>('friends');
  //   friendsList = friendsBox!.values.toList().cast<FriendsModel>();
  //   setState(() {});
  // }
}
