import 'package:flutter/material.dart';

import 'editor/editor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dialogue System Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: true,
      ),
      home: const DialogueEditor(),
    );
  }
}

class DialogueEditor extends StatefulWidget {
  const DialogueEditor({super.key});

  @override
  State<DialogueEditor> createState() => _DialogueEditorState();
}

class _DialogueEditorState extends State<DialogueEditor> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(_selectedIndex == 0 ? 'Editor' : 'Example'),
      ),
      body: _selectedIndex == 0 ? const Editor() : const Example(),
      bottomNavigationBar: BottomNavigationBar(onTap: _onItemTapped, items: [
        BottomNavigationBarItem(label: 'Editor', icon: const Icon(Icons.edit)),
        BottomNavigationBarItem(label: 'Example', icon: const Icon(Icons.home))
      ]),
    );
  }
}

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
