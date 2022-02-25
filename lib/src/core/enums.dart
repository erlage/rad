enum DomTag {
  div,
  span,
}

enum MeasuringUnit {
  pixel,
  percent,
}

mapDomTag({required DomTag tag}) {
  switch (tag) {
    case DomTag.div:
      return "div";

    case DomTag.span:
    default:
      return "span";
  }
}

mapMeasuringUnit({required MeasuringUnit unit}) {
  switch (unit) {
    case MeasuringUnit.percent:
      return "%";

    case MeasuringUnit.pixel:
    default:
      return "px";
  }
}
