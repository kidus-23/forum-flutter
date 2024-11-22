import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  Order order = Order();

  String? _validateItem(String? value) {
    return value == null || value.isEmpty ? 'Item is required' : null;
  }

  String? _validateCount(String? value) {
    if (value == null || value.isEmpty) {
      return 'Quantity is required';
    }
    final intValue = int.tryParse(value);
    if (intValue == null || intValue <= 0) {
      return 'Please enter a valid quantity (greater than 0)';
    }
    return null;
  }

  void _submitOrder() {
    if (_formStateKey.currentState!.validate()) {
      _formStateKey.currentState!.save();
      print('Order Item: ${order.item}');
      print('Order Quantity: ${order.quantity}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Order submitted: ${order.item}, ${order.quantity}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Elegant Order Form'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 4,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Form(
            key: _formStateKey,
            autovalidateMode: AutovalidateMode.always,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Place Your Order',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Item',
                      hintText: 'Coffee',
                    ),
                    validator: (value) => _validateItem(value!),
                    onSaved: (value) => order.item = value!,
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Quantity',
                      hintText: '2',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) => _validateCount(value!),
                    onSaved: (value) => order.quantity = int.tryParse(value!)!,
                  ),
                  const Divider(
                    thickness: 3.0,
                    color: Colors.black,
                  ),
                  ElevatedButton(
                    onPressed: () => _submitOrder(),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      backgroundColor: Colors.teal,
                      elevation: 5.0,
                      shadowColor: Colors.tealAccent,
                    ),
                    child: const Text(
                      'Submit Order',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Order {
  late String item;
  late int quantity;
}
