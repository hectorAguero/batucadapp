@JS()
library safe_area;

import 'dart:js_interop';

//https://github.com/flutter/flutter/issues/84833#issuecomment-1679737846
@JS('bottomInset')
external double bottomInset();

@JS('topInset')
external double topInset();

@JS('rightInset')
external double rightInset();

@JS('leftInset')
external double leftInset();
