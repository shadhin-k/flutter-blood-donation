import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AddDonor extends StatefulWidget {
  const AddDonor({Key? key}) : super(key: key);

  @override
  State<AddDonor> createState() => _AddDonorState();
}

class _AddDonorState extends State<AddDonor> {
  final bloodgroups = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  String? selectedgroup;
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController donorName = TextEditingController();
  TextEditingController donorNumber = TextEditingController();
  void adDonor() {
    final data = {
      'name': donorName.text,
      'phone number': donorNumber.text,
      'blood group': selectedgroup
    };
    donor.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Title(
          color: Colors.white,
          child: const Text(
            'Add Donor Details',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: donorName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Donor Name', // Use labelText instead of label
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: donorNumber,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone Number', // Use labelText instead of label
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField(
                decoration: InputDecoration(label: Text('select Blood Group')),
                items: bloodgroups
                    .map((e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    selectedgroup = val.toString();
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    adDonor();
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(Size(double.infinity, 50)),
                      backgroundColor: MaterialStatePropertyAll(Colors.red)),
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
