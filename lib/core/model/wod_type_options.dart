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

WodTypeOptions enumFromString(String s) {
  switch (s) {
    case 'For Time':
      return WodTypeOptions.time;
    case 'AMRAP':
      return WodTypeOptions.amrap;
    case 'For Weight':
      return WodTypeOptions.weight;
    case 'Custom':
      return WodTypeOptions.custom;
    default:
      return WodTypeOptions.time;
  }
}
