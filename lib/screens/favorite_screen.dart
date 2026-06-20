import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final uid =
        FirebaseAuth.instance.currentUser!.uid;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('favorites')
          .where('uid', isEqualTo: uid)
          .snapshots(),

      builder: (context, snapshot) {

        if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData ||
            snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(
              "Belum ada favorite",
            ),
          );
        }

        final docs = snapshot.data!.docs;

        return ListView.builder(
          itemCount: docs.length,

          itemBuilder: (context, index) {

            final data =
                docs[index].data()
                    as Map<String, dynamic>;

            return Card(
              margin:
                  const EdgeInsets.all(10),

              child: ListTile(
                leading: Image.network(
                  data["imageUrl"],
                  width: 70,
                  fit: BoxFit.cover,
                ),

                title: Text(
                  data["title"],
                  maxLines: 2,
                  overflow:
                      TextOverflow.ellipsis,
                ),

                subtitle:
                    Text(data["newsSite"]),

                trailing: IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () async {

                    await FirebaseFirestore
                        .instance
                        .collection(
                            'favorites')
                        .doc(docs[index].id)
                        .delete();
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}