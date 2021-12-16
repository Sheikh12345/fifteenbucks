import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fifteenbucks/bottom_navigation_bar/home_screen/product_review.dart';
import 'package:fifteenbucks/common/navgation_fun.dart';
import 'package:fifteenbucks/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchLessonScreen extends StatefulWidget {
  final List<Products> listOfProducts;
  const SearchLessonScreen({Key? key, required this.listOfProducts})
      : super(key: key);

  @override
  _SearchLessonScreenState createState() => _SearchLessonScreenState();
}

class _SearchLessonScreenState extends State<SearchLessonScreen> {
  Stream? stream;
  String searchString = '';
  List<Products> _filters = [];
  @override
  void initState() {
    setState(() {
      _filters = widget.listOfProducts;
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: size.height * 0.001, bottom: 6),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          left: size.width * 0.04, top: size.height * 0.02),
                      padding: EdgeInsets.only(
                          left: size.width * 0.025,
                          top: size.width * 0.02,
                          bottom: size.width * 0.045,
                          right: size.width * 0.03),
                      width: size.width * 0.07,
                      height: size.width * 0.07,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5)),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: size.width * 0.035,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: size.width * 0.04, top: size.height * 0.02),
                    child: Text(
                      "Search",
                      style: GoogleFonts.ramabhadra(
                          color: Colors.black, fontSize: size.width * 0.05),
                    ),
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: size.width * 0.01),
              margin: EdgeInsets.symmetric(
                  horizontal: size.width * 0.04, vertical: 5),
              width: size.width,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20)),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search products",
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                  hintStyle: GoogleFonts.cabin(
                    height: 2,
                  ),
                ),
                onChanged: (string) {
                  setState(() {
                    setState(() {
                      _filters = widget.listOfProducts
                          .where((u) => (u.productName!
                                  .toLowerCase()
                                  .contains(string.toLowerCase()) ||
                              u.productPrice
                                  .toString()
                                  .toLowerCase()
                                  .contains(string.toLowerCase())))
                          .toList();
                    });
                  });
                },
              ),
            ),
            Container(
              child: Expanded(
                child: GridView.builder(
                  itemCount: _filters.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 1.0,
                      crossAxisSpacing: 5.0,
                      childAspectRatio: .6),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        screenPush(
                            context,
                            ProductViewScreen(
                                id: _filters[index].id.toString(),
                                recommendedProducts: widget.listOfProducts,
                                image: "https:" +
                                    _filters[index].productImage.toString(),
                                price: _filters[index].productPrice.toString(),
                                name: _filters[index].productName.toString(),
                                productUrl:
                                    _filters[index].productUrl.toString()));
                      },
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: size.width * 0.04),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                screenPush(
                                    context,
                                    ProductViewScreen(
                                        id: widget.listOfProducts[index].id
                                            .toString(),
                                        recommendedProducts:
                                            widget.listOfProducts,
                                        image: "https:" +
                                            _filters[index]
                                                .productImage
                                                .toString(),
                                        price: _filters[index]
                                            .productPrice
                                            .toString(),
                                        name: _filters[index]
                                            .productName
                                            .toString(),
                                        productUrl: _filters[index]
                                            .productUrl
                                            .toString()));
                              },
                              child: Container(
                                width: size.width * 0.6,
                                height: size.height * 0.26,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage("https:" +
                                          _filters[index]
                                              .productImage
                                              .toString()),
                                      fit: BoxFit.fill,
                                    ),
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            ),
                            Text(
                              '${_filters[index].productName}',
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
                                    text: '\$ ${_filters[index].productPrice}',
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
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
