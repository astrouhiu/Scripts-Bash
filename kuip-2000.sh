#!/bin/bash

# Coloque esse script na pasta principal das saidas para a corrida 2000-0.965. Essa corrida em cada subpasta contem dados dos planetas (planet.out) e das particulas para o tempo inicial (Px0-*) e para o tempo final (Px1-*). Esse script origina blocos de dados de planetas e particulas recursivamente, para o tempo inicial e tempo final, no formato: id a e inc capom obar lamb. Para um mesmo tempo consideramos os dados dos planetas de diferentes diretorios pois a evolucao e diferente. So se considera os diri com i = 1, 2, ..., 25.

SECONDS=0

func(){

        for ((i=$1; i<$2; i=i+1))
        do

                rm -f arquivo_$(($i+1))

                for ((j=1; j<=$ndir; j++))
                do

       		arquivo1=dir$j/planet.out
	
			if (($i==0)); then
				
				t=0.000000E+00
	                       arquivo2=dir$j/Px0-$((j+50))

			else

				t=0.450000E+10
				arquivo2=dir$j/Px1-$((j+50))

			fi

			awk -v key="$t" '$1==key {print $8, $2, $3, $4, $5, $6, $7}' $arquivo1 >> arquivo_$(($i+1))
                       awk '{print $1, $3, $4, $5, $6, $7, $8}' $arquivo2 >> arquivo_$(($i+1))

		done

	done

}

ndir=25

# i: indice em tempo[i] 
# $1     $2      
# i_ini  i_final 

func 0 2 &

wait

echo "total time: $SECONDS seconds"
echo "Done! =D"
