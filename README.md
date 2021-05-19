## CrossFit Kabod app - a Gym Management app in flutter [![GitHub stars](https://img.shields.io/github/stars/anthonycuervo23/kabod_app?style=social)](https://github.com/login?return_to=%2Fanthonycuervo23%kabod_app) ![GitHub forks](https://img.shields.io/github/forks/anthonycuervo23/kabod_app?style=social) 
![GitHub pull requests](https://img.shields.io/github/issues-pr/anthonycuervo23/kabod_app) ![GitHub closed pull requests](https://img.shields.io/github/issues-pr-closed/anthonycuervo23/kabod_app) ![GitHub last commit](https://img.shields.io/github/last-commit/anthonycuervo23/kabod_app)  ![GitHub issues](https://img.shields.io/github/issues-raw/anthonycuervo23/kabod_app) [![Open Source Love](https://badges.frapsoft.com/os/v2/open-source.svg?v=103)](https://github.com/anthonycuervo23/kabod_app) 



A working Gym Management written in Flutter using Firebase auth,firestore database and storage.

## NOTE: 
* This app was intentionally created to be used in a specific crossfit called [![@CrossFitKabod](https://www.instagram.com/crossfitkabod/)
* . If you want to use the application you must enter with the following credentials: 
* user: test@email.com 
* password: test123


## Download App
[![Get it from iTunes](https://lisk.io/sites/default/files/pictures/2020-01/download_on_the_app_store_badge.svg)](https://apps.apple.com/us/app/crossfit-kabod/id1567053900)
[![Get it on Google Play](https://lisk.io/sites/default/files/pictures/2020-01/download_on_the_play_store_badge.svg)](https://play.google.com/store/apps/details?id=com.jeancuervo.kabod_app)

## Features

* WODs - View current and past WODs
* Class - Register and sign-in to class
* Results - Record your WOD results
* Leaderboard - View current and past WOD results of all classes
* Personal Records - Add a result and see your history of all exercises (gymnastics, weightlifting, metcons, and more)
* RM Calculator - Add the weight and reps and calculate your 1RM
* Weight Calculator - Add the weight you want to have in the barbell and the calculator will do the maths
* Timers - Use the Tabata and Emom timers in your workouts
* Chat - Use the chat to be in touch with the Athletes and coaches


## Dependencies
<details>
     <summary> Click to expand </summary>
     
* [audioplayers](https://pub.dev/packages/audioplayers)
* [cached_network_image](https://pub.dev/packages//cached_network_image)
* [cloud_firestore](https://pub.dev/packages/cloud_firestore)
* [datetime_picker_formfield](https://pub.dev/packages/datetime_picker_formfield)
* [firebase_core](https://pub.dev/packages/firebase_core)
* [firebase_auth](https://pub.dev/packages/firebase_auth)
* [firebase_messaging](https://pub.dev/packages/firebase_messaging)
* [firebase_storage](https://pub.dev/packages/firebase_storage)
* [flutter_colorpicker](https://pub.dev/packages/flutter_colorpicker)
* [flutter_form_builder](https://pub.dev/packages/flutter_form_builder)
* [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications)
* [flutter_staggered_animations](https://pub.dev/packages/flutter_staggered_animations)
* [flutter_native_timezone](https://pub.dev/packages/flutter_native_timezone)
* [fluttertoast](https://pub.dev/packages/fluttertoast)
* [font_awesome_flutter](https://pub.dev/packages/font_awesome_flutter)
* [http](https://pub.dev/packages/http)
* [intl](https://pub.dev/packages/intl)
* [image_picker](https://pub.dev/packages/image_picker)
* [image_cropper](https://pub.dev/packages/image_cropper)
* [numberpicker](https://pub.dev/packages/numberpicker)
* [photo_view](https://pub.dev/packages/photo_view)
* [provider](https://pub.dev/packages/provider)
* [screen](https://pub.dev/packages/screen)
* [shared_preferences](https://pub.dev/packages/shared_preferences)
* [table_calendar](https://pub.dev/packages/table_calendar)

     
</details>

## Screenshots

Drawer              |  Home Page (WOD)               | Home Page (Schedule)              |  Class Reservation
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
![](https://user-images.githubusercontent.com/72933322/118514393-84c12480-b702-11eb-97ba-6126934c51f1.png)|![](https://user-images.githubusercontent.com/72933322/118514827-c8b42980-b702-11eb-90c1-74d6f7ac0806.png)|![](https://user-images.githubusercontent.com/72933322/118514911-dff31700-b702-11eb-9868-58e3bd660365.png)|![](https://user-images.githubusercontent.com/72933322/118515012-f600d780-b702-11eb-9859-156de55ec956.png)|

Leaderboard         |  Save Results       |   Personal Records 1             |  Personal Records 2
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
![](https://user-images.githubusercontent.com/72933322/118515074-0913a780-b703-11eb-923f-76d4d4feb6fe.png)|![](https://user-images.githubusercontent.com/72933322/118515301-4415db00-b703-11eb-9acf-77ec3ebd0ab7.png)|![](https://user-images.githubusercontent.com/72933322/118515387-5728ab00-b703-11eb-84fe-6b972bfc0686.png)|![](https://user-images.githubusercontent.com/72933322/118515506-745d7980-b703-11eb-9bef-4396963cd570.png)|

Weight Calculator                  | 1RM Calculator       |   Timers      |     Profile
:-------------------------:|:-------------------------:|:-------------------------:|:-------------------------:
![](https://user-images.githubusercontent.com/72933322/118515620-893a0d00-b703-11eb-8d45-7fadb97a62ba.png)|![](https://user-images.githubusercontent.com/72933322/118515674-97882900-b703-11eb-9a31-d4a01e891a38.png)|![](https://user-images.githubusercontent.com/72933322/118515803-b7b7e800-b703-11eb-9716-117e2b2a7c1e.png)|![](https://user-images.githubusercontent.com/72933322/118515856-c69e9a80-b703-11eb-8589-da4f495d6244.png)|






## Getting started 
* Project setup instructions are given at [Wiki](https://github.com/anthonycuervo23/kabod_app/wiki) section.

## Directory Structure
<details>
     <summary> Click to expand </summary>
  
```
|-- lib
|   |-- core
|   |   |-- model
|   |   |   '-- gender_options.dart
|   |   |   '-- main_screen_model.dart
|   |   |   '-- wod_type_options.dart
|   |   |-- presentation
|   |   |   '-- constants.dart
|   |   |   '-- routes.dart
|   |   |-- repository
|   |   |   '-- chat_repository.dart
|   |   |   '-- classes_repository.dart
|   |   |   '-- intro_profile_repository.dart
|   |   |   '-- results_repository.dart
|   |   |   '-- user_repository.dart
|   |   |   '-- wod_repository.dart
|   |   |-- utils
|   |   |   '-- decimalTextInputFormatter.dart
|   |   |   '-- general_utils.dart
|   |-- generated
|   |   |-- intl
|   |   |   '-- messages_all.dart
|   |   |   '-- messages_en.dart
|   |   |   '-- messages_es.dart
|   |   '-- I10n.dart
|   |-- I10n
|   |   '-- intl_en.dart
|   |   '-- intl_es.dart
|   |-- navigationDrawer
|   |   |-- model
|   |   |   '-- drawer_notifier.dart
|   |   '-- main_drawer.dart
|   |-- screens
|   |   |-- Auth
|   |   |   |-- components
|   |   |   |   '-- background_image.dart
|   |   |   |   '-- intro_profile_form.dart
|   |   |   |   '-- login_fields.dart
|   |   |   |   '-- login_form.dart
|   |   |   |   '-- logo.dart
|   |   |   |   '-- text_fields_input.dart
|   |   |   |-- model
|   |   |   |   '-- user_model.dart
|   |   |   |-- screens
|   |   |   |   '-- intro_screen.dart
|   |   |   |   '-- login_screen.dart
|   |   |   |   '-- login_screens_controller.dart
|   |   |   |   '-- reset_password_screen.dart
|   |   |   |   '-- splash.dart
|   |   |-- calculator
|   |   |   |-- components
|   |   |   |   '-- calculator.dart
|   |   |   |   '-- custom_dialog.dart
|   |   |   |   '-- input_cards.dart
|   |   |   |   '-- result_card.dart
|   |   |   '-- calculator_screen.dart
|   |   |-- chat
|   |   |   |-- components
|   |   |   |   '-- full_photo.dart
|   |   |   |   '-- loading.dart
|   |   |   |-- helpers
|   |   |   |   '-- sharedPreferences_helper.dart
|   |   |   |-- screens
|   |   |   |   '-- chat_room.dart
|   |   |   |   '-- home_chat.dart
|   |   |-- classes
|   |   |   |-- components
|   |   |   |   '-- users_gridView.dart
|   |   |   |-- model
|   |   |   |   '-- class_details_screen.dart
|   |   |-- commons
|   |   |   '-- appbar.dart
|   |   |   '-- dividers.dart
|   |   |   '-- reusable_button.dart
|   |   |   '-- reusable_card.dart
|   |   |   '-- show_toast.dart
|   |   |-- home
|   |   |   |-- components
|   |   |   |    '-- calendar_wod_message.dart
|   |   |   |    '-- main_calendar.dart
|   |   |   |    '-- popup_menu.dart
|   |   |   '-- home_screen.dart
|   |   |-- leaderboard
|   |   |   |-- components
|   |   |   |    '-- leaderboard_cards.dart
|   |   |   '-- leaderboard_screen.dart
|   |   |   '-- picture_details_screen.dart
|   |   |-- personal_records
|   |   |   |-- components
|   |   |   |    '-- exercisesList.dart
|   |   |   |    '-- pr_result_form.dart
|   |   |   |    '-- result_details.dart
|   |   |   |    '-- resultsList.dart
|   |   |   |-- model
|   |   |   |    '-- pr_model.dart
|   |   |   '-- pr_results_screen.dart
|   |   |   '-- pr_screen.dart
|   |   |   '-- result_editor_screen.dart
|   |   |-- profile
|   |   |   |-- components
|   |   |   |    '-- avatar.dart
|   |   |   |    '-- profile_header.dart
|   |   |   |    '-- user_info.dart
|   |   |   '-- editProfile_screen.dart
|   |   |   '-- profile_screen.dart
|   |   |-- results
|   |   |   |-- components
|   |   |   |    '-- add_results_form.dart
|   |   |   |    '-- delete_result_button.dart
|   |   |   |-- model
|   |   |   |    '-- results_model.dart
|   |   |   '-- add_results.dart
|   |   |   '-- edit_results.dart
|   |   |-- timers
|   |   |   |-- components
|   |   |   |    '-- durationpicker.dart
|   |   |   |    '-- round_icon_button.dart
|   |   |   |-- model
|   |   |   |    '-- emom_model.dart
|   |   |   |    '-- settings_model.dart
|   |   |   |    '-- tabata_model.dart
|   |   |   '-- emom_timer_screen.dart
|   |   |   '-- settings_screen.dart
|   |   |   '-- tabata_screen.dart
|   |   |   '-- workout_screen.dart
|   |   |-- wods
|   |   |   |-- components
|   |   |   |    '-- add_wod_form.dart
|   |   |   |    '-- alert_dialog.dart
|   |   |   |    '-- delete_wod_button.dart
|   |   |   |-- model
|   |   |   |    '-- wod_model.dart
|   |   |   '-- wod_editor_screen.dart
|   |-- service
|   |   '-- api_service.dart
|   |   '-- notifications.dart
|   |   '-- sharedPreferences.dart
|   |-- main.dart
|-- pubspec.yaml
```

</details>
     
## Contributing

If you wish to contribute a change to any of the existing feature or add new in this repo,
please review our [contribution guide](https://github.com/anthonycuervo23/kabod_app/blob/master/CONTRIBUTING.md),
and send a [pull request](https://github.com/anthonycuervo23/kabod_app/pulls). I welcome and encourage all pull requests. It usually will take me within 24-48 hours to respond to any issue or request.

## Created & Maintained By

[Jean Cuervo](https://github.com/anthonycuervo23)

> If you found this project helpful or you learned something from the source code and want to thank me, consider buying me a cup of :coffee:
>

## Visitors Count

<img align="left" src = "https://profile-counter.glitch.me/kabod_app/count.svg" alt ="Loading">
