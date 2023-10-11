
--
--key bindings for telemetry profiler

-- these two moved to GameConsoleProvider::Subscribe() so they work when not in game
--bind("CONTROL+F11","TMProfiler_Toggle(false)")
--bind("SHIFT+F11","TMProfiler_Stop()")

bind("ALT+CONTROL+F11","TMProfiler_PerfTest()")

--
--key bindings for state tree profiler

bind("CONTROL+SHIFT+PageUp","statetreeprofiler_scroll_up_tree_demographic_tracking(20)")
bind("CONTROL+SHIFT+PageDown","statetreeprofiler_scroll_down_tree_demographic_tracking(20)")

--

	
