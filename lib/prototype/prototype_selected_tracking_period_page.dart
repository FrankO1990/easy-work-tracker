import 'package:flutter/material.dart';
import 'package:franks_invoice_tool/main.dart';

class PrototypeSelectedTrackingPeriodPage extends StatefulWidget {
  final String titleText;
  const PrototypeSelectedTrackingPeriodPage({Key? key, required this.titleText})
      : super(key: key);

  @override
  State<PrototypeSelectedTrackingPeriodPage> createState() =>
      _PrototypeSelectedTrackingPeriodPageState();
}

class _PrototypeSelectedTrackingPeriodPageState
    extends State<PrototypeSelectedTrackingPeriodPage> {
  bool isDone = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titleText),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              onPressed: isDone
                  ? null
                  : () async {
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SimpleDialog(
                            backgroundColor: BACKGROUND_COLOR,
                            title: const Text(
                              'Finish tracking period?',
                              style: TextStyle(color: ACCENT_COLOR),
                            ),
                            children: [
                              SimpleDialogOption(
                                child: const Text(
                                  'Finish tracking period and generate invoice',
                                  style: TextStyle(color: MAIN_TEXT_COLOR),
                                ),
                                onPressed: () {
                                  setState(
                                    () {
                                      isDone = true;
                                    },
                                  );
                                  Navigator.pop(context);
                                },
                              ),
                              SimpleDialogOption(
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(color: MAIN_TEXT_COLOR),
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          );
                        },
                      );
                    },
              icon: const Icon(Icons.check))
        ],
      ),
      floatingActionButton: isDone
          ? null
          : FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 20, 30, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Total hours tracked',
                  style: TextStyle(color: ACCENT_COLOR, fontSize: 26),
                ),
                SizedBox(
                  width: 40,
                ),
                Text(
                  '333',
                  style: TextStyle(color: ACCENT_COLOR, fontSize: 26),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: isDone
                  ? const EdgeInsets.all(30.0)
                  : const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 100.0),
              child: SingleChildScrollView(
                child: Column(
                  children: const [
                    TrackedWorkRow(),
                    TrackedWorkRow(),
                    TrackedWorkRow(),
                    TrackedWorkRow(),
                    TrackedWorkRow(),
                    TrackedWorkRow(),
                    TrackedWorkRow(),
                    TrackedWorkRow(),
                    TrackedWorkRow(),
                    TrackedWorkRow(),
                    TrackedWorkRow(),
                    TrackedWorkRow(),
                    TrackedWorkRow(),
                    TrackedWorkRow(),
                    TrackedWorkRow(),
                    TrackedWorkRow(),
                    TrackedWorkRow(),
                    TrackedWorkRow(),
                    TrackedWorkRow(),
                    TrackedWorkRow(),
                    TrackedWorkRow(),
                    TrackedWorkRow(),
                    TrackedWorkRow(),
                    TrackedWorkRow(),
                    TrackedWorkRow(),
                    TrackedWorkRow(),
                    TrackedWorkRow(),
                    TrackedWorkRow(),
                    Text('Test'),
                    TrackedWorkRow(),
                    TrackedWorkRow(),
                    TrackedWorkRow(),
                    TrackedWorkRow(),
                    TrackedWorkRow(),
                    TrackedWorkRow(),
                    TrackedWorkRow(),
                    TrackedWorkRow(),
                    TrackedWorkRow(),
                    TrackedWorkRow(),
                    TrackedWorkRow(),
                    TrackedWorkRow(),
                    TrackedWorkRow(),
                    TrackedWorkRow(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TrackedWorkRow extends StatelessWidget {
  const TrackedWorkRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                Text(
                  'Programming Feature',
                  textAlign: TextAlign.start,
                  style: TextStyle(color: ACCENT_COLOR, fontSize: 12),
                ),
                Text(
                  'Tracked Work Item with some Text, might end up in multiple lines.',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
              child: Text(
            '3h',
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 22,
            ),
          )),
        ],
      ),
    );
  }
}
