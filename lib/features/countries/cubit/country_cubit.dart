import 'package:egypto/features/countries/data/models/get_countries_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/data_state.dart';
import '../data/models/country_model.dart';
import '../domain/repositories/country_repository.dart';

part 'country_state.dart';

class CountryCubit extends Cubit<CountryState> {
  CountryCubit(this._countryRepository) : super(const CountryInitial());

  static CountryCubit get(BuildContext context) => BlocProvider.of(context);

  final CountryRepository _countryRepository;

  List<CountryModel> countries = [];
  bool hasReachedMax = false;
  int currentPage = 1;
  static const int defaultPageSize = 15;

  Future<void> getCountries({
    int page = 1,
    int pageSize = defaultPageSize,
  }) async {
    try {
      if (page == 1) {
        emit(const GetCountriesLoadingState());
      } else {
        emit(GetCountriesLoadingMoreState(countries));
      }

      final result = await _countryRepository.getCountries(
        page: page,
        limit: pageSize,
      );

      if (result is DataSuccess<CountriesResponse>) {
        final newCountries = result.data?.countries ?? [];

        if (page == 1) {
          countries = newCountries;
        } else {
          countries.addAll(newCountries);
        }

        hasReachedMax = newCountries.length < pageSize;
        currentPage = page;

        emit(
          GetCountriesSuccessState(
            countries,
            hasReachedMax: hasReachedMax,
            currentPage: currentPage,
          ),
        );
      } else {
        emit(
          GetCountriesErrorState(
            result.error?.message ?? 'Failed to load countries',
          ),
        );
      }
    } catch (e) {
      emit(GetCountriesErrorState('An error occurred: $e'));
    }
  }

  Future<void> refreshCountries() async {
    return getCountries(page: 1);
  }
}
