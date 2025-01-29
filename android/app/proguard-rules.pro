# Keep all TensorFlow Lite classes
-keep class org.tensorflow.** { *; }
-keepclassmembers class org.tensorflow.** { *; }

# Keep all GPU Delegate classes
-keep class org.tensorflow.lite.gpu.** { *; }
-keepclassmembers class org.tensorflow.lite.gpu.** { *; }
# Suppress warnings for missing classes
-dontwarn org.tensorflow.lite.gpu.GpuDelegateFactory$Options
-dontwarn org.tensorflow.lite.gpu.GpuDelegateFactory$Options$GpuBackend