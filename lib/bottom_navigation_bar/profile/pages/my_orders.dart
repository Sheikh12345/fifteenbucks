import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  _MyOrdersScreenState createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "My Orders",
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('myOrders')
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data.docs.length ?? 0,
                          itemBuilder: (context, index) {
                            return Container(
                              width: size.width,
                              height: size.height * 0.15,
                              decoration: BoxDecoration(
                                  color: Colors.red.shade700,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Products:",
                                              style: GoogleFonts.rubik(
                                                color: Colors.white,
                                                fontSize: size.width * 0.04,
                                              ),
                                            ),
                                            Text(
                                              "${snapshot.data.docs[index]['product']}",
                                              style: GoogleFonts.rubik(
                                                color: Colors.white,
                                                fontSize: size.width * 0.042,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Price:",
                                              style: GoogleFonts.rubik(
                                                color: Colors.white,
                                                fontSize: size.width * 0.04,
                                              ),
                                            ),
                                            Text(
                                              "${snapshot.data.docs[index]['price']}",
                                              style: GoogleFonts.rubik(
                                                color: Colors.white,
                                                fontSize: size.width * 0.042,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Address',
                                              style: GoogleFonts.rubik(
                                                color: Colors.white,
                                                fontSize: size.width * 0.04,
                                              ),
                                            ),
                                            Text(
                                              "${snapshot.data.docs[index]['address']}",
                                              style: GoogleFonts.rubik(
                                                color: Colors.white,
                                                fontSize: size.width * 0.042,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .collection('myOrders')
                                          .doc(snapshot.data.docs[index].id)
                                          .delete();
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.white.withOpacity(0.7),
                                      size: size.width * 0.1,
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    } else {
                      return Container();
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
