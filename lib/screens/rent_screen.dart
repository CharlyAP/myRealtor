import 'package:flutter/material.dart';
import 'package:myrealtor/model/rent.dart';
import 'package:myrealtor/screens/rent_transaction_screen.dart';
import 'package:myrealtor/widgets/rent_widget.dart';

class RentScreen extends StatefulWidget {
  const RentScreen({super.key});

  @override
  State<RentScreen> createState() {
    return _RentScreenState();
  }
}

class _RentScreenState extends State<RentScreen> {
  final List<Rent> rents = [];

  void addRent(Rent rent) {
    setState(() {
      rents.add(rent);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
        child: Text('No transactions yet',
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground)));

    if (rents.isNotEmpty) {
      content = ListView.builder(
        itemCount: rents.length,
        itemBuilder: (ctx, index) => RentWidget(
          rent: rents[index],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rent Transactions',
        ),
      ),
      body: content,
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => AddRentTransaction(addRent: addRent),
              ),
            );
          }),
    );
  }
}
