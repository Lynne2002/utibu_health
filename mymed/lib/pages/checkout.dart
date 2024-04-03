import 'package:flutter/material.dart';
import 'payment.dart';
import 'home.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool payNow = true;
  void navigateToPaymentPage() {
    if (payNow) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Payment()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PayNowPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Utibu Health',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        height: 500,
        padding: const EdgeInsets.all(10.0),
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(padding: EdgeInsets.only(top: 50.0)),
              const Text(
                'Payment Option:',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              ListTile(
                title: const Text('Pay Now'),
                trailing: Radio(
                  value: true,
                  groupValue: payNow,
                  onChanged: (value) {
                    setState(() {
                      payNow = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Pay Later'),
                trailing: Radio(
                  value: false,
                  groupValue: payNow,
                  onChanged: (value) {
                    setState(() {
                      payNow = value!;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              Center(
                child: MaterialButton(
                  color: const Color.fromRGBO(0, 194, 203, 1),
                  child: const Text('Proceed to checkout',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  onPressed: () {
                    // Add your checkout logic here
                    print('Payment option selected: $payNow');
                    navigateToPaymentPage();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PayNowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Utiba Health',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 100.0,
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Medicine order successful!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Please check your email for details on when to pay and pick your medicine',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 20.0),
            MaterialButton(
              color: const Color.fromRGBO(0, 194, 203, 1),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: const Text('Okay',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
