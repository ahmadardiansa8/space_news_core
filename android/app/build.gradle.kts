plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    
    // Cukup tulis satu kali di sini:
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.spacenews_core"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // Ini adalah applicationId kamu untuk dimasukkan ke Firebase: com.example.spacenews_core
        applicationId = "com.example.spacenews_core"
        
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

// === TAMBAHKAN BLOK DEPENDENCIES INI DI PALING BAWAH ===
dependencies {
    // Import the Firebase BoM
    implementation(platform("com.google.firebase:firebase-bom:34.15.0"))
    
    // Tambahkan library Firebase Analytics
    implementation("com.google.firebase:firebase-analytics")
}