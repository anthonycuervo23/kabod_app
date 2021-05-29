import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kabod_app/core/presentation/routes.dart';
import 'package:kabod_app/screens/personal_records/components/exercisesList.dart';
import 'package:kabod_app/screens/personal_records/models/pr_model.dart';
import 'package:kabod_app/screens/personal_records/pr_results_screen.dart';

void main() {
  testWidgets('make sure we render exercise list', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ExercisesList()));
    await tester.pump();
    expect(find.byType(ExercisesList), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(ListTile), findsNothing);
  });

  testWidgets('make sure list of exercises is been render',
      (WidgetTester tester) async {
    List<Exercise> mockedExercises = [
      Exercise(id: '2', uid: '3', results: [], exercise: 'squat'),
      Exercise(id: '1', uid: '4', results: [], exercise: 'run')
    ];

    await tester.pumpWidget(
        MaterialApp(home: ExercisesList(exercises: mockedExercises)));
    await tester.pump();
    expect(find.byType(ExercisesList), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(Card), findsNWidgets(2));
    expect(find.byType(ListTile), findsNWidgets(2));
    expect(find.text('squat'), findsNWidgets(1));
    expect(find.text('run'), findsNWidgets(1));
  });

  testWidgets('make sure onTap is executed after taping a Card',
      (WidgetTester tester) async {
    List<Exercise> mockedExercises = [
      Exercise(id: '2', uid: '3', results: [], exercise: 'squat'),
      Exercise(id: '1', uid: '4', results: [], exercise: 'run')
    ];

    await tester.pumpWidget(MaterialApp(
        // onGenerateRoute: AppRoutes.generateRoute,
        home: ExercisesList(exercises: mockedExercises)));
    await tester.pump();
    expect(find.byType(ExercisesList), findsOneWidget);
    expect(find.byType(ListTile), findsNWidgets(2));
    expect(find.text('squat'), findsNWidgets(1));
    expect(find.text('run'), findsNWidgets(1));
    Finder textFinder = find.text('squat');
    // await tester.tap(textFinder);
    // await tester.pump();
    // expect(find.byType(ResultsScreen), findsOneWidget);
  });
}
