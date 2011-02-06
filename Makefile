PEXPORTS=pexports
PDCURSESDLL=pdcurses.dll
PDCURSESDEF=pdcurses.def
PDCURSESLIB=pdcurses.lib
PDCURSESW32DLL=pdcurses-win32a.dll
PDCURSESW32DEF=pdcurses-win32a.def
PDCURSESW32LIB=pdcurses-win32a.lib
SED=sed
DLLTOOL=dlltool
RM=rm
CP=cp
GEN_DIR=gen

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

gen: pdcurses.def pdcurses.lib pdcurses-win32a.def pdcurses-win32a.lib
	$(CP) $(PDCURSESDEF) $(GEN_DIR)
	$(CP) $(PDCURSESLIB) $(GEN_DIR)
	$(CP) $(PDCURSESW32DEF) $(GEN_DIR)
	$(CP) $(PDCURSESW32LIB) $(GEN_DIR)

