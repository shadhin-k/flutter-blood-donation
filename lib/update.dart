import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class updateDonor extends StatefulWidget {
  const updateDonor({Key? key}) : super(key: key);

  @override
  State<updateDonor> createState() => _updateDonorState();
}

class _updateDonorState extends State<updateDonor> {
  final bloodgroups = ['A+', 'A-', 'B+', 'B-', 'o+', 'o-', 'AB+', 'AB-'];
  String? selectedgroup;
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');

  TextEditingController donorName = TextEditingController();
  TextEditingController donorNumber = TextEditingController();

  void updateDonors(docId) {
    final data = {
      'name': donorName.text,
      'phone number': donorNumber.text,
      'blood group': selectedgroup,
    };
    donor.doc(docId).update(data).then((value) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    donorName.text = args['name'];
    donorNumber.text = args['phone number'];
    selectedgroup = args['blood group'];
    final docId = args['id'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Title(
          color: Colors.white,
          child: const Text(
            'Update Donor Details',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: donorName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Donor Name', // Use labelText instead of label
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: donorNumber,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone Number', // Use labelText instead of label
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField(
                value: selectedgroup,
                decoration:
                    const InputDecoration(label: Text('select Blood Group')),
                items: bloodgroups
                    .map((e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ))
                    .toList(),
                onChanged: (val) {
                  selectedgroup = val as String?;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    updateDonors(docId);
                  },
                  style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(Size(double.infinity, 50)),
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.red)),
                  child: const Text(
                    'Update',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
