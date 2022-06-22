String jsonEscape(str) {
  return str.replace('\n', "\\n").replace('\r', "\\r").replace('\t', "\\\\t");
}
