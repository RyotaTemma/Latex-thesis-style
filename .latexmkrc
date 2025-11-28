$latex = 'uplatex -synctex=1 -interaction=nonstopmode -file-line-error %O %S';
$pdf_mode = 3;  # latexmk に DVI→PDF(dvipdfmx) まで任せる
$dvipdf = 'dvipdfmx -f haranoaji.map %O -o %D %S';


