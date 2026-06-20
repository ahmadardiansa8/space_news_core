import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfileScreen
    extends StatefulWidget {

  const EditProfileScreen({
    super.key,
  });

  @override
  State<EditProfileScreen>
      createState() =>
          _EditProfileScreenState();
}

class _EditProfileScreenState
    extends State<EditProfileScreen> {

  final nameController =
      TextEditingController();

  final instagramController =
      TextEditingController();

  Future<void> saveProfile() async {

    final uid =
        FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({

      'fullname':
          nameController.text.trim(),

      'instagram':
          instagramController.text.trim(),
    });

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:
            const Text("Edit Profile"),
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(20),

        child: Column(
          children: [

            TextField(
              controller:
                  nameController,
              decoration:
                  const InputDecoration(
                labelText:
                    "Nama Lengkap",
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller:
                  instagramController,
              decoration:
                  const InputDecoration(
                labelText:
                    "Instagram",
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: saveProfile,
              child: const Text(
                "Simpan",
              ),
            ),
          ],
        ),
      ),
    );
  }
}