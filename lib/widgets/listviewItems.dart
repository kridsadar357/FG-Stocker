// File: widgets/listviewItems.dart

import 'package:flutter/material.dart';
class Item {
  final IconData icon;
  final String title;
  final String idbom;
  final String transaction;
  final Color backgroundColor;

  Item({
    required this.icon,
    required this.title,
    required this.idbom,
    required this.transaction,
    required this.backgroundColor,
  });
}

class ListViewItems extends StatelessWidget {
  final List<Item> items;
  final Function(int) onDelete;
  
  ListViewItems({required this.items, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Container(
          margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 0),
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: item.backgroundColor,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Row(
            children: [
              Text(
                "1000",
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigoAccent),
              ),
              SizedBox(width: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent),
                  ),
                  Text(
                    "ID BOM : ${item.idbom}",
                    style: TextStyle(fontSize: 14.0, color: Colors.white),
                  ),
                  Text(
                    "Trans. : ${item.transaction}",
                    style: TextStyle(fontSize: 12.0, color: Colors.white),
                  ),
                ],
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.delete, size: 30, color: Colors.white),
                onPressed: () => onDelete(index), // Call the onDelete callback with the index
              ),
            ],
          ),
        );
      },
    );
  }
}