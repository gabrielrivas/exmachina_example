defmodule SupervisorExample do
  def start(_type, _args) do
     import Supervisor.Spec, warn: false
     #link_opts = [strategy: :one_for_one, name: TelLog.LinkSupervisor]

     children = [
       #Call supervisor with empty list of parameters
       supervisor(ExMachinaSupervisor, [])
     ]

     # start our links like so?
     #Supervisor.start_child(:link_supervisor, [{"ztopic", "jbus"}])

     # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
     # for other strategies and supported options
     opts = [strategy: :one_for_one, name: ExMachinaSupervisor]

     #Start list of children
     Supervisor.start_link(children, opts)
   end
end