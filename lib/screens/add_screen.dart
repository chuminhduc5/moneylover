import 'package:flutter/material.dart';
import 'package:money_manage/screens/home_screen.dart';
import 'package:money_manage/widget/button_add_widget.dart';
import 'package:money_manage/widget/dropDownMenu_widget.dart';
import 'package:money_manage/widget/field_add_widget.dart';

import '../home.dart';

const List<String> list = <String>['Income', 'Expense'];

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            }, 
            icon: Icon(Icons.close)),
        title: Text('Thêm giao dịch'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            FieldAddWidget(),
            SizedBox(
              height: 10,
            ),
            DropDownMenuWidget(),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonAddWidget(buttonName: 'Thêm')
              ],
            )
          ],
        ),
      ),
    ));
  }
}
