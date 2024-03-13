import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:bookstore/res/constant_page.dart';

class BookCard extends StatelessWidget {
  final String image;
  final String bookName;
  final String firstAuthor;
  final String publishedYear;
  final bool bookStatus;
  final void Function(bool)? onChanged;
  const BookCard({
    Key? key,
    required this.image,
    required this.bookName,
    required this.firstAuthor,
    required this.publishedYear,
    required this.bookStatus,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              height: Constant.height / 2.5,
              child: Image.network(
                image,fit: BoxFit.fill,
              ),
            ),
          ),
             Container(
             color: Colors.white,
             width: double.infinity,
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                    //  SizedBox(height: Constant.height/20,),
                           Text(bookName,style:GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,),
                          const SizedBox(height: 10,),
                           Text(firstAuthor,style:GoogleFonts.roboto(fontSize: 14,fontWeight: FontWeight.w600,color:Colors.grey)),
                           const SizedBox(height: 5),
                           Text('Published on $publishedYear',style:GoogleFonts.roboto(fontSize: 14,fontWeight: FontWeight.w600,color:Colors.black54)),
                           const SizedBox(height: 6,),
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               SizedBox(
                                height: Constant.height/40,
                                width: 50,
                                child: Switch(value: bookStatus, onChanged: onChanged,activeColor: Colors.green,)),
                                                         bookStatus==true? FittedBox(child: Text('Read',style:GoogleFonts.roboto(fontSize: 14,fontWeight: FontWeight.w600,color:Colors.green)))
                                                         :Text('Unread',style:GoogleFonts.roboto(fontSize: 14,fontWeight: FontWeight.w600,color:Colors.red)),
                             ],
                           ),
                   ],
                 ),
               ),
             ),
        ],
      ),
    );
  }
}
