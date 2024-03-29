import 'package:bookstore/res/constant_page.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onTap;
  const CustomButton({Key? key, required this.buttonText, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Constant.height/10,
      width:Constant.width/1.3,
      child: ElevatedButton(
      
        style: ButtonStyle(
         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                ),
            ),),
        onPressed:  onTap, child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(buttonText,style:TextStyle(fontSize: Constant.height/40)),
           const  Icon(
                  Icons.shopping_bag_outlined,
                  size: 30,
                  color: Colors.white,
                ),
          ],
        )),
    );
  }
}
