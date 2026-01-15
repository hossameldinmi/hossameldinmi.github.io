import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class CalendlyWidget extends StatefulWidget {
  final String url;
  const CalendlyWidget({super.key, required this.url});

  @override
  State<CalendlyWidget> createState() => _CalendlyWidgetState();
}

class _CalendlyWidgetState extends State<CalendlyWidget> {
  InAppWebViewController? _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Reload when theme changes
    if (_controller != null) {
      _loadCalendlyUrl();
    }
  }

  Future<void> _loadCalendlyUrl() async {
    if (_controller == null || !mounted) return;

    // Calendly URL with theme customization
    final isDark = Theme.brightnessOf(context) == Brightness.dark;

    final baseUrl = widget.url;
    final backgroundColor = isDark ? '0a192f' : 'ffffff';
    final textColor = isDark ? 'ccd6f6' : '0f172a';
    final primaryColor = isDark ? '64ffda' : '0ea5e9';

    final themedUrl = '$baseUrl?'
        'background_color=$backgroundColor&'
        'text_color=$textColor&'
        'primary_color=$primaryColor&'
        'hide_event_type_details=0&'
        'hide_gdpr_banner=1';

    await _controller!.loadUrl(urlRequest: URLRequest(url: WebUri(themedUrl)));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final baseUrl = widget.url;
    final backgroundColor = isDark ? '0a192f' : 'ffffff';
    final textColor = isDark ? 'ccd6f6' : '0f172a';
    final primaryColor = isDark ? '64ffda' : '0ea5e9';

    final themedUrl = '$baseUrl?'
        'background_color=$backgroundColor&'
        'text_color=$textColor&'
        'primary_color=$primaryColor&'
        'hide_event_type_details=0&'
        'hide_gdpr_banner=1';

    return Container(
      constraints: const BoxConstraints(maxHeight: 700),
      width: double.infinity,
      child: Stack(
        children: [
          InAppWebView(
            key: ValueKey(isDark), // Force rebuild when theme changes
            initialUrlRequest: URLRequest(
              url: WebUri(themedUrl),
            ),
            initialSettings: InAppWebViewSettings(
              verticalScrollBarEnabled: false,
              disableVerticalScroll: true,
              overScrollMode: OverScrollMode.NEVER,
              supportZoom: false,
              disableHorizontalScroll: true,
              useHybridComposition: true,
              transparentBackground: false,
            ),
            gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
            onWebViewCreated: (controller) {
              _controller = controller;
            },
            onLoadStop: (controller, url) async {
              // Inject CSS to disable scrolling and prevent touch event blocking
              await controller.evaluateJavascript(source: '''
                var style = document.createElement('style');
                style.innerHTML = 'body, html { overflow: hidden !important; height: 100% !important; touch-action: pan-y !important; }';
                document.head.appendChild(style);
                
                // Allow parent scroll on touch
                document.addEventListener('touchmove', function(e) {
                  if (e.target.tagName !== 'INPUT' && e.target.tagName !== 'TEXTAREA' && e.target.tagName !== 'SELECT') {
                    e.stopPropagation();
                  }
                }, { passive: true });
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
