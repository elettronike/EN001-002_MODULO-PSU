# EN001-002_MODULO-PSU

"MODULO" series PSU board

## Design

Design considerations and references are reported in the [design file](./Design/design.md)

### EDA - Kicad specific

The project is developed using Kicad-8.4.

The component library is managed using the new

## Realease

Kikad production files are generated using the kicad [CLI interface](https://docs.kicad.org/8.0/en/cli/cli.html#introduction_to_the_kicad_command_line_interface).

the command `make` will generate the production file in the folder *release*:

| ID | Document                   | Format |
| :-: | :------------------------- | :----- |
| 1 | BOM with JLCPCB template   | CSV    |
| 2 | Gerber files               | IPCxxx |
| 3 | Drill Files                | .drl   |
| 4 | Schematic                  | PDF    |
| 5 | Manufacturing Instructions | PDF    |

## TODO

- [ ] Fix the variable override: `-D Revision=1.2`
- [ ] # Reference,Value,Case,MNFR-1,MNFR-1-PN,SUPP-1,SUPP-1-CODE,SUPP-1-UNIT-PRICE ,$${QUANTITY},$${DNP}
- [ ]
