import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worker/features/categories/presentation/bloc/categories_bloc.dart';

import '../bloc/joprequest_bloc.dart';

class JobsReqeusts extends StatefulWidget {
  const JobsReqeusts({super.key});

  @override
  State<JobsReqeusts> createState() => _JobsReqeustsState();
}

class _JobsReqeustsState extends State<JobsReqeusts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<JoprequestBloc, JoprequestState>(
        builder: (context, state) {
          return switch (state.status) {
            CubitStatus.failed => const SizedBox(),
            CubitStatus.success => GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return Card(
                    color:
                        state.requests[index].status.toLowerCase() == 'pending'
                            ? Colors.yellowAccent
                            : state.requests[index].status.toLowerCase() ==
                                    'accepted'
                                ? Colors.greenAccent
                                : Colors.redAccent,
                    child: Center(
                        child: Column(
                      children: [
                        Text(
                          state.requests[index].jobDescription,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (state.requests[index].status.toLowerCase() ==
                            'pending')
                          Row(
                            children: [
                              IconButton.filled(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.check,
                                    color: Colors.greenAccent,
                                  )),
                              IconButton.filled(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.redAccent,
                                  ))
                            ],
                          )
                      ],
                    )),
                  );
                },
              ),
            _ => const Center(
                child: CircularProgressIndicator(),
              ),
          };
        },
      ),
    );
  }
}
