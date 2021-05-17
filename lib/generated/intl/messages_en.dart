// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static m0(athletes, limits) => "${athletes} / ${limits} Participants.";

  static m1(subscribers, limit) => "${subscribers} of ${limit}";

  static m2(time) => "Final Time: ${time}";

  static m3(weight) => "Plates for ${weight} lb";

  static m4(comment) => "Comment: ${comment}";

  static m5(reps) => "Reps: ${reps}";

  static m6(time) => "Time: ${time}";

  static m7(weight) => "Weight: ${weight} lb";

  static m8(rounds, reps) => "${rounds} Rounds ${reps} Reps";

  static m9(score) => "Score: ${score}";

  static m10(silentmode) => "Silent mode ${silentmode}activated";

  static m11(rounds, reps) => "Total Rounds and Reps: ${rounds} Rounds ${reps} Reps";

  static m12(finalSum) => "Note: ${finalSum} lb is as close as you can get with the plates you have setup.";

  static m13(weight) => "Weight: ${weight}";

  static m14(username) => "Welcome ${username}";

  static m15(username) => "Welcome ${username}";

  static m16(date) => "THIS WOD CANNOT BE VIEWED UNTIL ${date}";

  static m17(wodDate) => "Date: ${wodDate}";

  static m18(wodName) => "Wod Name: ${wodName}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "addPicture" : MessageLookupByLibrary.simpleMessage("Add Picture"),
    "addScore" : MessageLookupByLibrary.simpleMessage("Add Score"),
    "all" : MessageLookupByLibrary.simpleMessage("All"),
    "appBarCalculator" : MessageLookupByLibrary.simpleMessage("RM Calculator"),
    "appBarEditProfile" : MessageLookupByLibrary.simpleMessage("EDIT PROFILE"),
    "appBarFullPhoto" : MessageLookupByLibrary.simpleMessage("FULL PHOTO"),
    "appBarLeaderBoard" : MessageLookupByLibrary.simpleMessage("Leader Board"),
    "appBarPersonalRecords" : MessageLookupByLibrary.simpleMessage("Personal Records"),
    "appBarResultDetails" : MessageLookupByLibrary.simpleMessage("Results Details"),
    "appBarSaveResult" : MessageLookupByLibrary.simpleMessage("Save Result"),
    "appBarSchedule" : MessageLookupByLibrary.simpleMessage("Schedule"),
    "appBarTimers" : MessageLookupByLibrary.simpleMessage("TIMERS"),
    "athlete" : MessageLookupByLibrary.simpleMessage("Athlete"),
    "athletesInClass" : m0,
    "athletesSubscribed" : m1,
    "bookClassButton" : MessageLookupByLibrary.simpleMessage("BOOK"),
    "breakTime" : MessageLookupByLibrary.simpleMessage("Break Time"),
    "breakTimeBetweenEmom" : MessageLookupByLibrary.simpleMessage("Break time between EMOM"),
    "breakTimeBetweenSets" : MessageLookupByLibrary.simpleMessage("Break time between sets"),
    "breakTimer" : MessageLookupByLibrary.simpleMessage("Break"),
    "cancel" : MessageLookupByLibrary.simpleMessage("Cancel"),
    "cancelClassButton" : MessageLookupByLibrary.simpleMessage("CANCEL BOOKING"),
    "cancelTimer" : MessageLookupByLibrary.simpleMessage("CANCEL"),
    "cantCreateWod" : MessageLookupByLibrary.simpleMessage("you cannot create a WOD from a day that has already passed"),
    "cantUpdateWod" : MessageLookupByLibrary.simpleMessage("you cannot update a WOD from a day that has already passed"),
    "changeImage" : MessageLookupByLibrary.simpleMessage("Change Image"),
    "chooseTheAmountOfEmom" : MessageLookupByLibrary.simpleMessage("choose the amount of EMOM"),
    "classBooked" : MessageLookupByLibrary.simpleMessage("You\'ve booked a class"),
    "classCanceled" : MessageLookupByLibrary.simpleMessage("You\'ve canceled the class"),
    "classDetails" : MessageLookupByLibrary.simpleMessage("Class Details"),
    "classEmpty" : MessageLookupByLibrary.simpleMessage("THE CLASS IS EMPTY"),
    "closeButton" : MessageLookupByLibrary.simpleMessage("Close"),
    "completed" : MessageLookupByLibrary.simpleMessage("COMPLETED"),
    "confirmDialog" : MessageLookupByLibrary.simpleMessage("Are you sure want delete this item?"),
    "continuoToSignIn" : MessageLookupByLibrary.simpleMessage("Continue to sign in"),
    "countDownBeforeWorkout" : MessageLookupByLibrary.simpleMessage("Countdown before starting workout"),
    "countdownPips" : MessageLookupByLibrary.simpleMessage("Countdown pips"),
    "create" : MessageLookupByLibrary.simpleMessage("Create"),
    "createWod" : MessageLookupByLibrary.simpleMessage("Create WOD"),
    "crossfitClass" : MessageLookupByLibrary.simpleMessage("CrossFit Class"),
    "deleteButton" : MessageLookupByLibrary.simpleMessage("Delete"),
    "deleteExercise" : MessageLookupByLibrary.simpleMessage("Delete Exercise"),
    "deleteResultAlert" : MessageLookupByLibrary.simpleMessage("Are you sure you want to delete this Result?"),
    "deleteWodAlert" : MessageLookupByLibrary.simpleMessage("Are you sure you want to delete this WOD?"),
    "drawerCalculator" : MessageLookupByLibrary.simpleMessage("1RM Calculator"),
    "drawerChat" : MessageLookupByLibrary.simpleMessage("Kabod Chat"),
    "drawerHome" : MessageLookupByLibrary.simpleMessage("Home"),
    "drawerLeaderBoard" : MessageLookupByLibrary.simpleMessage("LeaderBoard"),
    "drawerLogout" : MessageLookupByLibrary.simpleMessage("Logout"),
    "drawerPersonalRecords" : MessageLookupByLibrary.simpleMessage("Personal Records"),
    "drawerTimers" : MessageLookupByLibrary.simpleMessage("Timers"),
    "editButton" : MessageLookupByLibrary.simpleMessage("Edit"),
    "editProfile" : MessageLookupByLibrary.simpleMessage("Edit profile"),
    "editResult" : MessageLookupByLibrary.simpleMessage("Edit your Result"),
    "editScore" : MessageLookupByLibrary.simpleMessage("Edit Score"),
    "editWod" : MessageLookupByLibrary.simpleMessage("Edit WOD"),
    "emptyMessage" : MessageLookupByLibrary.simpleMessage("Nothing to send"),
    "endWorkout" : MessageLookupByLibrary.simpleMessage("End workout (Plays twice)"),
    "enterExerciseName" : MessageLookupByLibrary.simpleMessage("Enter exercise name"),
    "enterFilters" : MessageLookupByLibrary.simpleMessage("PLEASE ENTER SOME FILTERS TO SEARCH"),
    "enterValidDate" : MessageLookupByLibrary.simpleMessage("PLEASE ENTER A VALID DATE TO SEE THE SCORES"),
    "exerciseHint" : MessageLookupByLibrary.simpleMessage("Please Enter Exercise"),
    "exerciseTime" : MessageLookupByLibrary.simpleMessage("Exercise Time"),
    "exerciseTimePerRepetition" : MessageLookupByLibrary.simpleMessage("Exercise time per repetition"),
    "female" : MessageLookupByLibrary.simpleMessage("Female"),
    "filterGender" : MessageLookupByLibrary.simpleMessage("Gender: "),
    "finalTime" : m2,
    "fromCamera" : MessageLookupByLibrary.simpleMessage("Camera"),
    "fromGallery" : MessageLookupByLibrary.simpleMessage("Gallery"),
    "highBeep" : MessageLookupByLibrary.simpleMessage("High Beep"),
    "introBirthDate" : MessageLookupByLibrary.simpleMessage("Birth date"),
    "introContinueButton" : MessageLookupByLibrary.simpleMessage("CONTINUE"),
    "introGender" : MessageLookupByLibrary.simpleMessage("Select Gender"),
    "introName" : MessageLookupByLibrary.simpleMessage("Name"),
    "introPhone" : MessageLookupByLibrary.simpleMessage("Phone Number"),
    "introTitle" : MessageLookupByLibrary.simpleMessage("You\'re almost ready to get started. We just need a couple more details to complete your profile."),
    "joinedDate" : MessageLookupByLibrary.simpleMessage("joined date"),
    "loginForgotPassword" : MessageLookupByLibrary.simpleMessage("Forgot Password?"),
    "loginFormEmail" : MessageLookupByLibrary.simpleMessage("Please enter an email"),
    "loginFormHintEmail" : MessageLookupByLibrary.simpleMessage("Enter your email"),
    "loginFormHintPassword" : MessageLookupByLibrary.simpleMessage("Enter your password"),
    "loginFormLabelPassword" : MessageLookupByLibrary.simpleMessage("Password"),
    "loginFormPassword" : MessageLookupByLibrary.simpleMessage("Please enter your password"),
    "loginSignIn" : MessageLookupByLibrary.simpleMessage("SIGN IN"),
    "lowBeep" : MessageLookupByLibrary.simpleMessage("Low Beep"),
    "male" : MessageLookupByLibrary.simpleMessage("Male"),
    "newExercise" : MessageLookupByLibrary.simpleMessage("New Exercise"),
    "newPasswordAlert" : MessageLookupByLibrary.simpleMessage("We have sent a new reset link to your email"),
    "newPasswordError" : MessageLookupByLibrary.simpleMessage("Please enter a valid email"),
    "newPr" : MessageLookupByLibrary.simpleMessage("Log New Score"),
    "noClassesToday" : MessageLookupByLibrary.simpleMessage("NO CLASSES TODAY"),
    "noComments" : MessageLookupByLibrary.simpleMessage("No comments"),
    "noDataCalculator" : MessageLookupByLibrary.simpleMessage("No Data to Calculate"),
    "noExercise" : MessageLookupByLibrary.simpleMessage("No exercises found, tap plus button to add!"),
    "noExerciseFound" : MessageLookupByLibrary.simpleMessage("No data found, please add new score"),
    "noPhoto" : MessageLookupByLibrary.simpleMessage("No Photo to show"),
    "noScoreFound" : MessageLookupByLibrary.simpleMessage("NO DATA FOUND"),
    "noScoreWithFilter" : MessageLookupByLibrary.simpleMessage("NO RESULTS FOUND FOR THIS FILTERING"),
    "noUsersFound" : MessageLookupByLibrary.simpleMessage("You don\'t have active chats"),
    "notAnImage" : MessageLookupByLibrary.simpleMessage("This file is not an image"),
    "notificationBody" : MessageLookupByLibrary.simpleMessage("Your class is about to start"),
    "notificationTitle" : MessageLookupByLibrary.simpleMessage("Hurry up!"),
    "openImage" : MessageLookupByLibrary.simpleMessage("Open image..."),
    "optionalComments" : MessageLookupByLibrary.simpleMessage("Optional comments..."),
    "personalInformation" : MessageLookupByLibrary.simpleMessage("Personal information"),
    "pickImage" : MessageLookupByLibrary.simpleMessage("Pick an image"),
    "platesForWeight" : m3,
    "platesToLoad" : MessageLookupByLibrary.simpleMessage("Load these plates on each side of a 45lb bar"),
    "prComment" : m4,
    "prReps" : m5,
    "prTime" : m6,
    "prWeight" : m7,
    "registerAthletes" : MessageLookupByLibrary.simpleMessage("Registered Athletes"),
    "registered" : MessageLookupByLibrary.simpleMessage("Registered"),
    "rename" : MessageLookupByLibrary.simpleMessage("Rename"),
    "renameExercise" : MessageLookupByLibrary.simpleMessage("Rename Exercise"),
    "repTimer" : MessageLookupByLibrary.simpleMessage("Rep"),
    "reps" : MessageLookupByLibrary.simpleMessage("Reps"),
    "repsWorkout" : MessageLookupByLibrary.simpleMessage("Reps in the workout"),
    "required" : MessageLookupByLibrary.simpleMessage("Required"),
    "resetPassword" : MessageLookupByLibrary.simpleMessage("Reset Password"),
    "resetPasswordInstructions" : MessageLookupByLibrary.simpleMessage("Please enter your email address. You will receive a link to create a new password via email"),
    "rest" : MessageLookupByLibrary.simpleMessage("Rest"),
    "restDayMessage1" : MessageLookupByLibrary.simpleMessage("Today is a very important day as it is your scheduled rest day. We pre-program rest days in order to give your body the time it needs to recover and reap the rewards of all the hard work you\'ve done the last few days."),
    "restDayMessage2" : MessageLookupByLibrary.simpleMessage("If you still plan to exercise then please click on a previous calendar day to select a new workout."),
    "restDayMessage3" : MessageLookupByLibrary.simpleMessage("Note: A rest day does not mean that you still can\'t be active: get outside, go for a hike, play with your kids, let your imagination run wild 😉"),
    "restTime" : MessageLookupByLibrary.simpleMessage("Rest Time"),
    "restTimeBetweenRepetitions" : MessageLookupByLibrary.simpleMessage("Rest time between repetitions"),
    "rounds" : MessageLookupByLibrary.simpleMessage("Rounds"),
    "roundsAndReps" : m8,
    "saveButton" : MessageLookupByLibrary.simpleMessage("SAVE"),
    "saveResult" : MessageLookupByLibrary.simpleMessage("Save your Result"),
    "saveResultButton" : MessageLookupByLibrary.simpleMessage("SAVE RESULT"),
    "scale" : MessageLookupByLibrary.simpleMessage("Scale"),
    "scheduleNotAvailable" : MessageLookupByLibrary.simpleMessage("THE SCHEDULE IS NOT AVAILABLE"),
    "score" : MessageLookupByLibrary.simpleMessage("Score"),
    "scoreResult" : m9,
    "searchAthleteHint" : MessageLookupByLibrary.simpleMessage("Athlete Name"),
    "searchExercise" : MessageLookupByLibrary.simpleMessage("Search..."),
    "selectDay" : MessageLookupByLibrary.simpleMessage("Select Date"),
    "sendButton" : MessageLookupByLibrary.simpleMessage("SEND"),
    "setEmom" : MessageLookupByLibrary.simpleMessage("Every minute or Every two minutes"),
    "setTimer" : MessageLookupByLibrary.simpleMessage("Set"),
    "setsInsideTheEmom" : MessageLookupByLibrary.simpleMessage("Sets inside the EMOM"),
    "setsWorkout" : MessageLookupByLibrary.simpleMessage("Sets in the workout"),
    "silenceMode" : MessageLookupByLibrary.simpleMessage("Silent mode"),
    "silentModeActive" : m10,
    "sounds" : MessageLookupByLibrary.simpleMessage("Sounds"),
    "startNextRep" : MessageLookupByLibrary.simpleMessage("Start next rep"),
    "startNextSet" : MessageLookupByLibrary.simpleMessage("Start next set"),
    "startTimer" : MessageLookupByLibrary.simpleMessage("Start Timer"),
    "startingCountdown" : MessageLookupByLibrary.simpleMessage("Starting Countdown"),
    "success" : MessageLookupByLibrary.simpleMessage("Success!"),
    "time" : MessageLookupByLibrary.simpleMessage("Time"),
    "timerSettings" : MessageLookupByLibrary.simpleMessage("Settings"),
    "totalRepsRounds" : m11,
    "totalTime" : MessageLookupByLibrary.simpleMessage("Total Time"),
    "totalTimeTimer" : MessageLookupByLibrary.simpleMessage("Total Time"),
    "tryAgain" : MessageLookupByLibrary.simpleMessage("Try again"),
    "typeMessage" : MessageLookupByLibrary.simpleMessage("Type your message..."),
    "typeOfEmom" : MessageLookupByLibrary.simpleMessage("Type of EMOM"),
    "unexpectedError" : MessageLookupByLibrary.simpleMessage("Upps, an unxepected error occured. Try again!"),
    "updateButton" : MessageLookupByLibrary.simpleMessage("UPDATE"),
    "updateResultButton" : MessageLookupByLibrary.simpleMessage("UPDATE RESULT"),
    "validEmail" : MessageLookupByLibrary.simpleMessage("Please enter a valid email"),
    "warning" : MessageLookupByLibrary.simpleMessage("Warning!"),
    "weight" : MessageLookupByLibrary.simpleMessage("Weight"),
    "weightNote" : m12,
    "weightResult" : m13,
    "welcomeUserMan" : m14,
    "welcomeUserWoman" : m15,
    "wodAvailableDate" : m16,
    "wodDateResult" : m17,
    "wodDescription" : MessageLookupByLibrary.simpleMessage("WOD Description..."),
    "wodName" : MessageLookupByLibrary.simpleMessage("WOD Name: "),
    "wodNameFilter" : MessageLookupByLibrary.simpleMessage("WOD Name"),
    "wodNameResult" : m18,
    "wodNotAvailable" : MessageLookupByLibrary.simpleMessage("THIS WOD IS NO LONGER AVAILABLE"),
    "wodType" : MessageLookupByLibrary.simpleMessage("WOD Type"),
    "yes" : MessageLookupByLibrary.simpleMessage("Yes")
  };
}
