class FavoriteModel {
  String? status;
  List<Product>? favoriteProduct;

  FavoriteModel({this.status, this.favoriteProduct});

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['favoriteProducts'] != null) {
      favoriteProduct = <Product>[];
      json['favoriteProducts'].forEach((e) {
        favoriteProduct!.add(Product.fromJson(e));
      });
    }
  }
}

class Product {
  String? sId;
  String? status;
  String? category;
  String? name;
  dynamic price;
  String? description;
  String? image;
  List<String>? images;
  String? company;
  dynamic countInStock;
  dynamic iV;
  int? sales;

  Product(
      {this.sId,
      this.status,
      this.category,
      this.name,
      this.price,
      this.description,
      this.image,
      this.images,
      this.company,
      this.countInStock,
      this.iV,
      this.sales});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        sId: json['_id'],
        status: json['status'],
        name: json['name'],
        category: json['category'],
        price: json['price'],
        description: json['description'],
        images: json['images'].cast<String>(),
        company: json['company'],
        countInStock: json['countInStock'],
        iV: json['__v'],
        sales: json['sales'],
        image: json['image']);
  }

}
