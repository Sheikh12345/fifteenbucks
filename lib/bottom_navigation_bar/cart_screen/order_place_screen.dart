import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fifteenbucks/common/functions.dart';
import 'package:fifteenbucks/server_interaction/get_products_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderPlaceScreen extends StatefulWidget {
  final List<Map> list;

  const OrderPlaceScreen({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  _OrderPlaceScreenState createState() => _OrderPlaceScreenState();
}

class _OrderPlaceScreenState extends State<OrderPlaceScreen> {
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerAddress = TextEditingController();
  TextEditingController _controllerPhone = TextEditingController();

  @override
  void initState() {
    super.initState();
    print("Data => ${widget.list}");
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      _controllerName.text = value.get('name');
      _controllerAddress.text = value.get('address');
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Order screen'),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.03,
              ),
              Text(
                "Shipping details",
                style: TextStyle(
                    fontSize: size.width * 0.06, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05, vertical: 10),
                child: TextField(
                    controller: _controllerName,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Your name',
                    )),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                    ),
                    borderRadius: BorderRadius.circular(10)),
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05, vertical: 10),
                child: TextField(
                    controller: _controllerPhone,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Your phone number',
                    )),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                    ),
                    borderRadius: BorderRadius.circular(10)),
              ),
              Container(
                padding: EdgeInsets.only(left: 10),
                margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05, vertical: 10),
                child: TextField(
                  controller: _controllerAddress,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Shipping Address',
                  ),
                ),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                    ),
                    borderRadius: BorderRadius.circular(10)),
              ),
              InkWell(
                onTap: () async {
                  if (_controllerName.text.isNotEmpty &&
                      _controllerAddress.text.isNotEmpty &&
                      _controllerPhone.text.isNotEmpty) {
                    var formData = {
                      'userName': _controllerName.text,
                      'products': widget.list,
                      'address': _controllerAddress.text,
                      'userId': FirebaseAuth.instance.currentUser!.uid,
                      'phoneNo': _controllerPhone.text,
                      'deliveryMethod': 'cod'
                    };
                    bool result = await Server().sendOrder(formData);
                    if (result == true) {
                      getProductList();
                      showSnackBarSuccess(context, 'Order is sent');
                    } else {
                      showSnackBarFailed(context, 'Something is wrong');
                    }
                  } else {
                    showSnackBarFailed(context, 'Something is missing');
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  margin: EdgeInsets.symmetric(
                      horizontal: size.width * 0.05,
                      vertical: size.height * 0.2),
                  width: size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red),
                  child: Text(
                    'Send order',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: size.width * 0.04),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  getProductList() async {
    final CollectionReference _fetchProducts = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .collection('cart');
    final List<String> _fireDocsList = [];
    QuerySnapshot querySnapshotLens = await _fetchProducts.get();

    for (int i = 0; i < querySnapshotLens.docs.length; i++) {
      var a = querySnapshotLens.docs[i];
      _fireDocsList.add(a.id);
    }
    for (int index = 0; index < _fireDocsList.length; index++) {
      await _fetchProducts.doc(_fireDocsList.elementAt(index)).delete();
    }
    Navigator.pop(context);
  }
}
