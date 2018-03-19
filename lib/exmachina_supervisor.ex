defmodule ExmachinaSupervisor do
  use Supervisor

  #Starts supervisor with no arguments
  def start_link do
    # We are now registering our supervisor process with a name
    # so we can reference it in the `start_room/1` function
    Supervisor.start_link(__MODULE__, [], name: :exmachina_supervisor)
  end

  def init(args) do
    children = [
      # Worker template
      # of Module Basic taking list of arguments
      # When starting the worker do:
      # Supervisor.start_child(:supervisor_name, [arg1, arg2, arg3, ... , argN])
      # This will start a worker (GenServer) with:
      # For a ModuleName.start_link(arg1, arg2, arg3, ... , argN)
      worker(ExMachina, args)
    ]

    # We also changed the `strategty` to `simple_one_for_one`.
    # With this strategy, we define just a "template" for a child,
    # no process is started during the Supervisor initialization,
    # just when we call `start_child/2`
    supervise(children, strategy: :simple_one_for_one)
  end
end