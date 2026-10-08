import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'domain/validate_name.dart';

import 'bloc/st_bloc.dart';
import 'bloc/st_event.dart';
import 'bloc/st_state.dart';
import 'profile_page.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => StudentBloc(ValidateNameUseCase()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'КТ8',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главная'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocConsumer<StudentBloc, StudentState>(
          listener: (context, state) {
            if (state is ErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }

            if (state is NavigateToProfileState) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProfilePage(
                    name: state.name,
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 4,
                  child: Padding(
                    padding:
                        const EdgeInsets.all(20),
                    child: Column(
                      children: const [
                        Text(
                          'Профиль',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Вход',
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                TextField(
                  controller: _controller,
                  decoration:
                      const InputDecoration(
                    labelText:
                        'Введите имя',
                    border:
                        OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    context
                        .read<StudentBloc>()
                        .add(
                          OpenProfileEvent(
                            _controller.text,
                          ),
                        );
                  },
                  child: const Text(
                    'Открыть профиль',
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}