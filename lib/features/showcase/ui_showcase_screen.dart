import 'package:flutter/material.dart';
import 'web_page_panel.dart';

class UiShowcaseScreen extends StatelessWidget {
  const UiShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(title: const Text('UI Showcase')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Flutter Widget Gallery',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          const Text('Common widgets and layout patterns'),
          const SizedBox(height: 16),

          // Container, Icon, Expanded
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2F7),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              children: [
                Icon(Icons.widgets, size: 32),
                SizedBox(width: 12),
                Expanded(child: Text('Container, Icon and Expanded')),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Card, Buttons, IconButton
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Buttons and Card'),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      FilledButton(
                        onPressed: () => ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                              content: Text('Button pressed'),
                            )),
                        child: const Text('Filled Button'),
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        child: const Text('Outlined Button'),
                      ),
                      IconButton(
                        tooltip: 'Favorite',
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Image.network with a fallback
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 150,
                alignment: Alignment.center,
                color: Colors.black12,
                child: const Text('Image could not be loaded'),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Stack and Positioned
          SizedBox(
            height: 130,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 61, 47),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const Positioned(
                  left: 16,
                  top: 16,
                  child: Icon(Icons.school, color: Colors.white, size: 34),
                ),
                const Positioned(
                  left: 16,
                  bottom: 16,
                  child: Text(
                    'Stack: widgets can overlap',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const Positioned(
                  right: 16,
                  top: 16,
                  child: Icon(Icons.star, color: Colors.amber, size: 28),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // GridView inside ListView
          GridView.count(
            crossAxisCount: width >= 600 ? 4 : 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.5,
            children: const [
              _GridTile(icon: Icons.book, label: 'Courses'),
              _GridTile(icon: Icons.event, label: 'Events'),
              _GridTile(icon: Icons.task_alt, label: 'Tasks'),
              _GridTile(icon: Icons.person, label: 'Profile'),
            ],
          ),
          const SizedBox(height: 12),

          // Responsive layout with LayoutBuilder
          LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxWidth < 500;
              const first = _InfoCard(
                title: 'Row / Column',
                text: 'Arrange children horizontally or vertically.',
              );
              const second = _InfoCard(
                title: 'Expanded',
                text: 'Fill the remaining space in a Flex layout.',
              );
              return compact
                  ? const Column(children: [first, SizedBox(height: 12), second])
                  : const Row(
                      children: [
                        Expanded(child: first),
                        SizedBox(width: 12),
                        Expanded(child: second),
                      ],
                    );
            },
          ),
          const SizedBox(height: 12),

          // Flexible vs Expanded (student exercise)
          const Text(
            'Flexible vs Expanded',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  color: const Color(0xFFE3F2F7),
                  child: const Text('Flexible: uses only the space it needs'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  color: const Color.fromARGB(255, 255, 51, 51),
                  child: const Text('Expanded: fills the rest of the row'),
                ),
              ),
                        const SizedBox(height: 12),
          const Text(
            'Embedded web page',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const WebPagePanel(),
            ],
          ),
        ],
      ),
    );
  }
}

class _GridTile extends StatelessWidget {
  final IconData icon;
  final String label;
  const _GridTile({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28),
          const SizedBox(height: 6),
          Text(label),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String text;
  const _InfoCard({required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(text),
          ],
        ),
      ),
    );
  }
}