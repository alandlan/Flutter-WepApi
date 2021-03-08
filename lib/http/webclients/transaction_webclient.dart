import 'dart:convert';

import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';
import 'package:bytebank/http/webclient.dart';

class TransactionWebClient{
  Future<List<Transaction>> findAll() async {
    final Response response =
    await client.get(urlBase).timeout(Duration(seconds: 15));
    List<Transaction> transactions = _toTransactions(response);
    return transactions;
    //debugPrint(decodedJson.toString());
  }

  Future<Transaction> save(Transaction transaction) async {

    final String transactionJson = jsonEncode(transaction.toJson());

    final Response response =  await client.post(urlBase,
        headers: { 'Content-Type': 'application/json', 'password': '1000'},
        body:transactionJson);

    return _toTransaction(response);
  }

  List<Transaction> _toTransactions(Response response) {
    final List<dynamic> decodedJson = jsonDecode(response.body);
    final List<Transaction> transactions = List();

    for (Map<String, dynamic> transactionJson in decodedJson) {
      transactions.add(Transaction.fromJson(transactionJson));
    }
    return transactions;
  }

  Transaction _toTransaction(Response response) {
    Map<String,dynamic> json = jsonDecode(response.body);
    final Map<String, dynamic> contactJson = json['contact'];
    return Transaction.fromJson(json);
  }
  
}