import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HistorialPage extends StatelessWidget {
  Future<List<Map<String, dynamic>>> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final historyJson = prefs.getStringList('history') ?? [];

    List<Map<String, dynamic>> historyList = historyJson
        .map((item) => json.decode(item) as Map<String, dynamic>)
        .toList();

    return historyList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial de Resultados'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _loadHistory(),
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
                          Text('Puntaje: ${result['score']}'),
                          SizedBox(width: 8),
                          _buildStarRating(result['score'],
                              20), // Asumiendo un total de 20 puntos
                        ],
                      ),
                      subtitle: Text(_formatDateTime(result['dateTime'])),
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

  Map<String, List<Map<String, dynamic>>> _groupByTopic(
      List<Map<String, dynamic>> history) {
    Map<String, List<Map<String, dynamic>>> grouped = {};
    for (var item in history) {
      final topic = item['topic'] ?? 'Desconocido';
      if (!grouped.containsKey(topic)) {
        grouped[topic] = [];
      }
      grouped[topic]!.add(item);
    }
    return grouped;
  }

  Widget _buildStarRating(int score, int total) {
    int starCount = ((score / total) * 5)
        .round(); // Calcula cuántas estrellas (de 5) merece el puntaje
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
      case 'Programación 1':
        return Icon(Icons.code, color: Colors.green);
      case 'Programación 2':
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
