class UserSession {
  // Static variable agar bisa diakses dari mana saja tanpa context
  static int userId = 0;
  static String username = "";

  // Fungsi untuk reset saat logout
  static void clearSession() {
    userId = 0;
    username = "";
  }
}