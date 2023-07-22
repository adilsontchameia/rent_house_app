import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rent_house_app/features/data/mock_data.dart';

class ImageListView extends StatefulWidget {
  final int startIndex;
  const ImageListView({
    super.key,
    required this.startIndex,
  });

  @override
  State<ImageListView> createState() => _ImageListViewState();
}

class _ImageListViewState extends State<ImageListView> {
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        //Implement scroll of listView
        _autoScroll();
      }
    });
  }

  void _autoScroll() {
    final currentScrollPosition = _scrollController.offset;
    final scrollEndPosition = _scrollController.position.maxScrollExtent;

    scheduleMicrotask(() {
      _scrollController.animateTo(
        currentScrollPosition == scrollEndPosition ? 0 : scrollEndPosition,
        duration: const Duration(seconds: 10),
        curve: Curves.linear,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 1.96 * pi,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.60,
        width: MediaQuery.of(context).size.width * 0.60,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: 5,
          itemBuilder: ((context, index) {
            return CachedNetworkImage(
                imageUrl: products[widget.startIndex + index].houseImage,
                imageBuilder: (context, imageProvider) {
                  return Container(
                    margin: const EdgeInsets.only(
                      right: 8.0,
                      left: 8.0,
                      top: 10.0,
                    ),
                    height: MediaQuery.of(context).size.height * 0.50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        )),
                  );
                });
          }),
        ),
      ),
    );
  }
}
