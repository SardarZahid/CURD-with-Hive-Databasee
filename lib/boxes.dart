import 'package:hive/hive.dart';
import 'package:myapp/userModel.dart';

class Boxes {
  static Box<User> getUserBox() => Hive.box<User>('users');
  static Box<NotesModel> getNotesBox() => Hive.box<NotesModel>('notesBox');
}
