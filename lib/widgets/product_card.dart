import 'package:flutter/material.dart';
import 'package:golden_goals/screens/menu.dart';
import 'package:golden_goals/screens/product_form.dart';
import 'package:golden_goals/screens/product_entry_list.dart';


class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color, // Menggunakan warna dari item
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));

          // --- LOGIKA NAVIGASI ---
          if (item.name == "Create Product") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProductFormPage()),
            );
          } 
          else if (item.name == "All Products") {
            // Ke List Page dengan filterUserProductsOnly = false (Tampilkan Semua)
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProductEntryListPage(
                  filterUserProductsOnly: false,
                ),
              ),
            );
          } 
          else if (item.name == "My Products") {
            // Ke List Page dengan filterUserProductsOnly = true (Filter User Saja)
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProductEntryListPage(
                  filterUserProductsOnly: true,
                ),
              ),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}