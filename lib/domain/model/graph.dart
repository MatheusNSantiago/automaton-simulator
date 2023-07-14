// import 'package:automata_simulator/domain/model/link.dart';
// import 'package:collection/collection.dart';
// import 'package:directed_graph/directed_graph.dart';
// export 'package:directed_graph/directed_graph.dart';
//
// import 'node.dart';
//
// class Graph {
//   const Graph(this.nodes, this.links);
//
//   final List<Node> nodes;
//   final List<Link> links;
// }

// extension GraphUtils on Graph {
//   Node? getNodeById(String id) {
//     return nodes.firstWhereOrNull((node) => node.key.toString() == id);
//   }
//
//   List<Node> getEdgesByNode(Node node) {
//     return links
//         .where((edge) {
//           return edge.from.toString() == node.key.toString() ||
//               edge.to.toString() == node.key.toString();
//         })
//         .map((edge) {
//           final from = getNodeById(edge.from.toString());
//           final to = getNodeById(edge.to.toString());
//           return [from, to];
//         })
//         .expand((element) => element)
//         .whereNotNull()
//         .toList();
//   }
//
//   int comparator(Node s1, Node s2) {
//     return s1.key.toString().compareTo(s2.key.toString());
//   }
//
//   int inverseComparator(Node s1, Node s2) {
//     return -comparator(s1, s2);
//   }
//
//   DirectedGraph<Node> getDirectedGraph({bool reverse = false}) {
//     final graph = DirectedGraph<Node>(
//       {
//         for (final node in nodes) node: getEdgesByNode(node).toSet(),
//       },
//     );
//     if (reverse) {
//       graph.comparator = inverseComparator;
//     } else {
//       graph.comparator = comparator;
//     }
//     return graph;
//   }
// }
