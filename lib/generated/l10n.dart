// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Home`
  String get drawerHome {
    return Intl.message(
      'Home',
      name: 'drawerHome',
      desc: '',
      args: [],
    );
  }

  /// `LeaderBoard`
  String get drawerLeaderBoard {
    return Intl.message(
      'LeaderBoard',
      name: 'drawerLeaderBoard',
      desc: '',
      args: [],
    );
  }

  /// `Personal Records`
  String get drawerPersonalRecords {
    return Intl.message(
      'Personal Records',
      name: 'drawerPersonalRecords',
      desc: '',
      args: [],
    );
  }

  /// `1RM Calculator`
  String get drawerCalculator {
    return Intl.message(
      '1RM Calculator',
      name: 'drawerCalculator',
      desc: '',
      args: [],
    );
  }

  /// `Timers`
  String get drawerTimers {
    return Intl.message(
      'Timers',
      name: 'drawerTimers',
      desc: '',
      args: [],
    );
  }

  /// `Kabod Chat`
  String get drawerChat {
    return Intl.message(
      'Kabod Chat',
      name: 'drawerChat',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get drawerLogout {
    return Intl.message(
      'Logout',
      name: 'drawerLogout',
      desc: '',
      args: [],
    );
  }

  /// `You're almost ready to get started. We just need a couple more details to complete your profile.`
  String get introTitle {
    return Intl.message(
      'You\'re almost ready to get started. We just need a couple more details to complete your profile.',
      name: 'introTitle',
      desc: '',
      args: [],
    );
  }

  /// `CONTINUE`
  String get introContinueButton {
    return Intl.message(
      'CONTINUE',
      name: 'introContinueButton',
      desc: '',
      args: [],
    );
  }

  /// `Select Gender`
  String get introGender {
    return Intl.message(
      'Select Gender',
      name: 'introGender',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get introName {
    return Intl.message(
      'Name',
      name: 'introName',
      desc: '',
      args: [],
    );
  }

  /// `Birth date`
  String get introBirthDate {
    return Intl.message(
      'Birth date',
      name: 'introBirthDate',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get introPhone {
    return Intl.message(
      'Phone Number',
      name: 'introPhone',
      desc: '',
      args: [],
    );
  }

  /// `Please enter an email`
  String get loginFormEmail {
    return Intl.message(
      'Please enter an email',
      name: 'loginFormEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get loginFormHintEmail {
    return Intl.message(
      'Enter your email',
      name: 'loginFormHintEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get loginFormPassword {
    return Intl.message(
      'Please enter your password',
      name: 'loginFormPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get loginFormHintPassword {
    return Intl.message(
      'Enter your password',
      name: 'loginFormHintPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get loginFormLabelPassword {
    return Intl.message(
      'Password',
      name: 'loginFormLabelPassword',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get loginForgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'loginForgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `SIGN IN`
  String get loginSignIn {
    return Intl.message(
      'SIGN IN',
      name: 'loginSignIn',
      desc: '',
      args: [],
    );
  }

  /// `Pick an image`
  String get pickImage {
    return Intl.message(
      'Pick an image',
      name: 'pickImage',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get fromGallery {
    return Intl.message(
      'Gallery',
      name: 'fromGallery',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get fromCamera {
    return Intl.message(
      'Camera',
      name: 'fromCamera',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email address. You will receive a link to create a new password via email`
  String get resetPasswordInstructions {
    return Intl.message(
      'Please enter your email address. You will receive a link to create a new password via email',
      name: 'resetPasswordInstructions',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get validEmail {
    return Intl.message(
      'Please enter a valid email',
      name: 'validEmail',
      desc: '',
      args: [],
    );
  }

  /// `SEND`
  String get sendButton {
    return Intl.message(
      'SEND',
      name: 'sendButton',
      desc: '',
      args: [],
    );
  }

  /// `RM Calculator`
  String get appBarCalculator {
    return Intl.message(
      'RM Calculator',
      name: 'appBarCalculator',
      desc: '',
      args: [],
    );
  }

  /// `Weight`
  String get weight {
    return Intl.message(
      'Weight',
      name: 'weight',
      desc: '',
      args: [],
    );
  }

  /// `Required`
  String get required {
    return Intl.message(
      'Required',
      name: 'required',
      desc: '',
      args: [],
    );
  }

  /// `Reps`
  String get reps {
    return Intl.message(
      'Reps',
      name: 'reps',
      desc: '',
      args: [],
    );
  }

  /// `No Data to Calculate`
  String get noDataCalculator {
    return Intl.message(
      'No Data to Calculate',
      name: 'noDataCalculator',
      desc: '',
      args: [],
    );
  }

  /// `Plates for {weight} lb`
  String platesForWeight(Object weight) {
    return Intl.message(
      'Plates for $weight lb',
      name: 'platesForWeight',
      desc: '',
      args: [weight],
    );
  }

  /// `Load these plates on each side of a 45lb bar`
  String get platesToLoad {
    return Intl.message(
      'Load these plates on each side of a 45lb bar',
      name: 'platesToLoad',
      desc: '',
      args: [],
    );
  }

  /// `Note: {finalSum} lb is as close as you can get with the plates you have setup.`
  String weightNote(Object finalSum) {
    return Intl.message(
      'Note: $finalSum lb is as close as you can get with the plates you have setup.',
      name: 'weightNote',
      desc: '',
      args: [finalSum],
    );
  }

  /// `FULL PHOTO`
  String get appBarFullPhoto {
    return Intl.message(
      'FULL PHOTO',
      name: 'appBarFullPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Nothing to send`
  String get emptyMessage {
    return Intl.message(
      'Nothing to send',
      name: 'emptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `This file is not an image`
  String get notAnImage {
    return Intl.message(
      'This file is not an image',
      name: 'notAnImage',
      desc: '',
      args: [],
    );
  }

  /// `Type your message...`
  String get typeMessage {
    return Intl.message(
      'Type your message...',
      name: 'typeMessage',
      desc: '',
      args: [],
    );
  }

  /// `You don't have active chats`
  String get noUsersFound {
    return Intl.message(
      'You don\'t have active chats',
      name: 'noUsersFound',
      desc: '',
      args: [],
    );
  }

  /// `Athlete Name`
  String get searchAthleteHint {
    return Intl.message(
      'Athlete Name',
      name: 'searchAthleteHint',
      desc: '',
      args: [],
    );
  }

  /// `Open image...`
  String get openImage {
    return Intl.message(
      'Open image...',
      name: 'openImage',
      desc: '',
      args: [],
    );
  }

  /// `Schedule`
  String get appBarSchedule {
    return Intl.message(
      'Schedule',
      name: 'appBarSchedule',
      desc: '',
      args: [],
    );
  }

  /// `Class Details`
  String get classDetails {
    return Intl.message(
      'Class Details',
      name: 'classDetails',
      desc: '',
      args: [],
    );
  }

  /// `CrossFit Class`
  String get crossfitClass {
    return Intl.message(
      'CrossFit Class',
      name: 'crossfitClass',
      desc: '',
      args: [],
    );
  }

  /// `{subscribers} of {limit}`
  String athletesSubscribed(Object subscribers, Object limit) {
    return Intl.message(
      '$subscribers of $limit',
      name: 'athletesSubscribed',
      desc: '',
      args: [subscribers, limit],
    );
  }

  /// `Registered Athletes`
  String get registerAthletes {
    return Intl.message(
      'Registered Athletes',
      name: 'registerAthletes',
      desc: '',
      args: [],
    );
  }

  /// `THE CLASS IS EMPTY`
  String get classEmpty {
    return Intl.message(
      'THE CLASS IS EMPTY',
      name: 'classEmpty',
      desc: '',
      args: [],
    );
  }

  /// `You've booked a class`
  String get classBooked {
    return Intl.message(
      'You\'ve booked a class',
      name: 'classBooked',
      desc: '',
      args: [],
    );
  }

  /// `BOOK`
  String get bookClassButton {
    return Intl.message(
      'BOOK',
      name: 'bookClassButton',
      desc: '',
      args: [],
    );
  }

  /// `You've canceled the class`
  String get classCanceled {
    return Intl.message(
      'You\'ve canceled the class',
      name: 'classCanceled',
      desc: '',
      args: [],
    );
  }

  /// `CANCEL BOOKING`
  String get cancelClassButton {
    return Intl.message(
      'CANCEL BOOKING',
      name: 'cancelClassButton',
      desc: '',
      args: [],
    );
  }

  /// `Today is a very important day as it is your scheduled rest day. We pre-program rest days in order to give your body the time it needs to recover and reap the rewards of all the hard work you've done the last few days.`
  String get restDayMessage1 {
    return Intl.message(
      'Today is a very important day as it is your scheduled rest day. We pre-program rest days in order to give your body the time it needs to recover and reap the rewards of all the hard work you\'ve done the last few days.',
      name: 'restDayMessage1',
      desc: '',
      args: [],
    );
  }

  /// `If you still plan to exercise then please click on a previous calendar day to select a new workout.`
  String get restDayMessage2 {
    return Intl.message(
      'If you still plan to exercise then please click on a previous calendar day to select a new workout.',
      name: 'restDayMessage2',
      desc: '',
      args: [],
    );
  }

  /// `Note: A rest day does not mean that you still can't be active: get outside, go for a hike, play with your kids, let your imagination run wild 😉`
  String get restDayMessage3 {
    return Intl.message(
      'Note: A rest day does not mean that you still can\'t be active: get outside, go for a hike, play with your kids, let your imagination run wild 😉',
      name: 'restDayMessage3',
      desc: '',
      args: [],
    );
  }

  /// `Edit Score`
  String get editScore {
    return Intl.message(
      'Edit Score',
      name: 'editScore',
      desc: '',
      args: [],
    );
  }

  /// `Add Score`
  String get addScore {
    return Intl.message(
      'Add Score',
      name: 'addScore',
      desc: '',
      args: [],
    );
  }

  /// `Start Timer`
  String get startTimer {
    return Intl.message(
      'Start Timer',
      name: 'startTimer',
      desc: '',
      args: [],
    );
  }

  /// `Edit WOD`
  String get editWod {
    return Intl.message(
      'Edit WOD',
      name: 'editWod',
      desc: '',
      args: [],
    );
  }

  /// `Welcome {username}`
  String welcomeUser(Object username) {
    return Intl.message(
      'Welcome $username',
      name: 'welcomeUser',
      desc: '',
      args: [username],
    );
  }

  /// `THE SCHEDULE IS NOT AVAILABLE`
  String get scheduleNotAvailable {
    return Intl.message(
      'THE SCHEDULE IS NOT AVAILABLE',
      name: 'scheduleNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `NO CLASSES TODAY`
  String get noClassesToday {
    return Intl.message(
      'NO CLASSES TODAY',
      name: 'noClassesToday',
      desc: '',
      args: [],
    );
  }

  /// `Registered`
  String get registered {
    return Intl.message(
      'Registered',
      name: 'registered',
      desc: '',
      args: [],
    );
  }

  /// `COMPLETED`
  String get completed {
    return Intl.message(
      'COMPLETED',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `{athletes} / {limits} Participants`
  String athletesInClass(Object athletes, Object limits) {
    return Intl.message(
      '$athletes / $limits Participants',
      name: 'athletesInClass',
      desc: '',
      args: [athletes, limits],
    );
  }

  /// `THIS WOD IS NO LONGER AVAILABLE`
  String get wodNotAvailable {
    return Intl.message(
      'THIS WOD IS NO LONGER AVAILABLE',
      name: 'wodNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `THIS WOD CANNOT BE VIEWED UNTIL {date}`
  String wodAvailableDate(Object date) {
    return Intl.message(
      'THIS WOD CANNOT BE VIEWED UNTIL $date',
      name: 'wodAvailableDate',
      desc: '',
      args: [date],
    );
  }

  /// `Leader Board`
  String get appBarLeaderBoard {
    return Intl.message(
      'Leader Board',
      name: 'appBarLeaderBoard',
      desc: '',
      args: [],
    );
  }

  /// `PLEASE ENTER SOME FILTERS TO SEARCH`
  String get enterFilters {
    return Intl.message(
      'PLEASE ENTER SOME FILTERS TO SEARCH',
      name: 'enterFilters',
      desc: '',
      args: [],
    );
  }

  /// `Scale`
  String get scale {
    return Intl.message(
      'Scale',
      name: 'scale',
      desc: '',
      args: [],
    );
  }

  /// `NO DATA FOUND`
  String get noScoreFound {
    return Intl.message(
      'NO DATA FOUND',
      name: 'noScoreFound',
      desc: '',
      args: [],
    );
  }

  /// `Select Date`
  String get selectDay {
    return Intl.message(
      'Select Date',
      name: 'selectDay',
      desc: '',
      args: [],
    );
  }

  /// `PLEASE ENTER A VALID DATE TO SEE THE SCORES`
  String get enterValidDate {
    return Intl.message(
      'PLEASE ENTER A VALID DATE TO SEE THE SCORES',
      name: 'enterValidDate',
      desc: '',
      args: [],
    );
  }

  /// `WOD Name: `
  String get wodName {
    return Intl.message(
      'WOD Name: ',
      name: 'wodName',
      desc: '',
      args: [],
    );
  }

  /// `NO RESULTS FOUND FOR THIS FILTERING`
  String get noScoreWithFilter {
    return Intl.message(
      'NO RESULTS FOUND FOR THIS FILTERING',
      name: 'noScoreWithFilter',
      desc: '',
      args: [],
    );
  }

  /// `Gender: `
  String get filterGender {
    return Intl.message(
      'Gender: ',
      name: 'filterGender',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `{rounds} Rounds {reps} Reps`
  String roundsAndReps(Object rounds, Object reps) {
    return Intl.message(
      '$rounds Rounds $reps Reps',
      name: 'roundsAndReps',
      desc: '',
      args: [rounds, reps],
    );
  }

  /// `Results Details`
  String get appBarResultDetails {
    return Intl.message(
      'Results Details',
      name: 'appBarResultDetails',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time {
    return Intl.message(
      'Time',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `Optional comments...`
  String get optionalComments {
    return Intl.message(
      'Optional comments...',
      name: 'optionalComments',
      desc: '',
      args: [],
    );
  }

  /// `Time: {time}`
  String prTime(Object time) {
    return Intl.message(
      'Time: $time',
      name: 'prTime',
      desc: '',
      args: [time],
    );
  }

  /// `Reps: {reps}`
  String prReps(Object reps) {
    return Intl.message(
      'Reps: $reps',
      name: 'prReps',
      desc: '',
      args: [reps],
    );
  }

  /// `Weight: {weight} lb`
  String prWeight(Object weight) {
    return Intl.message(
      'Weight: $weight lb',
      name: 'prWeight',
      desc: '',
      args: [weight],
    );
  }

  /// `Comment: {comment}`
  String prComment(Object comment) {
    return Intl.message(
      'Comment: $comment',
      name: 'prComment',
      desc: '',
      args: [comment],
    );
  }

  /// `Edit`
  String get editButton {
    return Intl.message(
      'Edit',
      name: 'editButton',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get deleteButton {
    return Intl.message(
      'Delete',
      name: 'deleteButton',
      desc: '',
      args: [],
    );
  }

  /// `Warning!`
  String get warning {
    return Intl.message(
      'Warning!',
      name: 'warning',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure want delete this item?`
  String get confirmDialog {
    return Intl.message(
      'Are you sure want delete this item?',
      name: 'confirmDialog',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Log New Score`
  String get newPr {
    return Intl.message(
      'Log New Score',
      name: 'newPr',
      desc: '',
      args: [],
    );
  }

  /// `Rename Exercise`
  String get renameExercise {
    return Intl.message(
      'Rename Exercise',
      name: 'renameExercise',
      desc: '',
      args: [],
    );
  }

  /// `Delete Exercise`
  String get deleteExercise {
    return Intl.message(
      'Delete Exercise',
      name: 'deleteExercise',
      desc: '',
      args: [],
    );
  }

  /// `No data found, please add new score`
  String get noExerciseFound {
    return Intl.message(
      'No data found, please add new score',
      name: 'noExerciseFound',
      desc: '',
      args: [],
    );
  }

  /// `Enter exercise name`
  String get enterExerciseName {
    return Intl.message(
      'Enter exercise name',
      name: 'enterExerciseName',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Exercise`
  String get exerciseHint {
    return Intl.message(
      'Please Enter Exercise',
      name: 'exerciseHint',
      desc: '',
      args: [],
    );
  }

  /// `New Exercise`
  String get newExercise {
    return Intl.message(
      'New Exercise',
      name: 'newExercise',
      desc: '',
      args: [],
    );
  }

  /// `Rename`
  String get rename {
    return Intl.message(
      'Rename',
      name: 'rename',
      desc: '',
      args: [],
    );
  }

  /// `Personal Records`
  String get appBarPersonalRecords {
    return Intl.message(
      'Personal Records',
      name: 'appBarPersonalRecords',
      desc: '',
      args: [],
    );
  }

  /// `Search...`
  String get searchExercise {
    return Intl.message(
      'Search...',
      name: 'searchExercise',
      desc: '',
      args: [],
    );
  }

  /// `No exercises found, tap plus button to add!`
  String get noExercise {
    return Intl.message(
      'No exercises found, tap plus button to add!',
      name: 'noExercise',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `Save your Result`
  String get saveResult {
    return Intl.message(
      'Save your Result',
      name: 'saveResult',
      desc: '',
      args: [],
    );
  }

  /// `Save Result`
  String get appBarSaveResult {
    return Intl.message(
      'Save Result',
      name: 'appBarSaveResult',
      desc: '',
      args: [],
    );
  }

  /// `Edit your Result`
  String get editResult {
    return Intl.message(
      'Edit your Result',
      name: 'editResult',
      desc: '',
      args: [],
    );
  }

  /// `UPDATE RESULT`
  String get updateResultButton {
    return Intl.message(
      'UPDATE RESULT',
      name: 'updateResultButton',
      desc: '',
      args: [],
    );
  }

  /// `SAVE RESULT`
  String get saveResultButton {
    return Intl.message(
      'SAVE RESULT',
      name: 'saveResultButton',
      desc: '',
      args: [],
    );
  }

  /// `Personal information`
  String get personalInformation {
    return Intl.message(
      'Personal information',
      name: 'personalInformation',
      desc: '',
      args: [],
    );
  }

  /// `joined date`
  String get joinedDate {
    return Intl.message(
      'joined date',
      name: 'joinedDate',
      desc: '',
      args: [],
    );
  }

  /// `SAVE`
  String get saveButton {
    return Intl.message(
      'SAVE',
      name: 'saveButton',
      desc: '',
      args: [],
    );
  }

  /// `Athlete`
  String get athlete {
    return Intl.message(
      'Athlete',
      name: 'athlete',
      desc: '',
      args: [],
    );
  }

  /// `Edit profile`
  String get editProfile {
    return Intl.message(
      'Edit profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `EDIT PROFILE`
  String get appBarEditProfile {
    return Intl.message(
      'EDIT PROFILE',
      name: 'appBarEditProfile',
      desc: '',
      args: [],
    );
  }

  /// `Rounds`
  String get rounds {
    return Intl.message(
      'Rounds',
      name: 'rounds',
      desc: '',
      args: [],
    );
  }

  /// `Score`
  String get score {
    return Intl.message(
      'Score',
      name: 'score',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this Result?`
  String get deleteResultAlert {
    return Intl.message(
      'Are you sure you want to delete this Result?',
      name: 'deleteResultAlert',
      desc: '',
      args: [],
    );
  }

  /// `Add Picture`
  String get addPicture {
    return Intl.message(
      'Add Picture',
      name: 'addPicture',
      desc: '',
      args: [],
    );
  }

  /// `Change Image`
  String get changeImage {
    return Intl.message(
      'Change Image',
      name: 'changeImage',
      desc: '',
      args: [],
    );
  }

  /// `Wod Name: {wodName}`
  String wodNameResult(Object wodName) {
    return Intl.message(
      'Wod Name: $wodName',
      name: 'wodNameResult',
      desc: '',
      args: [wodName],
    );
  }

  /// `Date: {wodDate}`
  String wodDateResult(Object wodDate) {
    return Intl.message(
      'Date: $wodDate',
      name: 'wodDateResult',
      desc: '',
      args: [wodDate],
    );
  }

  /// `Weight: {weight}`
  String weightResult(Object weight) {
    return Intl.message(
      'Weight: $weight',
      name: 'weightResult',
      desc: '',
      args: [weight],
    );
  }

  /// `Total Rounds and Reps: {rounds} Rounds {reps} Reps`
  String totalRepsRounds(Object rounds, Object reps) {
    return Intl.message(
      'Total Rounds and Reps: $rounds Rounds $reps Reps',
      name: 'totalRepsRounds',
      desc: '',
      args: [rounds, reps],
    );
  }

  /// `Final Time: {time}`
  String finalTime(Object time) {
    return Intl.message(
      'Final Time: $time',
      name: 'finalTime',
      desc: '',
      args: [time],
    );
  }

  /// `Score: {score}`
  String scoreResult(Object score) {
    return Intl.message(
      'Score: $score',
      name: 'scoreResult',
      desc: '',
      args: [score],
    );
  }

  /// `No comments`
  String get noComments {
    return Intl.message(
      'No comments',
      name: 'noComments',
      desc: '',
      args: [],
    );
  }

  /// `No Photo to show`
  String get noPhoto {
    return Intl.message(
      'No Photo to show',
      name: 'noPhoto',
      desc: '',
      args: [],
    );
  }

  /// `CANCEL`
  String get cancelTimer {
    return Intl.message(
      'CANCEL',
      name: 'cancelTimer',
      desc: '',
      args: [],
    );
  }

  /// `Rep`
  String get repTimer {
    return Intl.message(
      'Rep',
      name: 'repTimer',
      desc: '',
      args: [],
    );
  }

  /// `Set`
  String get setTimer {
    return Intl.message(
      'Set',
      name: 'setTimer',
      desc: '',
      args: [],
    );
  }

  /// `Total Time`
  String get totalTimeTimer {
    return Intl.message(
      'Total Time',
      name: 'totalTimeTimer',
      desc: '',
      args: [],
    );
  }

  /// `Low Beep`
  String get lowBeep {
    return Intl.message(
      'Low Beep',
      name: 'lowBeep',
      desc: '',
      args: [],
    );
  }

  /// `High Beep`
  String get highBeep {
    return Intl.message(
      'High Beep',
      name: 'highBeep',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get timerSettings {
    return Intl.message(
      'Settings',
      name: 'timerSettings',
      desc: '',
      args: [],
    );
  }

  /// `Silent mode`
  String get silenceMode {
    return Intl.message(
      'Silent mode',
      name: 'silenceMode',
      desc: '',
      args: [],
    );
  }

  /// `Sounds`
  String get sounds {
    return Intl.message(
      'Sounds',
      name: 'sounds',
      desc: '',
      args: [],
    );
  }

  /// `Countdown pips`
  String get countdownPips {
    return Intl.message(
      'Countdown pips',
      name: 'countdownPips',
      desc: '',
      args: [],
    );
  }

  /// `Start next rep`
  String get startNextRep {
    return Intl.message(
      'Start next rep',
      name: 'startNextRep',
      desc: '',
      args: [],
    );
  }

  /// `Rest`
  String get rest {
    return Intl.message(
      'Rest',
      name: 'rest',
      desc: '',
      args: [],
    );
  }

  /// `Break`
  String get breakTimer {
    return Intl.message(
      'Break',
      name: 'breakTimer',
      desc: '',
      args: [],
    );
  }

  /// `Start next set`
  String get startNextSet {
    return Intl.message(
      'Start next set',
      name: 'startNextSet',
      desc: '',
      args: [],
    );
  }

  /// `End workout (Plays twice)`
  String get endWorkout {
    return Intl.message(
      'End workout (Plays twice)',
      name: 'endWorkout',
      desc: '',
      args: [],
    );
  }

  /// `TIMERS`
  String get appBarTimers {
    return Intl.message(
      'TIMERS',
      name: 'appBarTimers',
      desc: '',
      args: [],
    );
  }

  /// `Silent mode {silentmode}activated`
  String silentModeActive(Object silentmode) {
    return Intl.message(
      'Silent mode ${silentmode}activated',
      name: 'silentModeActive',
      desc: '',
      args: [silentmode],
    );
  }

  /// `Sets in the workout`
  String get setsWorkout {
    return Intl.message(
      'Sets in the workout',
      name: 'setsWorkout',
      desc: '',
      args: [],
    );
  }

  /// `Reps in the workout`
  String get repsWorkout {
    return Intl.message(
      'Reps in the workout',
      name: 'repsWorkout',
      desc: '',
      args: [],
    );
  }

  /// `Starting Countdown`
  String get startingCountdown {
    return Intl.message(
      'Starting Countdown',
      name: 'startingCountdown',
      desc: '',
      args: [],
    );
  }

  /// `Countdown before starting workout`
  String get countDownBeforeWorkout {
    return Intl.message(
      'Countdown before starting workout',
      name: 'countDownBeforeWorkout',
      desc: '',
      args: [],
    );
  }

  /// `Exercise Time`
  String get exerciseTime {
    return Intl.message(
      'Exercise Time',
      name: 'exerciseTime',
      desc: '',
      args: [],
    );
  }

  /// `Exercise time per repetition`
  String get exerciseTimePerRepetition {
    return Intl.message(
      'Exercise time per repetition',
      name: 'exerciseTimePerRepetition',
      desc: '',
      args: [],
    );
  }

  /// `Rest Time`
  String get restTime {
    return Intl.message(
      'Rest Time',
      name: 'restTime',
      desc: '',
      args: [],
    );
  }

  /// `Rest time between repetitions`
  String get restTimeBetweenRepetitions {
    return Intl.message(
      'Rest time between repetitions',
      name: 'restTimeBetweenRepetitions',
      desc: '',
      args: [],
    );
  }

  /// `Break Time`
  String get breakTime {
    return Intl.message(
      'Break Time',
      name: 'breakTime',
      desc: '',
      args: [],
    );
  }

  /// `Break time between sets`
  String get breakTimeBetweenSets {
    return Intl.message(
      'Break time between sets',
      name: 'breakTimeBetweenSets',
      desc: '',
      args: [],
    );
  }

  /// `Total Time`
  String get totalTime {
    return Intl.message(
      'Total Time',
      name: 'totalTime',
      desc: '',
      args: [],
    );
  }

  /// `choose the amount of EMOM`
  String get chooseTheAmountOfEmom {
    return Intl.message(
      'choose the amount of EMOM',
      name: 'chooseTheAmountOfEmom',
      desc: '',
      args: [],
    );
  }

  /// `Sets inside the EMOM`
  String get setsInsideTheEmom {
    return Intl.message(
      'Sets inside the EMOM',
      name: 'setsInsideTheEmom',
      desc: '',
      args: [],
    );
  }

  /// `Type of EMOM`
  String get typeOfEmom {
    return Intl.message(
      'Type of EMOM',
      name: 'typeOfEmom',
      desc: '',
      args: [],
    );
  }

  /// `Every minute or Every two minutes`
  String get setEmom {
    return Intl.message(
      'Every minute or Every two minutes',
      name: 'setEmom',
      desc: '',
      args: [],
    );
  }

  /// `Break time between EMOM`
  String get breakTimeBetweenEmom {
    return Intl.message(
      'Break time between EMOM',
      name: 'breakTimeBetweenEmom',
      desc: '',
      args: [],
    );
  }

  /// `WOD Type`
  String get wodType {
    return Intl.message(
      'WOD Type',
      name: 'wodType',
      desc: '',
      args: [],
    );
  }

  /// `WOD Description...`
  String get wodDescription {
    return Intl.message(
      'WOD Description...',
      name: 'wodDescription',
      desc: '',
      args: [],
    );
  }

  /// `you cannot update a WOD from a day that has already passed`
  String get cantUpdateWod {
    return Intl.message(
      'you cannot update a WOD from a day that has already passed',
      name: 'cantUpdateWod',
      desc: '',
      args: [],
    );
  }

  /// `you cannot create a WOD from a day that has already passed`
  String get cantCreateWod {
    return Intl.message(
      'you cannot create a WOD from a day that has already passed',
      name: 'cantCreateWod',
      desc: '',
      args: [],
    );
  }

  /// `UPDATE`
  String get updateButton {
    return Intl.message(
      'UPDATE',
      name: 'updateButton',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get closeButton {
    return Intl.message(
      'Close',
      name: 'closeButton',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this WOD?`
  String get deleteWodAlert {
    return Intl.message(
      'Are you sure you want to delete this WOD?',
      name: 'deleteWodAlert',
      desc: '',
      args: [],
    );
  }

  /// `Create WOD`
  String get createWod {
    return Intl.message(
      'Create WOD',
      name: 'createWod',
      desc: '',
      args: [],
    );
  }

  /// `We have sent a new reset link to your email`
  String get newPasswordAlert {
    return Intl.message(
      'We have sent a new reset link to your email',
      name: 'newPasswordAlert',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get newPasswordError {
    return Intl.message(
      'Please enter a valid email',
      name: 'newPasswordError',
      desc: '',
      args: [],
    );
  }

  /// `Success!`
  String get success {
    return Intl.message(
      'Success!',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get tryAgain {
    return Intl.message(
      'Try again',
      name: 'tryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Continue to sign in`
  String get continuoToSignIn {
    return Intl.message(
      'Continue to sign in',
      name: 'continuoToSignIn',
      desc: '',
      args: [],
    );
  }

  /// `WOD Name`
  String get wodNameFilter {
    return Intl.message(
      'WOD Name',
      name: 'wodNameFilter',
      desc: '',
      args: [],
    );
  }

  /// `Upps, an unxepected error occured. Try again!`
  String get unexpectedError {
    return Intl.message(
      'Upps, an unxepected error occured. Try again!',
      name: 'unexpectedError',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}