import 'package:flutter/material.dart';
import 'package:sandbox_route_navigation_maps/add_route_maps.dart';
import 'package:sandbox_route_navigation_maps/add_route_maps2.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page - Build 1'),
        backgroundColor: Colors.grey,
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddRouteMaps2(),
              ),
            ),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
