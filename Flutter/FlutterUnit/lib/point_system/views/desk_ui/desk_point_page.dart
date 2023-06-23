import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/point_system/github_model/github_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/plateform_adapter/window/windows_adapter.dart';
import '../../../widget_ui/desk_ui/widget_panel/window_buttons.dart';
import '../../blocs/point_bloc/point_bloc.dart';
import '../../blocs/point_bloc/point_event.dart';
import '../../github_model/repository.dart';
import '../../views/issues_point/issues_point_page.dart';
import 'github_repo_panel.dart';

class DeskPointPage extends StatefulWidget {
  const DeskPointPage({Key? key}) : super(key: key);

  @override
  State<DeskPointPage> createState() => _DeskPointPageState();
}

class _DeskPointPageState extends State<DeskPointPage> {

  final Repository _repository = Repository.fromJson({
    'full_name': 'toly1994328/FlutterUnit',
    'license': {"spdx_id": 'GPL-3.0'},
    'description':
        '【Flutter 集录指南 App】The unity of flutter, The unity of coder.',
    'stargazers_count': 5840,
    'forks_count': 956,
    'subscribers_count': 126,
    'open_issues_count': 40,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PointBloc()..add(EventLoadPoint()),
      child: Scaffold(
        body: Column(
          children: [
            SimpleDeskTopBar(
              leading: Text(
                'Flutter  要点集录',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(height: 1),
            Expanded(
                child: Row(
              children: [
                Column(
                  children: [
                    GithubRepoPanel(
                      repository: _repository,
                    ),
                    Expanded(
                        child: SizedBox(
                            width: 250,
                            child: IssuesTip())
                        )
                  ],
                ),
                VerticalDivider(width: 1,),
                Expanded(flex: 2, child: IssuesPointContent()),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

class IssuesTip extends StatelessWidget {
  const IssuesTip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text.rich(
        TextSpan(children: [
          TextSpan(
              text: '* 注： ',
              style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold)),
          TextSpan(
              text:
              '要点集录中的 QA 数据收录在 FlutterUnit 以 point 为标签的 issues 中。如果需要提供数据，在 issues 中问答即可。'),
          TextSpan(
              text: '点击这里跳转',
              mouseCursor: SystemMouseCursors.click,
              recognizer: TapGestureRecognizer()
                ..onTap = _toUrl,
              style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold)),
        ]),
        style: TextStyle(fontSize: 14),
      ),
    );
  }

  void _toUrl() async{
    String url = 'https://github.com/toly1994328/FlutterUnit/issues?q=label%3Apoint+';
    if (!await launchUrl(Uri.parse(url))) {
       throw Exception('Could not launch $url');
    }
  }
}


class SimpleDeskTopBar extends StatelessWidget {
  final Widget? leading;

  const SimpleDeskTopBar({super.key, this.leading});

  @override
  Widget build(BuildContext context) {
    return DragToMoveAreaNoDouble(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 64,
        color: Colors.white,
        child: Row(
          children: [
            if (leading != null) leading!,
            const Spacer(),
            const SizedBox(
              width: 20,
            ),
            const WindowButtons(),
          ],
        ),
      ),
    );
  }
}
