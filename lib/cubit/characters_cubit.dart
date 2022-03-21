import 'package:bloc/bloc.dart';
import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:valorant_app_test/repository/characters_repository.dart';

import '../models/character_model.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  CharactersCubit(this._charactersRepository)
      : super(const CharactersInitial());

  final CharactersRepository _charactersRepository;

  Future<void> getCharacters() async {
    try {
      emit(const CharactersLoading());
      final listAllOfCharacters = await requestCharacters();

      emit(CharactersLoaded(listCharacters: listAllOfCharacters));
    } catch (e) {
      emit(const CharactersError(message: 'Error'));
    }
  }

  Future<List<CharacterModel>> requestCharacters() async {
    try {
      final response = await _charactersRepository.getListCharacters();
      if (response == null) {
        return [];
      }
      final listOfCharacters = json.decode(response.body);
      final owo = listOfCharacters['data'] as List<dynamic>;
      final list = owo
          .map((dynamic e) {
            //Role
            final roles = e['role'] ?? {};
            final roleInfo = RoleModel(
                displayName: roles['displayName'] ?? '',
                description: roles['description'] ?? '',
                displayIcon: roles['displayIcon'] ?? '',
                id: roles['uuid'] ?? '');

            //Abilities
            final abilities = e['abilities'] as List<dynamic>;
            final abilitiesInfo = abilities
                .map((dynamic a) => AbilityModel(
                      slot: a['slot'] ?? '',
                      displayName: a['displayName'] ?? '',
                      description: a['description'] ?? '',
                      displayIcon: a['displayIcon'] ?? '',
                    ))
                .toList();
            abilitiesInfo.retainWhere((x) => x.displayIcon.isNotEmpty);

            //VoiceLine
            final voiceLine = e['voiceLine'] ?? {};
            final voiceMediaList = voiceLine['mediaList'] as List;
            final voiceMedia =
                VoiceLineModel(voiceLine: voiceMediaList[0]['wave']);

            return CharacterModel(
              displayName: e['displayName'] ?? '',
              description: e['description'] ?? '',
              background: e['background'] ?? '',
              fullPortrait: e['fullPortrait'] ?? '',
              role: roleInfo,
              abilitie: abilitiesInfo,
              voiceLine: voiceMedia,
            );
          })
          .toSet()
          .toList();

      list.retainWhere((x) => x.fullPortrait.isNotEmpty);
      // final ids = Set();
      // list.retainWhere((x) => ids.add(x.displayName));
      return list;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
