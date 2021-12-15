import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fifteenbucks/bottom_navigation_bar/cart_screen/cart_screen.dart';
import 'package:fifteenbucks/chat_screen/chat_screen.dart';
import 'package:fifteenbucks/common/functions.dart';
import 'package:fifteenbucks/common/navgation_fun.dart';
import 'package:fifteenbucks/model/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductViewScreen extends StatefulWidget {
  final String image;
  final String price;
  final String name;
  final String productUrl;
  final List<Products> recommendedProducts;
  const ProductViewScreen({
    Key? key,
    required this.image,
    required this.price,
    required this.name,
    required this.productUrl,
    required this.recommendedProducts,
  }) : super(key: key);

  @override
  _ProductViewScreenState createState() => _ProductViewScreenState();
}

class _ProductViewScreenState extends State<ProductViewScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: size.width,
                    height: size.height * 0.65,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      image: DecorationImage(
                          image: NetworkImage(widget.image), fit: BoxFit.fill),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            !isChecked ? Icons.favorite_border : Icons.favorite,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              isChecked = true;
                            });
                            if (isChecked) {
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .collection('favorite')
                                  .add({
                                'image': widget.image,
                                'price': widget.price,
                                'name': widget.name,
                                'productUrl': widget.productUrl,
                                'quantity': 0
                              }).whenComplete(() {
                                showSnackBarSuccess(
                                    context, 'Added into favorite');
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 6,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: size.width * 0.9,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        widget.name,
                        style: GoogleFonts.cabin(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: size.width * 0.04),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$ " + widget.price,
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: size.width * 0.06,
                              fontWeight: FontWeight.w800),
                        ),
                        IconButton(
                            onPressed: () {
                              screenPush(
                                  context,
                                  ChatScreenWithUser(
                                      receiverId: 'admin',
                                      receiverName: 'Owner'));
                            },
                            icon: Icon(
                              Icons.chat,
                              color: Colors.red,
                            )),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Text(
                  'Related products',
                  style: GoogleFonts.rubik(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: size.width * 0.05),
                ),
              ),
              Container(
                width: size.width,
                height: size.height * 0.4,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.recommendedProducts.length > 4
                        ? 4
                        : widget.recommendedProducts.length,
                    itemBuilder: (context, index) {
                      if (widget.recommendedProducts[index].productName !=
                          widget.name) {
                        return InkWell(
                          onTap: () {
                            screenPush(
                              context,
                              ProductViewScreen(
                                image:
                                    'https:${widget.recommendedProducts[index].productImage.toString()}',
                                price: widget
                                    .recommendedProducts[index].productPrice
                                    .toString(),
                                name: widget
                                    .recommendedProducts[index].productName
                                    .toString(),
                                productUrl: widget
                                    .recommendedProducts[index].productUrl
                                    .toString(),
                                recommendedProducts: widget.recommendedProducts,
                              ),
                            );
                          },
                          child: Container(
                            width: size.width * 0.5,
                            margin: EdgeInsets.symmetric(
                                horizontal: size.width * 0.04),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: size.width * 0.6,
                                  height: size.height * 0.26,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            'https:${widget.recommendedProducts[index].productImage.toString()}'),
                                        fit: BoxFit.fill,
                                      ),
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                                Text(
                                  '${widget.recommendedProducts[index].productName}',
                                  style: TextStyle(
                                    fontSize: size.width * 0.04,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: 'Price: ',
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontWeight: FontWeight.w600),
                                    children: [
                                      TextSpan(
                                        text:
                                            '\$${widget.recommendedProducts[index].productPrice}',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }),
              )
            ],
          ),
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.only(bottom: 20, left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('cart')
                      .add({
                    'image': widget.image,
                    'price': widget.price,
                    'totalPrice': widget.price,
                    'name': widget.name,
                    'productUrl': widget.productUrl,
                    'quantity': 1
                  }).whenComplete(() {
                    showSnackBarSuccess(context, 'Added to cart');
                    Navigator.pop(context);
                  });
                },
                child: Icon(
                  Icons.shopping_cart_rounded,
                  color: Colors.red,
                  size: size.width * 0.078,
                ),
              ),
              InkWell(
                onTap: () {
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('cart')
                      .add({
                    'image': widget.image,
                    'price': widget.price,
                    'totalPrice': widget.price,
                    'name': widget.name,
                    'productUrl': widget.productUrl,
                    'quantity': 1
                  }).whenComplete(() {
                    screenPushRep(context, const CartScreen());
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  width: size.width * 0.6,
                  height: size.height * 0.08,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    "Buy Now",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: size.width * 0.04,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
