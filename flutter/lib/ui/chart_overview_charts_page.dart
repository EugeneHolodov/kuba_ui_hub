import 'package:flutter/material.dart';
import '../widgets/kuba_chart.dart';

class ChartOverviewChartsPage extends StatelessWidget {
  const ChartOverviewChartsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Sample data
    final lineChartData = [
      const ChartDataPoint(value: 20, label: 'Jan'),
      const ChartDataPoint(value: 35, label: 'Feb'),
      const ChartDataPoint(value: 28, label: 'Mar'),
      const ChartDataPoint(value: 45, label: 'Apr'),
      const ChartDataPoint(value: 50, label: 'May'),
      const ChartDataPoint(value: 42, label: 'Jun'),
    ];

    final barChartData = [
      const ChartDataPoint(value: 65, label: 'Mon'),
      const ChartDataPoint(value: 80, label: 'Tue'),
      const ChartDataPoint(value: 45, label: 'Wed'),
      const ChartDataPoint(value: 90, label: 'Thu'),
      const ChartDataPoint(value: 70, label: 'Fri'),
      const ChartDataPoint(value: 55, label: 'Sat'),
      const ChartDataPoint(value: 40, label: 'Sun'),
    ];

    final pieChartData = [
      const ChartDataPoint(value: 35, label: 'Open', color: Colors.green),
      const ChartDataPoint(value: 40, label: 'New', color: Colors.blue),
      const ChartDataPoint(value: 12, label: 'Closed', color: Colors.grey),
      const ChartDataPoint(value: 13, label: 'Rejected', color: Colors.red),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Charts'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Overview section
            Card(
              elevation: 0,
              color: theme.colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.show_chart,
                      size: 48,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Chart Widgets',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Reusable Material 3 chart widgets with brand styling',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Line Chart (Animated)
            _buildSectionTitle(context, 'Line Chart (Animated)'),
            const SizedBox(height: 8),
            KubaChart(
              type: ChartType.line,
              data: lineChartData,
              title: 'Monthly Sales',
              subtitle: 'Last 6 months - Smooth animation',
              height: 250,
              showLegend: false,
              labels: lineChartData.map((d) => d.label ?? '').toList(),
              animated: true,
            ),
            const SizedBox(height: 24),

            // Bar Chart (Animated)
            _buildSectionTitle(context, 'Bar Chart (Animated)'),
            const SizedBox(height: 8),
            KubaChart(
              type: ChartType.bar,
              data: barChartData,
              title: 'Weekly Activity',
              subtitle: 'This week - Bars grow from bottom',
              height: 250,
              showLegend: false,
              labels: barChartData.map((d) => d.label ?? '').toList(),
              animated: true,
            ),
            const SizedBox(height: 24),

            // Pie Chart (Animated with Custom Colors)
            _buildSectionTitle(
              context,
              'Pie Chart (Animated with Custom Colors)',
            ),
            const SizedBox(height: 8),
            KubaChart(
              type: ChartType.pie,
              data: pieChartData,
              title: 'Status Distribution',
              subtitle: 'Colors from data points - Slices animate in',
              height: 250,
              showLegend: true,
              animated: true,
            ),
            const SizedBox(height: 24),

            // Line Chart with Custom Colors
            _buildSectionTitle(context, 'Line Chart (Custom Colors)'),
            const SizedBox(height: 8),
            KubaChart(
              type: ChartType.line,
              data: lineChartData,
              title: 'Revenue Trend',
              subtitle: 'Custom brand colors',
              height: 250,
              primaryColor: theme.colorScheme.secondary,
              secondaryColor: theme.colorScheme.tertiary,
              showLegend: false,
              labels: lineChartData.map((d) => d.label ?? '').toList(),
            ),
            const SizedBox(height: 24),

            // Bar Chart with Custom Colors
            _buildSectionTitle(context, 'Bar Chart (Custom Colors)'),
            const SizedBox(height: 8),
            KubaChart(
              type: ChartType.bar,
              data: barChartData,
              title: 'Performance Metrics',
              subtitle: 'Alternating colors',
              height: 250,
              primaryColor: theme.colorScheme.primary,
              secondaryColor: theme.colorScheme.secondary,
              showLegend: false,
              labels: barChartData.map((d) => d.label ?? '').toList(),
            ),
            const SizedBox(height: 24),

            // Pie Chart with Custom Colors from Data
            _buildSectionTitle(context, 'Pie Chart (Custom Colors from Data)'),
            const SizedBox(height: 8),
            KubaChart(
              type: ChartType.pie,
              data: pieChartData,
              title: 'Status Distribution',
              subtitle: 'Colors defined in data points',
              height: 250,
              showLegend: true,
              animated: true,
            ),
            const SizedBox(height: 24),

            // Line Chart without Grid
            _buildSectionTitle(context, 'Line Chart (No Grid)'),
            const SizedBox(height: 8),
            KubaChart(
              type: ChartType.line,
              data: lineChartData,
              title: 'Simple Line Chart',
              subtitle: 'Grid disabled',
              height: 250,
              showGrid: false,
              showLegend: false,
              labels: lineChartData.map((d) => d.label ?? '').toList(),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Text(
      title,
      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}
