import 'package:flutter/material.dart';
import 'package:flutter_api_project_mvvm/res/color.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;

  const RoundButton({Key? key,required this.title,this.loading=false,required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 40,
        width: 80,
        decoration: BoxDecoration(
          color: AppColors.buttonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(child: loading? const CircularProgressIndicator(color: AppColors.whiteColor) : Text(title,style: TextStyle(color: AppColors.whiteColor),)),
      ),
    );
  }
}

