import 'package:flutter/material.dart';
import 'package:golden_goals/screens/menu.dart';
import 'package:golden_goals/screens/product_form.dart';
import 'package:golden_goals/screens/product_entry_list.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:golden_goals/screens/login.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    
    return Drawer(
      // 1. Ganti ListView utama menjadi Column
      child: Column(
        children: [
          // 2. Bungkus ListView menu atas dengan Expanded
          // Ini akan memaksa list ini mengambil semua ruang kosong yang tersedia
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero, // Penting agar header menyentuh ujung atas (status bar)
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 25, 48, 150),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '✨ Golden Goals',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 255, 219, 16),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Text(
                        "All of your football utensils needed!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.home_outlined),
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyHomePage(),
                        ));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.post_add),
                  title: const Text('Create Product'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProductFormPage(),
                        ));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.add_reaction_rounded),
                  title: const Text('Product List'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProductEntryListPage()),
                    );
                  },
                ),
              ],
            ),
          ),
          
          // 3. Bagian Bawah (Logout) ditaruh di luar Expanded
          // Tambahkan Divider biar ada garis pemisah (opsional)
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              final response = await request.logout(
                  "http://localhost:8000/auth/logout/"); // Sesuaikan URL
              
              String message = response["message"];

              if (context.mounted) {
                if (response['status']) {
                  String uname = response["username"];
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("$message Sampai jumpa, $uname."),
                  ));
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                    ),
                  );
                }
              }
            },
          ),
          // Menambahkan jarak sedikit dari bawah layar (opsional)
          const SizedBox(height: 16), 
        ],
      ),
    );
  }
}