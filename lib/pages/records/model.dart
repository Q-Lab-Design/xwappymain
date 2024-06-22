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
  final String fromCurrency;
  final String toCurrency;

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
    required this.fromCurrency,
    required this.toCurrency,
  });

  factory TransactionCrypto.fromJson(Map<String, dynamic> json) {
    return TransactionCrypto(
      cryptoAddress: json['crypto_address'].toString(),
      cryptoNetwork: json['crypto_network'].toString(),
      paymentProvider: json['payment_provider'].toString(),
      fromCurrencyAmt: json['from_currency_amt'].toString(),
      toCurrencyAmt: json['to_currency_amt'].toString(),
      txnHash: json['txn_hash'].toString(),
      fee: json['fee'].toString(),
      paymentRef: json['payment_ref'].toString(),
      orderNo: json['order_no'].toString(),
      senderBank: json['sender_bank'].toString(),
      amountPaid: json['amount_paid'].toString(),
      senderName: json['sender_name'].toString(),
      accountNumber: json['account_number'].toString(),
      timestamp: json['timestamp'].toString(),
      rate: json['rate'].toString(),
      fromCurrency: json['from_currency'] ?? '',
      toCurrency: json['to_currency'] ?? "",
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
      cryptoAddress: json['crypto_address'].toString(),
      cryptoNetwork: json['crypto_network'].toString(),
      paymentProvider: json['payment_provider'].toString(),
      fromCurrencyAmt: json['from_currency_amt'].toString(),
      toCurrencyAmt: json['to_currency_amt'].toString(),
      txnHash: json['txn_hash'].toString(),
      fee: json['fee'].toString(),
      paymentRef: json['payment_ref'].toString(),
      orderNo: json['order_no'].toString(),
      senderBank: json['sender_bank'].toString(),
      amountPaid: json['amount_paid'].toString(),
      senderName: json['sender_name'].toString(),
      accountNumber: json['account_number'].toString(),
      timestamp: json['timestamp'].toString(),
      rate: json['rate'].toString(),
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
  final needskyc;
  final String kycurl;
  final String fiatamount;
  final String dollaramount;
  final String fromCurrency;
  final String toCurrency;

  TransactionSummary({
    required this.amount,
    required this.date,
    required this.reference,
    required this.txnHash,
    required this.status,
    required this.orderNo,
    required this.type,
    this.needskyc,
    required this.kycurl,
    required this.dollaramount,
    required this.fiatamount,
    this.fromCurrency = '',
    this.toCurrency = '',
  });

  factory TransactionSummary.fromJson(Map<String, dynamic> json) {
    return TransactionSummary(
      amount: json['amount'].toString(),
      date: json['date'].toString(),
      reference: json['reference'].toString(),
      txnHash: json['txn_hash'].toString(),
      status: json['status'].toString(),
      orderNo: json['order_no'].toString(),
      type: json['type'].toString(),
      needskyc: json['needs_kyc'].toString(),
      kycurl: json['kyc_url'] ?? '',
      fiatamount: json['fiat_amount'].toString(),
      dollaramount: json['dollar_amount'].toString(),
      fromCurrency: json['from_currency'] ?? '',
      toCurrency: json['to_currency'] ?? '',
    );
  }
}

RxList<TransactionSummary> pendingList = <TransactionSummary>[].obs;
RxList<TransactionSummary> initiatedList = <TransactionSummary>[].obs;
RxList<TransactionSummary> completeList = <TransactionSummary>[].obs;
