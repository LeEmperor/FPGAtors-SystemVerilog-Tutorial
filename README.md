These are the files used for the second presentation on SystemVerilog for FPGAtors club @ University of Florida. 

1. "vivado_proj.sh" in ./scripts will create a new vivado project taking in args "proj_name" and "top_module_name" afterwards being the name of the project and the name of the top module.
ie: "./vivado_proj.sh demo my_top" will create a project named "demo" with the top module named "my_top"

This script's purpose is just because Vivado project creation is annoyingly slow (vs generic functions like the RTL analyzer and elaboration engine). 

2. "compile_script.do" when run in the TCL console of Model/QuestaSim will simply compile the current project. It's solve purpose is the fact that autocomplete works on script name targets.
ie: "do co..." and pressing TAB will autocomplete vs manually typing out "project compileoutofdate" is tedious on a QWERTY layout and NOT autocomplete friendly.

3. "sim_script.do" is similar in that it simply runs the "start simulation" functionality of Questa/Modelsim, but particularly with the optimization flags off so QuestaSim DOESN'T optimize away the internal signals.
Simply rename the target item after the "work.ENTITY_NAME" and you will get the simulation started on the relevant body (assuming it is a valid simulation struct).

4. "run_script.do" does the "run -all" TCL command, which is another keystroke saving autocomplete.

5. "bruh_script.do" will let you re-run the simulation WHILE you are in the simulation. This also re-fits the window (akin to what pressing 'f' does to fit the entire simulation run to the window).
For example, if you change a file AFTER simulating, you can run this, which will re-compile and re-run the simulation, while preserving custom wave-viewer configurations such as radixes or grouping.

ADDITIONAL: the "add wave -r *" is the command I used many times to add all the internal signals recursively onto the wave viewer. 
You can CTRL-S while selected (focused) on the wave viewer window and save a wave setup as some file (such as "wave.do") which can be re-run later to reformat the wave viewer into the saved state, including groupings and radixes as previously set. 
There is also something similar for memories that you view, which can save as "mem.do" and will save radix and data formatting on any memories you are internally viewing. 

See my the earlier portion of my TCL scripting guide for more information on TCL scripting and automations. It also includes some relevant information for memory initializatoins that Quartus may load - this is lacking a bit though. 
