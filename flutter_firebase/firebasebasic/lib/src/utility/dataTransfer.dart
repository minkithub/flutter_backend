getMonthToNumber({String month}) {
  switch (month) {
    case 'Jan':
      return '01';
      break;
    case 'Feb':
      return '02';
      break;
    case 'Mar':
      return '03';
      break;
    case 'Apr':
      return '04';
      break;
    case 'May':
      return '05';
      break;
    case 'Jun':
      return '06';
      break;
    case 'Jul':
      return '07';
      break;
    case 'Aug':
      return '08';
      break;
    case 'Sept':
      return '09';
      break;
    case 'Oct':
      return '10';
      break;
    case 'Nov':
      return '11';
      break;
    case 'Dec':
      return '12';
      break;
    default:
  }
}

isPlusZero({String day}) {
  if (day.length == 1) {
    return '0' + day;
  } else {
    return day;
  }
}
