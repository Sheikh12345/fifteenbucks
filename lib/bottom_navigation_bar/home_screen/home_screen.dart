import 'package:carousel_slider/carousel_slider.dart';
import 'package:fifteenbucks/bottom_navigation_bar/home_screen/components/custom_tile.dart';
import 'package:fifteenbucks/bottom_navigation_bar/home_screen/product_review.dart';
import 'package:fifteenbucks/bottom_navigation_bar/home_screen/products_screen.dart';
import 'package:fifteenbucks/common/functions.dart';
import 'package:fifteenbucks/common/navgation_fun.dart';
import 'package:fifteenbucks/authentication/login_screen.dart';
import 'package:fifteenbucks/bloc/products_cubit/products_cubit.dart';
import 'package:fifteenbucks/styles/colors.dart';
import 'package:fifteenbucks/styles/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/all_product_view.dart';
import 'components/search_products.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  getProducts(String category, BuildContext context) {
    context.read<ProductsCubit>().getProducts(category);
    ProductsCubit()..getProducts(category);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => ProductsCubit()..getProducts(category),
      child: BlocConsumer<ProductsCubit, ProductsState>(
        listener: (context, state) {
          if (state is ProductsFailedState) {
            showSnackBarFailed(context, 'Server error');
          }
        },
        builder: (context, state) {
          if (state is ProductsLoading) {
            return const SafeArea(
              child: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (state is ProductsSuccessState) {
            return SafeArea(
              child: Scaffold(
                body: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10)),
                      width: size.width,
                      margin:
                          EdgeInsets.symmetric(horizontal: size.width * 0.1),
                      child: TextField(
                        readOnly: true,
                        onTap: () {
                          if (state.productModel.products != null) {
                            screenPush(
                                context,
                                SearchLessonScreen(
                                  listOfProducts: state.productModel.products!,
                                ));
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Find your products',
                          border: InputBorder.none,
                          prefixIcon: const Icon(Icons.search),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: size.height * 0.02),
                      height: size.height * 0.2,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 400,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.7,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        ),
                        items: Constants().slider.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                height: size.height * 0.2,
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  image: DecorationImage(
                                      image: AssetImage('assets/$i'),
                                      fit: BoxFit.fill),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: size.width,
                      height: 50,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          CustomTile(
                            title: 'Mens clothing',
                            bgColor:
                                selectedIndex == 0 ? Colors.red : Colors.grey,
                            txtColor: Colors.white,
                            onTap: () {
                              setState(() {
                                selectedIndex = 0;
                                category = 'mens-clothing';
                              });
                              getProducts('mens-clothing', context);
                            },
                          ),
                          CustomTile(
                            title: 'Womens clothing',
                            bgColor:
                                selectedIndex == 1 ? Colors.red : Colors.grey,
                            txtColor: Colors.white,
                            onTap: () {
                              setState(() {
                                selectedIndex = 1;
                                category = 'womens-clothing';
                              });
                              getProducts('womens-clothing', context);
                            },
                          ),
                          CustomTile(
                            title: 'Watches',
                            bgColor:
                                selectedIndex == 3 ? Colors.red : Colors.grey,
                            txtColor: Colors.white,
                            onTap: () {
                              setState(() {
                                selectedIndex = 3;
                                category = 'watches';
                              });
                              getProducts('watches', context);
                            },
                          ),
                          CustomTile(
                            title: 'Beauty health',
                            bgColor:
                                selectedIndex == 4 ? Colors.red : Colors.grey,
                            txtColor: Colors.white,
                            onTap: () {
                              setState(() {
                                selectedIndex = 4;
                                category = 'beauty-health';
                              });
                              getProducts('beauty-health', context);
                            },
                          ),
                          CustomTile(
                            title: 'outdoor sports',
                            bgColor:
                                selectedIndex == 5 ? Colors.red : Colors.grey,
                            txtColor: Colors.white,
                            onTap: () {
                              setState(() {
                                selectedIndex = 5;
                                category = 'outdoor-sports';
                              });
                              getProducts('outdoor-sports', context);
                            },
                          ),
                          CustomTile(
                            title: 'Toys kids',
                            bgColor:
                                selectedIndex == 6 ? Colors.red : Colors.grey,
                            txtColor: Colors.white,
                            onTap: () {
                              setState(() {
                                selectedIndex = 6;
                                category = 'toys-kids';
                              });
                              getProducts('toys-kids', context);
                            },
                          ),
                          CustomTile(
                            title: 'Home',
                            bgColor:
                                selectedIndex == 7 ? Colors.red : Colors.grey,
                            txtColor: Colors.white,
                            onTap: () {
                              setState(() {
                                selectedIndex = 7;
                                category = 'home';
                              });
                              getProducts('home', context);
                            },
                          ),
                          CustomTile(
                            title: 'Phone telecommunication',
                            bgColor:
                                selectedIndex == 8 ? Colors.red : Colors.grey,
                            txtColor: Colors.white,
                            onTap: () {
                              setState(() {
                                selectedIndex = 8;
                                category = 'phone-telecommunication';
                              });
                              getProducts('phone-telecommunication', context);
                            },
                          ),
                          CustomTile(
                            title: 'Computer office',
                            bgColor:
                                selectedIndex == 9 ? Colors.red : Colors.grey,
                            txtColor: Colors.white,
                            onTap: () {
                              setState(() {
                                selectedIndex = 9;
                                category = 'computer-office';
                              });
                              getProducts('computer-office', context);
                            },
                          ),
                          CustomTile(
                            title: 'Bags luggage',
                            bgColor:
                                selectedIndex == 10 ? Colors.red : Colors.grey,
                            txtColor: Colors.white,
                            onTap: () {
                              setState(() {
                                selectedIndex = 10;
                                category = 'bags-luggage';
                              });
                              getProducts('bags-luggage', context);
                            },
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        screenPush(
                            context,
                            AllProductScreen(
                              productsList: state.productModel.products!,
                            ));
                      },
                      child: Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(right: 20, bottom: 10),
                        width: size.width,
                        height: size.height * 0.04,
                        child: Text(
                          'View all',
                          style: GoogleFonts.rubik(
                              color: Colors.red, fontWeight: FontWeight.w900),
                        ),
                      ),
                    ),
                    Container(
                      child: Expanded(
                        child: GridView.builder(
                          itemCount: state.productModel.products!.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
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
                                        id: state
                                            .productModel.products![index].id
                                            .toString(),
                                        recommendedProducts:
                                            state.productModel.products!,
                                        image: "https:" +
                                            state.productModel.products![index]
                                                .productImage
                                                .toString(),
                                        price: state.productModel
                                            .products![index].productPrice
                                            .toString(),
                                        name: state.productModel
                                            .products![index].productName
                                            .toString(),
                                        productUrl: state.productModel
                                            .products![index].productUrl
                                            .toString()));
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.04),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        screenPush(
                                            context,
                                            ProductViewScreen(
                                                id: state.productModel
                                                    .products![index].id
                                                    .toString(),
                                                recommendedProducts: state
                                                    .productModel.products!,
                                                image: "https:" +
                                                    state
                                                        .productModel
                                                        .products![index]
                                                        .productImage
                                                        .toString(),
                                                price: state
                                                    .productModel
                                                    .products![index]
                                                    .productPrice
                                                    .toString(),
                                                name: state
                                                    .productModel
                                                    .products![index]
                                                    .productName
                                                    .toString(),
                                                productUrl: state.productModel
                                                    .products![index].productUrl
                                                    .toString()));
                                      },
                                      child: Container(
                                        width: size.width * 0.6,
                                        height: size.height * 0.26,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage("https:" +
                                                  state
                                                      .productModel
                                                      .products![index]
                                                      .productImage
                                                      .toString()),
                                              fit: BoxFit.fill,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                      ),
                                    ),
                                    Text(
                                      '${state.productModel.products![index].productName}',
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
                                                '\$ ${state.productModel.products![index].productPrice}',
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
                    )
                  ],
                ),
              ),
            );
          } else {
            return const Scaffold(body: Center(child: Text('Server error')));
          }
        },
      ),
    );
  }

  showBottomSheet(Size size, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialogNotice(size, context);
      },
    );
  }

  alertDialogNotice(Size size, BuildContext context, {String? value}) {
    return Dialog(
      backgroundColor: Colors.grey,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)), //this right here
      child: Container(
        width: size.width,
        height: size.height * 0.7,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.03,
            ),
            Text(
              "Select product type",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontSize: size.width * 0.06,
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                screenPush(
                    context, const ProductsScreen(type: 'mens-clothing'));
              },
              child: Text(
                'Mens-clothing product',
                style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: size.width * 0.045),
              ),
            ),
            SizedBox(
              height: size.height * 0.027,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                screenPush(
                    context, const ProductsScreen(type: 'mens-clothing'));
              },
              child: Text(
                'Womens clothing product',
                style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: size.width * 0.04),
              ),
            ),
            SizedBox(
              height: size.height * 0.027,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                screenPush(context, const ProductsScreen(type: 'watches'));
              },
              child: Text(
                'Watches',
                style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: size.width * 0.04),
              ),
            ),
            SizedBox(
              height: size.height * 0.027,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                screenPush(context,
                    const ProductsScreen(type: 'phone-telecommunication'));
              },
              child: Text(
                'Phone telecommunication',
                style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: size.width * 0.04),
              ),
            ),
            SizedBox(
              height: size.height * 0.027,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                screenPush(
                    context, const ProductsScreen(type: 'computer-office'));
              },
              child: Text(
                'Computer office',
                style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: size.width * 0.04),
              ),
            ),
            SizedBox(
              height: size.height * 0.027,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                screenPush(context,
                    const ProductsScreen(type: 'consumer-electronics'));
              },
              child: Text(
                'Consumer electronics',
                style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: size.width * 0.04),
              ),
            ),
            SizedBox(
              height: size.height * 0.027,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                screenPush(context, const ProductsScreen(type: 'home'));
              },
              child: Text(
                'Home',
                style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: size.width * 0.04),
              ),
            ),
            SizedBox(
              height: size.height * 0.027,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                screenPush(context, const ProductsScreen(type: 'toys-kids'));
              },
              child: Text(
                'Toys kids',
                style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: size.width * 0.04),
              ),
            ),
            SizedBox(
              height: size.height * 0.027,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                screenPush(context, const ProductsScreen(type: 'bags-luggage'));
              },
              child: Text(
                'Bugs luggage',
                style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: size.width * 0.04),
              ),
            ),
            SizedBox(
              height: size.height * 0.027,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                screenPush(
                    context, const ProductsScreen(type: 'beauty-health'));
              },
              child: Text(
                'Beauty health',
                style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: size.width * 0.04),
              ),
            ),
            SizedBox(
              height: size.height * 0.027,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                screenPush(
                    context, const ProductsScreen(type: 'outdoor-sports'));
              },
              child: Text(
                'Outdoor sports',
                style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: size.width * 0.04),
              ),
            ),
            SizedBox(
              height: size.height * 0.027,
            ),
          ],
        ),
      ),
    );
  }
}
