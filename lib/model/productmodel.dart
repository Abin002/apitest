class ProductModel {
  final List<Product>? products;
  final num? total;
  final num? skip;
  final num? limit;

  ProductModel({
    this.products,
    this.total,
    this.skip,
    this.limit,
  });
}

class Product {
  final int? id;
  final String? title;
  final String? description;
  final num? price;
  final num? discountPercentage;
  final num? rating;
  final num? stock;
  final String? brand;
  final String? category;
  final String? thumbnail;
  final List<String>? images;

  Product({
    this.id,
    this.title,
    this.description,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.brand,
    this.category,
    this.thumbnail,
    this.images,
  });
}
