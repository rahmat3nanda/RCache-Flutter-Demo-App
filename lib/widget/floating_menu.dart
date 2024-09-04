import 'package:flutter/material.dart';

class FloatingMenu extends StatefulWidget {
  final List<Widget> menu;
  final Widget child;

  const FloatingMenu({super.key, required this.menu, required this.child});

  @override
  State<FloatingMenu> createState() => _FloatingMenuState();
}

class _FloatingMenuState extends State<FloatingMenu> {
  late bool _isMenuOpen;
  late Duration _duration;

  @override
  void initState() {
    super.initState();
    _isMenuOpen = false;
    _duration = const Duration(milliseconds: 200);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: widget.child),
        IgnorePointer(
          ignoring: !_isMenuOpen,
          child: InkWell(
            onTap: () => setState(() {
              _isMenuOpen = false;
            }),
            child: AnimatedContainer(
              duration: _duration,
              color: _isMenuOpen
                  ? Colors.black.withOpacity(0.5)
                  : Colors.transparent,
            ),
          ),
        ),
        Positioned.fill(
          bottom: 16,
          right: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AnimatedOpacity(
                opacity: _isMenuOpen ? 1 : 0,
                duration: _duration,
                child: IgnorePointer(
                  child: ListView.separated(
                    shrinkWrap: true,
                    primary: false,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.menu.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (_, i) => Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        AbsorbPointer(
                          child: widget.menu[i],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              FloatingActionButton(
                onPressed: () => setState(() {
                  _isMenuOpen = !_isMenuOpen;
                }),
                child: AnimatedRotation(
                  turns: _isMenuOpen ? 0.25 : 0,
                  duration: _duration,
                  child: const Icon(Icons.menu),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
