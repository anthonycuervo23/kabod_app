enum WodTypeOptions { time, weight, amrap, custom }

String wodTypeOptionsToString(WodTypeOptions value) {
  switch (value) {
    case WodTypeOptions.time:
      return 'Por Tiempo';
    case WodTypeOptions.amrap:
      return 'AMRAP';
    case WodTypeOptions.weight:
      return 'Por Peso';
    case WodTypeOptions.custom:
    default:
      return 'Custom';
  }
}

WodTypeOptions enumFromString(String s) {
  switch (s) {
    case 'Por Tiempo':
      return WodTypeOptions.time;
    case 'AMRAP':
      return WodTypeOptions.amrap;
    case 'Por Peso':
      return WodTypeOptions.weight;
    case 'Custom':
      return WodTypeOptions.custom;
    default:
      return WodTypeOptions.time;
  }
}
