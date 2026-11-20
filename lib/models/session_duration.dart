/// Screen Time schedules cannot be shorter than 15 minutes.
const minSessionMinutes = 15;

const maxSessionMinutes = 180;

const sessionPresets = <int>[15, 25, 45, 60, 90];

int clampSessionMinutes(int minutes) {
  if (minutes < minSessionMinutes) return minSessionMinutes;
  if (minutes > maxSessionMinutes) return maxSessionMinutes;
  return minutes;
}
