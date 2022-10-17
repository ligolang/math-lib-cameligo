import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
    kotlin("jvm") version "1.7.20"
    id("org.jetbrains.kotlinx.benchmark") version "0.4.5"
}

group = "math"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
}

dependencies {
    testImplementation(kotlin("test"))
    implementation("org.jetbrains.kotlinx:kotlinx-benchmark-runtime:0.4.5")
    implementation("org.jetbrains.kotlinx:kotlinx-benchmark-runtime-jvm:0.4.5")
}

tasks.test {
    useJUnitPlatform()
}

tasks.withType<KotlinCompile> {
    kotlinOptions.jvmTarget = "1.8"
}

benchmark {
    configurations {
        named("main") {
            iterations = 5 // number of iterations
            iterationTime = 300
            iterationTimeUnit = "ns"
            warmups = 10
            advanced("jvmForks", 3)
        }
    }
    targets {
        register("test")
    }
}