import 'package:flutter/material.dart';
import 'package:myportfolio_mobile/menu.dart';
import 'package:myportfolio_mobile/projects_page.dart';

class LeftDrawer extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(),
      width: 230,
      backgroundColor: Theme.of(context).colorScheme.surface,

      child: ListView(
        children: [
           Container(
            padding: EdgeInsets.only(bottom: 20),
            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Leficullen ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Theme.of(context).colorScheme.primary)),
                SizedBox(height: 10,),
                Text("Explore My Portfolio", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Theme.of(context).colorScheme.primary)),
              ],
            )
                //header
          ),
          Divider(thickness: 1, color: Colors.black26),
          //routing
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home", style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.folder_copy),
            title: Text("Projects", style: TextStyle(fontWeight: FontWeight.bold)),
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
