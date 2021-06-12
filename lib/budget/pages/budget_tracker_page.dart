import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/models.dart';
import '../repositories/repositories.dart';
import '../utils/utils.dart';
import '../widgets/widgets.dart';

class BudgetTrackerPage extends StatelessWidget {
  const BudgetTrackerPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _Body(),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  Future<List<BudgetItemModel>> _futureItems;

  @override
  void initState() {
    super.initState();
    _futureItems = BudgetRepository().getItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget Tracker'),
        elevation: 2,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: RefreshIndicator(
            onRefresh: () async {
              _futureItems = BudgetRepository().getItems();
              setState(() {});
            },
            child: FutureBuilder<List<BudgetItemModel>>(
              future: _futureItems,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // Show pie chart and list view of items.
                  final items = snapshot.data;
                  return ListView.builder(
                    itemCount: items.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) return SpendingChartWidget(items: items);

                      final item = items[index - 1];
                      return Container(
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            width: 2.0,
                            color: item.category.categoryColor,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 2),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(item.name),
                          subtitle: Text(
                            '${item.category} • ${DateFormat.yMd().format(item.date)}',
                          ),
                          trailing: Text(
                            '-\$${item.price.toStringAsFixed(2)}',
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  // Show failure error message.
                  final failure = snapshot.error as FailureModel;
                  return Center(child: Text(failure.message));
                }
                // Show a loading spinner.
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ),
    );
  }
}
