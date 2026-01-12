/**
 * @fileoverview: Defines a double floating value animation process.
 * @organization: UATM GASA Formation - https://uatm-gasa.com
 * @framework: Flutter - https://www.flutter.dev
 * @author: Obrymec - https://obrymec.vercel.app
 * @file: animated_double.dart
 * @supported: ANDROID & IOS
 * @created: 2026-01-12
 * @updated: 2026-01-12
 * @version: 0.0.1
 */

/// Flutter dependencies.
library;
import "package:flutter/material.dart";

/// Plugin dependencies.
import "package:simple_animations/simple_animations.dart";

/// Enumerations.
enum AnimationDirection {backwards, alternate, forwards}

/// Builds the complete animation process to animate a double floating
/// value step by step from a start and end value.
///
/// This __[StatefulWidget]__ uses a _[Tween]_ of [double] to animate
/// a given float through a starting and ending worth. We can trigger
/// animation by taping on it.
class AnimatedDouble extends StatefulWidget {
  /// Attributes.
  final Widget Function(double, BuildContext) builder;
  final AnimationDirection direction;
  final void Function()? onCompleted;
  final int iterationCount;
  final bool isAnimated;
  final bool isDisabled;
  final double start;
  final Curve easing;
  final int duration;
  final double end;
  final int delay;

  /// Initializes the [Key] and calls its parent constructor.
  /// The [Key] represents the unique id to identify this animation.
  @override
  State<AnimatedDouble> createState () => _AnimatedDoubleState();

  /// Creates a new object instance of its state.
  ///
  /// The state represents all different necessaries
  /// [widgets] to render graphically.
  const AnimatedDouble ({
    this.direction = AnimationDirection.forwards,
    this.easing = Curves.easeInOut,
    this.isDisabled = false,
    this.isAnimated = false,
    this.iterationCount = 1,
    required this.builder,
    this.duration = 400,
    this.onCompleted,
    this.start = 0.0,
    this.end = 0.0,
    this.delay = 0,
    super.key
  });
}

/// Builds an animator [Widget] specified for double floating animation
/// effect.
///
/// It's there, we use [AnimationMixin] and [PlayAnimationBuilder] classes
/// provided by a plugin to animate a floating value according to a
/// starting and ending value. Any _[Widget]_ that will the child
/// of this [AnimatedWidget] will be affected by the animation.
class _AnimatedDoubleState
extends State<AnimatedDouble>
with AnimationMixin {
  /// Attributes.
  late final AnimationController _controller;
  late final Animation<double> _float;

  /// Called when this activity is mounted into the tree.
  ///
  /// Notice that, _[initState]_ method is called once only.
  /// If you mutate the state, this method won't call again.
  @override
  void initState () {
    // Calls the parent init state method.
    super.initState();
    // Initializes the floating animation controller.
    _controller = createController();
    // Initializes the tween animation.
    _float = Tween<double>(
      begin: widget.start, end: widget.end
    ).animate(_controller);
  }

  /// Runs animation with ping pong mode thank a plugin's
  /// class named: [MirrorAnimationBuilder].
  MirrorAnimationBuilder _runAlternate () => MirrorAnimationBuilder<double>(
    tween: Tween<double>(begin: widget.start, end: widget.end),
    duration: Duration(milliseconds: widget.duration),
    curve: widget.easing,
    builder: (
      BuildContext animContext, double value, Widget? _
    ) => _buildContainer(value)
  );

  /// Builds an interactive widget container to allow us to
  /// trigger animation from a click.
  IgnorePointer _buildContainer (double value) => IgnorePointer(
    ignoring: widget.isDisabled,
    child: InkWell(
      canRequestFocus: !widget.isDisabled,
      enableFeedback: !widget.isDisabled,
      splashColor: Colors.transparent,
      onTap: () async => await _run(),
      child: widget.builder(value, context)
    )
  );

  /// Runs animation with forwards mode thank a plugin's class
  /// named: [LoopAnimationBuilder].
  LoopAnimationBuilder _runLoop ({
    required double start, required double end
  }) => LoopAnimationBuilder <double> (
    duration: Duration(milliseconds: widget.duration),
    tween: Tween<double>(begin: start, end: end),
    curve: widget.easing,
    builder: (
      BuildContext animContext, double value, Widget? _
    ) => _buildContainer(value)
  );

  /// Runs animation with forwards mode thank a plugin's class
  /// named: [PlayAnimationBuilder].
  PlayAnimationBuilder _runForwards ({
    required double start, required double end
  }) => PlayAnimationBuilder <double> (
    duration: Duration(milliseconds: widget.duration),
    tween: Tween<double>(begin: start, end: end),
    delay: Duration(milliseconds: widget.delay),
    onCompleted: widget.onCompleted,
    curve: widget.easing,
    builder: (
      BuildContext animContext, double value, Widget? _
    ) => _buildContainer(value)
  );

  /// Plays animation with forwards mode.
  Future<void> _playForwards (Duration duration) async {
    // Whether iteration count is less that zero.
    if (widget.iterationCount < 0) {
      // Plays animation with loop mode.
      await _controller.loop(duration: duration);
    // Otherwise.
    } else {
      // Running animation from the passed iteration count.
      for (int i = 1; i <= widget.iterationCount; i++) {
        // Plays animation with forwards mode.
        await _controller.play(duration: duration);
      }
    }
  }

  /// Plays animation with backwards mode.
  Future<void> _playBackwards (Duration duration) async {
    // Whether iteration count is less that zero.
    if (widget.iterationCount < 0) {
      // Infinite playing.
      while (true) {
        // Plays animation with backwards mode.
        await _controller.playReverse(duration: duration);
      }
    // Otherwise.
    } else {
      // Running animation from the passed iteration count.
      for (int j = 1; j <= widget.iterationCount; j++) {
        // Plays animation with backwards mode.
        await _controller.playReverse(duration: duration);
      }
    }
  }

  /// Plays animation with alternate mode.
  Future<void> _playAlternate (Duration duration) async {
    // Whether iteration count is less that zero.
    if (widget.iterationCount < 0) {
      // Infinite playing.
      while (true) {
        // Plays animation with forwards mode.
        await _controller.play(duration: duration);
        // Plays animation with backwards mode.
        await _controller.playReverse(duration: duration);
      }
    // Otherwise.
    } else {
      // Running animation from the passed iteration count.
      for (int k = 1; k <= widget.iterationCount; k++) {
        // Plays animation with forwards mode.
        await _controller.play(duration: duration);
        // Plays animation with backwards mode.
        await _controller.playReverse(duration: duration);
      }
    }
  }

  /// Plays animation according to the passed direction.
  Future<void> _run () async {
    // Whether iteration count is not equal to zero.
    if (widget.iterationCount != 0) {
      // Waits for the passed delay value.
      await Future.delayed(
        Duration(milliseconds: widget.delay.abs()), () async {
          // The duration value.
          final Duration time = Duration(
            milliseconds: widget.duration.abs()
          );
          // Whether direction is forwards.
          if (widget.direction == AnimationDirection.forwards) {
            // Runs animation with forwards mode.
            await _playForwards(time);
          // Whether direction is reversed.
          } else if (widget.direction == AnimationDirection.backwards) {
            // Runs animation with backwards mode.
            await _playBackwards(time);
          // Whether direction is alternate.
          } else {
            // Runs animation with alternate mode.
            await _playAlternate(time);
          }
          // Whether `onCompleted` method is listening.
          if (widget.onCompleted != null) {
            // Calls it.
            widget.onCompleted!();
          }
        }
      );
    }
  }

  /// Plays animation according to the passed direction.
  ///
  /// We'll use the provided [widgets] of a plugin
  /// to implement auto animation process.
  Widget _execute (double value) {
    // Whether iteration count is not equal to zero.
    if (widget.iterationCount != 0) {
      // Whether direction is forwards.
      if (widget.direction == AnimationDirection.forwards) {
        // Whether iteration count is less that zero.
        if (widget.iterationCount < 0) {
          // Infinite playing.
          return _runLoop(start: widget.start, end: widget.end);
        // Otherwise.
        } else {
          // Plays animation with forwards mode.
          return _runForwards(start: widget.start, end: widget.end);
        }
      // Whether direction is reversed.
      } else if (widget.direction == AnimationDirection.backwards) {
        // Whether iteration count is less that zero.
        if (widget.iterationCount < 0) {
          // Infinite playing.
          return _runLoop(end: widget.start, start: widget.end);
        // Otherwise.
        } else {
          // Plays animation with backwards mode.
          return _runForwards(end: widget.start, start: widget.end);
        }
      // Whether direction is alternate.
      } else {
        // Runs animation with alternate mode.
        return _runAlternate();
      }
    }
    // Returns the default container for most others cases.
    return _buildContainer(value);
  }

  /// Called when the state is ready and at all times where it mutates.
  ///
  /// When the view is ready, it generates its own [context] that
  /// represents the state's [BuildContext] bound to its activity.
  /// *[build]* method will call at every time if and only if
  /// *[setState]* method is called within a program.
  @override
  Widget build (BuildContext _) => (
    widget.isAnimated ?
    _execute(_float.value) :
    _buildContainer(_float.value)
  );
}
