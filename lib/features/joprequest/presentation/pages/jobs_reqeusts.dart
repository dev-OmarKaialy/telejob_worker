import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worker/core/extensions/widget_extensions.dart';
import 'package:worker/features/categories/presentation/bloc/categories_bloc.dart';
import 'package:worker/features/shop/presentation/pages/shop_screen.dart';

import '../bloc/joprequest_bloc.dart';

class JobsReqeusts extends StatefulWidget {
  const JobsReqeusts({super.key});

  @override
  State<JobsReqeusts> createState() => _JobsReqeustsState();
}

class _JobsReqeustsState extends State<JobsReqeusts> {
  @override
  void initState() {
    super.initState();
    context.read<JoprequestBloc>().add(GetJobRequestsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          const Icon(Icons.shop).onTap(() {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const ShopScreen();
              },
            ));
          })
        ],
      ),
      body: BlocBuilder<JoprequestBloc, JoprequestState>(
        builder: (context, state) {
          return switch (state.status) {
            CubitStatus.failed => const SizedBox(),
            CubitStatus.success => ListView.builder(
                itemCount: state.requests.length,
                itemBuilder: (context, index) {
                  return Card(
                    color:
                        state.requests[index].status.toLowerCase() == 'pending'
                            ? Colors.grey.shade100
                            : state.requests[index].status.toLowerCase() ==
                                    'accepted'
                                ? Colors.greenAccent
                                : Colors.redAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            state.requests[index].jobDescription,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (state.requests[index].status.toLowerCase() ==
                              'pending')
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton.filled(
                                    onPressed: () {
                                      context.read<JoprequestBloc>().add(
                                          UpdateJobRequestsEvent(
                                              id: state.requests[index].id,
                                              status: true));
                                    },
                                    icon: const Icon(
                                      Icons.check,
                                      color: Colors.greenAccent,
                                    )),
                                IconButton.filled(
                                    onPressed: () {
                                      context.read<JoprequestBloc>().add(
                                          UpdateJobRequestsEvent(
                                              id: state.requests[index].id,
                                              status: false));
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.redAccent,
                                    ))
                              ],
                            )
                        ],
                      )),
                    ),
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
