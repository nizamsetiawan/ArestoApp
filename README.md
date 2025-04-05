# ARestro - Restaurant Discovery App

![App Logo](https://res.cloudinary.com/dsqajzles/image/upload/v1743866153/github/skaksizsweikmkfswadw.png) 

ARestro adalah aplikasi pencarian restoran yang memungkinkan pengguna menemukan, mengeksplorasi, dan menyimpan restoran favorit mereka. Aplikasi ini dibangun dengan Flutter dan mengikuti arsitektur yang terstruktur dengan baik.

## Fitur Utama

- 🏠 Daftar restoran populer
- 🔍 Pencarian restoran
- 📌 Menandai restoran favorit
- 🌙 Dukungan tema gelap dan terang
- 🔔 Notifikasi terjadwal
- 📱 Tampilan responsif

## Arsitektur Aplikasi

```
lib/
├── core/
│   ├── constants/
│   ├── enums/
│   ├── network/
│   ├── notification/
│   ├── styles/
│   └── theme/
├── features/
│   ├── favorite/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── restaurant/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── setting/
│       └── presentation/
└── injection_container.dart
```

## Teknologi yang Digunakan

- **Flutter** - Framework UI
- **Provider** - State management
- **Dio** - HTTP client
- **Shared Preferences** - Penyimpanan lokal
- **Flutter Local Notifications** - Notifikasi lokal
- **Timezone** - Penanganan zona waktu

## Cara Menjalankan

### Prasyarat

- Flutter SDK (versi terbaru)
- Dart SDK (versi terbaru)
- Perangkat atau emulator

### Langkah-langkah

1. Clone repositori:
   ```bash
   git clone https://github.com/nizamstwn/arestro.git
   cd arestro
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Jalankan aplikasi:
   ```bash
   flutter run
   ```

## Konfigurasi

### Android

Pastikan konfigurasi berikut ada di `android/app/build.gradle`:

```gradle
android {
    compileOptions {
        coreLibraryDesugaringEnabled true
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }
    defaultConfig {
        multiDexEnabled true
    }
}

dependencies {
    coreLibraryDesugaring 'com.android.tools:desugar_jdk_libs:2.0.3'
    implementation 'androidx.multidex:multidex:2.0.1'
}
```

### iOS

Untuk notifikasi terjadwal, tambahkan konfigurasi berikut di `ios/Runner/AppDelegate.swift`:

```swift
if #available(iOS 10.0, *) {
  UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
}
```

## State Management

Aplikasi menggunakan `Provider` untuk manajemen state dengan struktur berikut:

- **FavoriteProvider**: Menangani logika favorit restoran
- **RestaurantListProvider**: Menangani daftar restoran
- **RestaurantDetailProvider**: Menangani detail restoran
- **ThemeProvider**: Menangani tema aplikasi
- **ReminderProvider**: Menangani pengaturan notifikasi

## Komponen Kustom

### FavoriteButton

Komponen untuk menandai restoran favorit:

```dart
FavoriteButton(
  restaurant: restaurant,
)
```

Menggunakan `FavoriteProvider` untuk mengelola state dan menampilkan:
- Ikon hati penuh untuk restoran favorit
- Ikon hati kosong untuk restoran non-favorit
- Indikator loading saat proses toggle

## Testing

Aplikasi dilengkapi dengan unit test dan widget test. Untuk menjalankan test:

```bash
flutter test
```

