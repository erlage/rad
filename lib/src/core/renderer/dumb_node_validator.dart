import 'dart:html';

/// A node validator that won't validate...
///
class DumbNodeValidator implements NodeValidator {
  const DumbNodeValidator();

  @override
  allowsElement(_) => true;

  @override
  allowsAttribute(_, __, ___) => true;
}
