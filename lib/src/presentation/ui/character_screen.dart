import 'package:casino_test/src/di/main_di_module.dart';
import 'package:casino_test/src/domain/entities/character.dart';
import 'package:casino_test/src/presentation/cubit/characters_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersScreen extends StatelessWidget {
  const CharactersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => di.get<CharactersScreenCubit>()..init(),
        child: BlocConsumer<CharactersScreenCubit, CharactersScreenState>(
          listener: (context, state) {},
          builder: (blocContext, state) {
            return state.map(
                loading: (_) => _loadingWidget(),
                loaded: (loadedState) => CharactersList(
                      characters: loadedState.characters,
                      onReachedEnd: () => blocContext
                          .read<CharactersScreenCubit>()
                          .loadNextPage(),
                      loadingMore: loadedState.loadingMore,
                      errorWhileLoadingMore: loadedState.errorWhileLoadingMore,
                    ),
                error: (_) => Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Error while loading data \n Please try again',
                          textAlign: TextAlign.center,
                        ),
                        RefreshButton(
                          onPressed: () =>
                              blocContext.read<CharactersScreenCubit>().init(),
                        ),
                      ],
                    )));
          },
        ),
      ),
    );
  }

  Widget _loadingWidget() {
    return Center(
      child: Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: const CircularProgressIndicator(),
      ),
    );
  }
}

class CharactersList extends StatefulWidget {
  final List<Character> characters;
  final Function onReachedEnd;
  final bool loadingMore;
  final bool errorWhileLoadingMore;

  const CharactersList({
    super.key,
    required this.characters,
    required this.onReachedEnd,
    required this.loadingMore,
    this.errorWhileLoadingMore = false,
  });

  @override
  State<CharactersList> createState() => _CharactersListState();
}

class _CharactersListState extends State<CharactersList> {
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  initState() {
    super.initState();
    _controller.addListener(() => _onScroll());
  }

  _onScroll() {
    if (_controller.offset >= _controller.position.maxScrollExtent - 50 &&
        !_controller.position.outOfRange) {
      widget.onReachedEnd();
    }
  }

  @override
  Widget build(BuildContext context) {
    final characters = widget.characters;
    return ListView.builder(
      controller: _controller,
      itemCount: characters.length +
          ((widget.loadingMore || widget.errorWhileLoadingMore) ? 1 : 0),
      itemBuilder: (context, index) {
        if (characters.length == index) {
          if (widget.loadingMore) {
            return const Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return RefreshButton(
              onPressed: widget.onReachedEnd,
            );
          }
        }

        return CharacterCard(character: widget.characters[index]);
      },
    );
  }
}

class RefreshButton extends StatelessWidget {
  final Function onPressed;

  const RefreshButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Center(
        child: IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => onPressed(),
        ),
      ),
    );
  }
}

class CharacterCard extends StatelessWidget {
  final Character character;

  const CharacterCard({super.key, required this.character});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: ShapeDecoration(
          color: const Color.fromARGB(120, 204, 255, 255),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                character.image,
                width: 80,
                height: 80,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoLine(info: character.name),
                InfoLine(info: character.species),
                InfoLine(info: character.gender),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InfoLine extends StatelessWidget {
  final String info;

  const InfoLine({super.key, required this.info});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Text(info),
    );
  }
}
