import 'package:flutter/material.dart';

class Material3TestPage extends StatefulWidget {
  const Material3TestPage({super.key});

  @override
  State<Material3TestPage> createState() => _Material3TestPageState();
}

class _Material3TestPageState extends State<Material3TestPage> {
  bool _switchValue = false;
  bool _checkboxValue = false;
  int _radioValue = 1;
  double _sliderValue = 50.0;
  String? _dropdownMenuValue;
  String? _dropdownButtonValue;
  String? _bottomSheetValue;
  final List<String> _options = [
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material 3 UI Test'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Buttons Section
            _buildSectionTitle('Buttons'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton(
                  onPressed: () {},
                  child: const Text('Filled Button'),
                ),
                FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite),
                  label: const Text('Filled Icon'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Outlined Button'),
                ),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.star),
                  label: const Text('Outlined Icon'),
                ),
                TextButton(onPressed: () {}, child: const Text('Text Button')),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.share),
                  label: const Text('Text Icon'),
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.thumb_up)),
                IconButton.filled(
                  onPressed: () {},
                  icon: const Icon(Icons.thumb_up),
                ),
                IconButton.outlined(
                  onPressed: () {},
                  icon: const Icon(Icons.thumb_up),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Floating Action Buttons
            _buildSectionTitle('Floating Action Buttons'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                FloatingActionButton.small(
                  onPressed: () {},
                  child: const Icon(Icons.add),
                ),
                FloatingActionButton(
                  onPressed: () {},
                  child: const Icon(Icons.edit),
                ),
                FloatingActionButton.extended(
                  onPressed: () {},
                  icon: const Icon(Icons.send),
                  label: const Text('Extended FAB'),
                ),
                FloatingActionButton.large(
                  onPressed: () {},
                  child: const Icon(Icons.favorite),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Cards
            _buildSectionTitle('Cards'),
            const SizedBox(height: 8),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.account_circle),
                    title: const Text('Card Title'),
                    subtitle: const Text('Card subtitle with description'),
                    trailing: IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {},
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('This is a Material 3 card with content.'),
                  ),
                  ButtonBar(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text('Action 1'),
                      ),
                      FilledButton(
                        onPressed: () {},
                        child: const Text('Action 2'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 0,
              color: Theme.of(context).colorScheme.surfaceVariant,
              child: const ListTile(
                leading: Icon(Icons.info),
                title: Text('Filled Card'),
                subtitle: Text('Card with filled background'),
              ),
            ),
            const SizedBox(height: 24),

            // Chips
            _buildSectionTitle('Chips'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(
                  label: const Text('Assist Chip'),
                  avatar: const Icon(Icons.person, size: 18),
                  onDeleted: () {},
                ),
                FilterChip(
                  label: const Text('Filter Chip'),
                  selected: _checkboxValue,
                  onSelected: (value) {
                    setState(() => _checkboxValue = value);
                  },
                ),
                ChoiceChip(
                  label: const Text('Choice Chip'),
                  selected: _radioValue == 1,
                  onSelected: (selected) {
                    if (selected) setState(() => _radioValue = 1);
                  },
                ),
                ActionChip(
                  label: const Text('Action Chip'),
                  avatar: const Icon(Icons.settings, size: 18),
                  onPressed: () {},
                ),
                InputChip(label: const Text('Input Chip'), onDeleted: () {}),
              ],
            ),
            const SizedBox(height: 24),

            // Text Fields
            _buildSectionTitle('Text Fields'),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Standard Text Field',
                hintText: 'Enter text here',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {},
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Filled Text Field',
                hintText: 'Filled variant',
                filled: true,
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Outlined Text Field',
                hintText: 'Outlined variant',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
                suffixIcon: Icon(Icons.visibility),
              ),
            ),
            const SizedBox(height: 24),

            // Dropdowns
            _buildSectionTitle('Dropdowns (For Forms)'),
            const SizedBox(height: 8),
            const Text(
              'DropdownMenu (Material 3 - Recommended)',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            DropdownMenu<String>(
              label: const Text('Select an option'),
              hintText: 'Choose from list',
              width: double.infinity,
              initialSelection: _dropdownMenuValue,
              onSelected: (String? value) {
                setState(() {
                  _dropdownMenuValue = value;
                });
              },
              dropdownMenuEntries: _options.map<DropdownMenuEntry<String>>((
                String value,
              ) {
                return DropdownMenuEntry<String>(value: value, label: value);
              }).toList(),
            ),
            const SizedBox(height: 16),
            DropdownMenu<String>(
              label: const Text('Filled Dropdown'),
              hintText: 'Filled variant',
              width: double.infinity,
              initialSelection: _dropdownMenuValue,
              onSelected: (String? value) {
                setState(() {
                  _dropdownMenuValue = value;
                });
              },
              menuStyle: MenuStyle(
                backgroundColor: WidgetStateProperty.all(
                  Theme.of(context).colorScheme.surfaceVariant,
                ),
              ),
              dropdownMenuEntries: _options.map<DropdownMenuEntry<String>>((
                String value,
              ) {
                return DropdownMenuEntry<String>(value: value, label: value);
              }).toList(),
            ),
            const SizedBox(height: 16),
            const Text(
              'DropdownButton (Classic)',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            DropdownButton<String>(
              value: _dropdownButtonValue,
              hint: const Text('Select an option'),
              isExpanded: true,
              items: _options.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _dropdownButtonValue = newValue;
                });
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _dropdownButtonValue,
              decoration: const InputDecoration(
                labelText: 'DropdownButtonFormField',
                hintText: 'With form styling',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.arrow_drop_down),
              ),
              items: _options.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _dropdownButtonValue = newValue;
                });
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Bottom Sheet Dropdown (Better for Mobile)',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              readOnly: true,
              controller: TextEditingController(text: _bottomSheetValue ?? ''),
              decoration: InputDecoration(
                labelText: 'Select with Bottom Sheet',
                hintText: 'Tap to open bottom sheet',
                suffixIcon: const Icon(Icons.arrow_drop_down),
                border: const OutlineInputBorder(),
              ),
              onTap: () => _showBottomSheetDropdown(context),
            ),

            const SizedBox(height: 24),

            // Switches and Checkboxes
            _buildSectionTitle('Switches & Checkboxes'),
            const SizedBox(height: 8),
            SwitchListTile(
              secondary: const Icon(Icons.switch_account),
              title: const Text('Switch List Tile'),
              subtitle: const Text('Toggle switch with label'),
              value: _switchValue,
              onChanged: (value) => setState(() => _switchValue = value),
            ),
            CheckboxListTile(
              title: const Text('Checkbox List Tile'),
              subtitle: const Text('Checkbox with label'),
              value: _checkboxValue,
              onChanged: (value) =>
                  setState(() => _checkboxValue = value ?? false),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Switch(
                  value: _switchValue,
                  onChanged: (value) => setState(() => _switchValue = value),
                ),
                const SizedBox(width: 16),
                Checkbox(
                  value: _checkboxValue,
                  onChanged: (value) =>
                      setState(() => _checkboxValue = value ?? false),
                ),
                const SizedBox(width: 16),
                Radio<int>(
                  value: 1,
                  groupValue: _radioValue,
                  onChanged: (value) =>
                      setState(() => _radioValue = value ?? 1),
                ),
                const SizedBox(width: 8),
                Radio<int>(
                  value: 2,
                  groupValue: _radioValue,
                  onChanged: (value) =>
                      setState(() => _radioValue = value ?? 2),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Sliders
            _buildSectionTitle('Sliders'),
            const SizedBox(height: 8),
            Slider(
              value: _sliderValue,
              min: 0,
              max: 100,
              divisions: 10,
              label: _sliderValue.round().toString(),
              onChanged: (value) => setState(() => _sliderValue = value),
            ),
            Text('Value: ${_sliderValue.round()}'),
            const SizedBox(height: 8),
            RangeSlider(
              values: const RangeValues(20, 80),
              min: 0,
              max: 100,
              divisions: 10,
              labels: const RangeLabels('20', '80'),
              onChanged: (values) {},
            ),
            const SizedBox(height: 24),

            // Progress Indicators
            _buildSectionTitle('Progress Indicators'),
            const SizedBox(height: 8),
            const LinearProgressIndicator(),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: 0.6,
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            CircularProgressIndicator(value: 0.7, strokeWidth: 4),
            const SizedBox(height: 24),

            // Badges
            _buildSectionTitle('Badges'),
            const SizedBox(height: 8),
            Row(
              children: [
                Badge(
                  label: const Text('3'),
                  child: const Icon(Icons.notifications, size: 32),
                ),
                const SizedBox(width: 16),
                Badge(
                  label: const Text('99+'),
                  child: const Icon(Icons.mail, size: 32),
                ),
                const SizedBox(width: 16),
                Badge(child: const Icon(Icons.favorite, size: 32)),
              ],
            ),
            const SizedBox(height: 24),

            // Segmented Buttons
            _buildSectionTitle('Segmented Buttons'),
            const SizedBox(height: 8),
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 1, label: Text('Option 1')),
                ButtonSegment(value: 2, label: Text('Option 2')),
                ButtonSegment(value: 3, label: Text('Option 3')),
              ],
              selected: {_radioValue},
              onSelectionChanged: (Set<int> newSelection) {
                setState(() => _radioValue = newSelection.first);
              },
            ),
            const SizedBox(height: 24),

            // Dialogs and Snackbars
            _buildSectionTitle('Dialogs & Snackbars'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Material 3 Dialog'),
                        content: const Text(
                          'This is a Material 3 styled dialog.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          FilledButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text('Show Dialog'),
                ),
                FilledButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Material 3 Snackbar'),
                        action: SnackBarAction(
                          label: 'Action',
                          onPressed: () {},
                        ),
                      ),
                    );
                  },
                  child: const Text('Show Snackbar'),
                ),
                FilledButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Container(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Material 3 Bottom Sheet'),
                            const SizedBox(height: 16),
                            FilledButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Close'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: const Text('Show Bottom Sheet'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Navigation
            _buildSectionTitle('Navigation'),
            const SizedBox(height: 8),
            SizedBox(
              height: 80,
              child: NavigationBar(
                selectedIndex: 0,
                onDestinationSelected: (index) {},
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.favorite_outline),
                    selectedIcon: Icon(Icons.favorite),
                    label: 'Favorites',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.settings_outlined),
                    selectedIcon: Icon(Icons.settings),
                    label: 'Settings',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ClipRect(
              child: SizedBox(
                height: 250,
                child: NavigationRail(
                  selectedIndex: 0,
                  onDestinationSelected: (index) {},
                  labelType: NavigationRailLabelType.all,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite_outline),
                      selectedIcon: Icon(Icons.favorite),
                      label: Text('Favorites'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.settings_outlined),
                      selectedIcon: Icon(Icons.settings),
                      label: Text('Settings'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Dividers
            _buildSectionTitle('Dividers'),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),
            const Divider(indent: 20, endIndent: 20),
            const SizedBox(height: 8),
            Row(
              children: [
                const Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'OR',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                const Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 24),

            // Lists
            _buildSectionTitle('List Tiles'),
            const SizedBox(height: 8),
            Card(
              child: Column(
                children: [
                  const ListTile(
                    leading: Icon(Icons.person),
                    title: Text('List Tile'),
                    subtitle: Text('Subtitle text'),
                    trailing: Icon(Icons.chevron_right),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.star),
                    title: const Text('List Tile with Switch'),
                    trailing: Switch(
                      value: _switchValue,
                      onChanged: (value) =>
                          setState(() => _switchValue = value),
                    ),
                  ),
                  const Divider(height: 1),
                  const ListTile(
                    leading: Icon(Icons.info),
                    title: Text('Leading and Trailing Icons'),
                    trailing: Icon(Icons.more_vert),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _showBottomSheetDropdown(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 8, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Title
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select an Option',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const Divider(),
              // Options list
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _options.length,
                  itemBuilder: (context, index) {
                    final option = _options[index];
                    final isSelected = _bottomSheetValue == option;
                    return ListTile(
                      leading: Icon(
                        isSelected ? Icons.check_circle : Icons.circle_outlined,
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : null,
                      ),
                      title: Text(option),
                      subtitle: Text('Description for $option'),
                      selected: isSelected,
                      onTap: () {
                        setState(() {
                          _bottomSheetValue = option;
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
