import 'package:get/get.dart';

class TransactionCrypto {
  final String cryptoAddress;
  final String cryptoNetwork;
  final String paymentProvider;
  final String fromCurrencyAmt;
  final String toCurrencyAmt;
  final String txnHash;
  final String fee;
  final String paymentRef;
  final String orderNo;
  final String senderBank;
  final String amountPaid;
  final String senderName;
  final String accountNumber;
  final String timestamp;
  final String rate;

  TransactionCrypto({
    required this.cryptoAddress,
    required this.cryptoNetwork,
    required this.paymentProvider,
    required this.fromCurrencyAmt,
    required this.toCurrencyAmt,
    required this.txnHash,
    required this.fee,
    required this.paymentRef,
    required this.orderNo,
    required this.senderBank,
    required this.amountPaid,
    required this.senderName,
    required this.accountNumber,
    required this.timestamp,
    required this.rate,
  });

  factory TransactionCrypto.fromJson(Map<String, dynamic> json) {
    return TransactionCrypto(
      cryptoAddress: json['crypto_address'] as String,
      cryptoNetwork: json['crypto_network'] as String,
      paymentProvider: json['payment_provider'] as String,
      fromCurrencyAmt: json['from_currency_amt'] as String,
      toCurrencyAmt: json['to_currency_amt'] as String,
      txnHash: json['txn_hash'] as String,
      fee: json['fee'] as String,
      paymentRef: json['payment_ref'] as String,
      orderNo: json['order_no'] as String,
      senderBank: json['sender_bank'] as String,
      amountPaid: json['amount_paid'] as String,
      senderName: json['sender_name'] as String,
      accountNumber: json['account_number'] as String,
      timestamp: json['timestamp'] as String,
      rate: json['rate'] as String,
    );
  }
}

class TransactionFiat {
  final String cryptoAddress;
  final String cryptoNetwork;
  final String paymentProvider;
  final String fromCurrencyAmt;
  final String toCurrencyAmt;
  final String txnHash;
  final String fee;
  final String paymentRef;
  final String orderNo;
  final String senderBank;
  final String amountPaid;
  final String senderName;
  final String accountNumber;
  final String timestamp;
  final String rate;

  TransactionFiat({
    required this.cryptoAddress,
    required this.cryptoNetwork,
    required this.paymentProvider,
    required this.fromCurrencyAmt,
    required this.toCurrencyAmt,
    required this.txnHash,
    required this.fee,
    required this.paymentRef,
    required this.orderNo,
    required this.senderBank,
    required this.amountPaid,
    required this.senderName,
    required this.accountNumber,
    required this.timestamp,
    required this.rate,
  });

  factory TransactionFiat.fromJson(Map<String, dynamic> json) {
    return TransactionFiat(
      cryptoAddress: json['crypto_address'] as String,
      cryptoNetwork: json['crypto_network'] as String,
      paymentProvider: json['payment_provider'] as String,
      fromCurrencyAmt: json['from_currency_amt'] as String,
      toCurrencyAmt: json['to_currency_amt'] as String,
      txnHash: json['txn_hash'] as String,
      fee: json['fee'] as String,
      paymentRef: json['payment_ref'] as String,
      orderNo: json['order_no'] as String,
      senderBank: json['sender_bank'] as String,
      amountPaid: json['amount_paid'] as String,
      senderName: json['sender_name'] as String,
      accountNumber: json['account_number'] as String,
      timestamp: json['timestamp'] as String,
      rate: json['rate'] as String,
    );
  }
}

class TransactionSummary {
  final String amount;
  final String date;
  final String reference;
  final String txnHash;
  final String status;
  final String orderNo;
  final String type;

  TransactionSummary({
    required this.amount,
    required this.date,
    required this.reference,
    required this.txnHash,
    required this.status,
    required this.orderNo,
    required this.type,
  });

  factory TransactionSummary.fromJson(Map<String, dynamic> json) {
    return TransactionSummary(
      amount: json['amount'] as String,
      date: json['date'] as String,
      reference: json['reference'] as String,
      txnHash: json['txn_hash'] as String,
      status: json['status'] as String,
      orderNo: json['order_no'] as String,
      type: json['type'] as String,
    );
  }
}

RxList<TransactionSummary> pendingList = <TransactionSummary>[].obs;
RxList<TransactionSummary> initiatedList = <TransactionSummary>[].obs;
RxList<TransactionSummary> completeList = <TransactionSummary>[].obs;
