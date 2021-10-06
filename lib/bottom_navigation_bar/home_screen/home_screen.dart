import 'package:carousel_slider/carousel_slider.dart';
import 'package:fifteenbucks/bottom_navigation_bar/home_screen/product_review.dart';
import 'package:fifteenbucks/common/functions.dart';
import 'package:fifteenbucks/common/navgation_fun.dart';
import 'package:fifteenbucks/authentication/login_screen.dart';
import 'package:fifteenbucks/cubit/products_cubit/products_cubit.dart';
import 'package:fifteenbucks/styles/colors.dart';
import 'package:fifteenbucks/styles/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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




  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context)=>ProductsCubit()..getProducts(),
      child: BlocConsumer<ProductsCubit,ProductsState>(
        listener: (context,state){
          if(state is ProductsFailedState){
            showSnackBarFailed(context,'Server error');
          }
        },
        builder: (context,state){
          if(state is ProductsLoading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else if(state is ProductsSuccessState){
            return Column(
              children: [
                SizedBox(
                  height: size.height * 0.03,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10)),
                  width: size.width,
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.06),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Find your products',
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: Icon(Icons.filter_alt_sharp),
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
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration: const Duration(milliseconds: 800),
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
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              image: DecorationImage(
                                  image: AssetImage('assets/$i'), fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(top: 5),
                  height: size.height * 0.57,
                  child: GridView.builder(
                      itemCount: state.productModel.products!.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 1.0,
                          crossAxisSpacing: 5.0,
                          childAspectRatio: .4),
                      itemBuilder: (context, index) {
                        print('${state.productModel.products![0].productImage}');
                        return InkWell(
                          onTap: () {
                            screenPush(context, const ProductViewScreen());
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Container(
                                  width: size.width * 0.6,
                                  height: size.height * 0.26,
                                  decoration: BoxDecoration(
                                      image:  DecorationImage(
                                        image: NetworkImage('https:${state.productModel.products![index].productImage.toString()}'),
                                        fit: BoxFit.fill,
                                      ),
                                      borderRadius: BorderRadius.circular(20)),
                                ),

                                RichText(
                                    text:  TextSpan(
                                        text: '',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                        children: [TextSpan(text: '${state.productModel.products![index].productName}')])),
                                RichText(
                                    text:  TextSpan(
                                        text: 'Price: ',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                        children: [TextSpan(text: '${state.productModel.products![index].productPrice}')]))
                              ],
                            ),
                          ),
                        );
                      }),
                )
              ],
            );
          }else{
            return Center(
              child:Text('Server error')
            );
          }
        },
      )
    );
  }
}
