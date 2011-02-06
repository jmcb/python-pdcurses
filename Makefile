PEXPORTS=pexports
PDCURSESDLL=pdcurses.dll
PDCURSESDEF=pdcurses.def
PDCURSESLIB=pdcurses.lib
SED=sed
DLLTOOL=dlltool
RM=rm
CP=cp
GEN_DIR=gen

pdcurses.def:
	$(PEXPORTS) $(PDCURSESDLL) | $(SED) -e "s/^_//g" > $(PDCURSESDEF)

pdcurses.lib: pdcurses.def
	$(DLLTOOL) --dllname $(PDCURSESDLL) --def $(PDCURSESDEF) --output-lib $(PDCURSESLIB)

clean:
	$(RM) -f $(PDCURSESDEF) $(PDCURSESLIB)

gen: pdcurses.def pdcurses.lib
	$(CP) $(PDCURSESDEF) $(GEN_DIR)
	$(CP) $(PDCURSESLIB) $(GEN_DIR)
