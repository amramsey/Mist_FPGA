library ieee;
use ieee.std_logic_1164.all,ieee.numeric_std.all;

entity gfx_3f is
port (
	clk  : in  std_logic;
	addr : in  std_logic_vector(11 downto 0);
	data : out std_logic_vector(7 downto 0)
);
end entity;

architecture prom of gfx_3f is
	type rom is array(0 to  4095) of std_logic_vector(7 downto 0);
	signal rom_data: rom := (
		X"00",X"1C",X"26",X"63",X"63",X"63",X"32",X"1C",X"00",X"7E",X"18",X"18",X"18",X"18",X"1C",X"18",
		X"00",X"7F",X"07",X"1E",X"3C",X"70",X"63",X"3E",X"00",X"3E",X"63",X"60",X"3C",X"18",X"30",X"7E",
		X"00",X"30",X"30",X"7F",X"33",X"36",X"3C",X"38",X"00",X"3E",X"63",X"60",X"60",X"3F",X"03",X"3F",
		X"00",X"3E",X"63",X"63",X"3F",X"03",X"06",X"3C",X"00",X"0C",X"0C",X"0C",X"18",X"30",X"63",X"7F",
		X"00",X"3E",X"61",X"61",X"1E",X"27",X"23",X"1E",X"00",X"1E",X"30",X"60",X"7E",X"63",X"63",X"3E",
		X"00",X"00",X"00",X"00",X"00",X"24",X"36",X"36",X"00",X"00",X"00",X"00",X"3E",X"00",X"00",X"00",
		X"00",X"38",X"1C",X"0E",X"07",X"0E",X"1C",X"38",X"00",X"00",X"00",X"3E",X"00",X"00",X"3E",X"00",
		X"00",X"0E",X"1C",X"38",X"70",X"38",X"1C",X"0E",X"00",X"18",X"00",X"18",X"38",X"63",X"63",X"3E",
		X"3C",X"42",X"99",X"A5",X"85",X"99",X"42",X"3C",X"00",X"63",X"63",X"7F",X"63",X"63",X"36",X"1C",
		X"00",X"3F",X"63",X"63",X"3F",X"63",X"63",X"3F",X"00",X"3C",X"66",X"03",X"03",X"03",X"66",X"3C",
		X"00",X"1F",X"33",X"63",X"63",X"63",X"33",X"1F",X"00",X"7F",X"03",X"03",X"3F",X"03",X"03",X"7F",
		X"00",X"03",X"03",X"03",X"3F",X"03",X"03",X"7F",X"00",X"7C",X"66",X"63",X"73",X"03",X"06",X"7C",
		X"00",X"63",X"63",X"63",X"7F",X"63",X"63",X"63",X"00",X"7E",X"18",X"18",X"18",X"18",X"18",X"7E",
		X"00",X"3E",X"63",X"63",X"60",X"60",X"60",X"60",X"00",X"73",X"3B",X"1F",X"0F",X"1B",X"33",X"63",
		X"00",X"7E",X"06",X"06",X"06",X"06",X"06",X"06",X"00",X"63",X"63",X"6B",X"7F",X"7F",X"77",X"63",
		X"00",X"63",X"73",X"7B",X"7F",X"6F",X"67",X"63",X"00",X"3E",X"63",X"63",X"63",X"63",X"63",X"3E",
		X"00",X"03",X"03",X"3F",X"63",X"63",X"63",X"3F",X"00",X"5E",X"33",X"7B",X"63",X"63",X"63",X"3E",
		X"00",X"73",X"3B",X"1F",X"73",X"63",X"63",X"3F",X"00",X"3E",X"63",X"60",X"3E",X"03",X"33",X"1E",
		X"00",X"18",X"18",X"18",X"18",X"18",X"18",X"7E",X"00",X"3E",X"63",X"63",X"63",X"63",X"63",X"63",
		X"00",X"08",X"1C",X"3E",X"77",X"63",X"63",X"63",X"00",X"63",X"77",X"7F",X"7F",X"6B",X"63",X"63",
		X"00",X"63",X"77",X"3E",X"1C",X"3C",X"77",X"63",X"00",X"18",X"18",X"18",X"3C",X"66",X"66",X"66",
		X"00",X"7F",X"07",X"0E",X"1C",X"38",X"70",X"7F",X"00",X"08",X"06",X"06",X"00",X"00",X"00",X"00",
		X"00",X"30",X"30",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"02",X"04",X"08",X"10",X"20",X"00",
		X"00",X"00",X"18",X"18",X"00",X"00",X"00",X"00",X"00",X"7E",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"18",X"0C",X"0C",X"0C",X"0C",X"0C",X"18",X"00",X"0C",X"18",X"18",X"18",X"18",X"18",X"0C",
		X"00",X"5E",X"46",X"46",X"CE",X"C6",X"C6",X"5E",X"00",X"3A",X"5B",X"5B",X"5B",X"5A",X"5A",X"3A",
		X"00",X"96",X"D6",X"D6",X"CE",X"D6",X"D6",X"CE",X"00",X"39",X"5A",X"5A",X"3A",X"5A",X"5A",X"3A",
		X"00",X"33",X"33",X"00",X"33",X"77",X"77",X"77",X"00",X"18",X"18",X"00",X"18",X"38",X"38",X"38",
		X"00",X"00",X"22",X"14",X"08",X"14",X"22",X"00",X"00",X"00",X"00",X"18",X"18",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"20",X"30",X"30",X"00",X"54",X"54",X"54",X"54",X"54",X"40",X"28",
		X"00",X"24",X"24",X"24",X"20",X"24",X"20",X"10",X"00",X"12",X"12",X"12",X"08",X"12",X"10",X"08",
		X"00",X"41",X"91",X"91",X"91",X"91",X"81",X"41",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"FC",X"FC",X"FC",X"FC",X"FC",X"FC",X"FC",X"FC",X"EF",X"EF",X"FF",X"FF",X"EF",X"EF",X"FF",X"BC",
		X"FB",X"FB",X"FB",X"FF",X"EF",X"FB",X"FF",X"EF",X"0E",X"1F",X"37",X"37",X"37",X"37",X"3F",X"1E",
		X"00",X"00",X"F0",X"80",X"D8",X"A0",X"F8",X"E0",X"00",X"00",X"01",X"01",X"02",X"00",X"03",X"01",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"24",X"00",X"42",X"00",X"24",X"00",X"18",X"24",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"00",X"7C",X"0C",X"0C",X"0C",X"0C",X"0C",X"0C",X"00",X"8E",X"93",X"93",X"93",X"93",X"93",X"93",
		X"00",X"F1",X"99",X"99",X"D9",X"19",X"19",X"F1",X"00",X"0C",X"0C",X"0C",X"0C",X"0C",X"0C",X"0C",
		X"00",X"00",X"F0",X"80",X"D8",X"A0",X"F8",X"E0",X"00",X"00",X"01",X"01",X"02",X"00",X"03",X"01",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"D3",X"D3",X"D3",X"8F",X"00",X"FE",X"FE",X"00",X"AA",X"AA",X"AA",X"A9",X"00",X"7F",X"7F",X"00",
		X"00",X"FE",X"FE",X"00",X"81",X"C1",X"CF",X"D3",X"24",X"00",X"42",X"00",X"24",X"00",X"18",X"24",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"00",X"63",X"63",X"7F",X"63",X"63",X"36",X"1C",X"00",X"3F",X"63",X"63",X"3F",X"63",X"63",X"3F",
		X"00",X"3C",X"66",X"03",X"03",X"03",X"66",X"3C",X"00",X"1F",X"33",X"63",X"63",X"63",X"33",X"1F",
		X"00",X"7F",X"03",X"03",X"3F",X"03",X"03",X"7F",X"00",X"03",X"03",X"03",X"3F",X"03",X"03",X"7F",
		X"00",X"7C",X"66",X"63",X"73",X"03",X"06",X"7C",X"00",X"63",X"63",X"63",X"7F",X"63",X"63",X"63",
		X"00",X"7E",X"18",X"18",X"18",X"18",X"18",X"7E",X"00",X"3E",X"63",X"63",X"60",X"60",X"60",X"60",
		X"00",X"73",X"3B",X"1F",X"0F",X"1B",X"33",X"63",X"00",X"7E",X"06",X"06",X"06",X"06",X"06",X"06",
		X"00",X"63",X"63",X"6B",X"7F",X"7F",X"77",X"63",X"00",X"63",X"73",X"7B",X"7F",X"6F",X"67",X"63",
		X"00",X"3E",X"63",X"63",X"63",X"63",X"63",X"3E",X"00",X"03",X"03",X"3F",X"63",X"63",X"63",X"3F",
		X"00",X"5E",X"33",X"7B",X"63",X"63",X"63",X"3E",X"00",X"73",X"3B",X"1F",X"73",X"63",X"63",X"3F",
		X"00",X"3E",X"63",X"60",X"3E",X"03",X"33",X"1E",X"00",X"18",X"18",X"18",X"18",X"18",X"18",X"7E",
		X"00",X"3E",X"63",X"63",X"63",X"63",X"63",X"63",X"00",X"08",X"1C",X"3E",X"77",X"63",X"63",X"63",
		X"00",X"63",X"77",X"7F",X"7F",X"6B",X"63",X"63",X"00",X"63",X"77",X"3E",X"1C",X"3C",X"77",X"63",
		X"00",X"18",X"18",X"18",X"3C",X"66",X"66",X"66",X"00",X"7F",X"07",X"0E",X"1C",X"38",X"70",X"7F",
		X"00",X"33",X"33",X"00",X"33",X"77",X"77",X"77",X"00",X"00",X"06",X"06",X"00",X"00",X"00",X"00",
		X"F8",X"FC",X"FC",X"FC",X"FC",X"FC",X"FC",X"F8",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"1F",X"3F",X"3F",X"3F",X"3F",X"3F",X"3F",X"1F",
		X"FC",X"06",X"03",X"01",X"FF",X"FF",X"FE",X"FC",X"FF",X"00",X"00",X"00",X"FF",X"FF",X"FF",X"FF",
		X"3F",X"60",X"C0",X"80",X"FF",X"FF",X"7F",X"3F",X"FF",X"00",X"00",X"3C",X"3C",X"3C",X"7E",X"FF",
		X"FF",X"00",X"00",X"3C",X"3C",X"3C",X"7E",X"FF",X"FF",X"00",X"00",X"3C",X"3C",X"3C",X"7E",X"FF",
		X"00",X"00",X"08",X"0E",X"00",X"00",X"80",X"E0",X"2C",X"6C",X"6C",X"EC",X"1C",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"18",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"78",X"F0",X"C0",X"F0",X"F8",X"FC",X"FB",X"B7",X"7F",X"67",X"4E",X"4E",X"04",X"00",X"00",
		X"00",X"00",X"08",X"0E",X"00",X"00",X"80",X"E0",X"2C",X"6C",X"6C",X"EC",X"1C",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"18",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"02",X"02",X"66",X"77",X"FF",X"FF",X"FF",X"FE",X"20",X"22",X"66",X"76",X"7F",X"FF",X"FF",X"FF",
		X"40",X"40",X"66",X"EE",X"FF",X"FF",X"FF",X"7F",X"7F",X"01",X"03",X"07",X"0F",X"1F",X"3F",X"7F",
		X"7F",X"01",X"03",X"07",X"0F",X"1F",X"3F",X"7F",X"7F",X"01",X"03",X"07",X"0F",X"1F",X"3F",X"7F",
		X"FC",X"06",X"03",X"01",X"FF",X"FF",X"FE",X"FC",X"FF",X"00",X"00",X"00",X"FF",X"FF",X"FF",X"FF",
		X"3F",X"60",X"C0",X"80",X"FF",X"FF",X"7F",X"3F",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"7C",X"3F",X"F3",X"BD",X"FF",X"FF",X"C7",X"01",
		X"00",X"18",X"18",X"18",X"3C",X"66",X"66",X"66",X"00",X"3E",X"63",X"63",X"63",X"63",X"63",X"3E",
		X"00",X"3E",X"63",X"63",X"63",X"63",X"63",X"63",X"00",X"1F",X"33",X"63",X"63",X"63",X"33",X"1F",
		X"00",X"7E",X"18",X"18",X"18",X"18",X"18",X"7E",X"00",X"18",X"18",X"18",X"18",X"18",X"18",X"7E",
		X"00",X"73",X"3B",X"1F",X"0F",X"1B",X"33",X"63",X"00",X"7F",X"03",X"03",X"3F",X"03",X"03",X"7F",
		X"00",X"03",X"03",X"3F",X"63",X"63",X"63",X"3F",X"00",X"7C",X"66",X"63",X"73",X"03",X"06",X"7C",
		X"00",X"63",X"73",X"7B",X"7F",X"6F",X"67",X"63",X"00",X"3E",X"63",X"60",X"3E",X"03",X"33",X"1E",
		X"00",X"63",X"63",X"63",X"7F",X"63",X"63",X"63",X"00",X"00",X"06",X"06",X"00",X"00",X"00",X"00",
		X"00",X"33",X"33",X"00",X"33",X"77",X"77",X"77",X"00",X"18",X"18",X"00",X"18",X"38",X"38",X"38",
		X"FC",X"06",X"03",X"01",X"FF",X"FF",X"FE",X"FC",X"FF",X"00",X"00",X"00",X"FF",X"FF",X"FF",X"FF",
		X"3F",X"60",X"C0",X"80",X"FF",X"FF",X"7F",X"3F",X"00",X"00",X"77",X"77",X"77",X"77",X"77",X"77",
		X"00",X"00",X"77",X"77",X"77",X"77",X"77",X"77",X"00",X"00",X"77",X"77",X"77",X"77",X"77",X"77",
		X"00",X"03",X"03",X"3F",X"63",X"63",X"63",X"3F",X"00",X"7F",X"03",X"03",X"3F",X"03",X"03",X"7F",
		X"00",X"73",X"3B",X"1F",X"73",X"63",X"63",X"3F",X"00",X"03",X"03",X"03",X"3F",X"03",X"03",X"7F",
		X"00",X"3C",X"66",X"03",X"03",X"03",X"66",X"3C",X"00",X"18",X"18",X"18",X"18",X"18",X"18",X"7E",
		X"00",X"03",X"03",X"3F",X"63",X"63",X"63",X"3F",X"00",X"18",X"18",X"18",X"18",X"18",X"18",X"7E",
		X"00",X"3E",X"63",X"60",X"3E",X"03",X"33",X"1F",X"00",X"00",X"00",X"00",X"00",X"20",X"30",X"30",
		X"00",X"1C",X"26",X"63",X"63",X"63",X"32",X"1C",X"00",X"7E",X"18",X"18",X"18",X"18",X"1C",X"18",
		X"00",X"7F",X"07",X"1E",X"3C",X"70",X"63",X"3E",X"00",X"3E",X"63",X"60",X"3C",X"18",X"30",X"7E",
		X"00",X"30",X"30",X"7F",X"33",X"36",X"3C",X"38",X"00",X"3E",X"63",X"60",X"60",X"3F",X"03",X"3F",
		X"00",X"3E",X"63",X"63",X"3F",X"03",X"06",X"3C",X"00",X"0C",X"0C",X"0C",X"18",X"30",X"63",X"7F",
		X"00",X"3E",X"61",X"61",X"1E",X"27",X"23",X"1E",X"00",X"1E",X"30",X"60",X"7E",X"63",X"63",X"3E",
		X"00",X"03",X"03",X"03",X"3F",X"03",X"03",X"7F",X"00",X"63",X"63",X"7F",X"63",X"63",X"36",X"1C",
		X"00",X"3C",X"66",X"03",X"03",X"03",X"66",X"3C",X"00",X"7F",X"03",X"03",X"3F",X"03",X"03",X"7F",
		X"00",X"33",X"33",X"00",X"33",X"77",X"77",X"77",X"00",X"18",X"18",X"00",X"18",X"38",X"38",X"38",
		X"00",X"1C",X"26",X"63",X"63",X"63",X"32",X"1C",X"00",X"7E",X"18",X"18",X"18",X"18",X"1C",X"18",
		X"00",X"7F",X"07",X"1E",X"3C",X"70",X"63",X"3E",X"00",X"3E",X"63",X"60",X"3C",X"18",X"30",X"7E",
		X"00",X"30",X"30",X"7F",X"33",X"36",X"3C",X"38",X"00",X"3E",X"63",X"60",X"60",X"3F",X"03",X"3F",
		X"00",X"3E",X"63",X"63",X"3F",X"03",X"06",X"3C",X"00",X"0C",X"0C",X"0C",X"18",X"30",X"63",X"7F",
		X"00",X"3E",X"61",X"61",X"1E",X"27",X"23",X"1E",X"00",X"1E",X"30",X"60",X"7E",X"63",X"63",X"3E",
		X"00",X"00",X"00",X"00",X"00",X"24",X"36",X"36",X"00",X"00",X"00",X"00",X"3E",X"00",X"00",X"00",
		X"00",X"38",X"1C",X"0E",X"07",X"0E",X"1C",X"38",X"00",X"00",X"00",X"3E",X"00",X"00",X"3E",X"00",
		X"00",X"0E",X"1C",X"38",X"70",X"38",X"1C",X"0E",X"00",X"18",X"00",X"18",X"38",X"63",X"63",X"3E",
		X"00",X"6E",X"31",X"39",X"4E",X"14",X"14",X"08",X"00",X"63",X"63",X"7F",X"63",X"63",X"36",X"1C",
		X"00",X"3F",X"63",X"63",X"3F",X"63",X"63",X"3F",X"00",X"3C",X"66",X"03",X"03",X"03",X"66",X"3C",
		X"00",X"1F",X"33",X"63",X"63",X"63",X"33",X"1F",X"00",X"7F",X"03",X"03",X"3F",X"03",X"03",X"7F",
		X"00",X"03",X"03",X"03",X"3F",X"03",X"03",X"7F",X"00",X"7C",X"66",X"63",X"73",X"03",X"06",X"7C",
		X"00",X"63",X"63",X"63",X"7F",X"63",X"63",X"63",X"00",X"7E",X"18",X"18",X"18",X"18",X"18",X"7E",
		X"00",X"3E",X"63",X"63",X"60",X"60",X"60",X"60",X"00",X"73",X"3B",X"1F",X"0F",X"1B",X"33",X"63",
		X"00",X"7E",X"06",X"06",X"06",X"06",X"06",X"06",X"00",X"63",X"63",X"6B",X"7F",X"7F",X"77",X"63",
		X"00",X"63",X"73",X"7B",X"7F",X"6F",X"67",X"63",X"00",X"3E",X"63",X"63",X"63",X"63",X"63",X"3E",
		X"00",X"03",X"03",X"3F",X"63",X"63",X"63",X"3F",X"00",X"5E",X"33",X"7B",X"63",X"63",X"63",X"3E",
		X"00",X"73",X"3B",X"1F",X"73",X"63",X"63",X"3F",X"00",X"3E",X"63",X"60",X"3E",X"03",X"33",X"1E",
		X"00",X"18",X"18",X"18",X"18",X"18",X"18",X"7E",X"00",X"3E",X"63",X"63",X"63",X"63",X"63",X"63",
		X"00",X"08",X"1C",X"3E",X"77",X"63",X"63",X"63",X"00",X"63",X"77",X"7F",X"7F",X"6B",X"63",X"63",
		X"00",X"63",X"77",X"3E",X"1C",X"3C",X"77",X"63",X"00",X"18",X"18",X"18",X"3C",X"66",X"66",X"66",
		X"00",X"7F",X"07",X"0E",X"1C",X"38",X"70",X"7F",X"00",X"08",X"06",X"06",X"00",X"00",X"00",X"00",
		X"00",X"30",X"30",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"02",X"04",X"08",X"10",X"20",X"00",
		X"00",X"00",X"18",X"18",X"00",X"00",X"00",X"00",X"00",X"7E",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"18",X"0C",X"0C",X"0C",X"0C",X"0C",X"18",X"00",X"0C",X"18",X"18",X"18",X"18",X"18",X"0C",
		X"00",X"5E",X"46",X"46",X"CE",X"C6",X"C6",X"5E",X"00",X"3A",X"5B",X"5B",X"5B",X"5A",X"5A",X"3A",
		X"00",X"96",X"D6",X"D6",X"CE",X"D6",X"D6",X"CE",X"00",X"39",X"5A",X"5A",X"3A",X"5A",X"5A",X"3A",
		X"00",X"33",X"33",X"00",X"33",X"77",X"77",X"77",X"00",X"18",X"18",X"00",X"18",X"38",X"38",X"38",
		X"00",X"00",X"22",X"14",X"08",X"14",X"22",X"00",X"00",X"00",X"00",X"18",X"18",X"00",X"00",X"00",
		X"01",X"01",X"01",X"01",X"01",X"01",X"01",X"FF",X"80",X"80",X"80",X"80",X"80",X"80",X"80",X"FF",
		X"FF",X"80",X"80",X"80",X"80",X"80",X"80",X"80",X"FF",X"01",X"01",X"01",X"01",X"01",X"01",X"01",
		X"00",X"04",X"26",X"3C",X"66",X"3C",X"64",X"20",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"1C",X"26",X"63",X"63",X"63",X"32",X"1C",X"00",X"7E",X"18",X"18",X"18",X"18",X"1C",X"18",
		X"00",X"7F",X"07",X"1E",X"3C",X"70",X"63",X"3E",X"00",X"3E",X"63",X"60",X"3C",X"18",X"30",X"7E",
		X"00",X"30",X"30",X"7F",X"33",X"36",X"3C",X"38",X"00",X"3E",X"63",X"60",X"60",X"3F",X"03",X"3F",
		X"00",X"3E",X"63",X"63",X"3F",X"03",X"06",X"3C",X"00",X"0C",X"0C",X"0C",X"18",X"30",X"63",X"7F",
		X"00",X"3E",X"61",X"61",X"1E",X"27",X"23",X"1E",X"00",X"1E",X"30",X"60",X"7E",X"63",X"63",X"3E",
		X"00",X"00",X"00",X"00",X"00",X"24",X"36",X"36",X"00",X"00",X"00",X"00",X"3E",X"00",X"00",X"00",
		X"00",X"38",X"1C",X"0E",X"07",X"0E",X"1C",X"38",X"00",X"0E",X"1C",X"38",X"70",X"38",X"1C",X"0E",
		X"00",X"0E",X"1C",X"38",X"70",X"38",X"1C",X"0E",X"00",X"18",X"00",X"18",X"38",X"63",X"63",X"3E",
		X"00",X"6E",X"31",X"39",X"4E",X"14",X"14",X"08",X"00",X"63",X"63",X"7F",X"63",X"63",X"36",X"1C",
		X"00",X"3F",X"63",X"63",X"3F",X"63",X"63",X"3F",X"00",X"3C",X"66",X"03",X"03",X"03",X"66",X"3C",
		X"00",X"1F",X"33",X"63",X"63",X"63",X"33",X"1F",X"00",X"7F",X"03",X"03",X"3F",X"03",X"03",X"7F",
		X"00",X"03",X"03",X"03",X"3F",X"03",X"03",X"7F",X"00",X"7C",X"66",X"63",X"73",X"03",X"06",X"7C",
		X"00",X"63",X"63",X"63",X"7F",X"63",X"63",X"63",X"00",X"7E",X"18",X"18",X"18",X"18",X"18",X"7E",
		X"00",X"3E",X"63",X"63",X"60",X"60",X"60",X"60",X"00",X"73",X"3B",X"1F",X"0F",X"1B",X"33",X"63",
		X"00",X"7E",X"06",X"06",X"06",X"06",X"06",X"06",X"00",X"63",X"63",X"6B",X"7F",X"7F",X"77",X"63",
		X"00",X"63",X"73",X"7B",X"7F",X"6F",X"67",X"63",X"00",X"3E",X"63",X"63",X"63",X"63",X"63",X"3E",
		X"00",X"03",X"03",X"3F",X"63",X"63",X"63",X"3F",X"00",X"5E",X"33",X"7B",X"63",X"63",X"63",X"3E",
		X"00",X"73",X"3B",X"1F",X"73",X"63",X"63",X"3F",X"00",X"3E",X"63",X"60",X"3E",X"03",X"33",X"1E",
		X"00",X"18",X"18",X"18",X"18",X"18",X"18",X"7E",X"00",X"3E",X"63",X"63",X"63",X"63",X"63",X"63",
		X"00",X"08",X"1C",X"3E",X"77",X"63",X"63",X"63",X"00",X"63",X"77",X"7F",X"7F",X"6B",X"63",X"63",
		X"00",X"63",X"77",X"3E",X"1C",X"3C",X"77",X"63",X"00",X"18",X"18",X"18",X"3C",X"66",X"66",X"66",
		X"00",X"7F",X"07",X"0E",X"1C",X"38",X"70",X"7F",X"00",X"08",X"06",X"06",X"00",X"00",X"00",X"00",
		X"00",X"30",X"30",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"02",X"04",X"08",X"10",X"20",X"00",
		X"00",X"B6",X"B7",X"B7",X"B6",X"B6",X"06",X"36",X"00",X"7E",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"18",X"0C",X"0C",X"0C",X"0C",X"0C",X"18",X"00",X"0C",X"18",X"18",X"18",X"18",X"18",X"0C",
		X"00",X"5E",X"46",X"46",X"CE",X"C6",X"C6",X"5E",X"00",X"3A",X"5B",X"5B",X"5B",X"5A",X"5A",X"3A",
		X"00",X"96",X"D6",X"D6",X"CE",X"D6",X"D6",X"CE",X"00",X"39",X"5A",X"5A",X"3A",X"5A",X"5A",X"3A",
		X"00",X"33",X"33",X"00",X"33",X"77",X"77",X"77",X"00",X"18",X"18",X"00",X"18",X"38",X"38",X"38",
		X"00",X"00",X"22",X"14",X"08",X"14",X"22",X"00",X"00",X"00",X"00",X"18",X"18",X"00",X"00",X"00",
		X"01",X"01",X"01",X"01",X"01",X"01",X"01",X"FF",X"80",X"80",X"80",X"80",X"80",X"80",X"80",X"FF",
		X"FF",X"80",X"80",X"80",X"80",X"80",X"80",X"80",X"FF",X"01",X"01",X"01",X"01",X"01",X"01",X"01",
		X"00",X"04",X"26",X"3C",X"66",X"3C",X"64",X"20",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"1C",X"26",X"63",X"63",X"63",X"32",X"1C",X"00",X"7E",X"18",X"18",X"18",X"18",X"1C",X"18",
		X"00",X"7F",X"07",X"1E",X"3C",X"70",X"63",X"3E",X"00",X"3E",X"63",X"60",X"3C",X"18",X"30",X"7E",
		X"00",X"30",X"30",X"7F",X"33",X"36",X"3C",X"38",X"00",X"3E",X"63",X"60",X"60",X"3F",X"03",X"3F",
		X"00",X"3E",X"63",X"63",X"3F",X"03",X"06",X"3C",X"00",X"0C",X"0C",X"0C",X"18",X"30",X"63",X"7F",
		X"00",X"3E",X"61",X"61",X"1E",X"27",X"23",X"1E",X"00",X"1E",X"30",X"60",X"7E",X"63",X"63",X"3E",
		X"00",X"00",X"00",X"00",X"00",X"24",X"36",X"36",X"00",X"00",X"00",X"00",X"3E",X"00",X"00",X"00",
		X"00",X"3E",X"41",X"5D",X"45",X"5D",X"41",X"3E",X"00",X"F6",X"06",X"06",X"E6",X"36",X"37",X"E6",
		X"00",X"F1",X"9B",X"9B",X"F3",X"9B",X"9B",X"F1",X"00",X"78",X"CD",X"CD",X"60",X"C1",X"CC",X"78",
		X"3C",X"42",X"99",X"A5",X"85",X"99",X"42",X"3C",X"00",X"63",X"63",X"7F",X"63",X"63",X"36",X"1C",
		X"00",X"3F",X"63",X"63",X"3F",X"63",X"63",X"3F",X"00",X"3C",X"66",X"03",X"03",X"03",X"66",X"3C",
		X"00",X"1F",X"33",X"63",X"63",X"63",X"33",X"1F",X"00",X"7F",X"03",X"03",X"3F",X"03",X"03",X"7F",
		X"00",X"03",X"03",X"03",X"3F",X"03",X"03",X"7F",X"00",X"7C",X"66",X"63",X"73",X"03",X"06",X"7C",
		X"00",X"63",X"63",X"63",X"7F",X"63",X"63",X"63",X"00",X"7E",X"18",X"18",X"18",X"18",X"18",X"7E",
		X"00",X"3E",X"63",X"63",X"60",X"60",X"60",X"60",X"00",X"73",X"3B",X"1F",X"0F",X"1B",X"33",X"63",
		X"00",X"7E",X"06",X"06",X"06",X"06",X"06",X"06",X"00",X"63",X"63",X"6B",X"7F",X"7F",X"77",X"63",
		X"00",X"63",X"73",X"7B",X"7F",X"6F",X"67",X"63",X"00",X"3E",X"63",X"63",X"63",X"63",X"63",X"3E",
		X"00",X"03",X"03",X"3F",X"63",X"63",X"63",X"3F",X"00",X"5E",X"33",X"7B",X"63",X"63",X"63",X"3E",
		X"00",X"73",X"3B",X"1F",X"73",X"63",X"63",X"3F",X"00",X"3E",X"63",X"60",X"3E",X"03",X"33",X"1E",
		X"00",X"18",X"18",X"18",X"18",X"18",X"18",X"7E",X"00",X"3E",X"63",X"63",X"63",X"63",X"63",X"63",
		X"00",X"08",X"1C",X"3E",X"77",X"63",X"63",X"63",X"00",X"63",X"77",X"7F",X"7F",X"6B",X"63",X"63",
		X"00",X"63",X"77",X"3E",X"1C",X"3C",X"77",X"63",X"00",X"18",X"18",X"18",X"3C",X"66",X"66",X"66",
		X"00",X"7F",X"07",X"0E",X"1C",X"38",X"70",X"7F",X"00",X"08",X"06",X"06",X"00",X"00",X"00",X"00",
		X"00",X"30",X"30",X"00",X"00",X"00",X"00",X"00",X"00",X"30",X"30",X"B0",X"B0",X"F0",X"70",X"30",
		X"00",X"B6",X"B7",X"B7",X"B6",X"B6",X"06",X"36",X"00",X"99",X"99",X"99",X"99",X"CF",X"80",X"00",
		X"00",X"F1",X"19",X"F9",X"99",X"F3",X"01",X"00",X"00",X"CD",X"CC",X"CD",X"CD",X"7C",X"00",X"00",
		X"00",X"7C",X"66",X"66",X"66",X"7C",X"60",X"60",X"00",X"1E",X"33",X"33",X"33",X"1E",X"00",X"00",
		X"00",X"3C",X"66",X"66",X"66",X"3C",X"00",X"00",X"00",X"86",X"86",X"86",X"86",X"8F",X"06",X"0C",
		X"00",X"D9",X"DF",X"DF",X"D9",X"D9",X"0F",X"06",X"00",X"9A",X"DA",X"DA",X"DA",X"8D",X"00",X"00",
		X"00",X"6F",X"60",X"EF",X"EC",X"67",X"00",X"00",X"00",X"00",X"00",X"18",X"18",X"00",X"00",X"00",
		X"00",X"98",X"D8",X"D8",X"DB",X"9B",X"00",X"18",X"00",X"C7",X"30",X"30",X"30",X"E7",X"00",X"00",
		X"00",X"C6",X"C7",X"C3",X"C3",X"C3",X"C0",X"C0",X"00",X"66",X"66",X"66",X"66",X"3E",X"00",X"00",
		X"00",X"5E",X"03",X"03",X"03",X"1E",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"1C",X"26",X"63",X"63",X"63",X"32",X"1C",X"00",X"7E",X"18",X"18",X"18",X"18",X"1C",X"18",
		X"00",X"7F",X"07",X"1E",X"3C",X"70",X"63",X"3E",X"00",X"3E",X"63",X"60",X"3C",X"18",X"30",X"7E",
		X"00",X"30",X"30",X"7F",X"33",X"36",X"3C",X"38",X"00",X"3E",X"63",X"60",X"60",X"3F",X"03",X"3F",
		X"00",X"3E",X"63",X"63",X"3F",X"03",X"06",X"3C",X"00",X"0C",X"0C",X"0C",X"18",X"30",X"63",X"7F",
		X"00",X"3E",X"61",X"61",X"1E",X"27",X"23",X"1E",X"00",X"1E",X"30",X"60",X"7E",X"63",X"63",X"3E",
		X"00",X"33",X"33",X"00",X"33",X"77",X"77",X"77",X"00",X"00",X"00",X"00",X"3E",X"00",X"00",X"00",
		X"00",X"38",X"1C",X"0E",X"07",X"0E",X"1C",X"38",X"00",X"00",X"00",X"3E",X"00",X"00",X"3E",X"00",
		X"00",X"0E",X"1C",X"38",X"70",X"38",X"1C",X"0E",X"00",X"18",X"00",X"18",X"38",X"63",X"63",X"3E",
		X"3C",X"42",X"99",X"A5",X"85",X"99",X"42",X"3C",X"00",X"63",X"63",X"7F",X"63",X"63",X"36",X"1C",
		X"00",X"3F",X"63",X"63",X"3F",X"63",X"63",X"3F",X"00",X"3C",X"66",X"03",X"03",X"03",X"66",X"3C",
		X"00",X"1F",X"33",X"63",X"63",X"63",X"33",X"1F",X"00",X"7F",X"03",X"03",X"3F",X"03",X"03",X"7F",
		X"00",X"03",X"03",X"03",X"3F",X"03",X"03",X"7F",X"00",X"7C",X"66",X"63",X"73",X"03",X"06",X"7C",
		X"00",X"63",X"63",X"63",X"7F",X"63",X"63",X"63",X"00",X"7E",X"18",X"18",X"18",X"18",X"18",X"7E",
		X"00",X"3E",X"63",X"63",X"60",X"60",X"60",X"60",X"00",X"73",X"3B",X"1F",X"0F",X"1B",X"33",X"63",
		X"00",X"7E",X"06",X"06",X"06",X"06",X"06",X"06",X"00",X"63",X"63",X"6B",X"7F",X"7F",X"77",X"63",
		X"00",X"63",X"73",X"7B",X"7F",X"6F",X"67",X"63",X"00",X"3E",X"63",X"63",X"63",X"63",X"63",X"3E",
		X"00",X"03",X"03",X"3F",X"63",X"63",X"63",X"3F",X"00",X"5E",X"33",X"7B",X"63",X"63",X"63",X"3E",
		X"00",X"73",X"3B",X"1F",X"73",X"63",X"63",X"3F",X"00",X"3E",X"63",X"60",X"3E",X"03",X"33",X"1E",
		X"00",X"18",X"18",X"18",X"18",X"18",X"18",X"7E",X"00",X"3E",X"63",X"63",X"63",X"63",X"63",X"63",
		X"00",X"08",X"1C",X"3E",X"77",X"63",X"63",X"63",X"00",X"63",X"77",X"7F",X"7F",X"6B",X"63",X"63",
		X"00",X"63",X"77",X"3E",X"1C",X"3C",X"77",X"63",X"00",X"18",X"18",X"18",X"3C",X"66",X"66",X"66",
		X"00",X"7F",X"07",X"0E",X"1C",X"38",X"70",X"7F",X"00",X"08",X"06",X"06",X"00",X"00",X"00",X"00",
		X"00",X"30",X"30",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"02",X"04",X"08",X"10",X"20",X"00",
		X"00",X"00",X"18",X"18",X"00",X"00",X"00",X"00",X"00",X"7E",X"00",X"00",X"00",X"00",X"00",X"00",
		X"00",X"18",X"0C",X"0C",X"0C",X"0C",X"0C",X"18",X"00",X"0C",X"18",X"18",X"18",X"18",X"18",X"0C",
		X"00",X"5E",X"46",X"46",X"CE",X"C6",X"C6",X"5E",X"00",X"3A",X"5B",X"5B",X"5B",X"5A",X"5A",X"3A",
		X"00",X"96",X"D6",X"D6",X"CE",X"D6",X"D6",X"CE",X"00",X"39",X"5A",X"5A",X"3A",X"5A",X"5A",X"3A",
		X"00",X"33",X"33",X"00",X"33",X"77",X"77",X"77",X"00",X"00",X"00",X"00",X"00",X"20",X"30",X"30",
		X"00",X"00",X"00",X"00",X"00",X"02",X"06",X"06",X"00",X"00",X"00",X"18",X"18",X"00",X"00",X"00",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",
		X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"FF",X"00",X"00",X"00",X"00",X"00",X"00",X"00",X"00");
begin
process(clk)
begin
	if rising_edge(clk) then
		data <= rom_data(to_integer(unsigned(addr)));
	end if;
end process;
end architecture;