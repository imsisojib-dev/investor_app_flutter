class WidgetHelper {
  static String formatAmount(double amount) {
    if (amount >= 100000) {
      return amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,2})(?=(\d{2})+(?!\d))'), (m) => '${m[1]},');
    }
    return amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},');
  }
}