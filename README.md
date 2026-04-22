# FSM---Traffic-Light-Controller

📋 Project Overview
This project implements a smart traffic light controller using Verilog HDL that intelligently manages traffic at an intersection. Unlike traditional fixed-timer traffic lights, this design uses a sensor input to detect vehicles on the side road and adjusts the light timing accordingly.

Key Features:
🚦 4-State FSM design for traffic light sequencing
🔍 Sensor-based optimization - Side road gets green only when vehicles are detected
🟢 Priority-based control - Main road gets priority when no side traffic
⏱️ Proper sequencing - Green → Yellow → Red transitions
🎯 Deadlock prevention - Proper timing prevents accidents
🔄 Synchronous design with active-high reset

Light States:
State	    Main Road Light     Side Road Light      	Description
S_MAIN_G	🟢 GREEN	          🔴 RED	           Main road has right of way
S_MAIN_Y	🟡 YELLOW	          🔴 RED	           Transitioning to side road
S_SIDE_G	🔴 RED	            🟢 GREEN	         Side road has right of way
S_SIDE_Y	🔴 RED	            🟡 YELLOW	         Transitioning back to main

📊 Signal Description
Signal	           Width	      Direction	      Description
clk	               1 bit	       Input	      System clock (positive edge-triggered)
rst	               1 bit	       Input	      Active-high synchronous reset
sensor	           1 bit	       Input	      Vehicle detection on side road (1=car present)
light_main[2:0]    3 bits	       Output	      Main road traffic light (RGB order)
light_side[2:0]	   3 bits	       Output	      Side road traffic light (RGB order)
