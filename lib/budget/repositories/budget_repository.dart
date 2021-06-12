import 'dart:convert';
import 'dart:io';

import 'package:budget_tracker/budget/models/failure_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:http/http.dart' as http;

import '../constants/constants.dart';
import '../models/models.dart';

class BudgetRepository {
  final http.Client _client;

  BudgetRepository({http.Client client}) : _client = client ?? http.Client();

  void dispose() {
    _client.close();
  }

  Future<List<BudgetItemModel>> getItems() async {
    try {
      final url =
          '${baseURL}databases/${DotEnv.env['NOTION_DATABASE_ID']}/query';
      final response = await _client.post(
        Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader:
              'Bearer ${DotEnv.env['NOTION_API_KEY']}',
          'Notion-Version': '2021-05-13',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return (data['results'] as List)
            .map((e) => BudgetItemModel.fromMap(e))
            .toList()
              ..sort((a, b) => b.date.compareTo(a.date));
      } else {
        throw const FailureModel(message: 'Something went wrong!');
      }
    } catch (e) {
      throw const FailureModel(message: 'Something went wrong!');
    }
  }
}
