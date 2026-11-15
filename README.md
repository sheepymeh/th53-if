# th53-if

Reverse-engineered interface notes for the TUL TH53, only supplementary information is provided here

Refer to [this repo](https://github.com/Cafe3D-RL/release/releases) for more information,
particularly the [XDC files](https://github.com/Cafe3D-RL/release/releases/tag/th5x_series_XDC_V1.3)
and the [voltage setting instructions](https://github.com/Cafe3D-RL/release/releases/tag/adjusting_voltage).

Also see [this repo](https://github.com/Dracnea/UltrascalePlusVoltageControl/blob/main/docs/th5x.md)
for voltage setting.

## Visually Identified Components

| Board reference | Part | Function | Remarks |
| --- | --- | --- | --- |
| J4 | 2x Everflow T128015BU | Cooling fans | Daisy-chained 4-pin JST-PH |
| Q23 | MMST3906 | PNP transistor | |
| U14 | Atmel AT24C04C | I2C EEPROM | |
| U16 | Texas Instruments PCA9536DGKR | I2C GPIO expander | |
| U2 | NXP PCA9517A | Likely SMBus repeater | Connected to PCIe B5/B6 |
| U20 | Texas Instruments TMP432A | Temperature sensor | Expected at `0x4c`, but does not respond on FPGA PMBus bridge |
| U24 | Renesas/Intersil ISL68124 | Digital regulator with PMBus | Reachable at `0x60` through FPGA pins `L12` (SCL) and `L13` (SDA) |
| U34, U68 | NXP PCA9517A | I2C repeater | |
| U49 | FTDI FT4232HQ Rev C | USB/JTAG bridge | Channel A is JTAG, channel-B probes do not reach management devices |
| U60 | Si5332E Rev D, `D11286` | Clock generator | May contain custom NVM configuration |
| Y2 | 48 MHz crystal | Clock | |
| Y4 | 12 MHz crystal | Likely U49 reference clock | |
| SW3 | 8-way DIP switch | Hardware voltage selector | Read at startup, set 4 OR 7 and 8 ON for standard 0.85V |

## Findings

- Complete JTAG chain not mapped yet
- CFGMCLK bootstrap and SysMon access available via JTAG
- PCIe supported (Gen 1 x1 tested): site X1Y0, Q227 physical channel 3
  (`GTYE4_CHANNEL_X1Y15`) and MGTREFCLK0 (`AB9/AB8`), RX `AL2/AL1`, TX `Y5/Y4`
- Q226 MGTREFCLK0 showed inconsistent ~156-182 MHz frequency
- Q224 MGTREFCLK1 showed low, inconsistent activity
- `E10/E11` and `A14/B14` do not provide a confirmed I2C bus
- Public-pin UART reads returned no bytes
- GPIO inputs read `0b0011`

---

The project is not affiliated with TUL, Sparkle, AMD, or Xilinx
