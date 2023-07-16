import 'package:automata_simulator/domain/model/link.dart';

import '../model/node.dart';

class Canvas {
  final Map<String, Node> nodes;
  final Map<String, Link> links;
  final String name;

  Canvas({
    required this.nodes,
    required this.links,
    this.name = "Teste",
  });

  List<Node> get nodeList => nodes.values.toList();
  List<Link> get linkList => links.values.toList();

  factory Canvas.empty() => Canvas(nodes: {}, links: {});

  Map<String, dynamic> toJson() {
    final nodes = nodeList.map((node) => node.toJson()).toList();
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
      nodes: nodes,
      links: links,
      name: json['canvasName'],
    );
  }
}
