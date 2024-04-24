-- uart_fsm.vhd: UART controller - finite state machine
-- Author(s): xmacakt00
--
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-------------------------------------------------
ENTITY UART_FSM IS
   PORT (
    RST : IN STD_LOGIC;
    CLK : IN STD_LOGIC;
    CLK2: IN STD_LOGIC;
    DIN : IN STD_LOGIC;
    A : OUT STD_LOGIC;
    B : OUT STD_LOGIC;
    C : OUT STD_LOGIC;
    T8: OUT STD_LOGIC;
    T12: OUT STD_LOGIC
   );
END ENTITY UART_FSM;

-------------------------------------------------
ARCHITECTURE behavioral OF UART_FSM IS
   TYPE FSM_STATE IS (IDLE, DELAY, START, AT, AF, BT, BF, CT, CF, DT, DF, ET, EF,FF,FT GT, GF, HT, HF, OUTT, OUTF);
   SIGNAL actual_state : FSM_STATE := IDLE;
   SIGNAL next_state : FSM_STATE := IDLE;
BEGIN

   actual_state_process : PROCESS (RST, CLK, next_state)
   BEGIN
      IF RST = '1' THEN
         actual_state <= IDLE;
      ELSIF rising_edge(CLK) THEN
         actual_state <= next_state;
      END IF;
   END PROCESS actual_state_process;

   next_state_process : PROCESS (RST, CLK)
   BEGIN
      CASE actual_state IS

        WHEN IDLE =>
            A <= '0';
            B <= '0';
            C <= '0';
            T8 <= '0';
            T12 <= '0';
        IF CLK2='1' AND DIN='0' THEN
            next_state <= delay
        END IF;

        WHEN DELAY=>
        A <= '0';
        B <= '0';
        C <= '0';
        T8 <= '1';
        T12 <= '0';
        IF CLK2='1' THEN
            next_state <= start
        END IF;

        WHEN START=>
        A <= '0';
        B <= '0';
        C <= '0';
        T8 <= '0';
        T12 <= '1';
        IF CLK2='1' AND DIN='0' THEN
            next_state <= AF
        END IF;
        IF CLK2='1' AND DIN='1' THEN
            next_state <= AT
        END IF;            


        
WHEN AT=>
  A <= '1';
B <= '1';
C <= '0';
T8 <= '0';
T12 <= '1';
IF CLK2=1 AND DIN=0 THEN
next_state <= BF;
END IF;
IF CLK2=1 AND DIN=1 THEN
next_state <= BT;
END IF;


WHEN AF=>
A <= '0';
B <= '1';
C <= '0';
T8 <= '0';
T12 <= '1';
IF CLK2=1 AND DIN=0 THEN
next_state <= BF;
END IF;
IF CLK2=1 AND DIN=1 THEN
next_state <= BT;
END IF;


WHEN BT=>
  A <= '1';
B <= '1';
C <= '0';
T8 <= '0';
T12 <= '1';
IF CLK2=1 AND DIN=0 THEN
next_state <= CF;
END IF;
IF CLK2=1 AND DIN=1 THEN
next_state <= CT;
END IF;


WHEN BF=>
A <= '0';
B <= '1';
C <= '0';
T8 <= '0';
T12 <= '1';
IF CLK2=1 AND DIN=0 THEN
next_state <= CF;
END IF;
IF CLK2=1 AND DIN=1 THEN
next_state <= CT;
END IF;


WHEN CT=>
  A <= '1';
B <= '1';
C <= '0';
T8 <= '0';
T12 <= '1';
IF CLK2=1 AND DIN=0 THEN
next_state <= DF;
END IF;
IF CLK2=1 AND DIN=1 THEN
next_state <= DT;
END IF;


WHEN CF=>
A <= '0';
B <= '1';
C <= '0';
T8 <= '0';
T12 <= '1';
IF CLK2=1 AND DIN=0 THEN
next_state <= DF;
END IF;
IF CLK2=1 AND DIN=1 THEN
next_state <= DT;
END IF;


WHEN DT=>
  A <= '1';
B <= '1';
C <= '0';
T8 <= '0';
T12 <= '1';
IF CLK2=1 AND DIN=0 THEN
next_state <= EF;
END IF;
IF CLK2=1 AND DIN=1 THEN
next_state <= ET;
END IF;


WHEN DF=>
A <= '0';
B <= '1';
C <= '0';
T8 <= '0';
T12 <= '1';
IF CLK2=1 AND DIN=0 THEN
next_state <= EF;
END IF;
IF CLK2=1 AND DIN=1 THEN
next_state <= ET;
END IF;


WHEN ET=>
  A <= '1';
B <= '1';
C <= '0';
T8 <= '0';
T12 <= '1';
IF CLK2=1 AND DIN=0 THEN
next_state <= FF;
END IF;
IF CLK2=1 AND DIN=1 THEN
next_state <= FT;
END IF;


WHEN EF=>
A <= '0';
B <= '1';
C <= '0';
T8 <= '0';
T12 <= '1';
IF CLK2=1 AND DIN=0 THEN
next_state <= FF;
END IF;
IF CLK2=1 AND DIN=1 THEN
next_state <= FT;
END IF;


WHEN FT=>
  A <= '1';
B <= '1';
C <= '0';
T8 <= '0';
T12 <= '1';
IF CLK2=1 AND DIN=0 THEN
next_state <= GF;
END IF;
IF CLK2=1 AND DIN=1 THEN
next_state <= GT;
END IF;


WHEN FF=>
A <= '0';
B <= '1';
C <= '0';
T8 <= '0';
T12 <= '1';
IF CLK2=1 AND DIN=0 THEN
next_state <= GF;
END IF;
IF CLK2=1 AND DIN=1 THEN
next_state <= GT;
END IF;


WHEN GT=>
  A <= '1';
B <= '1';
C <= '0';
T8 <= '0';
T12 <= '1';
IF CLK2=1 AND DIN=0 THEN
next_state <= HF;
END IF;
IF CLK2=1 AND DIN=1 THEN
next_state <= HT;
END IF;


WHEN GF=>
A <= '0';
B <= '1';
C <= '0';
T8 <= '0';
T12 <= '1';
IF CLK2=1 AND DIN=0 THEN
next_state <= HF;
END IF;
IF CLK2=1 AND DIN=1 THEN
next_state <= HT;
END IF;


WHEN HT=>
  A <= '1';
B <= '1';
C <= '0';
T8 <= '0';
T12 <= '1';
IF CLK2=1 AND DIN=0 THEN
next_state <= OUTF;
END IF;
IF CLK2=1 AND DIN=1 THEN
next_state <= OUTT;
END IF;


WHEN HF=>
A <= '0';
B <= '1';
C <= '0';
T8 <= '0';
T12 <= '1';
IF CLK2=1 AND DIN=0 THEN
next_state <= OUTF;
END IF;
IF CLK2=1 AND DIN=1 THEN
next_state <= OUTT;
END IF;

WHEN OUTT=>
A <= '0';
B <= '0';
C <= '1';
T8 <= '0';
T12 <= '0';
IF CLK2=1 THEN
next_state <= IDLE;
END IF;


WHEN OUTF=>
A <= '0';
B <= '0';
C <= '0';
T8 <= '0';
T12 <= '0';
IF CLK2=1 AND DIN=1 THEN
next_state <= IDLE;
END IF;
END IF;
         
      END CASE;
   END PROCESS next_state_process;
END behavioral;
