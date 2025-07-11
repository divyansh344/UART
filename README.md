# Verilog Based Universal Asynchronous Receiver Transmitter (UART)
<br>
<br>
## Author - Divyansh Tripathi
<br>
<br>
## Features of UART:-
<br>
<br>
> UART is a hardware communication protocol used for short distance asynchronous serial communication between devices.
<br>
<br>
> It transmits and receives data one bit at a time (serially) over a single wire, without the need for a clock signal (asynchronous mode).
<br>
<br>
> Data transmission is framed with start bit, data bits (5 - 9 bits), stop bits and optional parity bit, enabling reliable communication even without a shared clock.
<br>
<br>
## UART typically consists of two main components:
<br>
<br>
> Transmitter (TX) - Converts parallel data from the system into serial form for transmission.
<br>
<br>
+ Receiver (RX) - Converts incoming serial data back into parallel form for the system.
<br>
<br>
> Commonly used for short-distance, low-speed, full-duplex serial communication between microcontrollers, sensors, GPS modules, Bluetooth devices, and PCs.
<br>
<br>
## I have implemented a Verilog based UART with the following features:
<br>
<br>
> full duplex mode - The transmitter is sending the serial data to the receiver and the receiver is receiving the  same serial data at the same time (in a loopback form) 
<br>
<br>
> The UART is being operated on a Baud Rate of 9600 bits per second with a global clock of frequency 1 MHz.
<br>
<br>
> The Baud Rate determines the speed of data transmission which includes the data bits as well as start and stop bits.
<br>
<br>
> The data frame consits of a start bit (0), 8 data bits and a stop bit (1).
<br>
<br>
> A slower clock is generated based on the desired Baud Rate with the help of the global clock. The slower clock determines when the data bits have to be captured by the uart. 
<br>
<br>
## The following ports are present in the module:
<br>
<br>
1> clk - global clock for generating the slower clock.
<br>
<br>
2> start - to mark the start of transmission operation.
<br>
<br>
3> tx_in - to receive 8 bit parallel data for the transmission operation.
<br>
<br>
4> tx - to output the serial data frame of the Transmitter consisting of start , data and stop bits.
<br>
<br>
5> tx_done - to mark the completion of transmission operation once stop bit is received.
<br>
<br>
6> rx - to receive serial data frame for the receiver consisting of start, data and stop bits.
<br>
<br>
7> rx_done - to mark completion of receiving operation once stop bit is received.
<br>
<br>
8> rx_out - to send 8 bit serial data received  into paralle form to the system.
<br>
<br>
## The Transmitter (TX) operation is described by the following states:
<br>
<br>
1> idle - TX is in idle state in which no transmission operation is being performed. The start signal is low and the tx line is kept at high level. as soon as start signal is high the start bit (0) is received by the line and it marks the transition to the next state - send.
<br>
<br>
2> send - the line receives the start bit and then the transmitter enters into check state to wait for the active clock edge of the slower clock and once the active edge arrives the transmitter again enters into send state to capture the subsequent bits. once the stop bit is received the tx_done signal is high and transmitter again enters into idle state.
<br>
<br>
3> check - in this state the transmitter waits for the active clock edge of slower clock to arrive (bit_done = 1 marks the arrival of active clock edge) and then it transitions to send state.
<br>
<br>
## The Receiver operation is described by the following states:
<br>
<br>
1> r_idle - this is same as of transmitter . the rx line is kept at high level in r_idle state and soon as the start bit is received ( rx line becoming low) the receiver enters into r_wait state.
<br>
<br>
2> r_wait - in this state the receiver waits for the subsequent bits to arrive based on slower clock . clk_count value determines the middle of bit duration so in order to capture the start of bit_duration the receiver waits for clk_count / 2 periods. once the start of bit duration arrives the receivers intp receive state.
<br>
<br>
3> receive - in this state the receiver waits for the middle of bit duration to arrive (bit_done = 1). then it stores the data bit into a 10 bit ( which includes start, stop and 8 data bits) right shift serial in parallel out register. once the data bit is captured it again moves into r_wait state and the operation continues till the stop bit is received and once the stop bit is received the rx_done signal is high,  rx_out receives the 8 bit parallel data.  The receiver again enters into r_idle state.
<br>
<br>
## In the testbench same signals are applied to tx and rx pins due to which the transmitter and receiver are working simultaneously (full-duplex mode) in a loopback form. 
<br>
<br>
## To view the simulation waveform follow these steps:-
<br>
<br>
> save the uart_gtkwave.gtkw file
<br>
<br>
> Open gtkwave.
<br>
<br>
> click on File > Open New Tab.
<br>
<br>
> open the saved file 
<br>
<br>
> select the ports to view the waveforms.
<br>
<br>
## Files present in the repository:-
<br>
<br>
> uart.v - dut module
<br>
<br>
> testbench.v - testbench module to generate the signals for the inputs.
<br>
<br>
> uart_gtkwave.gtkw - gtkwave file to see the waveforms.
<br>
<br>
> Simulation_images - screenshot of simulation images.
<br>
<br>
Thanks for checking out the project! Any feedback or Contributions are welcome.





