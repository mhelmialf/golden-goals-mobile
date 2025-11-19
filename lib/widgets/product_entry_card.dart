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

  // Warna Utama yang diminta
  final Color primaryColor = const Color.fromARGB(255, 25, 48, 150); // Biru Tua
  final Color accentColor = const Color.fromARGB(255, 255, 219, 16); // Kuning Terang

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: InkWell(
        onTap: onTap,
        child: Card(
          // 1. Latar Belakang Card: Biru Tua
          color: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            // Border dibuat warna aksen yang lebih soft
            side: BorderSide(color: accentColor.withOpacity(0.5)),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Thumbnail
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: (product.thumbnail != null && product.thumbnail!.isNotEmpty)
                      ? Image.network(
                          'https://muhammad-helmi41-goldengoals.pbp.cs.ui.ac.id/proxy-image/?url=${Uri.encodeComponent(product.thumbnail!)}',
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            height: 150,
                            // Placeholder kontras
                            color: primaryColor.withOpacity(0.8),
                            child: Center(child: Icon(Icons.broken_image, color: accentColor)),
                          ),
                        )
                      : Container(
                          height: 150,
                          width: double.infinity,
                          // Placeholder kontras
                          color: primaryColor.withOpacity(0.8),
                          child: Center(
                            child: Icon(Icons.image_not_supported, size: 50, color: accentColor.withOpacity(0.7)),
                          ),
                        ),
                ),
                const SizedBox(height: 12),

                // 2. Name (Product Name)
                Text(
                  product.productName,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: accentColor, // Kuning Terang untuk judul
                  ),
                ),
                const SizedBox(height: 4),

                // 3. Price (Harga)
                Text(
                  'Rp ${product.price}',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white, // Putih untuk harga agar kontras tapi tidak terlalu menonjol
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),

                // 4. Category
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    // Latar belakang tag menggunakan warna aksen Kuning
                    color: accentColor,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    product.category.toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      // Teks tag menggunakan warna primer (Biru Tua) agar kontras dari Kuning
                      color: primaryColor,
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
                  // Teks deskripsi menggunakan warna putih yang soft
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 8),

                // 6. Is Featured
                if (product.isFeatured)
                  Row(
                    children: [
                      Icon(Icons.star, color: accentColor, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        'Featured Product',
                        style: TextStyle(
                          // Kuning Terang untuk status "featured"
                          color: accentColor,
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