/// success : true
/// totalOrders : 1
/// order : [{"_id":"61cde46c61a8d82ec43c327b","userId":"7T0lHIneFhhg89mnguiXhMf7i473","userName":"kashif","phoneNo":"234567888","deliveryMethod":"cod","products":[{"productName":"(Blazer+Pants+Vest) Classic Men Suits Slim Wedding Groom Wear Male Business Casual 3 Piece Suit Trousers Gentlemen Costume M-6XL","productUrl":"https://www.aliexpress.com/item/1005003474136329.html?algo_pvid=c0ffa4fc-7a4a-43f7-9082-4018be262e60&algo_exp_id=c0ffa4fc-7a4a-43f7-9082-4018be262e60-1&pdp_ext_f=%7B%22sku_id%22%3A%2212000025948625266%22%7D","productImage":"https://ae01.alicdn.com/kf/Hf1b931cab57942c5bbf595198bafa2c2V/-Blazer-Pants-Vest-Classic-Men-Suits-Slim-Wedding-Groom-Wear-Male-Business-Casual-3-Piece.jpg_220x220xz.jpg_.webp","productPrice":12,"productId":"61ba9197d2d6bfcb90e3dcf5","_id":"61cde46c61a8d82ec43c327c","createdAt":"2021-12-30T16:55:08.244Z","updatedAt":"2021-12-30T16:55:08.244Z"}],"address":"gulshan ravi lahore","status":"Not Processed","createdAt":"2021-12-30T16:55:08.245Z","updatedAt":"2021-12-30T16:55:08.245Z","__v":0}]
// ignore_for_file: invalid_assignment

class AllOrdersHistoryModel {
  AllOrdersHistoryModel({
    bool? success,
    int? totalOrders,
    List<Order>? order,
  }) {
    _success = success;
    _totalOrders = totalOrders;
    _order = order;
  }

  AllOrdersHistoryModel.fromJson(dynamic json) {
    _success = json['success'];
    _totalOrders = json['totalOrders'];
    if (json['order'] != null) {
      _order = [];
      json['order'].forEach((v) {
        _order?.add(Order.fromJson(v));
      });
    }
  }

  bool? _success;
  int? _totalOrders;
  List<Order>? _order;

  bool? get success => _success;
  int? get totalOrders => _totalOrders;
  List<Order>? get order => _order;
}

/// _id : "61cde46c61a8d82ec43c327b"
/// userId : "7T0lHIneFhhg89mnguiXhMf7i473"
/// userName : "kashif"
/// phoneNo : "234567888"
/// deliveryMethod : "cod"
/// products : [{"productName":"(Blazer+Pants+Vest) Classic Men Suits Slim Wedding Groom Wear Male Business Casual 3 Piece Suit Trousers Gentlemen Costume M-6XL","productUrl":"https://www.aliexpress.com/item/1005003474136329.html?algo_pvid=c0ffa4fc-7a4a-43f7-9082-4018be262e60&algo_exp_id=c0ffa4fc-7a4a-43f7-9082-4018be262e60-1&pdp_ext_f=%7B%22sku_id%22%3A%2212000025948625266%22%7D","productImage":"https://ae01.alicdn.com/kf/Hf1b931cab57942c5bbf595198bafa2c2V/-Blazer-Pants-Vest-Classic-Men-Suits-Slim-Wedding-Groom-Wear-Male-Business-Casual-3-Piece.jpg_220x220xz.jpg_.webp","productPrice":12,"productId":"61ba9197d2d6bfcb90e3dcf5","_id":"61cde46c61a8d82ec43c327c","createdAt":"2021-12-30T16:55:08.244Z","updatedAt":"2021-12-30T16:55:08.244Z"}]
/// address : "gulshan ravi lahore"
/// status : "Not Processed"
/// createdAt : "2021-12-30T16:55:08.245Z"
/// updatedAt : "2021-12-30T16:55:08.245Z"
/// __v : 0

class Order {
  Order({
    String? id,
    String? userId,
    String? userName,
    String? phoneNo,
    String? deliveryMethod,
    List<Products>? products,
    String? address,
    String? status,
    String? createdAt,
    String? updatedAt,
    int? v,
  }) {
    _id = id;
    _userId = userId;
    _userName = userName;
    _phoneNo = phoneNo;
    _deliveryMethod = deliveryMethod;
    _products = products;
    _address = address;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
  }

  Order.fromJson(dynamic json) {
    _id = json['_id'];
    _userId = json['userId'];
    _userName = json['userName'];
    _phoneNo = json['phoneNo'];
    _deliveryMethod = json['deliveryMethod'];
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products?.add(Products.fromJson(v));
      });
    }
    _address = json['address'];
    _status = json['status'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }

  String? _id;
  String? _userId;
  String? _userName;
  String? _phoneNo;
  String? _deliveryMethod;
  List<Products>? _products;
  String? _address;
  String? _status;
  String? _createdAt;
  String? _updatedAt;
  int? _v;

  String? get id => _id;
  String? get userId => _userId;
  String? get userName => _userName;
  String? get phoneNo => _phoneNo;
  String? get deliveryMethod => _deliveryMethod;
  List<Products>? get products => _products;
  String? get address => _address;
  String? get status => _status;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['userId'] = _userId;
    map['userName'] = _userName;
    map['phoneNo'] = _phoneNo;
    map['deliveryMethod'] = _deliveryMethod;
    if (_products != null) {
      map['products'] = _products?.map((v) => v.toJson()).toList();
    }
    map['address'] = _address;
    map['status'] = _status;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }
}

/// productName : "(Blazer+Pants+Vest) Classic Men Suits Slim Wedding Groom Wear Male Business Casual 3 Piece Suit Trousers Gentlemen Costume M-6XL"
/// productUrl : "https://www.aliexpress.com/item/1005003474136329.html?algo_pvid=c0ffa4fc-7a4a-43f7-9082-4018be262e60&algo_exp_id=c0ffa4fc-7a4a-43f7-9082-4018be262e60-1&pdp_ext_f=%7B%22sku_id%22%3A%2212000025948625266%22%7D"
/// productImage : "https://ae01.alicdn.com/kf/Hf1b931cab57942c5bbf595198bafa2c2V/-Blazer-Pants-Vest-Classic-Men-Suits-Slim-Wedding-Groom-Wear-Male-Business-Casual-3-Piece.jpg_220x220xz.jpg_.webp"
/// productPrice : 12
/// productId : "61ba9197d2d6bfcb90e3dcf5"
/// _id : "61cde46c61a8d82ec43c327c"
/// createdAt : "2021-12-30T16:55:08.244Z"
/// updatedAt : "2021-12-30T16:55:08.244Z"

class Products {
  Products({
    String? productName,
    String? productUrl,
    String? productImage,
    int? productPrice,
    String? productId,
    String? id,
    String? createdAt,
    String? updatedAt,
  }) {
    _productName = productName;
    _productUrl = productUrl;
    _productImage = productImage;
    _productPrice = productPrice;
    _productId = productId;
    _id = id;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Products.fromJson(dynamic json) {
    _productName = json['productName'];
    _productUrl = json['productUrl'];
    _productImage = json['productImage'];
    _productPrice = json['productPrice'];
    _productId = json['productId'];
    _id = json['_id'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _productName;
  String? _productUrl;
  String? _productImage;
  int? _productPrice;
  String? _productId;
  String? _id;
  String? _createdAt;
  String? _updatedAt;

  String? get productName => _productName;
  String? get productUrl => _productUrl;
  String? get productImage => _productImage;
  int? get productPrice => _productPrice;
  String? get productId => _productId;
  String? get id => _id;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productName'] = _productName;
    map['productUrl'] = _productUrl;
    map['productImage'] = _productImage;
    map['productPrice'] = _productPrice;
    map['productId'] = _productId;
    map['_id'] = _id;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }
}
