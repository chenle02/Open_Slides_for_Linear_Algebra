#use Texlive 2015
export PATH := /usr/local/texlive/2015/bin/x86_64-linux:$(PATH)

PDF=pdflatex
HANDOUTTAG:=\[pdf,handout\]
PRESENTTAIONTAG:=\[pdf\]
HANDOUTFILE:=Handout.pdf
PRESENTATIONFILE:=Presentation.pdf

# Intermediate and target files that Latex will output
suffixes := .dvi .out .log .toc .aux .snm .nav

# Presentation and the Handout
pdf:
	for testfile in S*.tex; \
	do \
	echo $$testfile ;\
	file=`basename $$testfile .tex`;\
	echo $$file ;\
	sed -i 's/$(HANDOUTTAG)/$(PRESENTTAIONTAG)/' $$testfile ;\
	$(PDF) $$file; \
	$(PDF) $$file; \
	mv $$file.pdf $$file-$(PRESENTATIONFILE); \
	sed -i 's/$(PRESENTTAIONTAG)/$(HANDOUTTAG)/' $$testfile ;\
	$(PDF) $$file; \
	$(PDF) $$file; \
	mv $$file.pdf $$file-$(HANDOUTFILE); \
	done


.PHONY: clean
clean:
	rm -f *.dvi *.out *.log *.toc *.aux *.snm *.nav
	@echo "done"
