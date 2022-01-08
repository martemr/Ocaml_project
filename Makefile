
build:
	@echo "\n==== COMPILING ====\n"
	ocamlbuild ftest.native

format:
	ocp-indent --inplace src/*

edit:
	code . -n

demo: build
	@echo "\n==== EXECUTING ====\n"
	./ftest.native graphs/graph1.txt 1 2 outfile
	@echo "\n==== RESULT ==== (content of outfile) \n"
	@cat outfile

clean:
	-rm -rf _build/
	-rm ftest.native

test:
	@echo "\n==== CLEANING ====\n"
	-rm -rf _build/
	-rm ftest.native
	@echo "\n==== COMPILING ====\n"
	ocamlbuild ftest.native
	@echo "\n==== TEST ====\n"
	./ftest.native graphs/graph1.txt 0 5 outfile
	@echo "\n==== CREATION DU GRAPH ==== \n"
	dot -Tsvg outfile > output-graph.svg


money:
	@echo "\n==== CLEANING ====\n"
	-rm -rf _build/
	-rm moneySharing.native
	@echo "\n==== COMPILING ====\n"
	ocamlbuild moneySharing.native
	@echo "\n==== TEST ====\n"
	./moneySharing.native data.txt 0 1000 outfile
	@echo "\n==== CREATION DU GRAPH ==== \n"
	dot -Tsvg outfile > output-graph.svg