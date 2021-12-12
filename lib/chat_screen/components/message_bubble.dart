import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MessageBubble extends StatefulWidget {
  final String text;
  final bool isMe;
  final String time;
  final Timestamp timestamp;
  final String type;
  final String link;
  const MessageBubble(
      {required this.timestamp,
      required this.text,
      required this.isMe,
      required this.time,
      required this.type,
      required this.link});

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {

  Duration position = Duration(
    seconds: 0,
    minutes: 0,
  );

  Duration totalDuration = Duration(
    seconds: 160,
    minutes: 1,
  );

  @override
  void initState() {
    super.initState();

  }

  late IconData icon = Icons.play_arrow;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    if (!widget.isMe) {
      /// Receiver Bubble
      if (widget.type == 'text') {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                width: size.width * 0.12,
                height: size.width * 0.12,
                margin: const EdgeInsets.only(
                    left: 5, bottom: 20, right: 7, top: 3),
                decoration:
                    BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                child: Text(
                  'S',
                  style: TextStyle(
                    fontSize: size.width * 0.05,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 15, bottom: 15, right: 10, left: 10),
                constraints: BoxConstraints(
                  maxWidth: size.width * 0.67,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18),
                    topRight: Radius.circular(18),
                  ),
                ),
                child: Text(
                  widget.text,
                  style: const TextStyle(color: Colors.black, height: 1.5),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  widget.time,
                  style: TextStyle(
                      color: Colors.grey.withOpacity(0.9),
                      fontSize: size.width * 0.03),
                ),
              )
            ],
          ),
        );
      } else if (widget.type == 'image') {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                width: size.width * 0.12,
                height: size.width * 0.12,
                margin: const EdgeInsets.only(
                    left: 5, bottom: 20, right: 7, top: 3),
                decoration:
                    BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                child: Text(
                  'R'.toUpperCase(),
                  style: TextStyle(
                      fontSize: size.width * 0.05, color: Colors.white),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Hero(
                  tag: 'image',
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 15, bottom: 15, right: 10, left: 10),
                    width: size.width * 0.67,
                    height: size.height * 0.3,
                    decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.2),
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(18),
                            bottomRight: Radius.circular(18),
                            topRight: Radius.circular(18))),
                    child: CachedNetworkImage(
                      imageUrl: widget.link,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  widget.time,
                  style: TextStyle(
                      color: Colors.grey.withOpacity(0.9),
                      fontSize: size.width * 0.03),
                ),
              )
            ],
          ),
        );
      } else {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                width: size.width * 0.12,
                height: size.width * 0.12,
                margin: const EdgeInsets.only(
                    left: 5, bottom: 20, right: 7, top: 3),
                decoration:
                    BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                child: Text(
                  'S'.toString()[0].toUpperCase(),
                  style: TextStyle(
                      fontSize: size.width * 0.05, color: Colors.white),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 15, bottom: 15, right: 10, left: 10),
                width: size.width * 0.67,
                height: size.height * 0.08,
                decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.2),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(18),
                        bottomRight: Radius.circular(18),
                        topRight: Radius.circular(18))),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        playAudio(widget.link);
                      },
                      child: Container(
                        width: size.width * 0.12,
                        height: size.width * 0.12,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: Icon(
                          icon,
                          color: Colors.white,
                          size: size.width * 0.054,
                        ),
                      ),
                    ),
                    Text(
                      (position.toString().split(".").first).length < 6
                          ? "00:00"
                          : position.toString().split(".").first,
                      style: TextStyle(
                          fontSize: size.width * 0.03,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: size.width * 0.15,
                      width: size.width * 0.38,
                      child: Slider(
                        value: position.inMilliseconds.toDouble(),
                        onChanged: (value) {
                          if (position.inMilliseconds.toDouble().toString() ==
                              totalDuration.inMilliseconds
                                  .toDouble()
                                  .toString()) {
                            print('kashif....');
                            setState(() {
                              icon = Icons.play_arrow;
                            });
                          }
                        },
                        max: totalDuration.inMilliseconds.toDouble() + 1.0,
                        activeColor: Colors.red,
                        inactiveColor: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  widget.time,
                  style: TextStyle(
                      color: Colors.grey.withOpacity(0.9),
                      fontSize: size.width * 0.03),
                ),
              )
            ],
          ),
        );
      }
    } else {
      /// Sender Bubble
      if (widget.type == 'text') {
        return Container(
          margin: const EdgeInsets.only(right: 10, top: 5, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.only(right: 7),
                child: Text(
                  widget.time,
                  style: TextStyle(
                      color: Colors.grey.withOpacity(0.8),
                      fontSize: size.width * 0.03),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 15, bottom: 15, right: 10, left: 10),
                constraints: BoxConstraints(
                  maxWidth: size.width * 0.78,
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(18),
                      topRight: Radius.circular(18),
                      topLeft: Radius.circular(18)),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xffda3838),
                      Color(0xfff55159),
                      Color(0xfff55159),
                      Color(0xfff55159),
                      Color(0xfff55159),
                      Color(0xfff55159),
                      Color(0xfff55159),
                      Color(0xfff55159),
                      Color(0xfff55159),
                      Color(0xfff55159),
                      Color(0xfff55159)
                    ],

                    // transform:
                  ),
                ),
                child: Text(
                  widget.text,
                  style: const TextStyle(color: Colors.white, height: 1.5),
                ),
              ),
            ],
          ),
        );
      } else if (widget.type == 'image') {
        return Container(
          width: size.width,
          margin: const EdgeInsets.only(right: 10, top: 5, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.only(right: 7),
                child: Text(
                  widget.time,
                  style: TextStyle(
                      color: Colors.grey.withOpacity(0.8),
                      fontSize: size.width * 0.03),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Hero(
                  tag: 'image',
                  child: Container(
                    padding: const EdgeInsets.only(
                        top: 15, bottom: 15, right: 10, left: 10),
                    width: size.width * 0.78,
                    height: size.height * 0.3,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(18),
                          topRight: Radius.circular(18),
                          topLeft: Radius.circular(18)),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xffda3838),
                          Color(0xfff55159),
                          Color(0xfff55159),
                          Color(0xfff55159),
                          Color(0xfff55159),
                          Color(0xfff55159),
                          Color(0xfff55159),
                          Color(0xfff55159),
                          Color(0xfff55159),
                          Color(0xfff55159),
                          Color(0xfff55159)
                        ],
                        // transform:
                      ),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: widget.link,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        return Container(
          width: size.width,
          margin: const EdgeInsets.only(right: 10, top: 5, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.only(right: 7),
                child: Text(
                  widget.time,
                  style: TextStyle(
                      color: Colors.grey.withOpacity(0.8),
                      fontSize: size.width * 0.03),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 15, bottom: 15, right: 10, left: 10),
                width: size.width * 0.78,
                height: size.height * 0.08,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(18),
                      topRight: Radius.circular(18),
                      topLeft: Radius.circular(18)),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xffda3838),
                      Color(0xfff55159),
                      Color(0xfff55159),
                      Color(0xfff55159),
                      Color(0xfff55159),
                      Color(0xfff55159),
                      Color(0xfff55159),
                      Color(0xfff55159),
                      Color(0xfff55159),
                      Color(0xfff55159),
                      Color(0xfff55159)
                    ],
                    // transform:
                  ),
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        playAudio(widget.link);
                      },
                      child: Container(
                        width: size.width * 0.12,
                        height: size.width * 0.12,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: Icon(
                          icon,
                          color: Colors.white,
                          size: size.width * 0.054,
                        ),
                      ),
                    ),
                    Text(
                      (position.toString().split(".").first).length < 6
                          ? "00:00"
                          : position.toString().split(".").first,
                      style: TextStyle(
                          fontSize: size.width * 0.03,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: size.width * 0.15,
                      width: size.width * 0.47,
                      child: Slider(
                        value: position.inMilliseconds.toDouble(),
                        onChanged: (value) {
                          if (position.inMilliseconds.toDouble().toString() ==
                              totalDuration.inMilliseconds
                                  .toDouble()
                                  .toString()) {
                            print('kashif....');
                            setState(() {
                              icon = Icons.play_arrow;
                            });
                          }
                        },
                        max: totalDuration.inMilliseconds.toDouble() + 1.0,
                        activeColor: Colors.red,
                        inactiveColor: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }
    }
  }

  playAudio(String url) async {
    if (icon == Icons.play_arrow) {
    } else {
    }
    setState(() {
      icon = icon == Icons.play_arrow ? Icons.pause_outlined : Icons.play_arrow;
    });
  }
}
