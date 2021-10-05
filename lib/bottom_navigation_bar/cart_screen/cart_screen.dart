import 'package:fifteenbucks/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
      body: ListView.builder(itemBuilder: (context, index) {
        return Container(
          height: size.height * 0.14,
          margin: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              Checkbox(
                value: true,
                onChanged: (value) {},
              ),
              Container(
                height: size.height * 0.13,
                width: size.width * 0.25,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                        image: NetworkImage(
                            'https://images.unsplash.com/photo-1542291026-7eec264c27ff?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8cHJvZHVjdHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80'),
                        fit: BoxFit.fill)),
              ),
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Text(
                      "Warm Zipper",
                      style: GoogleFonts.cabin(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Text(
                      "Hooded jacket",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Text(
                      "\$300.00",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: size.width * 0.05),
                child: Row(
                  children: [
                    Container(
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
                          borderRadius: BorderRadius.circular(10)),
                      width: size.width * 0.055,
                      height: size.width * 0.055,
                      margin:
                          EdgeInsets.symmetric(horizontal: size.width * 0.02),
                    ),
                    const Text('2'),
                    Container(
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
                          borderRadius: BorderRadius.circular(10)),
                      width: size.width * 0.055,
                      height: size.width * 0.055,
                      margin:
                          EdgeInsets.symmetric(horizontal: size.width * 0.02),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }),
     bottomNavigationBar: Container(
       height: size.height*0.07,
         alignment: Alignment.center,
       child: Text('Next',style: TextStyle(
fontSize: size.width*0.06,
         color: Colors.white,
         fontWeight: FontWeight.w600,
       ),),
       decoration: BoxDecoration(
           color: AppConstants().primaryColor
       ),
     ),
    );
  }
}
