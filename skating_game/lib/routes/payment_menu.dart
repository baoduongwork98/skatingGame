import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:onepref/onepref.dart';

class PaymentMenu extends StatelessWidget {
  const PaymentMenu({super.key, this.onBackPressed});

  final VoidCallback? onBackPressed;
  static const id = 'PaymentMenu';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'PaymentMenu',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 15),
            const SizedBox(height: 5),
            SizedBox(
              width: 150,
              child: OutlinedButton(
                onPressed: onBackPressed,
                child: const Text('Goback'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
