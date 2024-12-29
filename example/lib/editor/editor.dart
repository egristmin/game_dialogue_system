import 'package:example/editor/update_node_dialog.dart';
import 'package:flutter/material.dart';
import 'package:graphite/graphite.dart';

import 'dialogue_editor_node.dart';

const presetBasic = '['
    '{"id":"A","next":[{"outcome":"B","type":"one"}],"size":{"width": 75.0, "height": 75.0}},'
    '{"id":"B","size":{"width": 200.0, "height": 50.0},"next":[{"outcome":"D","type":"one"},{"outcome":"C","type":"one"},{"outcome":"K","type":"one"},{"outcome":"E","type":"one"}]},'
    '{"id":"C","next":[{"outcome":"F","type":"one"},{"outcome":"A","type":"one"}]},'
    '{"id":"D","next":[{"outcome":"J","type":"one"}],"size":{"width": 25.0, "height": 175.0}},'
    '{"id":"E","next":[{"outcome":"J","type":"one"}]},'
    '{"id":"J","size": {"width": 75.0, "height": 75.0},"next":[{"outcome":"I","type":"one"},{"outcome":"@","type":"one"}]},'
    '{"id":"I","next":[{"outcome":"H","type":"one"}]},'
    '{"id":"F","next":[{"outcome":"K","type":"one"}]},'
    '{"id":"K","size":{"width":50.0,"height":50.0},"next":[{"outcome":"L","type":"one"},{"outcome":"C","type":"one"},{"outcome":"X","type":"one"}]},'
    '{"id":"H","next":[{"outcome":"L","type":"one"}]},'
    '{"id":"L","next":[{"outcome":"I","type":"one"},{"outcome":"P","type":"one"}]},'
    '{"id":"P","next":[{"outcome":"M","type":"one"},{"outcome":"N","type":"one"}]},'
    '{"id":"M","next":[]},'
    '{"id":"X","next":[]},'
    '{"id":"N","next":[]},'
    '{"id":"@","next":[]}'
    ']';

class Editor extends StatefulWidget {
  const Editor({super.key});

  @override
  EditorState createState() => EditorState();
}

class EditorState extends State<Editor> {
  final List<DialogueEditorNode> nodes = [
    DialogueEditorNode(
        type: DialogueNodeType.answer, id: 'initialNode', next: []),
  ];
  bool _isVertical = false;
  bool _isCentered = true;

  Future<void> showUpdateDialog({DialogueEditorNode? initialNode}) async {
    final DialogueEditorNode? nodeToUpdate = await showDialog(
        context: context,
        builder: (context) => UpdateNodeDialog(
              initialNode: initialNode,
              currentNodes: nodes,
            ));
    if (initialNode == null && nodeToUpdate != null) {
      print('add node');
      setState(() {
        nodes.add(nodeToUpdate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: showUpdateDialog, child: const Icon(Icons.add)),
      body: Stack(
        children: [
          InteractiveViewer(
            constrained: false,
            child: DirectGraph(
              onNodeTapDown: (_, node, __) {},
              list: nodes,
              defaultCellSize: const Size(100.0, 100.0),
              cellPadding: _isVertical
                  ? const EdgeInsets.symmetric(vertical: 30, horizontal: 5)
                  : const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              contactEdgesDistance: 10.0,
              orientation: _isVertical
                  ? MatrixOrientation.Vertical
                  : MatrixOrientation.Horizontal,
              // edgeLabels: EdgeLabels(
              //     alignment: EdgeLabelTextAlignment.before,
              //     positionPriority: EdgeLabelPositionPriority.horizontal,
              //     builder: (context, edge, isVertical) => Padding(
              //           padding: const EdgeInsets.all(2),
              //           child: isVertical
              //               ? RotatedBox(
              //                   quarterTurns: -1,
              //                   child: Text(
              //                       style: Theme.of(context)
              //                           .textTheme
              //                           .bodyMedium!
              //                           .copyWith(
              //                               backgroundColor: Theme.of(context)
              //                                   .colorScheme
              //                                   .surface),
              //                       "${edge.from.id}=>${edge.to.id}"))
              //               : Text(
              //                   style: Theme.of(context)
              //                       .textTheme
              //                       .bodyMedium!
              //                       .copyWith(
              //                           backgroundColor: Theme.of(context)
              //                               .colorScheme
              //                               .surface),
              //                   "${edge.from.id}=>${edge.to.id}"),
              //         )),
              centered: _isCentered,
              minScale: .1,
              maxScale: 1,
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: Row(
              children: [
                const Icon(Icons.keyboard_arrow_right),
                Tooltip(
                  message: "Matrix alignment",
                  child: Switch(
                      value: _isVertical,
                      onChanged: (value) {
                        setState(() {
                          _isVertical = value;
                        });
                      }),
                ),
                const Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Row(
              children: [
                const Icon(Icons.format_align_left),
                Tooltip(
                  message: "Centered outcomes",
                  child: Switch(
                      value: _isCentered,
                      onChanged: (value) {
                        setState(() {
                          _isCentered = value;
                        });
                      }),
                ),
                const Icon(Icons.format_align_center),
              ],
            ),
          )
        ],
      ),
    );
  }
}
