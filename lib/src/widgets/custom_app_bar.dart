import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: height * 0.015, vertical: height * 0.015),
      child: Row(
        children: [
          const Icon(FontAwesomeIcons.chevronLeft),
          const Spacer(),
          const Icon(FontAwesomeIcons.commentAlt),
          SizedBox(width: height * 0.02),
          const Icon(FontAwesomeIcons.headphonesAlt),
          SizedBox(width: height * 0.02),
          const Icon(FontAwesomeIcons.externalLinkAlt),
        ],
      ),
    );
  }
}
