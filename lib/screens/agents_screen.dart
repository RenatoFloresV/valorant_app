import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valorant_app_test/widgets/agents_list.dart';
import 'package:valorant_app_test/models/character_model.dart';

import '../cubit/characters_cubit.dart';

class AgentsScreen extends StatefulWidget {
  const AgentsScreen({Key? key}) : super(key: key);

  @override
  State<AgentsScreen> createState() => _AgentsScreenState();
}

class _AgentsScreenState extends State<AgentsScreen> {
  List<CharacterModel> characters = [];

  @override
  Widget build(BuildContext context) {
    return AgentsList(data: characters, count: 2);
  }

  @override
  void initState() {
    // context.read<CharactersCubit>().getCharacters();
    final cubiData = context.read<CharactersCubit>();
    if (cubiData.state is CharactersLoaded) {
      characters = (cubiData.state as CharactersLoaded).listCharacters;
      // print(characters);
    }
    super.initState();
  }
}
