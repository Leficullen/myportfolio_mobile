import 'package:flutter/material.dart';
import 'package:myportfolio_mobile/menu.dart';
import 'package:myportfolio_mobile/projects_page.dart';

class LeftDrawer extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Leficullen ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white)),
                SizedBox(height: 10,),
                Text("Explore My Portfolio", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white)),
              ],
            )
                //header
          ),
          //routing
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.folder_copy),
            title: Text("Projects"),
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProjectsPage()),
            ),
          ),
        ],
      ),
    );
  }
}
