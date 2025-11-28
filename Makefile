# TeXバイナリの場所（必要に応じて上書き可能）
TEXBIN ?= /Library/TeX/texbin
LATEXMK ?= $(TEXBIN)/latexmk
DVIPDFMX ?= $(TEXBIN)/dvipdfmx
DVIPDFMX_OPTS ?=
LATEXMK_OPTS ?=

# PDFを生成（デフォルトで両方）
all: bachelor master

# 卒論PDF
bachelor: bachelor_sample.pdf

# 修論PDF
master: master_sample.pdf

# upLaTeX + dvipdfmx（latexmkにPDF生成まで任せる）
bachelor_sample.pdf: bachelor_sample.tex cdl_thesis.sty
	$(LATEXMK) -pdfdvi -gg -f bachelor_sample.tex
	# 環境によっては2回目の変換で日本語埋め込みが安定するため再実行
	$(DVIPDFMX) $(DVIPDFMX_OPTS) -o bachelor_sample.pdf bachelor_sample.dvi

master_sample.pdf: master_sample.tex cdl_thesis.sty
	$(LATEXMK) -pdfdvi -gg -f master_sample.tex
	# 環境によっては2回目の変換で日本語埋め込みが安定するため再実行
	$(DVIPDFMX) $(DVIPDFMX_OPTS) -o master_sample.pdf master_sample.dvi

.PHONY: watch-bachelor watch-master

# 保存のたびに自動再ビルド（PDFビューアは各自で開いておく）
watch-bachelor:
	$(LATEXMK) -pdfdvi -pvc -f $(LATEXMK_OPTS) bachelor_sample.tex

watch-master:
	$(LATEXMK) -pdfdvi -pvc -f $(LATEXMK_OPTS) master_sample.tex
.PHONY: clean distclean

# 中間生成物を削除
clean:
	$(LATEXMK) -C bachelor_sample.tex || true
	$(LATEXMK) -C master_sample.tex || true
	rm -f bachelor_sample.pdf master_sample.pdf

# dvi等も含め、より徹底的に削除
distclean: clean
	rm -f *.dvi *.synctex.gz *.toc *.aux *.log *.fls *.fdb_latexmk


