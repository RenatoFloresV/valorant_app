import 'package:valorant_app_test/repository/index.dart';
import 'package:valorant_app_test/repository/characters_repository.dart';

final Services apiProvider = Services();

final CharactersRepository charactersRepository = CharactersRepository(apiProvider: apiProvider);
