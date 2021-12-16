import 'package:fifteenbucks/common/navgation_fun.dart';
import 'package:fifteenbucks/model/product_model.dart';
import 'package:flutter/material.dart';

import '../product_review.dart';

class AllProductScreen extends StatefulWidget {
  final List<Products> productsList;
  const AllProductScreen({Key? key, required this.productsList})
      : super(key: key);

  @override
  _AllProductScreenState createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("All Products"),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 15),
        child: GridView.builder(
          itemCount: widget.productsList.length,
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
                      id: widget.productsList[index].id.toString(),
                        recommendedProducts: widget.productsList,
                        image: "https:" +
                            widget.productsList[index].productImage.toString(),
                        price:
                            widget.productsList[index].productPrice.toString(),
                        name: widget.productsList[index].productName.toString(),
                        productUrl:
                            widget.productsList[index].productUrl.toString()));
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        screenPush(
                            context,
                            ProductViewScreen(
                                id: widget.productsList[index].id.toString(),
                                recommendedProducts: widget.productsList,
                                image: "https:" +
                                    widget.productsList[index].productImage
                                        .toString(),
                                price: widget.productsList[index].productPrice
                                    .toString(),
                                name: widget.productsList[index].productName
                                    .toString(),
                                productUrl: widget
                                    .productsList[index].productUrl
                                    .toString()));
                      },
                      child: Container(
                        width: size.width * 0.6,
                        height: size.height * 0.26,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https:" +
                                  widget.productsList[index].productImage
                                      .toString()),
                              fit: BoxFit.fill,
                            ),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    Text(
                      '${widget.productsList[index].productName}',
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
                            text: '${widget.productsList[index].productPrice}',
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
    ));
  }
}
