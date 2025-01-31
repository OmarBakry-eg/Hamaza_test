import 'dart:developer' as developer;

sealed class Logger{

// Blue text
static void logInfo(String msg) {
  developer.log('\x1B[34m$msg\x1B[0m',name: '\x1B[34minfo\x1B[0m');
}

// Green text
static void logSuccess(String msg) {
  developer.log('\x1B[32m$msg\x1B[0m');
}

// Yellow text
static void logWarning(String msg) {
  developer.log('\x1B[33m$msg\x1B[0m');
}

// Red text
static void logError(String msg) {
  developer.log('\x1B[31m$msg\x1B[0m');
}

static void logNormal(String msg) {
  developer.log(msg);
}
// Black:   \x1B[30m
// Red:     \x1B[31m
// Green:   \x1B[32m
// Yellow:  \x1B[33m
// Blue:    \x1B[34m
// Magenta: \x1B[35m
// Cyan:    \x1B[36m
// White:   \x1B[37m
// Reset:   \x1B[0m
}
