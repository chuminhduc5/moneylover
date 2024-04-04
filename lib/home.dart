import 'package:currency_picker/currency_picker.dart';
import 'package:currency_picker/src/currency.dart';
import 'package:flutter/material.dart';
import 'package:money_manage/screens/account_screen.dart';
import 'package:money_manage/screens/add_screen.dart';
import 'package:money_manage/screens/budget_screen.dart';
import 'package:money_manage/screens/home_screen.dart';
import 'package:money_manage/screens/transaction_screen.dart';

class Home extends StatefulWidget {
  final Currency? selectedCurrency;
  const Home({Key? key, required this.selectedCurrency}) : super(key: key);
  //const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Currency? selectedCurrency;
  int _selectedIndex = 0;

  void _navigateBottomBar (int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  late List<Widget> _screen;
  @override
  void initState() {
    super.initState();
    _screen = [
      HomeScreen(selectedCurrency: selectedCurrency!),
      TransactionScreen(),
      AddScreen(),
      BudgetScreen(),
      AccountScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        selectedFontSize: 10,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Tổng quan'),
          BottomNavigationBarItem(icon: Icon(Icons.file_copy), label: 'Sổ giao dịch'),
          BottomNavigationBarItem(
              icon: Stack(
                children: <Widget>[
                  Icon(Icons.add, size: 50,),
                  Positioned(
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                      child: Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                ],
              ),
            label: '',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.collections_bookmark_rounded), label: 'Ngân sách'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Tài khoản'),
        ],
      ),
    );
  }
}

