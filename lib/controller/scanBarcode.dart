// ignore_for_file: use_build_context_synchronously, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../pages/qrCodeScannerPage.dart'; 

import '../model/ScannedResult.dart'; 

import '../environment.dart'; 


Future<ScannedResult?> scanQRCode(BuildContext context) async {
  try {
    String? scannedData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const QRCodeScannerPage(),
      ),
    );
    if (scannedData != null) {
      showLoadingDialog(context);
      http.Response response = await http.get(Uri.parse(Url_Fetch_Part + scannedData));
      Navigator.pop(context);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status_bom'] == 0) {
          showAlertDialog(context, "เกิดข้อผิดพลาด", "Barcode นี้ยังไม่ถูกลงทะเบียนโดยฝ่ายผลิต");
        } else if (responseData['status_repeat'] == 0) {
          showAlertDialog(context, "เกิดข้อผิดพลาด", "ข้อมูลซ้ำในระบบ");
        } else {
          return ScannedResult(
            idBom: responseData['id_bom'],
            transectionId: responseData['transection_id'],
            partNo: responseData['part_no'],
            scannedData: scannedData,
          );
        }
      } else {
        // Handle server error
        showAlertDialog(context, "Server Error", "Failed to fetch data. Status Code: ${response.statusCode}");
      }
    }
  } catch (error) {
    showAlertDialog(context, "Error", "An error occurred: $error");
  }
  return null;
}

Future<void> showLoadingDialog(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text(
                  "กำลังประมวลผล...",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> showAlertDialog(BuildContext context, String title, String content) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
