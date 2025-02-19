import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: DigitalPetApp()));
}

class DigitalPetApp extends StatefulWidget {
  @override
  _DigitalPetAppState createState() => _DigitalPetAppState();
}

class _DigitalPetAppState extends State<DigitalPetApp> {
  String petName = "Your Pet";
  int happinessLevel = 50;
  int hungerLevel = 50;
  var petHappyColor = Colors.yellow;
  String petMoodText = 'Nuetral';
  // Function to increase happiness and update hunger when playing with
  // the pet

  IconData _getMoodIcon() {
  if (happinessLevel < 30) {
    return Icons.sentiment_very_dissatisfied; // Sad face
  } else if (happinessLevel > 70) {
    return Icons.sentiment_very_satisfied; // Happy face
  } else {
    return Icons.sentiment_neutral; // Neutral face
  }
}

  void _updateMoodText(){
    setState(() {
      if (happinessLevel < 30) {
        petMoodText = 'Unhappy';
      } else if (happinessLevel > 70) {
        petMoodText = 'Happy';
      } else {
        petMoodText = 'Neutral';
      }
    });
  }

  void _changePetColorHappiness() {
    setState(() {
      if (happinessLevel < 30) {
        petHappyColor = Colors.red;
      } else if (happinessLevel > 70) {
        petHappyColor = Colors.green;
      } else {
        petHappyColor = Colors.yellow;
      }
    });
  }

  void _playWithPet() {
    setState(() {
      happinessLevel = (happinessLevel + 10).clamp(0, 100);
      _updateHunger();
      _changePetColorHappiness();
      _updateMoodText();
    });
  }

  // Function to decrease hunger and update happiness when feeding the pet
  void _feedPet() {
    setState(() {
      hungerLevel = (hungerLevel - 10).clamp(0, 100);
      _updateHappiness();
    });
  }

  // Update happiness based on hunger level
  void _updateHappiness() {
    if (hungerLevel < 30) {
      happinessLevel = (happinessLevel - 20).clamp(0, 100);
    } else {
      happinessLevel = (happinessLevel + 10).clamp(0, 100);
    }
    _changePetColorHappiness();
    _updateMoodText();
  }

  // Increase hunger level slightly when playing with the pet
  void _updateHunger() {
    hungerLevel = (hungerLevel + 5).clamp(0, 100);
    if (hungerLevel > 100) {
      hungerLevel = 100;
      happinessLevel = (happinessLevel - 20).clamp(0, 100);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Digital Pet')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: [
                Center(
                  child: Container(
                  width: 200.0,
                  height: 200.0,
                  color: petHappyColor,
                  ),
                ),
                Center( // Center the image
                  child: Image.asset(
                    'assets/images/cartoonDog.jpg',
                    width: 190.0,
                    height: 190.0,
                    fit: BoxFit.cover, // Or BoxFit.contain if you want it to scale within 190x190
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Mood: $petMoodText', style: TextStyle(fontSize: 20.0)),
                SizedBox(width: 8.0), // Spacing between icon and text
                Icon(_getMoodIcon(), size: 30.0, color: Colors.blue),
              ],
            ),
            SizedBox(height: 16.0),
            Text('Name: $petName', style: TextStyle(fontSize: 20.0)),
            SizedBox(height: 16.0),
            Text(
              'Happiness Level: $happinessLevel',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Hunger Level: $hungerLevel',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _playWithPet,
              child: Text('Play with Your Pet'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(onPressed: _feedPet, child: Text('Feed Your Pet')),
          ],
        ),
      ),
    );
  }
}
