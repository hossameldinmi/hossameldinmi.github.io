import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class CalendlyWidget extends StatefulWidget {
  final String id;
  const CalendlyWidget({super.key, required this.id});

  @override
  State<CalendlyWidget> createState() => _CalendlyWidgetState();
}

class _CalendlyWidgetState extends State<CalendlyWidget> {
  late InAppWebViewController _controller;
  late bool _isDark;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _isDark = false;
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final currentTheme = Theme.of(context).brightness == Brightness.dark;
    if (currentTheme != _isDark) {
      setState(() {
        _isDark = currentTheme;
        _isLoading = true;
      });
      await _loadCalendlyUrl();
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadCalendlyUrl() async {
    if (_isLoading) return;
    // Calendly URL with theme customization
    if (!mounted) return;

    final baseUrl = 'https://calendly.com/${widget.id}';
    final backgroundColor = _isDark ? '0a192f' : 'ffffff';
    final textColor = _isDark ? 'ccd6f6' : '0f172a';
    final primaryColor = _isDark ? '64ffda' : '0ea5e9';

    final themedUrl = '$baseUrl?'
        'background_color=$backgroundColor&'
        'text_color=$textColor&'
        'primary_color=$primaryColor&'
        'hide_event_type_details=0&'
        'hide_gdpr_banner=1';

    await _controller.loadUrl(urlRequest: URLRequest(url: WebUri(themedUrl)));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      constraints: const BoxConstraints(maxHeight: 700),
      width: double.infinity,
      child: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(
              url: WebUri('https://calendly.com/${widget.id}'),
            ),
            initialSettings: InAppWebViewSettings(
              verticalScrollBarEnabled: false,
              disableVerticalScroll: true,
              overScrollMode: OverScrollMode.IF_CONTENT_SCROLLS,
            ),
            onWebViewCreated: (controller) {
              _controller = controller;
              _loadCalendlyUrl();
            },
            onLoadStop: (controller, url) async {
              // Inject CSS to disable scrolling
              await controller.evaluateJavascript(source: '''
                var style = document.createElement('style');
                style.innerHTML = 'body, html { overflow: hidden !important; height: 100% !important; }';
                document.head.appendChild(style);
              ''');
              setState(() {
                _isLoading = false;
              });
            },
          ),
          if (_isLoading)
            Container(
              color: theme.cardColor,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Loading calendar...',
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        color: theme.textTheme.bodyMedium?.color,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
}
