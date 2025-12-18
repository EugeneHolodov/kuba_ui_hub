import 'package:flutter/material.dart';
import '../widgets/kuba_feature_list_card.dart';
import '../widgets/feature_list_chart.dart';

class FeatureListCardOverviewPage extends StatelessWidget {
  const FeatureListCardOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Activities chart data
    final activitiesChartValues = [42.0, 58.0, 65.0, 53.0, 72.0, 68.0];
    final activitiesChartLabels = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];

    // Deviations chart data
    final deviationsChartValues = [15.0, 22.0, 10.0, 4.0];
    final deviationsChartLabels = ['New', 'Open', 'Done', 'Rejected'];

    // Risk Analysis chart data
    final riskChartValues = [45.0, 30.0, 25.0];
    final riskChartLabels = ['Low', 'Medium', 'High'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Feature List Card Overview'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Activities Card
            KubaFeatureListCard(
              title: 'Activities',
              subtitle: 'Monthly activity tracking and progress',
              chartType: FeatureChartType.line,
              chartValues: activitiesChartValues,
              chartLabels: activitiesChartLabels,
              rightSideTitle: '358 Activities',
              statusTag: StatusTag(
                label: 'New',
                icon: Icons.check_circle,
                backgroundColor: Colors.green.shade100,
                textColor: Colors.green,
              ),
              tags: [
                InfoTag(
                  label: 'Completed',
                  colorIndicator: Theme.of(context).colorScheme.primary,
                  value: '68%',
                  valueColor: Theme.of(context).colorScheme.primary,
                ),
                InfoTag(
                  label: 'In Progress',
                  value: '24%',
                  icon: Icons.timelapse,
                  valueColor: Colors.orange,
                ),
                InfoTag(
                  label: 'New',
                  value: '8%',
                  icon: Icons.check_circle,
                  valueColor: Colors.blue,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Deviations Card
            KubaFeatureListCard(
              title: 'Deviations',
              subtitle: 'Weekly deviation reports and trends',
              chartType: FeatureChartType.pie,
              chartValues: deviationsChartValues,
              chartLabels: deviationsChartLabels,
              chartPrimaryColor: Colors.blue,
              chartSecondaryColor: Colors.orange,
              chartQuaternaryColor: Colors.red,
              rightSideTitle: '51 Deviations',
              statusTag: StatusTag(
                label: 'Expired in 3 days',
                icon: Icons.access_time,
                backgroundColor: Colors.red.shade100,
                textColor: Colors.red.shade900,
              ),
              tags: [
                InfoTag(
                  label: 'New',
                  colorIndicator: Colors.blue,
                  value: '15',
                  valueColor: Colors.blue,
                ),
                InfoTag(
                  label: 'Open',
                  colorIndicator: Colors.orange,
                  value: '22',
                  valueColor: Colors.orange,
                ),
                InfoTag(
                  label: 'Done',
                  colorIndicator: Colors.green,
                  value: '10',
                  valueColor: Colors.green,
                ),
                InfoTag(
                  label: 'Rejected',
                  colorIndicator: Colors.red,
                  value: '4',
                  valueColor: Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Risk Analysis Card
            KubaFeatureListCard(
              title: 'Risk Analysis',
              subtitle: 'Risk distribution across all projects',
              chartType: FeatureChartType.pie,
              chartValues: riskChartValues,
              chartLabels: riskChartLabels,
              rightSideTitle: '127 Risk Items',
              statusTag: StatusTag(
                label: 'Monitored',
                icon: Icons.visibility,
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.secondaryContainer,
                textColor: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
              tags: [
                InfoTag(
                  label: 'Low Risk',
                  colorIndicator: Colors.green,
                  value: '45%',
                  valueColor: Colors.green,
                ),
                InfoTag(
                  label: 'Medium Risk',
                  colorIndicator: Colors.orange,
                  value: '30%',
                  valueColor: Colors.orange,
                ),
                InfoTag(
                  label: 'High Risk',
                  colorIndicator: Colors.red,
                  value: '25%',
                  valueColor: Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Info Card
            Card(
              elevation: 0,
              color: theme.colorScheme.surfaceContainerHighest,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Feature List Card Features',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildFeatureInfo(context, 'Fixed Height: 320px'),
                    _buildFeatureInfo(
                      context,
                      'Full Width: 100% of screen width',
                    ),
                    _buildFeatureInfo(context, 'Layout: 50% chart, 50% info'),
                    _buildFeatureInfo(
                      context,
                      'Chart Types: Line, Bar, and Pie charts',
                    ),
                    _buildFeatureInfo(
                      context,
                      'Right Side: Title at top, tags at bottom (max 4)',
                    ),
                    _buildFeatureInfo(
                      context,
                      'Status Tag: Optional badge in top-right corner',
                    ),
                    _buildFeatureInfo(
                      context,
                      'Tags: Show chart colors, values, and labels',
                    ),
                    _buildFeatureInfo(
                      context,
                      'Material 3: Brand colors and styling',
                    ),
                    _buildFeatureInfo(
                      context,
                      'Smooth Animations: Gentle looping chart animations',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureInfo(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 16,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}
