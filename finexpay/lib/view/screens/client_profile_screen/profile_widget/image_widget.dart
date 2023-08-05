import 'package:flutter/material.dart';
import 'package:local_coin/core/utils/my_color.dart';
import 'package:local_coin/core/utils/my_images.dart';
import 'package:local_coin/core/utils/url_container.dart';
import 'package:local_coin/view/components/circle_image/circle_image_button.dart';

class ProfileImageWidget extends StatelessWidget {
  final String imagePath;
  const ProfileImageWidget({Key? key,required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String image = imagePath=='null' || imagePath.isEmpty?MyImages.defaultAvatar:'${UrlContainer.baseUrl}assets/images/user/profile/$imagePath';
    return Container(
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: MyColor.borderColor,width: .2)
        ),
        child: CircleImageWidget(imagePath: image,height: 70,width: 70, press: (){},isAsset: false,));
  }
}
