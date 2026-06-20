import 'package:flutter/material.dart';
import 'package:spacenews_core/screens/auth_service.dart';

import '../models/article_model.dart';
import '../services/api_service.dart';
import '../services/session_service.dart';
import '../services/favorite_service.dart';

import 'detail_screen.dart';
import 'login_screen.dart';
import 'favorite_screen.dart';
import 'notification_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {

  int currentIndex = 0;

  List<Article> articles = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadNews();
  }

  Future<void> loadNews() async {

    try {

      print(
        "Mulai mengambil berita...",
      );

      articles =
          await ApiService().getNews();

      print(
        "JUMLAH ARTIKEL: ${articles.length}",
      );

      if (articles.isNotEmpty) {

        print(
          "ARTIKEL PERTAMA: ${articles.first.title}",
        );
      }

    } catch (e) {

      print(
        "LOAD NEWS ERROR: $e",
      );

    } finally {

      if (mounted) {

        setState(() {
          loading = false;
        });
      }
    }
  }

  Future<void> logout() async {

    await AuthService().logout();

    await SessionService.logout();

    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const LoginScreen(),
      ),
      (route) => false,
    );
  }

  Widget homePage() {

    if (loading) {

      return const Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [

            CircularProgressIndicator(),

            SizedBox(height: 20),

            Text(
              "Memuat berita...",
            ),
          ],
        ),
      );
    }

    if (articles.isEmpty) {

      return const Center(
        child: Text(
          "Berita tidak ditemukan",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      );
    }

    return RefreshIndicator(

      onRefresh: loadNews,

      child: ListView.builder(

        itemCount: articles.length,

        itemBuilder:
            (context, index) {

          final article =
              articles[index];

          return Card(

            margin:
                const EdgeInsets.all(10),

            child: ListTile(

              leading: SizedBox(
                width: 80,

                child: Image.network(
                  article.imageUrl,
                  fit: BoxFit.cover,

                  errorBuilder:
                      (
                        context,
                        error,
                        stackTrace,
                      ) {

                    return const Icon(
                      Icons.image,
                      size: 50,
                    );
                  },
                ),
              ),

              title: Text(
                article.title,
                maxLines: 2,
                overflow:
                    TextOverflow
                        .ellipsis,
              ),

              subtitle:
                  Text(article.newsSite),

              trailing:
                  IconButton(

                icon: const Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),

                onPressed:
                    () async {

                  await FavoriteService()
                      .addFavorite(
                    article,
                  );

                  if (!mounted)
                    return;

                  ScaffoldMessenger
                          .of(
                        context,
                      )
                      .showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Berhasil ditambahkan ke Favorite",
                      ),
                    ),
                  );
                },
              ),

              onTap: () {

                Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (_) =>
                        DetailScreen(
                      article:
                          article,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(
      BuildContext context) {

    final pages = [

      homePage(),

      const FavoriteScreen(),

      const NotificationScreen(),

      const ProfileScreen(),
    ];

    return Scaffold(

      appBar: AppBar(

        centerTitle: true,

        title: const Text(
          "🚀 SpaceNews Core",
        ),

        actions: [

          IconButton(
            onPressed: logout,

            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),

      body: pages[currentIndex],

      bottomNavigationBar:
          NavigationBar(

        selectedIndex:
            currentIndex,

        onDestinationSelected:
            (value) {

          setState(() {
            currentIndex =
                value;
          });
        },

        destinations: const [

          NavigationDestination(
            icon: Icon(
              Icons.home,
            ),
            label: "Home",
          ),

          NavigationDestination(
            icon: Icon(
              Icons.favorite,
            ),
            label: "Favorite",
          ),

          NavigationDestination(
            icon: Icon(
              Icons.notifications,
            ),
            label: "Notif",
          ),

          NavigationDestination(
            icon: Icon(
              Icons.person,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}