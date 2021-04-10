enum GenderOptions { man, woman }

String genderOptionsToString(GenderOptions value) {
  switch (value) {
    case GenderOptions.woman:
      return 'Female';
    case GenderOptions.man:
    default:
      return 'Male';
  }
}
