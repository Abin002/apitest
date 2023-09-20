import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String? price;

  const ProductCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(25)),
      elevation: 15,
      color: Colors.white,
      child: ListTile(
        leading: Image.network(imageUrl),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description,
                style: const TextStyle(fontWeight: FontWeight.w500)),
            Text('Price ${price.toString()} Rs',
                style: const TextStyle(fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}
