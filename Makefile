PEXPORTS=pexports
PDCURSESDLL=pdcurses.dll
PDCURSESDEF=pdcurses.def
PDCURSESLIB=pdcurses.lib
SED=sed
DLLTOOL=dlltool
RM=rm

pdcurses.def:
	$(PEXPORTS) $(PDCURSESDLL) | $(SED) -e "s/^_//g" > $(PDCURSESDEF)

pdcurses.lib: pdcurses.def
	$(DLLTOOL) --dllname $(PDCURSESDLL) --def $(PDCURSESDEF) --output-lib $(PDCURSESLIB)

clean:
	$(RM) -f $(PDCURSESDEF) $(PDCURSESLIB)
