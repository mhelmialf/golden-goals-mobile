import 'package:flutter/material.dart';
import 'package:golden_goals/widgets/left_drawer.dart';

class ProductFormPage extends StatefulWidget {
    const ProductFormPage({super.key});

    @override
    State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
    final _formKey = GlobalKey<FormState>();
    String _name = "";
    int _price = 0;
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
                    title: const Text("Mark as new arrival product"),
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Product saved successfully!'),
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                        Text('Name: $_name'),
                                        Text('Price: $_price'),
                                        Text('Category: $_category'),
                                        Text('Description: $_description'),
                                        Text('Thumbnail: $_thumbnail'),
                                        Text('New Arrival: ${_isFeatured ? "Yes" : "No"}'),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                       setState(() {
                                          _name = "";
                                          _price = 0;
                                          _description = "";
                                          _category = "";
                                          _thumbnail = "";
                                          _isFeatured = false;
                                        });
                                      _formKey.currentState!.reset();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
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
