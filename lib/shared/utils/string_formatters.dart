/// Formats a bot message to be readable in a text field.
///
/// * Replaces newline characters with two spaces and a newline.
/// * Adds a newline before any lines that start with one or more '#' characters.
/// * Adds a newline before any lines that start with a '*', '-', or digit followed by a period and a space.
/// * Removes any lines that consist only of asterisks or hyphens.
/// * Removes any trailing asterisks or hyphens from lines.
/// * Wraps any lines that start with "**" or "__" in double asterisks.
String formatBotMessage(String message) {
  return message.replaceAllMapped(
    RegExp(r'###\s*\*\*(.*?)\*\*'),
    (match) => '### **${match.group(1)}** ', // Add space after header
  );
  // .replaceAll('###', '\n####');
  // .replaceAllMapped(
  //   RegExp(r'(#+\s*)([^*\n]+)'),
  //   (m) => '\n**${m.group(1)}${m.group(2)?.trim()}**',
  // )
  // .replaceAllMapped(RegExp(r'(\n)?([-] |\d+\. )'), (m) => '\n${m.group(2)}')
  // .replaceAll(RegExp(r'^\*+\s*', multiLine: true), '')
  // .replaceAll(RegExp(r'[-*]\s*(?=\n)'), '');
}
