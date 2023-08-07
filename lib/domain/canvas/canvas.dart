import 'package:automata_simulator/domain/collections/node_list.dart';
import 'package:automata_simulator/domain/model/link.dart';

import '../model/node.dart';

class Canvas {
  final NodeList nodes;
  final Map<String, Link> links;
  final String name;

  Canvas({
    required this.nodes,
    required this.links,
    this.name = "Teste",
  });

  List<Link> get linkList => links.values.toList();

  factory Canvas.empty() => Canvas(nodes: NodeList.empty, links: {});

  Map<String, dynamic> toJson() {
    final nodes = this.nodes.map((node) => node.toJson()).toList();
    final links = linkList.map((link) => link.toJson()).toList();

    return {
      'canvasName': name,
      'nodes': nodes,
      'links': links,
    };
  }

  factory Canvas.fromJson(Map<String, dynamic> json) {
    final nodes = <String, Node>{};
    final links = <String, Link>{};

    for (final node in json['nodes']) {
      nodes[node['label']] = Node.fromJson(node);
    }

    for (final link in json['links']) {
      final id = link['from'] + ' -> ' + link['to'];
      links[id] = Link.fromJson(link, nodes);
    }

    return Canvas(
      nodes: NodeList(nodes),
      links: links,
      name: json['canvasName'],
    );
  }
}
