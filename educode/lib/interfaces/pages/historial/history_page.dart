import 'package:educode/controllers/historial_controller.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class HistorialPage extends StatelessWidget {
  final HistorialController _historialController = HistorialController();

  Future<List<Map<String, dynamic>>> _loadHistory(User? currentUser) async {
    if (currentUser == null) return [];

    final historySnapshot = await _historialController.getHistorial(currentUser);
    return historySnapshot;
  }

  @override
  Widget build(BuildContext context) {
    final User? currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Historial de Resultados'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _loadHistory(currentUser),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error cargando datos'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay resultados disponibles'));
          } else {
            final history = snapshot.data!;
            final groupedHistory = _groupByTopic(history);
            return ListView(
              children: groupedHistory.entries.map((entry) {
                final topic = entry.key;
                final results = entry.value;
                return ExpansionTile(
                  leading: _getIconForTopic(topic),
                  title: Text(topic),
                  children: results.map((result) {
                    return ListTile(
                      title: Row(
                        children: [
                          Text('Puntaje: ${result['puntuacion']}'),
                          SizedBox(width: 8),
                          _buildStarRating(result['puntuacion'], 20), // Asumiendo un total de 20 puntos
                        ],
                      ),
                      subtitle: Text(_formatDateTime(result['inicio'])),
                    );
                  }).toList(),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }

  Map<String, List<Map<String, dynamic>>> _groupByTopic(List<Map<String, dynamic>> history) {
    Map<String, List<Map<String, dynamic>>> grouped = {};
    for (var item in history) {
      final topic = item['tema'] ?? 'Desconocido';
      if (!grouped.containsKey(topic)) {
        grouped[topic] = [];
      }
      grouped[topic]!.add(item);
    }
    return grouped;
  }

  Widget _buildStarRating(int score, int total) {
    int starCount = ((score / total) * 5).round();
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < starCount ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 20,
        );
      }),
    );
  }

  String _formatDateTime(String dateTime) {
    try {
      final date = DateTime.parse(dateTime);
      return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
    } catch (e) {
      return 'Fecha inválida';
    }
  }

  Icon _getIconForTopic(String topic) {
    switch (topic) {
      case 'Base de Datos':
        return Icon(Icons.storage, color: Colors.blue);
      case 'Programación':
        return Icon(Icons.computer, color: Colors.red);
      case 'Algoritmos':
        return Icon(Icons.functions, color: Colors.orange);
      case 'Lenguaje de Programación':
        return Icon(Icons.language, color: Colors.purple);
      case 'Programación Orientada a Objetos':
        return Icon(Icons.bubble_chart, color: Colors.teal);
      default:
        return Icon(Icons.help_outline, color: Colors.grey);
    }
  }
}
