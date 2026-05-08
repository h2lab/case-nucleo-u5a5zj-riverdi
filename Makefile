OPENSCAD ?= openscad

SCAD_COMMON := parameters.scad case_parts.scad

STL_TARGETS := base.stl lid.stl light_pipe_petg.stl

.PHONY: all clean

all: $(STL_TARGETS)

base.stl: export_base.scad $(SCAD_COMMON)
	$(OPENSCAD) -o $@ $<

lid.stl: export_lid.scad $(SCAD_COMMON)
	$(OPENSCAD) -o $@ $<

light_pipe_petg.stl: export_light_pipe.scad $(SCAD_COMMON)
	$(OPENSCAD) -o $@ $<

clean:
	rm -f $(STL_TARGETS)
