// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import '../controller/login.dart';
import '../controller/scanBarcode.dart';
import 'login.dart';
import 'listsIncomeChildPart.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8BA9F8),
        title: Text(
          "Child Part Stock Control",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              clearUserData();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildCategoryButton(
              icon: Icons.arrow_circle_down,
              color: Colors.pink,
              title: 'รับเข้า Stock',
              subtitle: 'Part In Store',
              onTap: () async {
                final result = await scanQRCode(context);
                if (result != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListsIncomeChildPart(
                        result.idBom,
                        result.transectionId,
                        result.partNo,
                        result.scannedData,
                      ),
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 16),
            buildCategoryButton(
              icon: Icons.arrow_circle_up,
              color: Colors.deepOrange,
              title: 'เบิกออก Stock',
              subtitle: 'Part Out Store',
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => NewDefectMcPage(),
                //   ),
                // );
              },
            ),
            SizedBox(height: 16),
            buildCategoryButton(
              icon: Icons.search,
              color: Colors.red,
              title: 'ตรวจสอบบาร์โค้ด',
              subtitle: 'Check Status Barcode',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    TextEditingController searchController =
                        TextEditingController();
                    return AlertDialog(
                      title: Text('ค้นหาข้อมูล'),
                      content: TextField(
                        controller: searchController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'กรอกเลขอ้างอิงข้อมูล',
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('ยกเลิก'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            String searchText = searchController.text;
                            Navigator.of(context).pop(); // Close the dialog
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) =>
                            //         SearchPage(searchText: searchText),
                            //   ),
                            // );
                          },
                          child: Text('ค้นหา'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            SizedBox(height: 16),
          ],
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
              iconSize: 30,
              onPressed: () async {
                final result = await scanQRCode(context);
                if (result != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListsIncomeChildPart(
                        result.idBom,
                        result.transectionId,
                        result.partNo,
                        result.scannedData,
                      ),
                    ),
                  );
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.print),
              color: Colors.white,
              iconSize: 30,
              onPressed: () {
                // Add functionality for the third bottom bar button
              },
            ),
            IconButton(
              icon: Icon(Icons.manage_accounts),
              color: Colors.white,
              iconSize: 30,
              onPressed: () {
                // Add functionality for the third bottom bar button
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCategoryButton({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2.0,
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          splashFactory: InkSplash.splashFactory,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Icon(
                  Icons.chevron_right,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
