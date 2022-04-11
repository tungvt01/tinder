enum Gender { male, female, other }

Gender getGenderFromValue({required String genderValue}) {
  if (genderValue.toLowerCase() == 'male') {
    return Gender.male;
  }
  if (genderValue.toLowerCase() == 'female') {
    return Gender.female;
  }
  return Gender.other;
}
