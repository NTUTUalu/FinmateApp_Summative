import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({Key? key}) : super(key: key);

  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _amountController = TextEditingController();

  List<String> _bankCards = [];
  String? _selectedCard;
  String _amount = '';

  @override
  void initState() {
    super.initState();
    _fetchBankCards();
    _amountController.text = '';

    if (_bankCards.isEmpty) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please add a bank card before selecting.'),
            duration: const Duration(seconds: 2),
          ),
        );
      });
    }
  }

  Future<void> _fetchBankCards() async {
    final currentUser = _auth.currentUser!;
    final userRef = _db.collection('users').doc(currentUser.uid);
    final bankCardsSnapshot = await userRef.collection('bankCards').get();

    final bankCards = bankCardsSnapshot.docs.map((doc) {
      final data = doc.data();
      return '${data['bankName']} ${data['accountNumber']} ${data['routingNumber']}';
    }).toList();

    setState(() {
      _bankCards = bankCards;
      _selectedCard = _bankCards.isNotEmpty ? _bankCards[0] : null;
    });
  }

  void _onSelectedCard(String? value) {
    if (value != null) {
      if (_bankCards.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please add a bank card before selecting.'),
            duration: const Duration(seconds: 2),
          ),
        );
        return;
      }
      setState(() {
        _selectedCard = value;
      });
    }
  }

  void _onAmountChanged(String value) {
    setState(() {
      _amount = value;
    });
  }

  void _onSendMoneyPressed() async {
    // Get the selected card details and transaction amount
    final cardDetails = _selectedCard?.split(' ') ?? [];
    final cardName = cardDetails.length > 0 ? cardDetails[0] : '';
    final accountNumber = cardDetails.length > 1 ? cardDetails[1] : '';
    final routingNumber = cardDetails.length > 2 ? cardDetails[2] : '';
    final amount = double.tryParse(_amountController.text) ?? 0.0;

    // Get the current user details
    final currentUser = _auth.currentUser!;
    final userRef = _db.collection('users').doc(currentUser.uid);

    try {
      // Create a new document in Firestore with the transaction details
      final timestamp = Timestamp.now();
      final transactionData = {
        'cardName': cardName,
        'accountNumber': accountNumber,
        'routingNumber': routingNumber,
        'amount': amount,
        'userId': currentUser.uid,
        'timestamp': timestamp,
      };
      await userRef.collection('transactions').add(transactionData);

      // Show success message to user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Money sent successfully'),
          duration: const Duration(seconds: 2),
        ),
      );

      // Clear the amount input
      _amountController.text = '';
    } catch (error) {
      // Show error message to user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error sending money: $error'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select a Card',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: _selectedCard,
              onChanged: _onSelectedCard,
              items: _bankCards.map((String card) {
                return DropdownMenuItem<String>(
                  value: card,
                  child: Text(card),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text(
              'Enter Amount',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            TextFormField(
              maxLength: 6,
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectedCard == null || _bankCards.isEmpty
                  ? null
                  : _onSendMoneyPressed,
              child: const Text('Send Money'),
            ),
            Visibility(
              visible: _bankCards.isEmpty,
              child: Container(
                color: Colors.yellow,
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(Icons.warning),
                    const SizedBox(width: 8.0),
                    const Expanded(
                      child: Text(
                        'Add a bank card before transacting.',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
