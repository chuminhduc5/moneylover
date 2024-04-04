import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  Currency? selectedCurrency;

  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
  }

  _checkOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool onboarded = prefs.getBool('onboarded') ?? false;
    if (onboarded) {
      _loadSelectedCurrency();
    }
  }

  _loadSelectedCurrency() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? currencyCode = prefs.getString('selectedCurrency');
    if (currencyCode != null) {
      setState(() {
        selectedCurrency = CurrencyService().findByCode(currencyCode);
      });
      _navigateToHome();
    }
  }

  _saveSelectedCurrency(String currencyCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedCurrency', currencyCode);
    prefs.setBool('onboarded', true);
    _navigateToHome();
  }

  _navigateToHome() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Home(
              selectedCurrency: selectedCurrency!,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Chọn đơn vị tiền tệ bạn sử dụng',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
              ),
              const Text('Bạn có thể thay đổi sang đươn vị tiền khác bất cứ lúc nào', style: TextStyle(fontSize: 14, color: Colors.grey),),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size.fromWidth(370),
                  padding: EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  side: const BorderSide(color: Colors.white38, width: 2),
                  // Change background color
                  backgroundColor: const Color(0xFF696868), // Add border
                ),
                onPressed: () {
                  showCurrencyPicker(
                    context: context,
                    showFlag: true,
                    showCurrencyName: true,
                    showSearchField: true,
                    showCurrencyCode: true,
                    favorite: ['eur'],
                    onSelect: (Currency currency) {
                      setState(() {
                        selectedCurrency = currency;
                      });
                    },
                  );
                },
                child: Text(
                  selectedCurrency != null
                      ? '${selectedCurrency!.name} (${selectedCurrency!.code})'
                      : 'Vui lòng chọn loại tiền tệ',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size.fromWidth(370),
                  padding: EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  if (selectedCurrency != null) {
                    _saveSelectedCurrency(selectedCurrency!.code);
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Lỗi'),
                          content: Text('Vui lòng chọn đơn vị tiền tệ'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text(
                  "Tiếp tục",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
