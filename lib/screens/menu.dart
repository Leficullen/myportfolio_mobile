import 'package:flutter/material.dart';
import 'package:myportfolio_mobile/projects_page.dart';
import 'package:myportfolio_mobile/screens/experience_form.dart';
import 'package:myportfolio_mobile/screens/project_form.dart';
import 'package:myportfolio_mobile/widgets/project_card.dart';
import 'package:myportfolio_mobile/widgets/left_drawer.dart';
import 'package:myportfolio_mobile/services/auth_state.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final String name = "Lefi";
  final String npm = "2506550721";
  final String kelas = "PBP F";

  final List<ItemHomePage> projectItems = [
    ItemHomePage(
      "Lihat Proyek",
      Icons.folder_copy_sharp,
      Colors.red,
      page: const ProjectsPage(),
    ),
    ItemHomePage(
      "Tambah Proyek",
      Icons.add_circle,
      Colors.blue,
      page: const ProjectFormPage(),
    ),
  ];

  final List<ItemHomePage> experienceItems = [
    ItemHomePage("Lihat Experience", Icons.cases_rounded, Colors.green),
    ItemHomePage(
      "Tambah Experience",
      Icons.add_circle,
      Colors.amber,
      page: const ExperienceFormPage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MyPortfolio",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: const LeftDrawer(),
      backgroundColor: Theme.of(context).colorScheme.primary,

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,

                    child: ElevatedButton(
                      onPressed: context.watch<AuthState>().isLoggedIn
                          ? () async {
                              var failed = false;
                              try {
                                await context.read<AuthState>().logout();
                              } catch (_) {
                                failed = true;
                              }
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      failed
                                          ? 'Logged out locally; server logout failed.'
                                          : 'Logged out.',
                                    ),
                                  ),
                                );
                              }
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        elevation: 4,
                        padding: EdgeInsets.symmetric(
                          horizontal: 3,
                          vertical: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Logout",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: InfoCard(title: "Name", content: name),
                    ),
                    Expanded(
                      child: InfoCard(title: "NPM", content: npm),
                    ),
                    Expanded(
                      child: InfoCard(title: "Class", content: kelas),
                    ),
                  ],
                ),
              ),
            ),

            Center(
              child: Column(
                children: [
                  // const Padding(
                  //   padding: EdgeInsets.only(top: 16),
                  //   child: Text(
                  //     "Selamat datang di myportfolio mobile",
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 18,
                  //       color: Colors.white,
                  //     ),
                  //   ),
                  // ),

                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: EdgeInsets.all(2),
                            child: const Text(
                              "Projects Section: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        child: GridView.count(
                          primary: true,
                          childAspectRatio: 16 / 9,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          children: projectItems.map((ItemHomePage item) {
                            return ItemCard(item);
                          }).toList(),
                        ),
                      ),
                    ],
                  ),

                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: EdgeInsets.all(2),
                            child: const Text(
                              "Experince Section",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),

                        child: GridView.count(
                          primary: true,
                          childAspectRatio: 16 / 9,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          children: experienceItems.map((ItemHomePage item) {
                            return ItemCard(item);
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Container(
        width: MediaQuery.of(context).size.width / 3.5,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            Text(content),
          ],
        ),
      ),
    );
  }
}

class ItemHomePage {
  final String name;
  final IconData icon;
  final Color color;
  final Widget? page;

  ItemHomePage(this.name, this.icon, this.color, {this.page});
}
