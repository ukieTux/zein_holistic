import 'package:flutter/material.dart';
import 'package:zein_holistic/core/extensions/extensions.dart';
import 'package:zein_holistic/ui/resources/resources.dart';

///*********************************************
/// Created by ukietux on 11/09/20 with ♥
/// (>’_’)> email : ukie.tux@gmail.com
/// github : https://www.github.com/ukieTux <(’_’<)
///*********************************************
/// © 2020 | All Right Reserved
class Toast extends StatelessWidget {
  final IconData? icon;
  final Color? bgColor;
  final Color? textColor;
  final String? message;

  const Toast({Key? key, this.icon, this.bgColor, this.message, this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: EdgeInsets.symmetric(
            vertical: context.dp8(),
            horizontal: 16,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: textColor,
              ),
              SizedBox(
                width: context.dp4(),
              ),
              Container(
                constraints:
                    BoxConstraints(maxWidth: context.widthInPercent(50)),
                child: Text(
                  message!,
                  style: TextStyles.text.copyWith(
                      color: textColor, decoration: TextDecoration.none),
                  textAlign: TextAlign.start,
                  maxLines: 5,
                  softWrap: true,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
