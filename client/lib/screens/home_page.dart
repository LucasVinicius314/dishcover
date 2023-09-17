import 'package:desktop_drop/desktop_drop.dart';
import 'package:dishcover_client/widgets/base_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const route = '/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _isDragging = false;

  Widget _getContent() {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: DropTarget(
        onDragDone: (detail) {
          final file = detail.files[0];
        },
        onDragEntered: (detail) {
          setState(() {
            _isDragging = true;
          });
        },
        onDragExited: (detail) {
          setState(() {
            _isDragging = false;
          });
        },
        child: IntrinsicHeight(
          child: Stack(
            fit: StackFit.expand,
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 200),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.photo),
                        const SizedBox(height: 16),
                        const Text(
                          'Arraste e solte sua foto aqui',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'ou',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        OutlinedButton.icon(
                          icon: const Icon(Icons.camera_alt_rounded),
                          onPressed: () {
                            // TODO: fix
                          },
                          label: const Text(
                            'Escolha uma foto',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              IgnorePointer(
                ignoring: !_isDragging,
                child: AnimatedOpacity(
                  opacity: _isDragging ? 1 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    color: Colors.black12,
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Center(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Icon(
                              Icons.check,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getHeader(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.bodyMedium,
            children: const [
              TextSpan(
                text: 'Olá! Este é o Dishcover. ',
              ),
              TextSpan(
                  text: 'Envie fotos do(s) seu(s) alimentos',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(
                text: ' e faremos ',
              ),
              TextSpan(
                  text: 'recomendações de receitas',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(
                text: '.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _getHeader(context),
          const SizedBox(height: 16),
          _getContent(),
        ],
      ),
    );
  }
}
