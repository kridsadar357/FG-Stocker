// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../controller/scanBarcode.dart';
import '../widgets/listviewItems.dart';
import '../model/ScannedResult.dart';

class ListsIncomeChildPart extends StatefulWidget {
  final String idBom;
  final String transectionId;
  final String partNo;
  final String scannedData;

  ListsIncomeChildPart(
      this.idBom, this.transectionId, this.partNo, this.scannedData);

  @override
  _ListsIncomeChildPartState createState() => _ListsIncomeChildPartState();
}

class _ListsIncomeChildPartState extends State<ListsIncomeChildPart> {
  List<Item> items = [];

  @override
  void initState() {
    super.initState();
    items.add(Item(
      icon: Icons.arrow_drop_down_circle,
      title: widget.partNo,
      idbom: widget.idBom,
      transaction: widget.transectionId,
      backgroundColor: Colors.grey,
    ));
  }

  void _handleScan(BuildContext context) async {
    ScannedResult? scannedData = await scanQRCode(context);
    if (scannedData != null) {
      int duplicateIndex = items
          .indexWhere((item) => item.transaction == scannedData.transectionId);
      if (duplicateIndex != -1) {
        showAlertDialog(context, "เกิดข้อผิดพลาด", "Barcode นี้มีอยู่ในรายการแล้ว");
      } else {
        setState(() {
          items.add(Item(
            icon: Icons.arrow_drop_down_circle,
            title: scannedData.partNo, // Correct partNo
            idbom: scannedData.idBom, // Correct idBom
            transaction: scannedData.transectionId, // Correct transectionId
            backgroundColor: Colors.grey,
          ));
        });
      }
    }
  }

  void _handleDelete(int index) {
    setState(() {
      items.removeAt(index);  // Remove the item from the list
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFF8BA9F8),
      appBar: AppBar(
        backgroundColor: Color(0xFF8BA9F8),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Waiting in Store (${items.length})', // Show the number of items
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
          child: Center(
            child: Container(
              width: screenWidth,
              height: screenHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListViewItems(items: items , onDelete: _handleDelete,),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF8BA9F8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.qr_code),
              color: Colors.white,
              iconSize: 50,
              onPressed: () {
                _handleScan(context); // Call the correct scan function
              },
            ),
            IconButton(
              icon: Icon(Icons.save),
              color: Colors.white,
              iconSize: 50,
              onPressed: () {
                // Add functionality for the save button
              },
            ),
          ],
        ),
      ),
    );
  }
}
