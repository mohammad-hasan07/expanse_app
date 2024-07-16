
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SummaryCard extends StatelessWidget {
  final String? topTitle;
  final String? title;
  final double amount;
  final IconData icon;
  final Color backgroundColor;
  final double? height;
  final double? width;

  const SummaryCard({
     this.title,
    required this.amount,
    required this.icon,
    required this.backgroundColor,  this.height,  this.width, this.topTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: width??Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: backgroundColor.withOpacity(0.1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            topTitle==null?const SizedBox():
            Text(
              topTitle??"",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: backgroundColor,
              ),
            ),
             ListTile(
               leading: Icon(icon, color: backgroundColor),
               title:topTitle==null? Text(
                 title??"",
                 style: TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 16,
                   color: backgroundColor,
                 ),
               ):null,
               trailing: Text(
                 '₹${amount.toStringAsFixed(2)}',
                 style: TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 18,
                   color: backgroundColor,
                 ),
               ),
             ),
          ],
        ),
      ),
    );
  }
}