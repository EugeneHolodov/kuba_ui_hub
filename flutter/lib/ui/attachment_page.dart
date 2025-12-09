import 'package:flutter/material.dart';
import '../widgets/kuba_attachment.dart';

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
      appBar: AppBar(
        title: const Text('Attachment Widget'),
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
                      Icons.attach_file,
                      size: 48,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Attachment Widget',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Reusable Material 3 attachment widget with support for multiple file types and optional multiple selection',
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

            // Different attachment types
            _buildSectionTitle(context, 'Different Attachment Types'),
            const SizedBox(height: 12),

            KubaAttachment(
              fileName: 'vacation_photo.jpg',
              type: AttachmentType.image,
              fileSize: '2.4 MB',
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
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Video attachment tapped')),
                );
              },
            ),
            const SizedBox(height: 12),

            KubaAttachment(
              fileName: 'podcast_episode.mp3',
              type: AttachmentType.audio,
              fileSize: '12.8 MB',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Audio attachment tapped')),
                );
              },
            ),
            const SizedBox(height: 12),

            KubaAttachment(
              fileName: 'report.pdf',
              type: AttachmentType.pdf,
              fileSize: '3.1 MB',
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
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Document attachment tapped')),
                );
              },
            ),
            const SizedBox(height: 12),

            KubaAttachment(
              fileName: 'data.xlsx',
              type: AttachmentType.xlsx,
              fileSize: '856 KB',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Spreadsheet attachment tapped'),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),

            KubaAttachment(
              fileName: 'article.txt',
              type: AttachmentType.article,
              fileSize: '45 KB',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Article attachment tapped')),
                );
              },
            ),
            const SizedBox(height: 12),

            KubaAttachment(
              fileName: 'generic_file.zip',
              type: AttachmentType.file,
              fileSize: '5.6 MB',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Generic file attachment tapped'),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            // Multiple selection mode
            _buildSectionTitle(context, 'Multiple Selection Mode'),
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
            ),
            const SizedBox(height: 24),

            // Without file size
            _buildSectionTitle(context, 'Without File Size'),
            const SizedBox(height: 12),

            KubaAttachment(
              fileName: 'simple_document.pdf',
              type: AttachmentType.pdf,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Attachment without size tapped'),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            // Swipeable attachments
            _buildSectionTitle(context, 'Swipeable Attachments'),
            const SizedBox(height: 8),
            Text(
              'Swipe left to remove, swipe right to share',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 12),

            KubaAttachment(
              fileName: 'document_to_remove.pdf',
              type: AttachmentType.pdf,
              fileSize: '2.1 MB',
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
            ),
            const SizedBox(height: 12),

            KubaAttachment(
              fileName: 'photo_to_share.jpg',
              type: AttachmentType.image,
              fileSize: '3.5 MB',
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
              rightSwipeAction: SwipeAction(
                label: 'Share',
                icon: Icons.share,
                backgroundColor: theme.colorScheme.primary,
                iconColor: Colors.white,
                onAction: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Photo shared'),
                      backgroundColor: theme.colorScheme.primary,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),

            KubaAttachment(
              fileName: 'video_only_remove.mp4',
              type: AttachmentType.video,
              fileSize: '45.2 MB',
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
            const SizedBox(height: 12),

            KubaAttachment(
              fileName: 'audio_only_share.mp3',
              type: AttachmentType.audio,
              fileSize: '8.3 MB',
              rightSwipeAction: SwipeAction(
                label: 'Share',
                icon: Icons.share,
                backgroundColor: theme.colorScheme.primary,
                iconColor: Colors.white,
                onAction: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Audio shared'),
                      backgroundColor: theme.colorScheme.primary,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}
