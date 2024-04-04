import 'dart:convert';

import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:money_manage/widget/report_widget.dart';
import 'package:money_manage/widget/wallet_widget.dart';
import 'package:http/http.dart' as http;
import '../models/transactions.dart';

class HomeScreen extends StatefulWidget {
  final Currency? selectedCurrency;
  const HomeScreen({Key? key, required this.selectedCurrency}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double balance = 0;
  List<Transactions> transactions = [];

  @override
  void initState(){
    super.initState();
    fetchTransactions();
  }
  
  Future<void> fetchTransactions() async {
    try {
      final response = await http.get(
        Uri.parse('https://660d6ef86ddfa2943b34664b.mockapi.io/User'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        print('Fetch Json Data: $jsonData');
        setState(() {
          transactions = jsonData.map((item) => Transactions.fromJson(item)).toList();
          calculateBalance(transactions);
        });
      }
    }catch(e) {
      print('Error');
    }
  }

  void calculateBalance(List<Transactions> transactions) {
    balance = transactions.fold(0, (prev, transactions) {
      if (transactions.type == 'Income'){
        return prev + transactions.amount;
      } else{
        return prev - transactions.amount;
      }
    });
  }
  
  Future<void> addTransaction(String type, double amount) async{
    try{
      final response = await http.post(
        Uri.parse('https://660d6ef86ddfa2943b34664b.mockapi.io/User'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'type': type,
          'amount': amount,
          'time': DateTime.now().toIso8601String(),
          'category': type == 'Income' ? 'Thu' : 'Chi'
        })
      );

      if (response.statusCode == 201){
        setState(() {
          transactions.add(Transactions(
              type: type,
              amount: amount,
              time: DateTime.now(),
              category: type == 'Income' ? 'Thu' : 'Chi',
          ));
          calculateBalance(transactions);
        });
      }else{
        throw Exception('Failed to add transaction');
      }
    }catch(e){
      print('Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('0 đ', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                              SizedBox(width: 10,),
                              Icon(Icons.remove_red_eye),
                            ],
                          ),
                          Text('Tổng số dư?', style: TextStyle(color: Colors.grey, fontSize: 16),),
                        ],
                      ),
                      Icon(Icons.notifications, size: 30,),
                    ],
                  ),
                  const SizedBox(height: 25,),
                  const WalletWidget(),
                  const SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Báo cáo chi tiêu'),
                      InkWell(
                        onTap: (){},
                        child: const Text('Xem báo cáo', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  const ReportWidget(),
                ],
            ),
          ),
        ),
      ),
    );
  }
}
