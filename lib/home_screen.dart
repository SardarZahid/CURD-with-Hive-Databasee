import 'package:flutter/material.dart';

import 'package:myapp/boxes.dart';
import 'package:myapp/signInScreen.dart';
import 'package:myapp/userModel.dart';
import 'package:myapp/save_data_screen.dart';

class HomeScreen extends StatefulWidget {
  final String userId;

  const HomeScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  

void _addNote() {
  final title = _titleController.text;
  final description = _descriptionController.text;

  if (title.isNotEmpty && description.isNotEmpty) {
    final note = NotesModel(
      title: title,
      description: description,
      userId: widget.userId, // Assuming userId is passed to HomeScreen
    );
    final box = Boxes.getNotesBox();
    box.add(note);

    _titleController.clear();
    _descriptionController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Note added successfully')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 224, 243, 245),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 184, 183, 183),
        title: const Center(child: Text('Home')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addNote,
                child: const Text('Add Note'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SaveDataScreen(userId: widget.userId),
                    ),
                  );
                },
                child: const Text('Show Saved Data'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignInScreen()
                    ),
                  );
                },
                child: const Text('Back to Signin'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
