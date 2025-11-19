class UserSession {
  // Static variable agar bisa diakses dari mana saja tanpa context
  static String username = "";

  // Fungsi untuk reset saat logout
  static void clearSession() {
    username = "";
  }
}