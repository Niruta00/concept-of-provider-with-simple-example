import 'package:flutter/cupertino.dart';

class MyDataModel extends ChangeNotifier {
  int itemCount = 0;

  void updateItemCount(int count) {
    itemCount = count;
    notifyListeners();
  }
}
