
/// the base class that all is going to inherit
abstract class CounterEvents{}

/// These events the UI will pass them to the Bloc file

// Event 1
class IncrementEvent extends CounterEvents{}

// Event 2
class DecrementEvent extends CounterEvents{}
