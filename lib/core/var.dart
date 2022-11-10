import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../features/cart/data/models/payment_model.dart';
import '../features/cart/domain/entities/cart.dart';
import '../features/cart/domain/entities/payment.dart';
import '../features/product/domain/entities/product.dart';

List<String> categories = [];
String categoryItems = "All";
List<Product> products = [];
//List<Product> productsCartList = [];
List<CartItem> carts = [];
List<Payment> payments = [];
late Database database;
Widget? home;
