import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      child: const Center(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
