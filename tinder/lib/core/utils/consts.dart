import 'package:tinder/presentation/resources/index.dart';
import 'package:flutter/material.dart';

const String MD5_KEY = "#123Ag";

const int LIMITED_MONEY = 10000;
const int MAX_CASH_MONEY = 5000000;
const TRANSACTION_ACTIVITY_CASH_IN = 'cashin_from_bank_linked';
const TRANSACTION_ACTIVITY_CASH_OUT = 'cashout_to_bank_linked';
const TRANSACTION_ACTIVITY_PAYMENT_ECOM = 'payment_ecom';
const TRANSACTION_ACTIVITY_MONEY_TRANSFER = 'money_transfer';

const TRANSACTION_ACTIVITY_COMPLETED = 'completed';
const TRANSACTION_ACTIVITY_PENDING = 'pending';
const TRANSACTION_ACTIVITY_ERROR = 'error';

// activity when transaction

Map<String, String> transactionActivityType = {
  TRANSACTION_ACTIVITY_CASH_IN: '+',
  TRANSACTION_ACTIVITY_CASH_OUT: '-',
  TRANSACTION_ACTIVITY_PAYMENT_ECOM: '-',
};
Map<String, Color> transactionStatusColor = {
  TRANSACTION_ACTIVITY_COMPLETED: Colors.green,
  TRANSACTION_ACTIVITY_PENDING: Colors.white,
  TRANSACTION_ACTIVITY_ERROR: Colors.red,
};
