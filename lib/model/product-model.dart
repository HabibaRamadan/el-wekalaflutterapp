class ProductModel {
  String? status;
  String? message;
  List<Product>? product;

  ProductModel();

  ProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((e) {
        product!.add(Product.fromJson(e));
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
      image:json['image']
    );
  }
}
