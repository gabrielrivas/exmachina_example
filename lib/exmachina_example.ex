defmodule ExMachinaExample do

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
     opts = [strategy: :one_for_one, name: :main_app]

     #Start list of children
     Supervisor.start_link(children, opts)
   end

   def run do
     transitions = [Transition.new() |>
                      Map.put(:current_state, :s1) |>
                      Map.put(:next_state, :s2)   |>
                      Map.put(:process_result, :ok)|> 
                      Map.put(:timeout, 1000),
                    Transition.new() |>
                      Map.put(:current_state, :s2) |>
                      Map.put(:next_state, :s3)   |>
                      Map.put(:process_result, :ok) |>
                      Map.put(:timeout, 1000),
                    Transition.new()|>
                      Map.put(:current_state, :s3) |>
                      Map.put(:next_state, :s4)   |>
                      Map.put(:process_result, :ok) |>
                      Map.put(:timeout, 1000),
                    Transition.new()|>
                      Map.put(:current_state, :s4) |>
                      Map.put(:next_state, :s5)   |>
                      Map.put(:process_result, :ok) |>
                      Map.put(:timeout, 1000),
                    Transition.new()|>
                      Map.put(:current_state, :s5) |>
                      Map.put(:next_state, :s6)  |>
                      Map.put(:process_result, :ok) |> 
                      Map.put(:timeout, 1000),
                    Transition.new()|>
                      Map.put(:current_state, :s6) |>
                      Map.put(:next_state, :s7)  |>
                      Map.put(:process_result, :ok) |> 
                      Map.put(:timeout, 1000),
                    Transition.new()|>
                      Map.put(:current_state, :s7) |>
                      Map.put(:next_state, :s8)  |>
                      Map.put(:process_result, :ok) |> 
                      Map.put(:timeout, 1000),
                    Transition.new()|>
                      Map.put(:current_state, :s8) |>
                      Map.put(:next_state, :s9)  |>
                      Map.put(:process_result, :ok) |> 
                      Map.put(:timeout, 1000),
                    Transition.new()|>
                      Map.put(:current_state, :s9) |>
                      Map.put(:next_state, :s1)  |>
                      Map.put(:process_result, :ok)  |>
                      Map.put(:timeout, 1000),                                                                                                    
                    ]   
                     
      test_fsm = FSMCore.new |>
                Map.put(:name, "fsm1") |>
                Map.put(:type, :time_driven) |>
                Map.put(:states, [:s1, :s2, :s3, :s4, :S5, :s6, :s7, :s8, :s9]) |>
                Map.put(:initial_state, :s1) |>
                Map.put(:data, "tester") |>
                Map.put(:module_logic, GeneratorLogic) |>
                Map.put(:initialization_function, :initialization) |>
                Map.put(:state_process, :state_process) |>
                Map.put(:info_handler, :info_handler) |>
                Map.put(:transition_table, transitions) |>
                Map.put(:timeout, 1000) 
                     
        test_fsm2 = FSMCore.new |>
                Map.put(:name, "fsm2") |>
                Map.put(:type, :time_driven) |>
                Map.put(:states, [:s1, :s2, :s3, :s4, :S5, :s6, :s7, :s8, :s9]) |>
                Map.put(:initial_state, :s1) |>
                Map.put(:data, "tester") |>
                Map.put(:module_logic, GeneratorLogic) |>
                Map.put(:initialization_function, :initialization) |>
                Map.put(:state_process, :state_process) |>
                Map.put(:info_handler, :info_handler) |>
                Map.put(:reset_function, :reset_logic) |>
                Map.put(:transition_table, transitions) |>
                Map.put(:timeout, 1000)

      #{:ok, gen} = ExMachina.start_link(test_fsm, 1000)                     
      #{:ok, gen2} = ExMachina.start_link(test_fsm2, 1000)
      Supervisor.start_child(:exmachina_supervisor,[test_fsm, 1000])
      Supervisor.start_child(:exmachina_supervisor,[test_fsm2, 1000])
      #Test info handler
      #send(gen, "Hello from fsm1")
      #send(gen2, "Hello from fsm2")
  
      #Get FSM data from its name
      ExMachina.call("fsm2", :get_data)

      :timer.sleep(5000)
      
      ExMachina.stop("fsm1")

      :timer.sleep(5000)

      ExMachina.stop("fsm2")     
   end
end