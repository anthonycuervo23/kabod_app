class WodModel {
  final String title;
  final String type;
  final String description;

  WodModel({this.title, this.type, this.description});
}

List<WodModel> wodList = [
  WodModel(title: 'Strength', type: 'For Time', description: '''
Every 2 Minutes For 12 Minutes (6 Sets)
1 Power Snatch + 1 Hang Power Snatch
70-75% Of 1rm Snatch
'''),
  WodModel(
    title: 'Murph',
    type: 'For Time',
    description: '''
1 Mile Run
100 Pull ups
200 Push ups
300 Squats
1 Mile Run
Partion the Pull ups, Push ups and Squats as needed.
Start and finish with a mile run.
If you have got a twenty pound vest or body armor, wear it.
In memory of Michael Murph, who was killed in Afghanistan June 28th, 2005.
''',
  ),
];
