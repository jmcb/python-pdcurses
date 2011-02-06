PEXPORTS=pexports
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
GEN_DIR=gen
BUILD=build
PDCURSES_BUILD=$(PDCURSES_DIR)/build
PDCURSESW32_BUILD=$(PDCURSESW32_DIR)/build

pdcurses.def:
	$(PEXPORTS) $(PDCURSESDLL) | $(SED) -e "s/^_//g" > $(PDCURSESDEF)

pdcurses.lib: pdcurses.def
	$(DLLTOOL) --dllname $(PDCURSESDLL) --def $(PDCURSESDEF) --output-lib $(PDCURSESLIB)

pdcurses-win32a.def:
	$(PEXPORTS) $(PDCURSESW32DLL) | $(SED) -e "s/^_//g" > $(PDCURSESW32DEF)

pdcurses-win32a.lib:
	$(DLLTOOL) --dllname $(PDCURSESW32DLL) --def $(PDCURSESW32DEF) --output-lib $(PDCURSESW32LIB)

clean:
	$(RM) -f $(PDCURSESDEF) $(PDCURSESLIB)
	$(RM) -f $(PDCURSESW32DEF) $(PDCURSESW32LIB)
	$(RM) -rf $(BUILD) $(PDCURSES_BUILD) $(PDCURSESW32_BUILD)

gen: pdcurses.def pdcurses.lib pdcurses-win32a.def pdcurses-win32a.lib
	$(CP) $(PDCURSESDEF) $(GEN_DIR)
	$(CP) $(PDCURSESLIB) $(GEN_DIR)
	$(CP) $(PDCURSESW32DEF) $(GEN_DIR)
	$(CP) $(PDCURSESW32LIB) $(GEN_DIR)

