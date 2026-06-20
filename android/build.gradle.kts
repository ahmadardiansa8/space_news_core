// 1. TAMBAHKAN BLOK BUILDSCRIPT INI DI PALING ATAS
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        // Tambahkan classpath untuk google-services di sini
        classpath("com.google.gms:google-services:4.5.0")
    }
}

// Ini adalah kode bawaan kamu yang sudah ada (biarkan tetap seperti ini)
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}