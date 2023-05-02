import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TransactionsHistoryPage extends StatelessWidget {
  const TransactionsHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final currentUser = _auth.currentUser!;
    final userRef = _db.collection('users').doc(currentUser.uid);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions History'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: userRef
            .collection('transactions')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final transactions = snapshot.data!.docs;
          if (transactions.isEmpty) {
            return Center(
              child: Text('No transactions have been performed.'),
            );
          }
          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              final cardName = transaction['cardName'];
              final accountNumber = transaction['accountNumber'];
              final routingNumber = transaction['routingNumber'];
              final amount = transaction['amount'];
              final timestamp = transaction['timestamp'] as Timestamp;
              final date = DateTime.fromMicrosecondsSinceEpoch(
                  timestamp.microsecondsSinceEpoch);
              return Card(
                child: ListTile(
                  title: Text('$cardName $accountNumber'),
                  subtitle: Text('$routingNumber\n${date.toString()}'),
                  trailing: Text(
                    '\$${amount.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: amount > 0 ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
