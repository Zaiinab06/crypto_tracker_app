import 'package:flutter/material.dart';

PreferredSizeWidget coffeeAppbar() {
  return AppBar(
    backgroundColor: Colors.white,
    leadingWidth: 300,
    leading: Row(
      children: [
        SizedBox(width: 10),
        IconButton(
          onPressed: () {
            print("Pressed Back!");
          },
          icon: Icon(Icons.arrow_back, color: Colors.grey),
        ),
        SizedBox(width: 12),
        Container(
          width: 100,
          height: 42,
          decoration: BoxDecoration(
            color: Colors.grey.withValues(alpha: .13),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              "Table 13",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ),
      ],
    ),
    actions: [
      Container(
        width: 70,
        height: 42,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.green.shade900),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("AR", style: TextStyle(fontSize: 16, color: Colors.green)),
              SizedBox(width: 4),
              Icon(Icons.language, color: Colors.green),
            ],
          ),
        ),
      ),
      SizedBox(width: 10),
      Stack(
        children: [
          Icon(Icons.shopping_bag_outlined, size: 28, color: Colors.black),
          Positioned(
            right: -4,
            top: -.1,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  "3",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          ),
        ],
      ),
      SizedBox(width: 10),
      Icon(Icons.search, color: Colors.black, size: 28),
      SizedBox(width: 10),
    ],
  );
}
