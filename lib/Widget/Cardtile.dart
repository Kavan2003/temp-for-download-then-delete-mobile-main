import 'package:flutter/material.dart';

class CardInfo extends StatelessWidget {
  const CardInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Text(
                  'Rejected-Customer Not Reachable',
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
