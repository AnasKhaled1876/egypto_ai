extension StringExtensions on String {
  /// Converts the string to title case (first letter of each word capitalized)
  /// Example: "hello world" -> "Hello World"
  String toTitleCase() {
    if (isEmpty) return this;
    
    return toLowerCase()
        .split(' ')
        .map((word) => word.isNotEmpty 
            ? '${word[0].toUpperCase()}${word.substring(1)}' 
            : '')
        .join(' ');
  }
}