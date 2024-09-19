import 'package:bsudoku/utils/game_colors.dart';
import 'package:bsudoku/utils/game_text_styles.dart';
import 'package:bsudoku/utils/gmae_sizes.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyScreen extends StatefulWidget {
    const PrivacyPolicyScreen({super.key});

    @override
    State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
    late WebViewController _controller;
    int progress = 0;

    @override
    void initState() {
        super.initState();
        _controller = WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted)..setBackgroundColor(const Color(0x00000000))
            ..setNavigationDelegate(NavigationDelegate(onProgress: (int progress) { setState(() { this.progress = progress; }); },
                onWebResourceError: (error) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${error.description}', style: const TextStyle(color: Colors.white)), backgroundColor: Colors.red,)),
                onNavigationRequest: (request) {
                    if (request.url.startsWith('https://www.youtube.com/')) {
                        return NavigationDecision.prevent;
                    }
                    return NavigationDecision.navigate;
            }))..loadRequest(Uri.parse('https://www.freeprivacypolicy.com/live/2c1fd13f-4643-472f-8c12-2ad368d88a4f'));
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(elevation: 0.5, centerTitle: true, backgroundColor: GameColors.appBarBackground,
                title: Text('Privacy Policy', style: GameTextStyles.optionsScreenAppBarTitle.copyWith(fontSize: GameSizes.getWidth(0.045))),
                leading: const BackButton(),
            ),
            body: Visibility(visible: progress >= 100,  replacement: LinearProgressIndicator(value: progress * 1.0), child: WebViewWidget(controller: _controller)),
    );
  }
}
