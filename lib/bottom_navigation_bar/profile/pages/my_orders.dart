import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fifteenbucks/bloc/bloc_order_history/bloc_order_history_cubit.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocProvider(
      create: (context) => BlocOrderHistoryCubit()..getOrderHistory(),
      child: BlocConsumer<BlocOrderHistoryCubit, BlocOrderHistoryState>(
        listener: (context, state) {
          if (state is BlocOrderHistorySuccessState) {
            print("Orders => ${state.allOrdersHistoryModel.order!.length}");
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text(
                  "My Orders",
                ),
              ),
              body: state is BlocOrderHistoryLoadingState
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : state is BlocOrderHistorySuccessState
                      ? Column(
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Expanded(
                              child: ListView.builder(
                                  itemCount:
                                      state.allOrdersHistoryModel.order?.length,
                                  itemBuilder: (context, index) {
                                    if (state.allOrdersHistoryModel
                                            .order![index].userId ==
                                        FirebaseAuth
                                            .instance.currentUser!.uid) {
                                      return Container(
                                        width: size.width,
                                        height: size.height * 0.2,
                                        decoration: BoxDecoration(
                                            color: Colors.red.shade700,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Products:",
                                                        style:
                                                            GoogleFonts.rubik(
                                                          color: Colors.white,
                                                          fontSize:
                                                              size.width * 0.04,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: size.width * 0.6,
                                                        child: Text(
                                                          "${state.allOrdersHistoryModel.order![index].products![0].productName}",
                                                          style:
                                                              GoogleFonts.rubik(
                                                            color: Colors.white,
                                                            fontSize:
                                                                size.width *
                                                                    0.042,
                                                          ),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Price:",
                                                        style:
                                                            GoogleFonts.rubik(
                                                          color: Colors.white,
                                                          fontSize:
                                                              size.width * 0.04,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: size.width * 0.1,
                                                        child: Text(
                                                          "${state.allOrdersHistoryModel.order![index].products![0].productPrice}",
                                                          style:
                                                              GoogleFonts.rubik(
                                                            color: Colors.white,
                                                            fontSize:
                                                                size.width *
                                                                    0.042,
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Delivery method: ',
                                                        style:
                                                            GoogleFonts.rubik(
                                                          color: Colors.white,
                                                          fontSize:
                                                              size.width * 0.04,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${state.allOrdersHistoryModel.order![index].deliveryMethod}",
                                                        style:
                                                            GoogleFonts.rubik(
                                                          color: Colors.white,
                                                          fontSize: size.width *
                                                              0.042,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Status: ',
                                                        style:
                                                            GoogleFonts.rubik(
                                                          color: Colors.white,
                                                          fontSize:
                                                              size.width * 0.04,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${state.allOrdersHistoryModel.order![index].status}",
                                                        style:
                                                            GoogleFonts.rubik(
                                                          color: Colors.white,
                                                          fontSize: size.width *
                                                              0.042,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.white
                                                    .withOpacity(0.7),
                                                size: size.width * 0.1,
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  }),
                            )
                          ],
                        )
                      : const Center(
                          child: Text("No History available"),
                        ),
            ),
          );
        },
      ),
    );
  }
}
