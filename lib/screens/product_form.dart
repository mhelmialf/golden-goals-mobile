import 'package:flutter/material.dart';
import 'package:golden_goals/widgets/left_drawer.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:golden_goals/screens/menu.dart';
import 'package:golden_goals/models/user_session.dart';

class ProductFormPage extends StatefulWidget {
    const ProductFormPage({super.key});

    @override
    State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
    final _formKey = GlobalKey<FormState>();
    String _name = "";
    int _price = 0;
    int _stock = 0;
    String _description = "";
    String _category = "Apparel & Jerseys"; //default
    String _thumbnail = "";
    bool _isFeatured = false; // default

    final List<String> _categories = [
    'Apparel & Jerseys',
    'Footwear & Boots',
    'Training Equipment',
    'Accessories & Bags',
    'Fan Merchandise',
    'Kids & Youth',
    'Care & Maintenance'
    ];

    @override
    Widget build(BuildContext context) {
        final request = context.watch<CookieRequest>();
        return Scaffold(
          appBar: AppBar(
            title: const Center(
              child: Text(
                'Create Product Form',
              ),
            ),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          drawer: LeftDrawer(),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                // === Name ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Product Name",
                      labelText: "Product Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _name = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Product name can't be empty!";
                      }
                      if (value.length < 3) {
                        return "Product name must be at least 3 characters!";
                      }
                      if (value.length > 50) {
                        return "Product name must be less than 50 characters!";
                      }
                      return null;
                    },
                  ),
                ),
                // === Price ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Product Price",
                      labelText: "Product Price",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (String? value) {
                      setState(() {
                        _price = int.tryParse(value ?? '0') ?? 0;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Price can't be empty!";
                      }
                      final parsed = int.tryParse(value);
                      if (parsed == null) {
                        return "Price must be a valid number!";
                      }
                      if (parsed < 0) {
                        return "Price can't be negative!";
                      }
                      if (parsed == 0) {
                        return "Price can't be zero!";
                      }
                      return null;
                    },
                  ),
                ),

                // === Stock ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Product Stock",
                      labelText: "Product Stock",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (String? value) {
                      setState(() {
                        _stock = int.tryParse(value ?? '0') ?? 0;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Stock can't be empty!";
                      }
                      final parsed = int.tryParse(value);
                      if (parsed == null) {
                        return "Stock must be a valid number!";
                      }
                      if (parsed < 0) {
                        return "Stock can't be negative!";
                      }
                      return null;
                    },
                  ),
                ),

                // === Description ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Product Description",
                      labelText: "Product Description",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _description = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Description can't be empty!";
                      }
                      if (value.length < 10) {
                        return "Description must be at least 10 characters!";
                      }
                      if (value.length > 200) {
                        return "Description can't exceed 200 characters!";
                      }
                      return null;
                    },
                  ),
                ),

                // === Category ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: "Product Category",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    value: _category,
                    items: _categories
                        .map((cat) => DropdownMenuItem(
                              value: cat,
                              child: Text(
                                  cat[0].toUpperCase() + cat.substring(1)),
                            ))
                        .toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _category = newValue!;
                      });
                    },
                    validator: (value) =>
                    value == null || value.isEmpty ? "Please select a category!" : null,
                  ),
                ),

                // === Thumbnail URL ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "URL Thumbnail",
                      labelText: "URL Thumbnail",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _thumbnail = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "URL Thumbnail can't be empty!";
                      }
                      final urlPattern = RegExp(r'^(https?:\/\/)([\w\-]+\.)+[a-zA-Z]{2,}(\/\S*)?$');
                      if (!urlPattern.hasMatch(value)) {
                        return "Please enter a valid URL!";
                      }
                      return null;
                    },
                  ),
                ),

                // === Is Featured ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SwitchListTile(
                    title: const Text("Mark as featured product"),
                    value: _isFeatured,
                    onChanged: (bool value) {
                      setState(() {
                        _isFeatured = value;
                      });
                    },
                  ),
                ),
                // === Tombol Simpan ===
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.indigo),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          
                          // TODO: Replace the URL with your app's URL
                          // To connect Android emulator with Django on localhost, use URL http://10.0.2.2/
                          // If you using chrome,  use URL http://localhost:8000
                          final response = await request.postJson(
                            "https://muhammad-helmi41-goldengoals.pbp.cs.ui.ac.id/create-flutter/", 
                            jsonEncode({
                              "product_name": _name, 
                              "price": _price, 
                              "stock": _stock,
                              "description": _description,
                              "category": _category,
                              "thumbnail": _thumbnail, 
                              "is_featured": _isFeatured,
                              "username": UserSession.username,
                            }),
                          );

                          if (context.mounted) {
                            if (response['status'] == 'success') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Product successfully saved!"),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => MyHomePage()),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Something went wrong, please try again."),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        }
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      );
    }
}
