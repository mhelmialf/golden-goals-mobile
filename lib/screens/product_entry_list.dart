import 'package:flutter/material.dart';
import 'package:golden_goals/models/product.dart';
import 'package:golden_goals/models/user_session.dart';
import 'package:golden_goals/widgets/left_drawer.dart';
import 'package:golden_goals/screens/product_detail.dart';
import 'package:golden_goals/widgets/product_entry_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ProductEntryListPage extends StatefulWidget {
 final bool filterUserProductsOnly;
 const ProductEntryListPage({super.key, this.filterUserProductsOnly = false,});

  @override
  State<ProductEntryListPage> createState() => _ProductEntryListPageState();
}

class _ProductEntryListPageState extends State<ProductEntryListPage> {
  late bool _showAllProducts = !widget.filterUserProductsOnly;

  Future<List<Product>> fetchProduct(CookieRequest request) async {
    final response = await request.get('https://muhammad-helmi41-goldengoals.pbp.cs.ui.ac.id/json/');
    var data = response;
    List<Product> listProduct = [];
    for (var d in data) {
      if (d != null) {
        listProduct.add(Product.fromJson(d));
      }
    }
    return listProduct;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Tombol All Products
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _showAllProducts = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _showAllProducts ? Colors.blue : Colors.grey[300],
                    foregroundColor: _showAllProducts ? Colors.white : Colors.black87,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      )
                    ),
                  ),
                  child: const Text("All Products"),
                ),
                // Tombol My Products
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _showAllProducts = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: !_showAllProducts ? Colors.blue : Colors.grey[300],
                    foregroundColor: !_showAllProducts ? Colors.white : Colors.black87,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      )
                    ),
                  ),
                  child: const Text("My Products"),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: fetchProduct(request),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  if (!snapshot.hasData) {
                    return const Column(
                      children: [
                        Text(
                          'There are no product in golden goals yet.',
                          style: TextStyle(fontSize: 20, color: Color(0xff59A5D8)),
                        ),
                        SizedBox(height: 8),
                      ],
                    );
                  } else {
                    List<Product> allProducts = snapshot.data!;
                    List<Product> displayedProducts;

                    if (_showAllProducts) {
                      displayedProducts = allProducts;
                    } else {
                      displayedProducts = allProducts
                          .where((product) => product.username == UserSession.username)
                          .toList();
                    }

                    if (displayedProducts.isEmpty) {
                      return Center(
                        child: Text(
                          _showAllProducts 
                            ? "Produk kosong" 
                            : "Kamu belum punya produk",
                          style: const TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: displayedProducts.length,
                      itemBuilder: (_, index) => ProductEntryCard(
                        product: displayedProducts[index],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailPage(
                                product: displayedProducts[index],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}