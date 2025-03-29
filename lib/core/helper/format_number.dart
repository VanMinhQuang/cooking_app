class Formatter{
  static String formatTotalLike(int? totalLike){
    if (totalLike == null) return '0';
    if (totalLike >= 1000 && totalLike < 1000000) {
      return '${(totalLike / 1000).toStringAsFixed(totalLike % 1000 == 0 ? 0 : 1)}k';
    }
    if(totalLike >= 1000000 && totalLike < 1000000000){
      return '${(totalLike / 1000000).toStringAsFixed(totalLike % 1000000 == 0 ? 0 : 1)}m';
    }
    if(totalLike >= 1000000000){
      return '${(totalLike / 1000000000).toStringAsFixed(totalLike % 1000000000 == 0 ? 0 : 1)}b';
    }
    return totalLike.toString();
  }

  static String formatTime(int? minutes) {
    if(minutes == null) return "0";
    if (minutes < 0) return "0"; // Handle negative input

    int hours = minutes ~/ 60;
    int remainingMinutes = minutes % 60;

    if (hours > 0 && remainingMinutes > 0) {
      return "$hours h $remainingMinutes'";
    } else if (hours > 0) {
      return "$hours h";
    } else {
      return "$remainingMinutes'";
    }
  }
}