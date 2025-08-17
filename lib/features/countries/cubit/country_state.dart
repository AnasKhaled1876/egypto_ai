part of 'country_cubit.dart';


abstract class CountryState extends Equatable {
  const CountryState();
  
  @override
  List<Object?> get props => [];
}

class CountryInitial extends CountryState {
  const CountryInitial();
}

class GetCountriesLoadingState extends CountryState {
  const GetCountriesLoadingState();
}

class GetCountriesLoadingMoreState extends CountryState {
  final List<CountryModel> countries;
  
  const GetCountriesLoadingMoreState(this.countries);
  
  @override
  List<Object?> get props => [countries];
}

class GetCountriesSuccessState extends CountryState {
  final List<CountryModel> countries;
  final bool hasReachedMax;
  final int currentPage;

  const GetCountriesSuccessState(
    this.countries, {
    this.hasReachedMax = false,
    this.currentPage = 1,
  });
  
  @override
  List<Object?> get props => [countries, hasReachedMax, currentPage];
  
  GetCountriesSuccessState copyWith({
    List<CountryModel>? countries,
    bool? hasReachedMax,
    int? currentPage,
  }) {
    return GetCountriesSuccessState(
      countries ?? this.countries,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

class GetCountriesErrorState extends CountryState {
  final String error;
  
  const GetCountriesErrorState(this.error);
  
  @override
  List<Object?> get props => [error];
}
