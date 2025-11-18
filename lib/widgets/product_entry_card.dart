import 'package:flutter/material.dart';
import 'package:golden_goals/models/product.dart';

class ProductEntryCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductEntryCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: InkWell(
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(color: Colors.grey.shade300),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Thumbnail
                // Mengecek apakah thumbnail ada dan tidak kosong
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: (product.thumbnail != null && product.thumbnail!.isNotEmpty)
                      ? Image.network(
                          // Menggunakan proxy logic seperti kode awal kamu
                          'https://muhammad-helmi41-goldengoals.pbp.cs.ui.ac.id/proxy-image/?url=${Uri.encodeComponent(product.thumbnail!)}',
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            height: 150,
                            color: Colors.grey[300],
                            child: const Center(child: Icon(Icons.broken_image)),
                          ),
                        )
                      : Container(
                          height: 150,
                          width: double.infinity,
                          color: Colors.grey[200],
                          child: const Center(
                            child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                          ),
                        ),
                ),
                const SizedBox(height: 12),

                // 2. Name (Product Name)
                Text(
                  product.productName,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),

                // 3. Price (Ditambahkan sesuai request)
                Text(
                  'Rp ${product.price}',
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),

                // 4. Category
               Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade100,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    product.category.toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo.shade700,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // 5. Description
                Text(
                  product.description.length > 100
                      ? '${product.description.substring(0, 100)}...'
                      : product.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 8),

                // 6. Is Featured
                if (product.isFeatured)
                  const Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      SizedBox(width: 4),
                      Text(
                        'Featured Product',
                        style: TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}