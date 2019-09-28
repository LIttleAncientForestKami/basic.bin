#!/bin/bash
echo Diagram: -r asciidoctor-diagram $1 
echo 'Szablon: -T $ADOC_TMPLT_PATH' $1
echo 'RevealJS po nowemu:  asciidoctor-revealjs -a revealjsdir=https://cdnjs.cloudflare.com/ajax/libs/reveal.js/3.6.0 X.adoc'
echo Obrazki z netu: -a allow-uri-read $1
echo PDF asiidoctor-pdf [diagram] [read-uri] [szablon] $1
