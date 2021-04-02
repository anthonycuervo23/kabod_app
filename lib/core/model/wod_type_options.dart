enum WodTypeOptions { time, weight, amrap, custom }

String wodTypeOptionsToString(WodTypeOptions value) {
  switch (value) {
    case WodTypeOptions.time:
      return 'For Time';
    case WodTypeOptions.amrap:
      return 'AMRAP';
    case WodTypeOptions.weight:
      return 'For Weight';
    case WodTypeOptions.custom:
    default:
      return 'Custom';
  }
}
