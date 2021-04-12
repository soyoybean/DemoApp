import 'package:demo_app/main.dart';
import 'package:demo_app/preferences_service.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'models.dart';

//Map<String,String> journalEntry = Map();
final preferencesService = PreferencesService();

final entryController = TextEditingController();
var selectedGender = Gender.FEMALE;
var selectedMood = Set<Mood>();
var isRecommend = false;

class Entries extends StatefulWidget{
  @override
  _Entries createState() => new _Entries();
}

class _Entries extends State<Entries> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Journal Entry')),
        body: new ListView(
          children: <Widget>[
            // JOURNAL ENTRY
            ListTile(
              title: TextField(
                controller: entryController,
                decoration: InputDecoration(labelText: 'Enter journal entry'),
              ),
            ),
            // GENDER
            RadioListTile(title: Text('Female'), value: Gender.FEMALE, groupValue: selectedGender, onChanged: (newValue) => setState(() => selectedGender = newValue)),
            RadioListTile(title: Text('Male'), value: Gender.MALE, groupValue: selectedGender, onChanged: (newValue) => setState(() => selectedGender = newValue)),
            RadioListTile(title: Text('Other'), value: Gender.OTHER, groupValue: selectedGender, onChanged: (newValue) => setState(() => selectedGender = newValue)),
            // MOOD
            CheckboxListTile(title: Text('Happy'), value: selectedMood.contains(Mood.HAPPY), onChanged: (_) {
              setState(() {
                selectedMood.contains(Mood.HAPPY)
                    ? selectedMood.remove(Mood.HAPPY)
                    : selectedMood.add(Mood.HAPPY);
              });
            }),
            CheckboxListTile(title: Text('Sad'), value: selectedMood.contains(Mood.SAD), onChanged: (_) {
              setState(() {
                selectedMood.contains(Mood.SAD)
                    ? selectedMood.remove(Mood.SAD)
                    : selectedMood.add(Mood.SAD);
              });
            }),
            CheckboxListTile(title: Text('Angry'), value: selectedMood.contains(Mood.ANGRY), onChanged: (_) {
              setState(() {
                selectedMood.contains(Mood.ANGRY)
                    ? selectedMood.remove(Mood.ANGRY)
                    : selectedMood.add(Mood.ANGRY);
              });
            }),
            CheckboxListTile(title: Text('Other'), value: selectedMood.contains(Mood.OTHER), onChanged: (_) {
              setState(() {
                selectedMood.contains(Mood.OTHER)
                    ? selectedMood.remove(Mood.OTHER)
                    : selectedMood.add(Mood.OTHER);
              });
            }),
            // RECOMMEND MINDFULNESS VIDEO
            SwitchListTile(title: Text('Recommend Mindfulness Video'), value: isRecommend, onChanged: (newValue) => setState(() => isRecommend = newValue)),
            ElevatedButton(onPressed: _saveJournal, child: Text('Save Entry'))
          ],
        )
    );
  }

  void _saveJournal() {
    final newJournal = Journal(entry: entryController.text, gender: selectedGender, mood: selectedMood, isRecommend: isRecommend);
    print(newJournal);
    preferencesService.saveJournal(newJournal);
    Navigator.of(context).pop('String');
  }
}
      /*SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              // Insert a text
              Text(
                'This is a new screen',
                style: TextStyle(fontSize: 24.0),
              ),
              // Insert a button shaped as an image
              new FlatButton(
                child: Image.asset('assets/happy.png', width: 120, height: 120),
                onPressed: () {},
              ),
              // Insert an Image
              new SizedBox(
                width: 30.0,
                height: 30.0,
                child: new Image.asset("assets/happy.png")
              )
             ],),
          ],
        ),
      ),
    );
  }
}*/