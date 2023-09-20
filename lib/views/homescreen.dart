import 'package:apitest/views/productdetailscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../getxcontrolllerfiles/modelapicontroller.dart';
import '../model/productmodel.dart';
import 'cardwidget.dart';

class ScreenHome extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  // Create an RxList to store the filtered product list
  final RxList<ProductModel> filteredProductList = RxList<ProductModel>();

  ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
          backgroundColor: Colors.grey[100],
          title: const Text(
            'Donzo',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          )),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.black),
                ),
                hintText: 'Search',
                hintStyle: const TextStyle(
                    color: Colors.black), // Set hint text color to black
              ),
              onChanged: (searchText) {
                // Clear the filtered list when the search field is empty
                if (searchText.isEmpty) {
                  filteredProductList.clear();
                } else {
                  // Filter the product list based on the search query
                  filteredProductList.assignAll(
                    productController.productlist.where((productModel) {
                      final product = productModel.products?.isNotEmpty == true
                          ? productModel.products![0]
                          : null;
                      final title = product?.title?.toLowerCase() ?? "";
                      return title.contains(searchText.toLowerCase());
                    }).toList(),
                  );
                }
              },
            ),
          ),
          Expanded(
            child: Obx(
              () {
                final List<ProductModel> displayList =
                    filteredProductList.isNotEmpty
                        ? filteredProductList.toList()
                        : productController.productlist;

                return ListView.builder(
                  itemCount: displayList.length,
                  itemBuilder: (context, index) {
                    final productModel = displayList[index];
                    final product = productModel.products?.isNotEmpty == true
                        ? productModel.products![0]
                        : null;
                    final title = product?.title ?? "";
                    final description = product?.description ?? "";

                    return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ProductDetails(
                                productId: product?.id,
                              );
                            },
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProductCard(
                            title: title,
                            description: description,
                            imageUrl: product?.thumbnail ?? '',
                            price: product?.price.toString(),
                          ),
                        ));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
