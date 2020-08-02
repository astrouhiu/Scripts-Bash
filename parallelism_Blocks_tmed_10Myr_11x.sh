#!/bin/bash

# Coloque esse script na pasta principal das saidas de uma corrida. Origina blocos de dados com tempo medio de cada 10 Myr e associados a ele 11x pontos para cada tp (se existirem), no formato: id a e inc capom obar lamb.

SECONDS=0

func(){

	for ((i=$1; i<$2; i=i+100))
	do

		rm -f arquivo_$((($i+100)/100))

		tmed=${tempo[$i+5]}
		text1=${tempo[$i]}
		text2=${tempo[$i+10]}	
 
		awk -v key="$tmed" '$1==key {print $8, $2, $3, $4, $5, $6, $7}' $arquivo1 > $3

		for ((j=1; j<=$ndir; j++))
		do

			arquivo2=dir$j/particles.out

			awk -v key="$text1" -v key2="$text2" -v j="$j" '$2<=key2 && $2>=key {x=substr($1,2)+(j-1)*100; print "p"x, $3, $4, $5, $6, $7, $8}' $arquivo2 >> $4

		done

		cat $3 $4 > arquivo_$((($i+100)/100))
		rm -f $4

	done

	rm -f $3

}

arquivo1=planet.out
tempo=($(awk '{ print $1}' $arquivo1 | uniq))
ndir=100

# i: indice em tempo[i] em multiplos de 100
# $1		$2		$3		$4
# $i_ini	i_final 	arquivo_tempPL	arquivo_tempPA

func 0 11300 tempPL1 tempPA1 &
func 11300 22600 tempPL2 tempPA2 &
func 22600 33900 tempPL3 tempPA3 &
func 33900 45000 tempPL4 tempPA4 &

wait

echo "total time: $SECONDS seconds"
echo "Done! =D"
