import 'package:flutter/material.dart';
import '../widgets/kuba_overview_page.dart';

class ChartOverviewOverviewPage extends StatelessWidget {
  const ChartOverviewOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample metrics
    final metrics = [
      OverviewMetricCard(
        label: 'Total Users',
        value: '12,345',
        icon: Icons.people,
        subtitle: '+12% from last month',
        badge: const MetricBadge(
          text: 'New',
          color: Colors.green,
          textColor: Colors.white,
        ),
        onTap: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Total Users tapped')));
        },
      ),
      OverviewMetricCard(
        label: 'Revenue',
        value: '\$45,678',
        icon: Icons.attach_money,
        subtitle: '+8% from last month',
        iconColor: Colors.green,
        onTap: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Revenue tapped')));
        },
      ),
      OverviewMetricCard(
        label: 'Orders',
        value: '1,234',
        icon: Icons.shopping_cart,
        subtitle: 'Pending: 56',
        iconColor: Colors.orange,
        onTap: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Orders tapped')));
        },
      ),
      OverviewMetricCard(
        label: 'Active Sessions',
        value: '567',
        icon: Icons.online_prediction,
        subtitle: 'Peak: 890',
        iconColor: Colors.blue,
        badge: const MetricBadge(
          text: 'Live',
          color: Colors.red,
          textColor: Colors.white,
        ),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Active Sessions tapped')),
          );
        },
      ),
      OverviewMetricCard(
        label: 'Conversion Rate',
        value: '3.2%',
        icon: Icons.trending_up,
        subtitle: '+0.5% improvement',
        iconColor: Colors.purple,
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Conversion Rate tapped')),
          );
        },
      ),
      OverviewMetricCard(
        label: 'Support Tickets',
        value: '89',
        icon: Icons.support_agent,
        subtitle: 'Open: 23',
        iconColor: Colors.teal,
        badge: const MetricBadge(
          text: '5 New',
          color: Colors.orange,
          textColor: Colors.white,
        ),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Support Tickets tapped')),
          );
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Overview'),
        centerTitle: true,
        elevation: 0,
      ),
      body: KubaOverviewPage(
        title: 'Dashboard Overview',
        subtitle: 'Key metrics and statistics',
        metrics: metrics,
        crossAxisCount: 2,
      ),
    );
  }
}
