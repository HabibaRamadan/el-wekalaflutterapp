// ignore: file_names
class CartModel {
  List<CartProducts>? products;

  CartModel({this.products});

  CartModel.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <CartProducts>[];
      json['products'].forEach((v) {
        products!.add(CartProducts.fromJson(v));
      });
    }
  }

  
}

class CartProducts{
  int? sales;
  String? sId;
  String? status;
  String? category;
  String? name;
  dynamic price;
  String? description;
  String? image;
  List<String>? images;
  String? company;
  int? countInStock;
  int? iV;
  dynamic quantity;
  dynamic totalPrice;

 CartProducts (
      {this.sales,
      this.sId,
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
      this.quantity,
      this.totalPrice});

  CartProducts.fromJson(Map<String, dynamic> json) {
    sales = json['sales'];
    sId = json['_id'];
    status = json['status'];
    category = json['category'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    image = json['image'];
    images = json['images'].cast<String>();
    company = json['company'];
    countInStock = json['countInStock'];
    iV = json['__v'];
    quantity = json['quantity'];
    totalPrice = json['totalPrice'];
  }
}
