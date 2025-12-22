import 'package:flutter/material.dart';
import '../widgets/kuba_checklist_card.dart';

class ChecklistOverviewPage extends StatefulWidget {
  const ChecklistOverviewPage({super.key});

  @override
  State<ChecklistOverviewPage> createState() => _ChecklistOverviewPageState();
}

class _ChecklistOverviewPageState extends State<ChecklistOverviewPage> {
  String? _comment1;
  String? _comment2;
  String? _comment3;
  String? _comment4;
  ChecklistStatus? _status1;
  ChecklistStatus? _status2;
  ChecklistStatus? _status3;
  ChecklistStatus? _status4;
  DateTime? _timestamp1;
  DateTime? _timestamp2;
  DateTime? _timestamp3;
  DateTime? _timestamp4;
  bool _showValidation = false;
  final String _userName = 'John Doe'; // Example user name

  // Attachment lists for each card
  List<ChecklistAttachment> _attachments1 = [
    const ChecklistAttachment(
      name: 'fire_extinguisher_report.pdf',
      icon: Icons.picture_as_pdf,
    ),
    const ChecklistAttachment(
      name: 'safety_equipment_photo.jpg',
      icon: Icons.image,
    ),
    const ChecklistAttachment(
      name: 'inspection_checklist.xlsx',
      icon: Icons.insert_drive_file,
    ),
  ];

  List<ChecklistAttachment> _attachments2 = [];

  List<ChecklistAttachment> _attachments3 = [
    const ChecklistAttachment(
      name: 'deviation_report_001.pdf',
      icon: Icons.picture_as_pdf,
    ),
    const ChecklistAttachment(name: 'quality_photo_1.jpg', icon: Icons.image),
    const ChecklistAttachment(name: 'quality_photo_2.jpg', icon: Icons.image),
    const ChecklistAttachment(name: 'quality_photo_3.jpg', icon: Icons.image),
    const ChecklistAttachment(
      name: 'test_results.xlsx',
      icon: Icons.insert_drive_file,
    ),
    const ChecklistAttachment(
      name: 'corrective_action_plan.docx',
      icon: Icons.description,
    ),
    const ChecklistAttachment(
      name: 'meeting_notes.pdf',
      icon: Icons.picture_as_pdf,
    ),
    const ChecklistAttachment(
      name: 'video_recording.mp4',
      icon: Icons.video_file,
    ),
    const ChecklistAttachment(name: 'audio_notes.m4a', icon: Icons.audiotrack),
    const ChecklistAttachment(
      name: 'additional_data.csv',
      icon: Icons.table_chart,
    ),
    const ChecklistAttachment(
      name: 'reference_document.pdf',
      icon: Icons.picture_as_pdf,
    ),
    const ChecklistAttachment(name: 'chart_analysis.png', icon: Icons.image),
    const ChecklistAttachment(
      name: 'summary_report.docx',
      icon: Icons.description,
    ),
    const ChecklistAttachment(
      name: 'final_checklist.pdf',
      icon: Icons.picture_as_pdf,
    ),
  ];

  List<ChecklistAttachment> _attachments4 = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checklist Card Overview'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Example 1: Default state with OK status
            KubaChecklistCard(
              title: 'Safety Inspection',
              subtitle: 'Monthly safety equipment check',
              status: _status1,
              errorText: _showValidation && _status1 == null
                  ? 'Status selection required'
                  : null,
              onStatusChanged: (newStatus) {
                setState(() {
                  _status1 = newStatus;
                  _timestamp1 = newStatus != null ? DateTime.now() : null;
                });
              },
              userName: _status1 != null ? _userName : null,
              timestamp: _timestamp1,
              attachments: _attachments1,
              comment: _comment1,
              onCommentChanged: (value) {
                setState(() {
                  _comment1 = value;
                });
              },
              onAttachmentAdd: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Add attachment tapped')),
                );
              },
              onAttachmentRemove: (index) {
                setState(() {
                  _attachments1.removeAt(index);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Attachment removed')),
                );
              },
            ),
            const SizedBox(height: 24),

            // Example 2: N/A status with no attachments and comment
            KubaChecklistCard(
              title: 'Equipment Maintenance',
              subtitle: 'Quarterly maintenance schedule',
              status: _status2,
              errorText: _showValidation && _status2 == null
                  ? 'Status selection required'
                  : null,
              onStatusChanged: (newStatus) {
                setState(() {
                  _status2 = newStatus;
                  _timestamp2 = newStatus != null ? DateTime.now() : null;
                });
              },
              userName: _status2 != null ? _userName : null,
              timestamp: _timestamp2,
              attachments: _attachments2,
              comment: _comment2,
              onCommentChanged: (value) {
                setState(() {
                  _comment2 = value;
                });
              },
              onAttachmentAdd: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Add attachment tapped')),
                );
              },
              onAttachmentRemove: (index) {
                setState(() {
                  _attachments2.removeAt(index);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Attachment removed')),
                );
              },
            ),
            const SizedBox(height: 24),

            // Example 3: Deviation status with many attachments and existing comment
            KubaChecklistCard(
              title: 'Quality Control Check',
              subtitle: 'Production line quality inspection',
              status: _status3,
              errorText: _showValidation && _status3 == null
                  ? 'Status selection required'
                  : null,
              onStatusChanged: (newStatus) {
                setState(() {
                  _status3 = newStatus;
                  _timestamp3 = newStatus != null ? DateTime.now() : null;
                });
              },
              userName: _status3 != null ? _userName : null,
              timestamp: _timestamp3,
              attachments: _attachments3,
              comment:
                  _comment3 ?? 'Needs immediate supervisor review and approval',
              onCommentChanged: (value) {
                setState(() {
                  _comment3 = value;
                });
              },
              onAttachmentAdd: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Add attachment tapped')),
                );
              },
              onAttachmentRemove: (index) {
                setState(() {
                  _attachments3.removeAt(index);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Attachment removed')),
                );
              },
            ),
            const SizedBox(height: 24),

            // Example 4: Minimal card
            KubaChecklistCard(
              title: 'Quick Check',
              subtitle: 'Daily routine inspection',
              status: _status4,
              errorText: _showValidation && _status4 == null
                  ? 'Status selection required'
                  : null,
              onStatusChanged: (newStatus) {
                setState(() {
                  _status4 = newStatus;
                  _timestamp4 = newStatus != null ? DateTime.now() : null;
                });
              },
              userName: _status4 != null ? _userName : null,
              timestamp: _timestamp4,
              attachments: _attachments4,
              comment: _comment4,
              onCommentChanged: (value) {
                setState(() {
                  _comment4 = value;
                });
              },
              onAttachmentAdd: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Add attachment tapped')),
                );
              },
              onAttachmentRemove: (index) {
                setState(() {
                  _attachments4.removeAt(index);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Attachment removed')),
                );
              },
            ),
            const SizedBox(height: 24),

            // Status Card
            Card(
              elevation: 0,
              color: theme.colorScheme.surfaceContainerHighest,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 20,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Checklist Status',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildStatusRow(
                      context,
                      'Safety Inspection',
                      _status1 != null,
                    ),
                    _buildStatusRow(
                      context,
                      'Equipment Maintenance',
                      _status2 != null,
                    ),
                    _buildStatusRow(
                      context,
                      'Quality Control Check',
                      _status3 != null,
                    ),
                    _buildStatusRow(context, 'Quick Check', _status4 != null),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Submit Button (demo)
            FilledButton(
              onPressed: () {
                if (_status1 != null &&
                    _status2 != null &&
                    _status3 != null &&
                    _status4 != null) {
                  setState(() {
                    _showValidation = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        'All checklists completed successfully!',
                      ),
                      backgroundColor: theme.colorScheme.primary,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                } else {
                  setState(() {
                    _showValidation = true;
                  });
                }
              },
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Submit All Checklists',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
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
                          'Checklist Card Features',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildFeatureInfo(
                      context,
                      'Two States: Default, Expanded attachments',
                    ),
                    _buildFeatureInfo(
                      context,
                      'Status Segmented Control: ok, n/a, deviation',
                    ),
                    _buildFeatureInfo(
                      context,
                      'Expandable Attachments: Swipeable cards with delete action',
                    ),
                    _buildFeatureInfo(
                      context,
                      'Comment Input: Collapsible comment textarea with badge',
                    ),
                    _buildFeatureInfo(
                      context,
                      'Add Attachment: Required button to add new files',
                    ),
                    _buildFeatureInfo(
                      context,
                      'Material 3: Brand colors and styling',
                    ),
                    _buildFeatureInfo(
                      context,
                      'Elevation: 5 for depth and prominence',
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

  Widget _buildStatusRow(BuildContext context, String label, bool isCompleted) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 20,
            color: isCompleted
                ? Theme.of(context).colorScheme.primary
                : Theme.of(
                    context,
                  ).colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
          ),
          const SizedBox(width: 8),
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          const Spacer(),
          Text(
            isCompleted ? 'Completed' : 'Pending',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isCompleted
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
