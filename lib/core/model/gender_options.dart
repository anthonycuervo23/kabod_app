enum GenderOptions { man, woman }

String genderOptionsToString(GenderOptions value) {
  switch (value) {
    case GenderOptions.woman:
      return 'Woman';
    case GenderOptions.man:
    default:
      return 'Man';
  }
}
