import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpenseSummaryScreen extends StatelessWidget {
  const ExpenseSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Expense Summary'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Weekly'),
              Tab(text: 'Monthly'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SummaryChart(period: 'Weekly'),
            SummaryChart(period: 'Monthly'),
          ],
        ),
      ),
    );
  }
}

class SummaryChart extends StatelessWidget {
  final String period;

  SummaryChart({required this.period});

  @override
  Widget build(BuildContext context) {
    // Mock data for chart
    final data = [
      {'category': 'Food', 'amount': 100},
      {'category': 'Travel', 'amount': 200},
      // Add more data here
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text('$period Summary', style: const TextStyle(fontSize: 24)),
          Expanded(
            child: BarChart(
              data: data,
            ),
          ),
        ],
      ),
    );
  }
}

class BarChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  BarChart({required this.data});

  @override
  Widget build(BuildContext context) {
    // Placeholder widget for BarChart
    return Container(
      color: Colors.grey[200],
      child: const Center(
        child: Text('Bar Chart'),
      ),
    );
  }
}
