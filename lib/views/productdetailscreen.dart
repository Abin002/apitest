import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../getxcontrolllerfiles/modelapicontroller.dart';
import '../model/productmodel.dart';

class ProductDetails extends StatelessWidget {
  final int? productId; // The ID of the selected product
  ProductDetails({required this.productId, super.key});

  final ProductController productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    // Find the product with the specified ID
    final Product? product = productController.productlist
        .expand((model) => model.products ?? [])
        .firstWhere((p) => p.id == productId, orElse: () => null);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text(
          product?.title ?? '',
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: product != null
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'catogory : ${product.category} ',
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'brand : ${product.brand} ',
                        style: const TextStyle(fontSize: 15),
                      ),
                      Text(
                        'stock left : ${product.stock} ',
                        style: const TextStyle(fontSize: 15),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'USER RATING : ${product.rating.toString()}',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Image.network(product.thumbnail.toString()),
                  // Display product images in a horizontal ListView

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      product.description ?? "",
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(' RS ${product.price.toString()} /- ',
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600)),
                  ),
                  Text("${product.discountPercentage} % off",
                      style: const TextStyle(fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: 200, // Adjust the height as needed
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: product.images?.length,
                      itemBuilder: (context, index) {
                        return Image.network(
                          product.images![index],
                          width: 200, // Adjust the width as needed
                        );
                      },
                    ),
                  ),
                  ElevatedButton(onPressed: () {}, child: const Text('Buy Now'))
                ],
              ),
            )
          : const Center(
              child: Text('Product not found!'),
            ),
    );
  }
}
