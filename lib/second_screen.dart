import 'package:flutter/material.dart';
import 'package:my_friends/add_friendas.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage('assets/images/dummy.png'),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Add Name', border: OutlineInputBorder()),
                ),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: ' Add Number', border: OutlineInputBorder()),
                ),
                TextFormField(
                  maxLines: 12,
                  decoration: InputDecoration(hintText: 'Add Description'),
                ),
                Container(
                  height: 50,
                  width: 150,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
