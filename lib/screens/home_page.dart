import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/data_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  List<int> selectedItems = [];
  List<int> availableItems = List.generate(10, (index) => index).toList();

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Consumer<MyDataModel>(
            builder: (context, value, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Wrap(
               
                    children: selectedItems.map((index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Chip(
                          shadowColor: Colors.lightGreen,
                          label: Text(
                            'Item $index',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.greenAccent,
                          onDeleted: () {
                            setState(() {
                              selectedItems.remove(index);
                              availableItems.add(index);
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 10,
                      mainAxisSpacing: 10.0,
                      children: List.generate(value.itemCount, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedItems.add(index);
                              availableItems.remove(index);
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.lightGreen,
                              child: Text('$index'),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (text) {
                        int count = text.isNotEmpty ? int.parse(text) : 0;
                        value.updateItemCount(count);
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2)),
                        labelText: 'Enter number of items',
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(onPressed: () {}, child: Text("Submit")),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
