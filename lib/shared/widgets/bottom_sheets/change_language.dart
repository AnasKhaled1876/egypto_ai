import 'package:egypto/features/countries/cubit/country_cubit.dart';
import 'package:egypto/features/countries/data/models/country_model.dart';
import 'package:egypto/shared/widgets/icons/icon_container.dart';
import 'package:egypto/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChangeLanguageBottomSheet extends StatefulWidget {
  const ChangeLanguageBottomSheet({super.key});

  @override
  State<ChangeLanguageBottomSheet> createState() =>
      _ChangeLanguageBottomSheetState();
}

class _ChangeLanguageBottomSheetState extends State<ChangeLanguageBottomSheet> {
  final ScrollController _scrollController = ScrollController();
  final List<CountryModel> _countries = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _currentPage = 1;
  static const int _pageSize = 15;

  @override
  void initState() {
    super.initState();
    if (context.read<CountryCubit>().countries.isEmpty) {
      _loadInitialData();
    } else {
      _countries.addAll(context.read<CountryCubit>().countries);
      _hasMore = context.read<CountryCubit>().hasReachedMax;
      _currentPage = context.read<CountryCubit>().currentPage;
    }
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoading &&
        _hasMore) {
      _loadMoreData();
    }
  }

  Future<void> _loadInitialData() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _currentPage = 1;
      _hasMore = true;
      _countries.clear();
    });

    final cubit = context.read<CountryCubit>();
    await cubit.getCountries(page: _currentPage, pageSize: _pageSize);

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadMoreData() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    final cubit = context.read<CountryCubit>();
    await cubit.getCountries(page: _currentPage + 1, pageSize: _pageSize);

    if (mounted) {
      setState(() {
        _isLoading = false;
        _currentPage++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CountryCubit, CountryState>(
      listener: (context, state) {
        if (state is GetCountriesErrorState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }

        if (state is GetCountriesSuccessState) {
          setState(() {
            if (state.currentPage == 1) {
              _countries.clear();
              _countries.addAll(state.countries);
            } else {
              _countries.addAll(state.countries);
            }
            _hasMore = !state.hasReachedMax;
          });
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              AppBar(
                leading: IconContainer(
                  icon: const Icon(Icons.close),
                  onTap: () => context.pop(),
                ),
                title: Text(
                  AppLocalizations.of(context)!.selectLanguage,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _loadInitialData,
                  child: GridView.builder(
                    controller: _scrollController,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          mainAxisExtent: 120,
                          childAspectRatio: 0.7,
                        ),
                    itemCount: _countries.length + (_hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index >= _countries.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      final country = _countries[index];
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceBright,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: Image.network(
                                country.flagUrl,
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              country.name,
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                              // maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              if (_isLoading && _countries.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ),
              TextButton(
                onPressed: () {
                  // Handle vote for more languages
                },
                child: Text(
                  AppLocalizations.of(context)!.voteForMore,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w300,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
