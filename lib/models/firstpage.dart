import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_resep/boxes.dart';
import "package:flutter/material.dart";
import 'package:hive/hive.dart';
import 'package:project_resep/models/home.dart';
import 'package:project_resep/register_page.dart';

import 'fav.dart';

class Firstpage extends StatefulWidget {
  Firstpage({Key? key}) : super(key: key);

  @override
  _FirstpageState createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  @override
  void dispose() {
    Hive.box('fav').close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown.shade600,
        title: const Text('Recipe App'),
        actions: <Widget>[
          ElevatedButton(
            child: Text("Logout"),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/LoginPage');
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'lib/models/images/263d53ed14ea33255b11d342a25c20d4.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Container(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 6),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                "FAVORITE RECIPES",
                textAlign: TextAlign.center,
                style: TextStyle(
                    backgroundColor: Colors.black,
                    fontFamily: "Pacifico",
                    color: Colors.grey.shade300,
                    fontWeight: FontWeight.w200,
                    fontSize: 38),
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: ValueListenableBuilder<Box<Fav>>(
              valueListenable: Boxes.getTransactions().listenable(),
              builder: (context, box, _) {
                final items = box.values.toList().cast<Fav>();
                if (items.isEmpty) {
                  return const Center(
                    child: Text(
                      'NO FAVORITE RECIPES',
                      style: TextStyle(
                          fontFamily: "Pacifico",
                          color: Colors.grey,
                          fontWeight: FontWeight.w200,
                          fontSize: 38),
                    ),
                  );
                } else {
                  return Center(
                    child: ListView.builder(
                      itemCount: box.values.length,
                      itemBuilder: (BuildContext context, int index) {
                        Fav? res = box.getAt(index);
                        return Dismissible(
                          background: Container(
                            color: Colors.white,
                          ),
                          key: UniqueKey(),
                          onDismissed: (direction) {
                            res!.delete();
                          },
                          child: Card(
                            child: ListTile(
                              title: Text(
                                res!.name,
                                style: TextStyle(
                                    fontFamily: "Pacifico",
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w200,
                                    fontSize: 38),
                              ),
                              leading: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: 44,
                                  minHeight: 44,
                                  maxWidth: 64,
                                  maxHeight: 64,
                                ),
                                child: Image.network(res.image.toString()),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
