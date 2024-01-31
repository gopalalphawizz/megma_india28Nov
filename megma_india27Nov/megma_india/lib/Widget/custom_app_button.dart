import 'package:flutter/cupertino.dart';
import 'package:megma_india/Helper/Colors.dart';

class CustomButton extends StatefulWidget {
  String? textt;

  CustomButton({Key? key, this.textt}) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width / 1.3,
      decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(
              MediaQuery.of(context).size.width / (1.5) / 2)),
      child: Center(
        child: Text(
          '${widget.textt.toString()}',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: AppColors.whiteTemp),
        ),
      ),
    );
  }
}
