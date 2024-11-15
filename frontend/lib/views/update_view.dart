import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'manage_view.dart';
import '../models/manage_model.dart';

class UpdateView extends StatelessWidget {
  final ManageModel item;

  const UpdateView({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chỉnh sửa thông tin")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              initialValue: item.lop, //gán giá trị lấy từ manage_view
              decoration: const InputDecoration(labelText: 'Sửa lớp sinh viên'),
              onChanged: (value) {
                item.lop = value;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: item.ten, //gán giá trị lấy từ manage_view
              decoration: const InputDecoration(labelText: 'Sửa tên sinh viên'),
              onChanged: (value) {
                item.ten = value;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, item); // trở về manage_view
              },
              child: const Text('Lưu'),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
