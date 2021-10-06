class Product {
  final int id;
  final num price, rating;
  int quantity;

  final String title, category, description, image;
  bool isFavourite, isInCart;

  Product({
    this.isFavourite = false,
    this.isInCart = false,
    this.quantity = 1,
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.description,
    required this.image,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      category: json['category'],
      description: json['description'],
      image: json['image'],
      rating: json['rating']['rate'],
    );
  }
  toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'category': category,
      'description': description,
      'image': image,
      'rating': {
        'rate': rating,
      }
    };
  }

  static List<Product> fromJsonList(List jsonList) {
    List<Product> list = [];
    jsonList.forEach((json) {
      list.add(Product.fromJson(json));
    });
    return list;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product && other.id == id;
  }

  @override
  int get hashCode {
    return quantity.hashCode ^
        price.hashCode ^
        image.hashCode ^
        isInCart.hashCode;
  }
}
