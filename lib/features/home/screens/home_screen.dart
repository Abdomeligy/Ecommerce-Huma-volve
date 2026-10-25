import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme.dart';
import '../presentation/cubit/home_cubit.dart';
import '../presentation/cubit/home_states.dart';
import 'widgets/category_chip.dart';
import 'widgets/pagination_loading_widget.dart';
import 'widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategoryIndex = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 300) {
      context.read<HomeCubit>().fetchNextPage();
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withValues(alpha: 0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.menu,
                            color: AppTheme.primary,
                          ),
                        ),
                        const CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(
                            'https://i.pravatar.cc/150',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Explore',
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge
                          ?.copyWith(fontSize: 36),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Best trendy collection!',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.05),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search clothes...',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          suffixIcon: Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppTheme.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.tune,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      height: 44,
                      child: BlocBuilder<HomeCubit, HomeStates>(
                        builder: (context, state) {
                          if (state is HomeLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (state is HomeError) {
                            return Center(
                              child: Text(state.message),
                            );
                          }

                          if (state is HomeSuccess) {
                            final categories = state.categories;

                            if (categories.isEmpty) {
                              return const Center(
                                child: Text('No categories available'),
                              );
                            }

                            return ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: categories.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 12),
                              itemBuilder: (context, index) {
                                final category = categories[index];

                                return CategoryChip(
                                  label: category.name,
                                  isSelected: _selectedCategoryIndex == index,
                                  onTap: () {
                                    setState(() {
                                      _selectedCategoryIndex = index;
                                    });

                                    context.read<HomeCubit>().loadProducts(
                                          category.id,
                                        );
                                  },
                                );
                              },
                            );
                          }

                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BlocBuilder<HomeCubit, HomeStates>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                }

                if (state is HomeError) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text(state.message),
                      ),
                    ),
                  );
                }

                if (state is HomeSuccess) {
                  final products = state.products;

                  if (products.isEmpty) {
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: Text('No products available'),
                        ),
                      ),
                    );
                  }

                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return ProductCard(
                            product: products[index],
                          );
                        },
                        childCount: products.length,
                      ),
                    ),
                  );
                }

                return const SliverToBoxAdapter(
                  child: SizedBox.shrink(),
                );
              },
            ),
            BlocBuilder<HomeCubit, HomeStates>(
              builder: (context, state) {
                if (state is HomeSuccess && state.isLoadingMore) {
                  return const SliverToBoxAdapter(
                    child: PaginationLoadingWidget(),
                  );
                }
                return const SliverToBoxAdapter(child: SizedBox(height: 24));
              },
            ),
          ],
        ),
      ),
    );
  }
}