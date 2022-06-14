// ignore_for_file: camel_case_types

import '../test_imports.dart';

class RT_StatelessWidget extends StatelessWidget {
  final VoidCallback? eventConstruct;

  final VoidCallback? eventBuild;
  final Function(BuildContext context)? hookBuild;

  final List<Widget> children;

  final String hash;

  RT_StatelessWidget({
    Key? key,
    this.eventConstruct,
    this.eventBuild,
    this.hookBuild,
    this.children = const [],
    String? customHash,
  })  : hash = customHash ?? 'none',
        super(key: key) {
    if (null != eventConstruct) {
      eventConstruct!();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (null != eventBuild) {
      eventBuild!();
    }

    if (null != hookBuild) {
      hookBuild!(context);
    }

    return RT_TestWidget(children: children);
  }
}

class RT_AnotherStatelessWidget extends RT_StatelessWidget {
  RT_AnotherStatelessWidget({
    Key? key,
    VoidCallback? eventConstruct,
    VoidCallback? eventBuild,
    Function(BuildContext context)? hookBuild,
    List<Widget> children = const [],
    String? customHash,
  }) : super(
          key: key,
          eventConstruct: eventConstruct,
          eventBuild: eventBuild,
          hookBuild: hookBuild,
          children: children,
          customHash: customHash,
        );
}
