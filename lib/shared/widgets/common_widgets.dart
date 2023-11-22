import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:tixcash/api/apis.dart';
import 'package:tixcash/shared/constants/colors.dart';

class LogoBuilder extends StatelessWidget {
  final String logoUrl;
  final double width;
  final double height;
  const LogoBuilder({
    Key? key,
    required this.logoUrl,
    this.width = 40,
    this.height = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String lUlr =
        logoUrl; //isFullURL?(logoUrl):('assets/icon/${logoUrl.toLowerCase()=='usdt'|| logoUrl.toLowerCase()=='usdt-trc20'?'usdt':logoUrl.replaceAll('USDT', '').toLowerCase()}@2x.png');
    print('mURL => $lUlr');

    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(25.0)),
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        // imageErrorBuilder: (context, url, error) => Image.asset('assets/images/sline.png', width: 50, height: 50,),
        imageErrorBuilder: (context, url, error) => Image.asset(
          lUlr,
          width: 50,
          height: 50,
        ),
        // image: '$BASE/Icon/$lUlr',
        image: '$BASE/Icon/$lUlr',
        // image: BASE_IMAGE+logoUrl,
        width: width, height: height,
      ),
    );

    // ignore: dead_code
    return lUlr.contains('line')
        ? Image.asset(
            'assets/icons/logo.png',
            width: 50,
            height: 50,
          )
        : FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            // imageErrorBuilder: (context, url, error) => Image.asset('assets/images/sline.png', width: 50, height: 50,),
            imageErrorBuilder: (context, url, error) => Image.asset(
              lUlr,
              width: 50,
              height: 50,
            ),
            // image: '$BASE/Icon/$lUlr',
            image: '$BASE/Icon/$lUlr',
            // image: BASE_IMAGE+logoUrl,
            width: width, height: height,
          );
  }
}

Container SACellContainer(
        {required Widget child,
        EdgeInsets padding = const EdgeInsets.all(16),
        EdgeInsets margin = const EdgeInsets.only(bottom: 4, top: 4),
        Color? color,
        double? width,
        double? height,
        AlignmentGeometry? alignment}) =>
    Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      child: child,
      alignment: alignment,
      decoration: BoxDecoration(
          // gradient: ColorConstants.gradient,
          color: color ?? ColorConstants.lightGray,
          borderRadius: BorderRadius.circular(13)),
    );
