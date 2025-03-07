import 'package:example/editor/converter.dart';
import 'package:example/editor/edge_label.dart';
import 'package:example/editor/editor_node.dart';
import 'package:example/editor/file_manager.dart';
import 'package:example/editor/update_node_dialog.dart';
import 'package:flutter/material.dart';
import 'package:graphite/graphite.dart';

import 'dialogue_editor_node.dart';

class Editor extends StatefulWidget {
  const Editor({super.key});

  @override
  EditorState createState() => EditorState();
}

class EditorState extends State<Editor> {
  final Map<String, DialogueEditorNode> nodes = {};

  Future<void> showUpdateDialog({DialogueEditorNode? initialNode}) async {
    final DialogueEditorNode? nodeToUpdate = await showDialog(
        context: context,
        builder: (context) => UpdateNodeDialog(
              initialNode: initialNode,
              currentNodes: nodes,
            ));
    if (initialNode == null && nodeToUpdate != null) addNode(nodeToUpdate);
  }

  void addNode(DialogueEditorNode nodeToUpdate) {
    setState(() {
      nodes[nodeToUpdate.id] = nodeToUpdate;
      if (nodeToUpdate.parentNode != null) {
        nodes.update(nodeToUpdate.parentNode!.id,
            (node) => node..next.add(EdgeInput(outcome: nodeToUpdate.id)));
      }
    });
  }

  Future<Map<String, dynamic>> assembleDialogueConfig() async {
    return {};
  }

  Future<String> getFileName() async {
    return 'test';
  }

  Future<void> saveFile() async {
    FileManager.saveJson(Converter(nodes: nodes).configFromNodes().toJson(),
        await getFileName());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Dialogue editor'),
        actions: [
          InkWell(
            onTap: saveFile,
            child: Icon(Icons.save),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: showUpdateDialog, child: const Icon(Icons.add)),
      body: nodes.isNotEmpty
          ? InteractiveViewer(
              constrained: false,
              child: DirectGraph(
                onNodeTapDown: (_, node, __) {},
                list: nodes.values.toList(),
                defaultCellSize: const Size(100.0, 100.0),
                cellPadding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                contactEdgesDistance: 10.0,
                orientation: MatrixOrientation.Horizontal,
                nodeBuilder: (context, node) =>
                    EditorNode(node: nodes[node.id]!),
                styleBuilder: (_) => EdgeStyle(
                    linePaint: Paint()
                      ..color = Color(0xFFFFFFFF)
                      ..style = PaintingStyle.stroke
                      ..strokeCap = StrokeCap.round
                      ..strokeJoin = StrokeJoin.round
                      ..strokeWidth = 2),
                edgeLabels: EdgeLabels(
                    alignment: EdgeLabelTextAlignment.before,
                    positionPriority: EdgeLabelPositionPriority.horizontal,
                    builder: (_, edge, __) {
                      if ((nodes[edge.to.id] as DialogueEditorNode)
                              .stateCondition !=
                          null) {
                        return EditorEdgeLabel(
                            condition: nodes[edge.to.id]!.stateCondition!);
                      }
                      return SizedBox();
                    }),
              ),
            )
          : Text('Add first node'),
    );
  }
}
