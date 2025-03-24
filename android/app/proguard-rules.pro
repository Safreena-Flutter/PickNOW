# Keep Razorpay classes
-keep class com.razorpay.** { *; }

# Keep Google Pay API classes
-keep class com.google.android.apps.nbu.paisa.** { *; }

# Keep ProGuard annotations
-keep @interface proguard.annotation.Keep
-keep @interface proguard.annotation.KeepClassMembers
-keep @interface proguard.annotation.KeepName
-keep @interface proguard.annotation.KeepPublicClassMembers

# Keep JSON-related classes
-keep class org.json.** { *; }

# Keep Kotlin metadata
-keep class kotlin.Metadata { *; }
-keep class kotlin.jvm.internal.** { *; }
