import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/userModel.dart';

class SaveDataScreen extends StatelessWidget {
  final String userId;

  const SaveDataScreen({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 231, 94),
      appBar: AppBar(
        title: const Center(child: Text('Saved Notes')),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<NotesModel>('notesBox').listenable(),
        builder: (context, Box<NotesModel> box, _) {
          final userNotes = box.values.where((note) => note.userId == userId).toList();

          if (userNotes.isEmpty) {
            return const Center(child: Text('No notes added yet'));
          } else {
            return ListView.builder(
              itemCount: userNotes.length,
              itemBuilder: (context, index) {
                final note = userNotes[index];
                return Card(
                  color: Colors.white,
                  elevation: 2,
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(
                      note.title,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(note.description),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _editNote(context, note),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteNote(note),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _editNote(BuildContext context, NotesModel note) {
    final TextEditingController _editTitleController = TextEditingController(text: note.title);
    final TextEditingController _editDescriptionController = TextEditingController(text: note.description);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                controller: _editTitleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _editDescriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                note.title = _editTitleController.text;
                note.description = _editDescriptionController.text;
                note.save();

                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteNote(NotesModel note) {
    note.delete();
  }
}
