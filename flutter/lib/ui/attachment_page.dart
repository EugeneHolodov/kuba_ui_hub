import 'package:flutter/material.dart';
import '../widgets/kuba_attachment.dart';
import '../widgets/review_input.dart';

class AttachmentPage extends StatefulWidget {
  const AttachmentPage({super.key});

  @override
  State<AttachmentPage> createState() => _AttachmentPageState();
}

class _AttachmentPageState extends State<AttachmentPage> {
  // Selection state for multiple select mode
  final Set<String> _selectedAttachments = {};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Attachment'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Attachment 1: Different File Types',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'Attachments with different file types (image, video, PDF, document). Swipe right to share.',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            KubaAttachment(
              fileName: 'vacation_photo.jpg',
              type: AttachmentType.image,
              fileSize: '2.4 MB',
              rightSwipeAction: SwipeAction(
                label: 'Share',
                icon: Icons.share,
                backgroundColor: theme.colorScheme.primary,
                iconColor: Colors.white,
                onAction: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Image shared'),
                      backgroundColor: theme.colorScheme.primary,
                    ),
                  );
                },
              ),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Image attachment tapped')),
                );
              },
            ),
            const SizedBox(height: 12),
            KubaAttachment(
              fileName: 'presentation.mp4',
              type: AttachmentType.video,
              fileSize: '45.2 MB',
              rightSwipeAction: SwipeAction(
                label: 'Share',
                icon: Icons.share,
                backgroundColor: theme.colorScheme.primary,
                iconColor: Colors.white,
                onAction: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Video shared'),
                      backgroundColor: theme.colorScheme.primary,
                    ),
                  );
                },
              ),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Video attachment tapped')),
                );
              },
            ),
            const SizedBox(height: 12),
            KubaAttachment(
              fileName: 'report.pdf',
              type: AttachmentType.pdf,
              fileSize: '3.1 MB',
              rightSwipeAction: SwipeAction(
                label: 'Share',
                icon: Icons.share,
                backgroundColor: theme.colorScheme.primary,
                iconColor: Colors.white,
                onAction: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('PDF shared'),
                      backgroundColor: theme.colorScheme.primary,
                    ),
                  );
                },
              ),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('PDF attachment tapped')),
                );
              },
            ),
            const SizedBox(height: 12),
            KubaAttachment(
              fileName: 'document.docx',
              type: AttachmentType.doc,
              fileSize: '1.2 MB',
              rightSwipeAction: SwipeAction(
                label: 'Share',
                icon: Icons.share,
                backgroundColor: theme.colorScheme.primary,
                iconColor: Colors.white,
                onAction: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Document shared'),
                      backgroundColor: theme.colorScheme.primary,
                    ),
                  );
                },
              ),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Document attachment tapped')),
                );
              },
            ),
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 24),
            const Text(
              'Attachment 2: Multiple Selection Mode',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'Attachments with checkboxes for multiple selection. Swipe left to remove.',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              'Selected: ${_selectedAttachments.length}',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            KubaAttachment(
              fileName: 'photo1.jpg',
              type: AttachmentType.image,
              fileSize: '1.2 MB',
              showCheckbox: true,
              isSelected: _selectedAttachments.contains('photo1.jpg'),
              onSelectionChanged: (selected) {
                setState(() {
                  if (selected) {
                    _selectedAttachments.add('photo1.jpg');
                  } else {
                    _selectedAttachments.remove('photo1.jpg');
                  }
                });
              },
              leftSwipeAction: SwipeAction(
                label: 'Remove',
                icon: Icons.delete,
                backgroundColor: Colors.red,
                iconColor: Colors.white,
                onAction: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Photo removed'),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            KubaAttachment(
              fileName: 'photo2.png',
              type: AttachmentType.image,
              fileSize: '2.8 MB',
              showCheckbox: true,
              isSelected: _selectedAttachments.contains('photo2.png'),
              onSelectionChanged: (selected) {
                setState(() {
                  if (selected) {
                    _selectedAttachments.add('photo2.png');
                  } else {
                    _selectedAttachments.remove('photo2.png');
                  }
                });
              },
              leftSwipeAction: SwipeAction(
                label: 'Remove',
                icon: Icons.delete,
                backgroundColor: Colors.red,
                iconColor: Colors.white,
                onAction: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Photo removed'),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            KubaAttachment(
              fileName: 'document.pdf',
              type: AttachmentType.pdf,
              fileSize: '3.5 MB',
              showCheckbox: true,
              isSelected: _selectedAttachments.contains('document.pdf'),
              onSelectionChanged: (selected) {
                setState(() {
                  if (selected) {
                    _selectedAttachments.add('document.pdf');
                  } else {
                    _selectedAttachments.remove('document.pdf');
                  }
                });
              },
              leftSwipeAction: SwipeAction(
                label: 'Remove',
                icon: Icons.delete,
                backgroundColor: Colors.red,
                iconColor: Colors.white,
                onAction: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Document removed'),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            KubaAttachment(
              fileName: 'video.mp4',
              type: AttachmentType.video,
              fileSize: '50.1 MB',
              showCheckbox: true,
              isSelected: _selectedAttachments.contains('video.mp4'),
              onSelectionChanged: (selected) {
                setState(() {
                  if (selected) {
                    _selectedAttachments.add('video.mp4');
                  } else {
                    _selectedAttachments.remove('video.mp4');
                  }
                });
              },
              leftSwipeAction: SwipeAction(
                label: 'Remove',
                icon: Icons.delete,
                backgroundColor: Colors.red,
                iconColor: Colors.white,
                onAction: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Video removed'),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 24),
            const Text(
              'Attachment 3: Full Featured',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'Attachment with all features enabled. Swipe both ways: left to remove, right to share.',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            KubaAttachment(
              fileName: 'complete_example.pdf',
              type: AttachmentType.pdf,
              fileSize: '5.2 MB',
              showCheckbox: true,
              isSelected: _selectedAttachments.contains('complete_example.pdf'),
              onSelectionChanged: (selected) {
                setState(() {
                  if (selected) {
                    _selectedAttachments.add('complete_example.pdf');
                  } else {
                    _selectedAttachments.remove('complete_example.pdf');
                  }
                });
              },
              leftSwipeAction: SwipeAction(
                label: 'Remove',
                icon: Icons.delete,
                backgroundColor: Colors.red,
                iconColor: Colors.white,
                onAction: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Document removed'),
                      backgroundColor: Colors.red,
                    ),
                  );
                },
              ),
              rightSwipeAction: SwipeAction(
                label: 'Share',
                icon: Icons.share,
                backgroundColor: theme.colorScheme.primary,
                iconColor: Colors.white,
                onAction: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Document shared'),
                      backgroundColor: theme.colorScheme.primary,
                    ),
                  );
                },
              ),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Full featured attachment tapped'),
                  ),
                );
              },
            ),
            const SizedBox(height: 32),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'About Attachments',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Attachment widgets are reusable components for displaying file attachments with support for various file types, multiple selection, and swipe actions.',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                    const Divider(),
                    const SizedBox(height: 12),
                    const Text(
                      'Supported File Types:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '• Image (JPG, PNG, etc.)\n'
                      '• Video (MP4, AVI, etc.)\n'
                      '• Audio (MP3, WAV, etc.)\n'
                      '• PDF documents\n'
                      '• Word documents (DOC, DOCX)\n'
                      '• Excel spreadsheets (XLSX)\n'
                      '• Articles (TXT)\n'
                      '• Generic files',
                      style: TextStyle(fontSize: 13),
                    ),
                    const SizedBox(height: 12),
                    const Divider(),
                    const SizedBox(height: 12),
                    const Text(
                      'Features:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '• File type detection with appropriate icons\n'
                      '• File size display (optional)\n'
                      '• Multiple selection with checkboxes\n'
                      '• Swipe left action (e.g., Remove)\n'
                      '• Swipe right action (e.g., Share)\n'
                      '• Both swipe actions can be enabled simultaneously',
                      style: TextStyle(fontSize: 13),
                    ),
                    const SizedBox(height: 12),
                    const Divider(),
                    const SizedBox(height: 12),
                    const Text(
                      'Swipe Actions:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '• Swipe left: Remove/Delete action (optional)\n'
                      '• Swipe right: Share action (optional)\n'
                      '• Both actions can be enabled simultaneously',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: ReviewInput(
        widgetName: 'kuba_attachment',
      ).buildFloatingActionButton(context),
    );
  }
}
