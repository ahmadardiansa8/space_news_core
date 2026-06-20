import 'package:flutter/material.dart';

class NotificationScreen
    extends StatelessWidget {

  const NotificationScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return ListView(
      children: const [

        ListTile(
          leading:
              Icon(Icons.notifications),
          title: Text(
            "Welcome to SpaceNews Core",
          ),
        ),

        ListTile(
          leading:
              Icon(Icons.rocket_launch),
          title: Text(
            "Latest space news available",
          ),
        ),

        ListTile(
          leading:
              Icon(Icons.favorite),
          title: Text(
            "Check your favorite articles",
          ),
        ),
      ],
    );
  }
}