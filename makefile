
PRJ = "EN001-002_MODULO-PSU"
VER = 1.1
REL = "release-${VER}"



all: fabrication

release: release-dir release-notes schematic manufacturing bom

fabrication: release-dir release-notes schematic manufacturing gerber drill bom

schematic:
	echo "\n## SHEMATIC (PDF)\n" >> ./${REL}/release_notes.md
	
	kicad-cli sch export pdf -o ${REL}/${PRJ}_V${VER}_SCH.pdf \
	-D Revision=1.2 --no-background-color \
	${PRJ}.kicad_sch >> ./${REL}/release_notes.md 

gerber:
	echo "\n## GERBERS \n" >> ./${REL}/release_notes.md

	kicad-cli pcb export gerbers -o ./${REL}/fabrication/gerber/ \
	-l F.Cu,B.Cu,F.Paste,B.Paste,F.Silkscreen,B.Silkscreen,F.Mask,B.Mask,Edge.Cuts \
	--no-x2	--no-netlist --exclude-value --precision 6 \
	${PRJ}.kicad_pcb >> ./${REL}/release_notes.md

drill:
	echo "\n## DRILL holes \n" >> ./${REL}/release_notes.md

	kicad-cli pcb export drill -o ./${REL}/fabrication/gerber/ \
	--drill-origin absolute --gerber-precision 6 \
	--format excellon --excellon-oval-format alternate --excellon-zeros-format decimal --excellon-units mm --excellon-separate-th  \
	--generate-map --map-format gerberx2 \
	${PRJ}.kicad_pcb >> ./${REL}/release_notes.md

bom:
	echo "\n## Bill of Materials (CVS)\n" >> ./${REL}/release_notes.md

	kicad-cli sch export bom -o ${REL}/fabrication/${PRJ}_V${VER}_BOM.csv \
	--group-by Value --fields 'Reference,Value,Case,MNFR-1,MNFR-1-PN,SUPP-1,SUPP-1-CODE,SUPP-1-UNIT-PRICE ,$${QUANTITY},$${DNP}' \
	${PRJ}.kicad_sch >> ./${REL}/release_notes.md 



manufacturing:
	echo "\n## Manufacturing Instructions \n" >> ./${REL}/release_notes.md

	kicad-cli pcb export pdf -o ${REL}/fabrication/${PRJ}_V${VER}_MNF.pdf \
	-l F.Fab \
	--include-border-title --exclude-value ${PRJ}.kicad_pcb >> ./${REL}/release_notes.md

3d-models:	
	echo "\n## 3D Model (STEP) \n" >> ./${REL}/release_notes.md
	
	kicad-cli pcb export step -o ${REL}/${PRJ}_V${VER}_3DMODEL.step  \
	--grid-origin --no-unspecified --subst-models --include-tracks --include-zones \
	${PRJ}.kicad_pcb >> ./${REL}/release_notes.md

release-notes:
	touch ./${REL}/release_notes.md
	echo "# ${PRJ} Release V${VER} \n" 	> ./${REL}/release_notes.md
	echo "Kicad Version: " 	>> ./${REL}/release_notes.md
	kicad-cli version >> ./${REL}/release_notes.md	
	echo " \n\n" >> ./${REL}/release_notes.md

release-dir:
	mkdir -p ${REL}
	mkdir -p ${REL}/fabrication
	mkdir -p ${REL}/fabrication/gerber	
	mkdir -p ${REL}/fabrication/assembly
	mkdir -p ${REL}/sources

clean:
	rm -r ${REL}
