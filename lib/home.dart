import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');

  void deleteDonor(docId) {
    donor.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
                color: Colors.blue,
                onPressed: () {
                  Navigator.pushNamed(context, '/add');
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30,
                ))
          ],
          backgroundColor: Colors.red,
          title: Title(
              color: Colors.white,
              child: const Text(
                'Blood Donation App',
                style: TextStyle(color: Colors.white),
              ))),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: StreamBuilder(
          stream: donor.orderBy('name').snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot donorSnap = snapshot.data.docs[index];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromARGB(255, 210, 202, 202),
                                blurRadius: 10,
                                spreadRadius: 15)
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 30,
                              child: Text(
                                donorSnap['blood group'],
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                donorSnap['name'],
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                donorSnap['phone number'].toString(),
                                style: const TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/update',
                                        arguments: {
                                          'name': donorSnap['name'],
                                          'phone number':
                                              donorSnap['phone number']
                                                  .toString(),
                                          'blood group':
                                              donorSnap['blood group'],
                                          'id': donorSnap.id
                                        });
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    deleteDonor(donorSnap.id);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return Container();
          }),
    );
  }
}
