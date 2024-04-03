import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mymed/pages/register.dart';
import 'checkout.dart';

void main() {
  runApp(OrderMedicine());
}

class OrderMedicine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order Medicine',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: OrderMedicinePage(),
    );
  }
}

class OrderMedicinePage extends StatefulWidget {
  @override
  _OrderMedicinePageState createState() => _OrderMedicinePageState();
}

class _OrderMedicinePageState extends State<OrderMedicinePage> {
  TextEditingController fullname = TextEditingController();
  TextEditingController qty = TextEditingController();
  String selectedMedicine = '';
  List<String> medicineList = [];

  @override
  void initState() {
    super.initState();
    fetchMedicineList(); // Fetch medicine names when the widget initializes
  }

  Future<void> fetchMedicineList() async {
    // Fetch list of medicines from the server
    var url = Uri.parse(
        "http://192.102.1.1/CEMA/mymed/order_medicine.php"); // Replace with your API URL
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      setState(() {
        // Update medicineList with the fetched medicine names
        medicineList = List<String>.from(data["medicine_names"]);
      });
    } else {
      // Handle error
      print('Failed to fetch medicine names: ${response.statusCode}');
    }
  }

  Future<void> orderMedicine() async {
    var url = Uri.parse("http://192.102.1.1/CEMA/mymed/order_medicine.php");
    var response = await http.post(url, body: {
      "medicine_name": selectedMedicine,
      "quantity": qty.text,
      "fullname": fullname.text,
    });
    if (response.statusCode == 200) {
      if (response.body.isEmpty) {
        Fluttertoast.showToast(
          msg: 'Empty response',
        );
      } else {
        try {
          var data = json.decode(response.body);
          if (data == "Error") {
            Fluttertoast.showToast(
              msg: 'Stock quantity less than specified quantity!',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 25.0,
            );
          } else {
            Fluttertoast.showToast(
              msg: 'Order Successful',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 25.0,
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CheckoutPage()),
            );
          }
        } catch (e) {
          print('Error decoding JSON: $e');
        }
      }
    } else {
      print('HTTP error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Dropdown items count: ${medicineList.length}');
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Utiba Health',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 100.0),
        height: 500,
        child: Card(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Order',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  controller: fullname,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  value: selectedMedicine.isNotEmpty &&
                          medicineList.contains(selectedMedicine)
                      ? selectedMedicine
                      : null, // Setting null if _selectedMedicine is not in _medicineList
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedMedicine = newValue!;
                    });
                  },
                  items: medicineList
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Quantity',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  controller: qty,
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 30.0)),
              Row(
                children: <Widget>[
                  Expanded(
                    child: MaterialButton(
                      color: const Color.fromRGBO(0, 194, 203, 1),
                      child: const Text('Order',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      onPressed: () {
                        orderMedicine();
                      },
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      color: Colors.white,
                      child: const Text('Add medicine',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Register(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
