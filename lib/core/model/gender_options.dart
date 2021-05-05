enum GenderOptions { man, woman }

String genderOptionsToString(GenderOptions value) {
  switch (value) {
    case GenderOptions.woman:
      return 'Femenino';
    case GenderOptions.man:
    default:
      return 'Masculino';
  }
}
