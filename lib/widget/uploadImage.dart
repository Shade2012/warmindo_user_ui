import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


typedef ImageCaptureCallback = void Function(ImageSource source);

class UploadImage extends StatelessWidget {
  final ImageCaptureCallback? onImageCapture;

  UploadImage({this.onImageCapture});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (onImageCapture != null) {
                    onImageCapture!(ImageSource.camera);
                  } else {
                    print('onImageCapture callback is null');
                  }
                },
                child: Column(
                  children: [
                    Icon(Icons.camera_alt, size: 40),
                    SizedBox(height: 10),
                    Text('Camera', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              SizedBox(width: screenWidth * 0.3),
              GestureDetector(
                onTap: () {
                  if (onImageCapture != null) {
                    onImageCapture!(ImageSource.gallery);
                  } else {
                    print('onImageCapture callback is null');
                  }
                },
                child: Column(
                  children: [
                    Icon(Icons.photo, size: 40),
                    SizedBox(height: 10),
                    Text('Gallery', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
