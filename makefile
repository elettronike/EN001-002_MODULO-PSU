
VER = 1.1
REL = "release-${VER}"
PRJ = "EN001-002_MODULO-PSU"


all: production
	touch ./${REL}/readme.md

	# 
	kicad-cli sch export pdf -o ${REL}/${PRJ}_V${VER}.pdf -D Revision=1.2 --no-background-color ${PRJ}.kicad_sch


production: release-dir
	mkdir -p ${REL}/production


release-dir:
	mkdir -p ${REL}
		
clean:
	rm -r ${REL}
