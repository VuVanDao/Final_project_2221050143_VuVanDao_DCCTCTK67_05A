import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/main.dart';
import './views/manage_view.dart';

class Second extends StatefulWidget {
  const Second({super.key});

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ứng dụng quản lí sinh viên'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Chào mừng đến với ứng dụng quản lý sinh viên!',
              style: TextStyle(
                fontSize: 30, // Kích thước văn bản lớn
                fontWeight: FontWeight.bold, // Đậm chữ
                color: Colors.black, // Màu chữ
              ),
              textAlign: TextAlign.center, // Căn giữa
            ),
            const SizedBox(height: 100), // Khoảng cách giữa 2 widget
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ManageView()),
                );
              },
              child: const Text('Bắt đầu'),
            ),
          ],
        ),
      ),
    );
  }
}
