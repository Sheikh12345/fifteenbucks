import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fifteenbucks/common/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShippingAddress extends StatefulWidget {
  const ShippingAddress({Key? key}) : super(key: key);

  @override
  _ShippingAddressState createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      print("address ${value.get('address')}");
      _controller.text = value.get('address');
    }).whenComplete(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Shipping address",
            style: GoogleFonts.rubik(
                color: Colors.white, fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.02, vertical: 20),
                width: size.width * 0.95,
                height: size.height * 0.4,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _controller,
                  style: TextStyle(
                      color: Colors.black, fontSize: size.width * 0.04),
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: "Shipping address"),
                  maxLines: 5,
                ),
              ),
              InkWell(
                onTap: () {
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .update({'address': _controller.text}).whenComplete(() {
                    showSnackBarSuccess(context, 'Saved');
                    Navigator.pop(context);
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  width: size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: size.height * 0.065,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    "Save",
                    style: GoogleFonts.rubik(
                      color: Colors.white,
                      fontSize: size.width * 0.05,
                      fontWeight: FontWeight.w500,
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
