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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Line Chart (Animated)
            Text(
              'Line Chart (Animated)',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Smooth animated line chart with customizable colors and grid',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 12),
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
            Text(
              'Bar Chart (Animated)',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Animated bar chart with bars growing from bottom',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 12),
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
            Text(
              'Pie Chart (Animated with Custom Colors)',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Animated pie chart with custom colors and legend',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 12),
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
            Text(
              'Line Chart (Custom Colors)',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Line chart with custom brand colors (secondary and tertiary)',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 12),
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
            Text(
              'Bar Chart (Custom Colors)',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Bar chart with alternating primary and secondary colors',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 12),
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
            Text(
              'Pie Chart (Custom Colors from Data)',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Pie chart with colors defined per data point',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 12),
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
            Text(
              'Line Chart (No Grid)',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Simplified line chart without grid lines',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 12),
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

            // Info card
            Card(
              elevation: 1,
              color: theme.colorScheme.surfaceContainerHighest,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: theme.colorScheme.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Chart Features',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Chart Types: Line, Bar, and Pie charts with Material 3 styling.\n\n'
                      'Features: Smooth animations, customizable colors, grid options, and legend support.\n\n'
                      'Color Styles: Use theme colors (primary, secondary, tertiary) or define custom colors per data point.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
