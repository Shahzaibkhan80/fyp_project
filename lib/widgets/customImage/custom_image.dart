import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String imageUrl;
  final String? title;
  final double? imagewidth;
  final double? imageheight;
  final VoidCallback? ontap;

  const CustomImage({
    super.key,
    required this.imageUrl,
    this.title,
    this.imagewidth,
    this.imageheight,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Column(
        children: [
          Image(
            image: AssetImage(imageUrl),
            height: imageheight,
            width: imagewidth,
          ),
          SizedBox(
            height: 5,
          ),
          if (title != null)
            Text(
              title!,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}
