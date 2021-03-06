import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fifteenbucks/common/functions.dart';
import 'package:fifteenbucks/common/navgation_fun.dart';
import 'package:fifteenbucks/model/cart_model.dart';
import 'package:fifteenbucks/styles/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'order_place_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String? productUrl;
  String? imageUrl;
  String? price;
  String? productName;
  double totalPrice = 0.0;
  List<Map> products = [];

  final CollectionReference _fetchProducts = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid.toString())
      .collection('cart');

  calculateAmount(AsyncSnapshot snapshot) {
    totalPrice = 0.0;
    for (int i = 0; i < snapshot.data.docs.length; i++) {
      totalPrice = totalPrice +
          double.parse(snapshot.data.docs[i]['price'].toString()) +
          double.parse(snapshot.data.docs[i]['quantity'].toString());
    }
    print("total price $totalPrice");
  }

  getProductList() async {
    final List<String> _fireDocsList = [];
    QuerySnapshot querySnapshotLens = await _fetchProducts.get();

    for (int i = 0; i < querySnapshotLens.docs.length; i++) {
      var a = querySnapshotLens.docs[i];
      _fireDocsList.add(a.id);
    }

    for (int index = 0; index < _fireDocsList.length; index++) {
      await _fetchProducts
          .doc(_fireDocsList.elementAt(index))
          .get()
          .then((value) {
        products.add({
          'productId': value.get('id'),
          "productName": value.get('name'),
          "productPrice":
              '${double.parse(value.get('price')) + value.get('quantity')}',
          "productImage": value.get('image'),
          "productUrl": value.get('productUrl')
        });
      }).whenComplete(() {
        if (products.isNotEmpty) {
          Future.delayed(const Duration(seconds: 1), () {
            screenPush(
              context,
              OrderPlaceScreen(list: products, totalPrice: totalPrice),
            );
          });
        } else {
          showSnackBarFailed(context, 'Cart is empty');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Cart',
          style:
              GoogleFonts.cabin(color: Colors.red, fontWeight: FontWeight.w600),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid.toString())
            .collection('cart')
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            calculateAmount(snapshot);
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: size.height * 0.14,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: size.height * 0.13,
                          width: size.width * 0.25,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      snapshot.data.docs[index]['image']),
                                  fit: BoxFit.fill)),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: size.height * 0.02,
                              ),
                              Text(
                                snapshot.data.docs[index]['name']
                                    .toString()
                                    .substring(0, 10),
                                style: GoogleFonts.cabin(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.03,
                              ),
                              Text(
                                "\$ ${snapshot.data.docs[index]['price'].toString()}",
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .collection('cart')
                                    .doc(snapshot.data.docs[index].id)
                                    .delete();
                              },
                              icon: const Icon(Icons.delete),
                            ),
                            SizedBox(
                              height: size.height * 0.035,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: size.width * 0.05),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (snapshot.data.docs[index]
                                              ['quantity'] >=
                                          2) {
                                        FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.uid
                                                .toString())
                                            .collection('cart')
                                            .doc(snapshot.data.docs[index].id)
                                            .update({
                                          'quantity': (snapshot.data.docs[index]
                                                  ['quantity'] -
                                              1),
                                        }).whenComplete(() {
                                          Future.delayed(
                                              Duration(milliseconds: 1000), () {
                                            FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(FirebaseAuth
                                                    .instance.currentUser!.uid
                                                    .toString())
                                                .collection('cart')
                                                .doc(snapshot
                                                    .data.docs[index].id)
                                                .update({
                                              'totalPrice': (double.parse(
                                                          snapshot
                                                              .data
                                                              .docs[index]
                                                                  ['price']
                                                              .toString()) *
                                                      double.parse(snapshot
                                                          .data
                                                          .docs[index]
                                                              ['quantity']
                                                          .toString()))
                                                  .toString()
                                            });
                                          }).whenComplete(() {
                                            calculateAmount(snapshot);
                                          });
                                        });
                                      }
                                    },
                                    child: Container(
                                      child: Icon(
                                        Icons.remove,
                                        size: size.width * 0.045,
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade500,
                                              spreadRadius: 2,
                                              blurRadius: 2,
                                              offset: const Offset(1, 1),
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      width: size.width * 0.055,
                                      height: size.width * 0.055,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: size.width * 0.02),
                                    ),
                                  ),
                                  Text(
                                      '${snapshot.data.docs[index]['quantity']}'),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        productUrl = snapshot.data.docs[index]
                                            ['productUrl'];
                                        price =
                                            snapshot.data.docs[index]['price'];
                                        imageUrl =
                                            snapshot.data.docs[index]['image'];
                                        productName =
                                            snapshot.data.docs[index]['name'];
                                      });
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid
                                              .toString())
                                          .collection('cart')
                                          .doc(snapshot.data.docs[index].id)
                                          .update({
                                        'quantity': (snapshot.data.docs[index]
                                                ['quantity'] +
                                            1),
                                      }).whenComplete(() {
                                        Future.delayed(
                                            Duration(milliseconds: 1000), () {
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(FirebaseAuth
                                                  .instance.currentUser!.uid
                                                  .toString())
                                              .collection('cart')
                                              .doc(snapshot.data.docs[index].id)
                                              .update({
                                            'totalPrice': (double.parse(snapshot
                                                        .data
                                                        .docs[index]['price']
                                                        .toString()) *
                                                    double.parse(snapshot.data
                                                        .docs[index]['quantity']
                                                        .toString()))
                                                .toString()
                                          }).whenComplete(() {
                                            calculateAmount(snapshot);
                                          });
                                        });
                                      });
                                    },
                                    child: Container(
                                      child: Icon(
                                        Icons.add,
                                        size: size.width * 0.045,
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade500,
                                              spreadRadius: 2,
                                              blurRadius: 2,
                                              offset: const Offset(1, 1),
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      width: size.width * 0.055,
                                      height: size.width * 0.055,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: size.width * 0.02),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      bottomNavigationBar: InkWell(
        onTap: () {
          getProductList();
        },
        child: Container(
          height: size.height * 0.07,
          alignment: Alignment.center,
          child: Text(
            'Next',
            style: TextStyle(
              fontSize: size.width * 0.06,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          decoration: BoxDecoration(color: AppConstants().primaryColor),
        ),
      ),
    );
  }
}
