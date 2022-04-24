import 'package:client/constant/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class GroupCarousel extends StatefulWidget {
  final String title;
  final List<String> images;
  final List<String> projects;

  const GroupCarousel({
    Key? key,
    required this.title,
    required this.images,
    required this.projects,
  }) : super(key: key);

  @override
  _GroupCarouselState createState() => _GroupCarouselState();
}

class _GroupCarouselState extends State<GroupCarousel> {

  final CarouselController _controller = CarouselController();
  final List _isSelected = [true, false, false, false, false, false, false];
  int _current = 0;

  List<Widget> generateImageTiles(screenSize) {
    return widget.images.map((element) => ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.network(
        element,
        fit: BoxFit.cover,
      ),
    ),).toList();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var imageSliders = generateImageTiles(screenSize);

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: screenSize.height / 70, bottom: screenSize.height / 70),
          child: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Stack(
          children: [
            CarouselSlider(
              items: imageSliders,
              options: CarouselOptions(
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                aspectRatio: 18 / 8,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                    for (int i = 0; i < imageSliders.length; i++) {
                      i == index
                      ? _isSelected[i] = true
                      : _isSelected[i] = false;
                    }
                  });
                }
              ),
              carouselController: _controller,
            ),
            AspectRatio(
              aspectRatio: 18 / 8,
              child: Center(
                child: Text(
                  widget.projects[_current],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    letterSpacing: 6,
                    fontSize: screenSize.width / 25,
                    color: MyColors.cardItemTextColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}