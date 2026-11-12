import 'package:flutter/material.dart';
import 'animated_welcome_card.dart';
import '../domain/task.dart';
import '../data/in_memory_task_repository.dart';
import 'add_task_screen.dart';
import 'task_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _repository = InMemoryTaskRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Hub Flutter Application -Asnaf Mehmood'),
        actions: [
          IconButton(
            tooltip: 'Add task',
            icon: const Icon(Icons.add),
            onPressed: _addTask,
          ),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const UserAccountsDrawerHeader(
                accountName: Text('Asnaf Mehmood'),
                accountEmail: Text('2502145@students.au.edu.pk'),
                currentAccountPicture: CircleAvatar(
                  child: Icon(Icons.school, size: 30),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home_outlined),
                title: const Text('Home'),
                onTap: () => Navigator.pop(context), // already on Home
              ),
              ListTile(
                leading: const Icon(Icons.explore_outlined),
                title: const Text('Explore'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/explore');
                },
              ),
              ListTile(
                leading: const Icon(Icons.person_outline),
                title: const Text('Profile'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/profile');
                },
              ),
              ListTile(
                leading: const Icon(Icons.widgets_outlined),
                title: const Text('UI Showcase'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/showcase');
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('About this lab'),
                onTap: () {
                  Navigator.pop(context);
                  showAboutDialog(
                    context: context,
                    applicationName: 'Flutter Project -Asnaf',
                    applicationVersion: '6.7.8',
                    children: const [Text('My First Flutter application')],
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/study.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(child: _buildHomeContent()),
        ],
      ),
      // bottomNavigationBar removed: main navigation is now the drawer
    );
  }

  Widget _buildHomeContent() {
    final tasks = _repository.getTasks();
    return ListView(
      padding: const EdgeInsets.all(16),
            children: [
        const AnimatedWelcomeCard(),
        const SizedBox(height: 16),
        Text(
          'Good morning Asnaf!',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 4),
        const Text('Student Workplace of Asnaf'),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                title: 'Tasks',
                value: '${tasks.length}',
                icon: Icons.checklist,
              ),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: _StatCard(
                title: 'Courses',
                value: '3',
                icon: Icons.menu_book_outlined,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text('My tasks', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        ...tasks.map(
          (task) => Card(
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.task_alt)),
              title: Text(task.title),
              subtitle: Text(task.description),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _openTask(task),
            ),
          ),
        ),
        const SizedBox(height: 10),
        FilledButton.icon(
          onPressed: _addTask,
          icon: const Icon(Icons.add),
          label: const Text('Add a task'),
        ),
      ],
    );
  }

  void _openTask(Task task) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => TaskDetailScreen(task: task)),
    ).then((_) => setState(() {}));
  }

  Future<void> _addTask() async {
    final task = await Navigator.push<Task>(
      context,
      MaterialPageRoute(builder: (_) => const AddTaskScreen()),
    );
    if (task != null) {
      setState(() => _repository.addTask(task));
    }
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 40),
            const SizedBox(height: 30),
            Text(value, style: Theme.of(context).textTheme.headlineMedium),
            Text(title),
          ],
        ),
      ),
    );
  }
}

// Was _ExploreContent (private tab body). Now a public full screen
// so it can be opened with the '/explore' named route.
class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Explore')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(
            child: ListTile(
              leading: Icon(Icons.event_outlined),
              title: Text('Upcoming events'),
              subtitle: Text('Seerah Fest, Sports Week'),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.library_books_outlined),
              title: Text('Learning resources'),
              subtitle: Text('Air Uni Resources'),
            ),
          ),
        ],
      ),
    );
  }
}