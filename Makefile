PEXPORTS=pexports
ifeq ($(shell which $(PEXPORTS) > /dev/null 2> /dev/null && echo Yes),)
PEXPORTS_AVAILABLE=Yes
endif
PDCURSES_DIR=pdcurses
PDCURSESW32_DIR=pdcurses-win32a
PDCURSESDLL=$(PDCURSES_DIR)/pdcurses.dll
PDCURSESDEF=$(PDCURSES_DIR)/pdcurses.def
PDCURSESLIB=$(PDCURSES_DIR)/pdcurses.lib
PDCURSESW32DLL=$(PDCURSESW32_DIR)/pdcurses.dll
PDCURSESW32DEF=$(PDCURSESW32_DIR)/pdcurses.def
PDCURSESW32LIB=$(PDCURSESW32_DIR)/pdcurses.lib
SED=sed
DLLTOOL=dlltool
RM=rm
CP=cp
MKDIR=mkdir
GEN_DIR=gen
BUILD=build
PDCURSES_BUILD=$(PDCURSES_DIR)/build
PDCURSESW32_BUILD=$(PDCURSESW32_DIR)/build
DIST=dist
PDCURSES_DIST=$(PDCURSES_DIR)/dist
PDCURSESW32_DIST=$(PDCURSESW32_DIR)/dist
SETUP_TEMPLATE=setup.py_template
MANIFEST=MANIFEST.in

all: dirs gen setups gen-source

all-pd-only: dirs gen-pd-only pdcurses-setup.py gen-source-pd-only
all-w32-only: dirs gen-w32-only pdcurses-win32a-setup.py gen-source-w32-only

dirs: $(PDCURSESW32_DIR) $(PDCURSES_DIR)

$(PDCURSESW32_DIR):
	$(MKDIR) $(PDCURSEW32_DIR)

$(PDCURSES_DIR):
	$(MKDIR) $(PDCURSE_DIR)

$(PDCURSESDEF): use-gen-pd-only
ifdef PEXPORTS_AVAILABLE
	$(PEXPORTS) $(PDCURSESDLL) | $(SED) -e "s/^_//g" > $(PDCURSESDEF)
endif

$(PDCURSESLIB): $(PDCURSESDEF)
	$(DLLTOOL) --dllname $(PDCURSESDLL) --def $(PDCURSESDEF) --output-lib $(PDCURSESLIB)

$(PDCURSESW32DEF): use-gen-w32-only
ifdef PEXPORTS_AVAILABLE
	$(PEXPORTS) $(PDCURSESW32DLL) | $(SED) -e "s/^_//g" > $(PDCURSESW32DEF)
endif

$(PDCURSESW32LIB): $(PDCURSESW32DEF)
	$(DLLTOOL) --dllname $(PDCURSESW32DLL) --def $(PDCURSESW32DEF) --output-lib $(PDCURSESW32LIB)

pdcurses-setup.py: $(PDCURSES_DIR)
	$(SED) -e s/PDCURSES_FLAV// $(SETUP_TEMPLATE) > $(PDCURSES_DIR)/setup.py

pdcurses-win32a-setup.py: $(PDCURSESW32_DIR)
	$(SED) -e s/PDCURSES_FLAV/-win32a/ $(SETUP_TEMPLATE) > $(PDCURSESW32_DIR)/setup.py

gen-setups.py: pdcurses-setup.py pdcurses-win32a-setup.py
	$(CP) $(PDCURSESW32_DIR)/setup.py $(GEN_DIR)/setup-win32a.py
	$(CP) $(PDCURSES_DIR)/setup.py $(GEN_DIR)/setup.py

setups: pdcurses-setup.py pdcurses-win32a-setup.py

defs: $(PDCURSESDEF) $(PDCURSESW32DEF)

libs: $(PDCURSESLIB) $(PDCURSESW32LIB)

gen: defs libs

gen-pd-only: $(PDCURSESLIB) $(PDCURSESDEF)

gen-w32-only: $(PDCURSESW32LIB) $(PDCURSESW32LIB)

gen-source: gen-source-w32-only gen-source-pd-only

gen-source-w32-only:
	$(CP) *.h *.c $(MANIFEST) $(PDCURSESW32_DIR)

gen-source-pd-only:
	$(CP) *.h *.c $(MANIFEST) $(PDCURSES_DIR)

gen-save: defs libs
	$(CP) $(PDCURSESDEF) $(PDCURSESLIB) $(GEN_DIR)
	$(CP) $(PDCURSESW32DEF) $(GEN_DIR)/pdcurses-win32a.def
	$(CP) $(PDCURSESW32LIB) $(GEN_DIR)/pdcurses-win32a.lib

use-gen: use-gen-pd-only use-gen-w32-only

use-gen-pd-only:
	$(CP) $(GEN_DIR)/pdcurses.def $(PDCURSES_DIR)
	$(CP) $(GEN_DIR)/pdcurses.lib $(PDCURSES_DIR)

use-gen-w32-only:
	$(CP) $(GEN_DIR)/pdcurses-win32a.def $(PDCURSESW32_DIR)/pdcurses.def
	$(CP) $(GEN_DIR)/pdcurses-win32a.lib $(PDCURSESW32_DIR)/pdcurses.lib

clean:
	$(RM) -f $(PDCURSESDEF) $(PDCURSESLIB)
	$(RM) -f $(PDCURSESW32DEF) $(PDCURSESW32LIB)
	$(RM) -rf $(BUILD) $(PDCURSES_BUILD) $(PDCURSESW32_BUILD)
	$(RM) -rf $(DIST) $(PDCURSES_DIST) $(PDCURSESW32_DIST)
	$(RM) -f $(PDCURSESW32_DIR)/*.h $(PDCURSESW32_DIR)/*.c
	$(RM) -f $(PDCURSES_DIR)/*.h $(PDCURSES_DIR)/*.c
	$(RM) -f $(PDCURSESW32_DIR)/$(MANIFEST) $(PDCURSESW32_DIR)/MANIFEST
	$(RM) -f $(PDCURSES_DIR)/$(MANIFEST) $(PDCURSES_DIR)/MANIFEST
	$(RM) -f $(PDCURSES_DIR)/setup.py $(PDCURSESW32_DIR)/setup.py
