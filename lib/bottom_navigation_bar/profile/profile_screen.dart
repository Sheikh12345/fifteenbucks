import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fifteenbucks/authentication/login_screen.dart';
import 'package:fifteenbucks/bottom_navigation_bar/profile/pages/edit_profile.dart';
import 'package:fifteenbucks/bottom_navigation_bar/profile/pages/my_orders.dart';
import 'package:fifteenbucks/bottom_navigation_bar/profile/pages/shipping_address.dart';
import 'package:fifteenbucks/chat_screen/list_of_chat_users.dart';
import 'package:fifteenbucks/common/navgation_fun.dart';
import 'package:fifteenbucks/styles/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = '';
  String profileLink = '';
  String email = '';
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      name = value.get('name');
      profileLink = value.get('image');
    }).whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppConstants().primaryColor,
        body: Column(
          children: [
            Container(
              width: size.width,
              margin: EdgeInsets.symmetric(
                  horizontal: size.width * 0.04, vertical: size.height * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * 0.3,
                    height: size.width * 0.3,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image:
                            DecorationImage(image: NetworkImage(profileLink))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "$name",
                    style: GoogleFonts.cabin(
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.05,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${FirebaseAuth.instance.currentUser!.email}',
                    style: GoogleFonts.cabin(
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.05,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: size.width,
              height: size.height * 0.57,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () async {
                      await screenPush(context, EditProfileScreen());
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .get()
                          .then((value) {
                        name = value.get('name');
                        profileLink = value.get('image');
                      }).whenComplete(() {
                        setState(() {});
                      });
                    },
                    child: Text(
                      'Edit profile',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.05,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      screenPush(context, MyOrdersScreen());
                    },
                    child: Text(
                      "My Orders",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.05,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      screenPush(context, const ShippingAddress());
                    },
                    child: Text(
                      'Shipping address',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.05,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      screenPush(context, const ListOfChatUsers());
                    },
                    child: Text(
                      'Chat',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.05,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      FirebaseAuth.instance.signOut().whenComplete(() {
                        screenPushRep(context, const LoginScreen());
                      });
                    },
                    child: Text(
                      'Logout',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.05,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
