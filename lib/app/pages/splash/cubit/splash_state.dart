import 'package:equatable/equatable.dart';

class SplashState extends Equatable{
  const SplashState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SplashEmpty extends SplashState{}
class SplashStart extends SplashState{}
class SplashDone extends SplashState{}