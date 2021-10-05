import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductViewScreen extends StatefulWidget {
  const ProductViewScreen({Key? key}) : super(key: key);

  @override
  _ProductViewScreenState createState() => _ProductViewScreenState();
}

class _ProductViewScreenState extends State<ProductViewScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
          Stack(
            children: [
              Container(
                width: size.width,
                height: size.height*0.7,
                decoration:  BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSorgsplWcOaCqmAkRgm97d-SKYMaC33EQE9w&usqp=CAU'
                    ),
                    fit: BoxFit.fill
                  ),
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
                    onPressed: (){

                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite,color: Colors.red,),
                    onPressed: (){

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
             margin: EdgeInsets.symmetric(horizontal: size.width*0.04),
             child: Column(
               children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Text("Warm Zipper",style: GoogleFonts.cabin(
                         color: Colors.black,
                         fontWeight: FontWeight.w800,
                         fontSize: size.width*0.07
                     ),),

                      Text("\$300.00",style: TextStyle(
                       color: Colors.red,
fontSize: size.width*0.06,
                        fontWeight: FontWeight.w800

                     ),)
                   ],
                 )
               ],
             ),
           ),

          ],
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(bottom: 20,left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child:  Icon(Icons.shopping_cart_rounded,color: Colors.red,
                size: size.width*0.078,
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: size.width*0.6,
                height: size.height*0.08,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(30)
                ),
                child: Text("Buy Now",style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: size.width*0.04,
                ),),
              )
            ],
          ),
        ),
      ),

    );
  }
}
