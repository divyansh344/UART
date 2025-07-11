# Verilog Based Universal Asynchronous Receiver Transmitter (UART)

## Author
**Divyansh Tripathi**

## 📌 Features of UART

- UART is a hardware communication protocol used for short-distance asynchronous serial communication between devices.
- It transmits and receives data one bit at a time (serially) over a single wire, without the need for a clock signal (asynchronous mode).
- Data transmission is framed with a start bit, data bits (5 - 9 bits), stop bits, and an optional parity bit, enabling reliable communication even without a shared clock.

## 🔧 UART consists of two main components

- **Transmitter (TX)** – Converts parallel data from the system into serial form for transmission.
- **Receiver (RX)** – Converts incoming serial data back into parallel form for the system.
- Commonly used for short-distance, low-speed, full-duplex serial communication between microcontrollers, sensors, GPS modules, Bluetooth devices, and PCs.

## 🛠️ Features of This Verilog UART Implementation

- Full duplex mode – The transmitter and receiver operate simultaneously in loopback form.
- Baud Rate: 9600 bps with a global clock of 1 MHz.
- Data frame format: 1 start bit (0), 8 data bits, 1 stop bit (1).
- A slower clock is generated from the global clock to match the Baud Rate.
- The slower clock determines when data bits should be captured.

## 🔌 Module Ports

- `clk` – Global clock for generating the slower clock.
- `start` – Marks the start of transmission.
- `tx_in` – 8-bit parallel input data for transmission.
- `tx` – Serial data output from the transmitter.
- `tx_done` – Indicates transmission completion.
- `rx` – Serial data input to the receiver.
- `rx_done` – Indicates reception completion.
- `rx_out` – 8-bit parallel output data from the receiver.

## 🚦 Transmitter (TX) State Description

1. **idle** – Default state, TX line high, waiting for start signal.
2. **send** – Serially sends start, data, and stop bits on slower clock edge.
3. **check** – Waits for the active clock edge before sending the next bit.

## 📥 Receiver (RX) State Description

1. **r_idle** – RX line is high; on detecting start bit (low), goes to `r_wait`.
2. **r_wait** – Waits for half-bit time for correct sampling, then transitions.
3. **receive** – Captures bits at the middle of each bit duration. Once the stop bit is received, `rx_done` is high and 8-bit data is output on `rx_out`.

## 🔁 Full-Duplex Operation

- In the testbench, the same signals are applied to `tx` and `rx` lines.
- Transmitter and Receiver operate simultaneously in loopback mode.

## 📊 How to View the Simulation Waveform

1. Save the `uart_gtkwave.gtkw` file.
2. Open GTKWave.
3. Click **File > Open New Tab**.
4. Select the saved `.gtkw` file.
5. Choose signals from the left panel to view the waveform.

## 📁 Files in This Repository

- `uart.v` – UART design module
- `testbench.v` – Verilog testbench
- `uart_gtkwave.gtkw` – GTKWave file for waveform view
- `Simulation_images/` – Folder with simulation screenshots

---

**Thanks for checking out the project!**  
Feedback and contributions are welcome.
