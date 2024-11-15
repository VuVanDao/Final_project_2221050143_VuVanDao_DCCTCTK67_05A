import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/manage_model.dart';
import './update_view.dart';

String getBackendUrl() {
  if (kIsWeb) {
    return 'http://localhost:8080'; // hoặc sử dụng IP LAN nếu cần
  } else if (Platform.isAndroid) {
    return 'http://10.0.2.2:8080'; // cho emulator
    // return 'http://192.168.1.x:8080'; // cho thiết bị thật khi truy cập qua LAN
  } else {
    return 'http://localhost:8080';
  }
}

class ManageView extends StatefulWidget {
  const ManageView({super.key});
  @override
  State<ManageView> createState() => _ManageViewState();
}

class _ManageViewState extends State<ManageView> {
  final _manager = <ManageModel>[];
  final _masv = TextEditingController();
  final _ten = TextEditingController();
  final _lop = TextEditingController();
  final _gpa = TextEditingController();
  final _headers = {'Content-Type': 'application/json'};
  final apiUrl = '${getBackendUrl()}/api/v1/todos';
  //lay ds todo
  Future<void> _fetchManager() async {
    final res = await http.get(Uri.parse(apiUrl));
    if (res.statusCode == 200) {
      final List<dynamic> todoList = json.decode(res.body);
      setState(() {
        _manager.clear();
        _manager.addAll(todoList.map((e) => ManageModel.fromMap(e)).toList());
      });
    }
  }

  //them 1 sinh vien
  Future<void> _addStudent() async {
    if (_masv.text.isEmpty) return;
    if (_ten.text.isEmpty) return;
    if (_lop.text.isEmpty) return;
    if (_gpa.text.isEmpty) return;

    final newItem = ManageModel(
        msv: int.parse(_masv.text),
        ten: _ten.text,
        lop: _lop.text,
        gpa: double.parse(_gpa.text),
        diemdanh: false);
    final res = await http.post(Uri.parse(apiUrl),
        headers: _headers, body: json.encode(newItem.toMap()));
    if (res.statusCode == 200) {
      _masv.clear();
      _ten.clear();
      _lop.clear();
      _gpa.clear();
      _fetchManager(); //lam moi ds
    }
  }

  //cap nhat trang thai complete
  Future<void> _updateDiemDanh(ManageModel item) async {
    item.diemdanh = !item.diemdanh; //thay doi trang thai true,false
    final res = await http.put(Uri.parse('$apiUrl/${item.msv}'),
        headers: _headers, body: json.encode(item.toMap()));
    if (res.statusCode == 200) {
      _fetchManager();
    }
  }

  Future<void> _updateDataSV(ManageModel item) async {
    item.msv != item.msv;
    item.ten != item.ten;
    item.lop != item.lop;
    final res = await http.put(Uri.parse('$apiUrl/${item.msv}'),
        headers: _headers, body: json.encode(item.toMap()));
    if (res.statusCode == 200) {
      _fetchManager();
    }
  }

  //xoa sinh vien
  Future<void> _deleteSinhVien(int id) async {
    final res = await http.delete(
      Uri.parse('$apiUrl/$id'),
    );
    if (res.statusCode == 200) {
      _fetchManager();
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchManager();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: const Text("Quản lí sinh viên"), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              //add todo
              Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: _masv,
                    decoration:
                        const InputDecoration(labelText: "Nhập mã sinh viên"),
                  )),
                  const Icon(Icons.numbers)
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: _ten,
                    decoration:
                        const InputDecoration(labelText: "Nhập tên sinh viên"),
                  )),
                  const Icon(Icons.abc)
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: _lop,
                    decoration:
                        const InputDecoration(labelText: "Lớp của sinh viên"),
                  )),
                  const Icon(Icons.class_outlined)
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: _gpa,
                    decoration:
                        const InputDecoration(labelText: "GPA của sinh viên"),
                  )),
                  const Icon(Icons.score)
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                  onPressed: _addStudent,
                  icon: const Icon(Icons.add),
                  label: const Text("Thêm thông tin")),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  //ds todo
                  child: ListView.builder(
                      itemCount: _manager.length,
                      itemBuilder: (context, index) {
                        final item = _manager.elementAt(index);
                        return ListTile(
                          title: Text(item.msv.toString() +
                              ". " +
                              item.ten +
                              "- " +
                              item.lop +
                              " - " +
                              item.gpa.toString()),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                  value: item.diemdanh,
                                  onChanged: (value) {
                                    _updateDiemDanh(item);
                                  }),
                              IconButton(
                                  onPressed: () {
                                    _deleteSinhVien(item.msv);
                                  },
                                  icon: const Icon(Icons.remove))
                            ],
                          ),
                          onTap: () async {
                            // Điều hướng đến EditPage khi nhấn vào ListTile
                            final updatedItem = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateView(item: item),
                              ),
                            );

                            // Kiểm tra nếu có thay đổi từ EditPage, cập nhật lại danh sách
                            if (updatedItem != null) {
                              _updateDataSV(
                                  updatedItem); // Hoặc sử dụng một hàm khác để cập nhật item
                            }
                          },
                        );
                      }))
            ],
          ),
        ));
  }
}
