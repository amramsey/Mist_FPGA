-----------------------------------------------------------------------------	
-- COMPUTER SPACE TOP LEVEL - embedded audio memory version          		--
-- Implementation of Computer Space FPGA emulator.									--
-- 																								--
-- Developed primarily to understand the inner workings of						--
-- the Computer Space game logic.														--
--																									--
-- The emulator can also serve the purpose of game									--
-- preservation as the schematics have been copied "wire by wire"				--
-- and "component by component"/"gate by gate" and hence represents			--
-- a very close realization of the original, except for sound 		 			--	
-- generation which in this solution is based on audio samples.				--
--																									--
-- Some errors in the original schematics have been 								--
-- discovered during the transfer of schematics into vhdl.	They are 		--	
-- accounted for and corrected in the vhdl code.									--
-- 																								--	
-- The Computer Space Logic part replicates the three Computer Space			--
-- Boards and represents the complete game. It is implementation agnostic,	--
-- but requires the ability to support global clock signals,					--
-- input signals from control panel buttons and										--
-- coin mechanism, output signal to trigger audio and output signal for		--
-- composite ntsc video and audio.														--
-- 																								--
--																									-- 
-- Credit goes to:																			--
-- 	*	Overall fpga development community; there is a lot of stuff			--
--			readily available as inspiration and working code - in 				--
--			particular regarding the implementation specifics						--
--		* 	Mike Salay (KLOV: road.runner) - who has provided a large number	--
--		  	of measurement points from real Computer Space boards to determine--	
--			timer values, resolve logic behind the distribution of stars on	--
--			screen and verify the original video sync logic.						-- 
--		*	Computerspacefan.com - who has provided sound samples and			--
--			original schematics																--
--		* 	Chris (http://www.pyroelectro.com/) whose code for interlaced		--
--			ntsc signalling I have kindly used as a basis for creating an		--
--			interlaced ntsc video signal version 										--
--																									--
-- v1.0																							--
-- by Mattias G, 2015																		--
-- Enjoy!																						-- 
-----------------------------------------------------------------------------

library 	ieee;
use 		ieee.std_logic_1164.all; 
use 		ieee.std_logic_arith.all;
use 		ieee.std_logic_unsigned.all;
library	work;

--80---------------------------------------------------------------------------|

entity computer_space_top is 
	port
	(
		reset  			: in  std_logic;
		clock_50 		: in  std_logic;
		game_clk			: in  std_logic;

		signal_ccw 		: in  std_logic;
		signal_cw 		: in  std_logic;
		signal_thrust 	: in  std_logic;
		signal_fire 	: in  std_logic;
		signal_start 	: in  std_logic;

		hsync				: out std_logic;
		vsync				: out std_logic;
		blank				: out std_logic;
		video 			: out std_logic;

		wav_out			: out signed (15 downto 0)
	);
end computer_space_top;

architecture computer_space_architecture
				 of computer_space_top is 		 
				 
component clocks is 
	port (
	clock_50  										: in  std_logic;
	thrust_and_rotate_clk 						: out std_logic:='0';
	explosion_clk 									: out std_logic;
	explosion_rotate_clk  						: out std_logic; 
	seconds_clk 									: out std_logic;
	timer_base_clk 								: out std_logic;
	rocket_missile_life_time_duration,
	saucer_missile_life_time_duration,
	saucer_missile_hold_duration,
	signal_delay_duration 						: out integer
	);
end component clocks;

component computer_space_logic is
	port (
	reset,
	game_clk, super_clk, explosion_clk,
	seconds_clk 									: in std_logic;
	timer_base_clk 								: in std_logic;
	rocket_missile_life_time_duration,
	saucer_missile_life_time_duration,
	saucer_missile_hold_duration,
	signal_delay_duration 						: in integer; 
	thrust_and_rotate_clk,
	explosion_rotate_clk 						: in std_logic;	
	signal_start, signal_coin, 
	signal_thrust, signal_fire,
	signal_cw, signal_ccw  						: in std_logic;
	composite_video_signal					 	: out std_logic;
	blank												: out std_logic;
	hsync												: out std_logic;
	vsync												: out std_logic;
	audio_gate										: out std_logic;
	sound_switch									: out std_logic_vector (7 downto 0)	
	);
end component computer_space_logic;	

component sound is
	port (
	clock_50, audio_gate							: in std_logic;
	sound_switch									: in std_logic_vector (7 downto 0);
	sigma_delta_wav 								: out signed (15 downto 0) 
	);
end component sound;

-- signals for thrust 
-- so that a continuous button push
-- create continuous thrust and/or
-- rotation 
signal thrust_and_rotate_clk  				: std_logic:='0';

-- signals for explosion circuitry
-- logic
signal explosion_clk 							: std_logic;

-- clock to rotate the rocket
-- rapdily at explosion
signal explosion_rotate_clk					: std_logic; 

--signals for clock counting seconds
signal seconds_clk 								: std_logic;

-- timer components for Motion Board 
signal timer_base_clk 							: std_logic;
signal rocket_missile_life_time_duration,
		 saucer_missile_life_time_duration,
		 saucer_missile_hold_duration,
		 signal_delay_duration  				: integer;

-- signals for composite
-- video
		 

-- signals to fetch and activate sound
-- from audio memory 
signal sound_switch 								: std_logic_vector (7 downto 0)
														:= "00000000" ;
-- not using bit 0, only bit 1 to 5
-- 1 = rocket rotate
-- 2 = rocket thrust,
-- 3 = rocket missile
-- 4 = rocket explosion,
-- 5 = saucer missile shooting

signal audio_gate 								: std_logic;
	
	 

------------------------------------------------------------------------//
begin 

--------------------------------------------------------------------------
-- GENERATE CLOCKS																		--
--------------------------------------------------------------------------
generate_clock : CLOCKS 
port map
(clock_50, thrust_and_rotate_clk,explosion_clk, explosion_rotate_clk,
seconds_clk, timer_base_clk,
rocket_missile_life_time_duration, saucer_missile_life_time_duration,
saucer_missile_hold_duration, signal_delay_duration);

--------------------------------------------------------------------------
-- CORE COMPUTER SPACE LOGIC															--
--------------------------------------------------------------------------
computer_space : COMPUTER_SPACE_LOGIC
port map
(reset, game_clk, clock_50, explosion_clk, seconds_clk, timer_base_clk,
rocket_missile_life_time_duration, saucer_missile_life_time_duration,
saucer_missile_hold_duration, signal_delay_duration,
thrust_and_rotate_clk, explosion_rotate_clk, 
signal_start, signal_start, signal_thrust, signal_fire,
signal_cw,signal_ccw, video, blank,
hsync, vsync,
audio_gate, sound_switch 
);		

audio_playback : sound
	port map (clock_50, audio_gate, sound_switch, wav_out);

end computer_space_architecture;	