import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/productmodel.dart';

class ProductController extends GetxController {
  final productlist = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    var url = "https://dummyjson.com/products";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        print('API request successful');
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse.containsKey("products") &&
            jsonResponse["products"] is List) {
          final List<dynamic> productsList = jsonResponse["products"];
          final List<ProductModel> productList = productsList
              .map((data) => ProductModel(
                    products: [
                      Product(
                        id: data["id"],
                        title: data["title"],
                        description: data["description"],
                        price: data["price"],
                        discountPercentage: data["discountPercentage"],
                        rating: data["rating"],
                        stock: data["stock"],
                        brand: data["brand"],
                        category: data["category"],
                        thumbnail: data["thumbnail"],
                        images: List<String>.from(data["images"]),
                      )
                    ],
                  ))
              .toList();

          // Update the productlist with the parsed data
          productlist.assignAll(productList);
        } else {
          // Handle the case when the "products" key is not present in the JSON
          print("No 'products' key found in the JSON response.");
        }
      } else {
        // Handle the case when the request fails
        print("Request failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }
}
