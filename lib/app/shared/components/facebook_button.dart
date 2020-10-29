import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FacebookButton extends StatelessWidget {
  const FacebookButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth * .85,
      height: 45,
      decoration: BoxDecoration(
        color: Color(0xFF4267B3), // azul do facebook
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 2),
            child: Icon(
              FontAwesome.facebook,
              color: Colors.white,
              size: 25,
            ),
          ),
          // divisor vertical...
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: VerticalDivider(
              color: Colors.white,
              thickness: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Conectar com facebook',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 50,
              ),
              // garantindo que o texto tenha o mesmo tamanho nos diversos disp.
              textScaleFactor: ScreenUtil().scaleText,
            ),
          ),
        ],
      ),
    );
  }
}
