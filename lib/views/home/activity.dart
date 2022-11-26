import 'package:flutter/material.dart';

class ActivityClass extends StatelessWidget {
  final List activityData;

  const ActivityClass({super.key, required this.activityData});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return activityData.isEmpty
        ? const Text('')
        :  SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
              child: Flex(direction: Axis.horizontal, children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Image.network(
                  activityData[0]['img'],
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Flex(
                      direction: Axis.vertical,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Image.network(activityData[1]['img']),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Image.network(activityData[2]['img']),
                        ),
                      ],
                    ))
              ]),
            ));
  }
}
