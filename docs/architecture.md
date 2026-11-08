            # Architecture

            `gza-core` is one of the four parts of GZA, the GS Zigbee service:

            | Part | Repository | Base version |
            |---|---|---|
            | GZA service | grandeursmart-zigbee-automation | 2.14.3 |
            | GZA core — Zigbee radio layer | gza-core | 11.2.0 |
            | GZA device library | gza-core-libs | 26.125.0 |
            | GZA frontend | gza-frontend | 0.9.21 |

            On the gateway the package is loaded from the GZA overlay (`node_modules/gza-core`) inside the GZA container.
            - Talks to the gateway's Zigbee coordinator (Silicon Labs EZSP, adapter `ezsp`) over the serial port.
- Forms and keeps the Zigbee network, admits joining devices while joining is open, and interviews them.
- Sends and receives Zigbee cluster messages for the device library (`gza-core-libs`), and keeps the device
  database and network backup on the gateway.
