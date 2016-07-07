#!/bin/bash

# If the output folder is changed to the project's "res" folder, consider that drawable folders will be overwritten. 
SOURCE_FOLDER=source
OUTPUT_FOLDER=output

# Output for Normal DPI (Inkscape 90dpi) 
OUTPUT_DPI_NAME[0]="mdpi"
OUTPUT_DPI_VALUE[0]=90

# Output for HDPI 
OUTPUT_DPI_NAME[1]="hdpi"
OUTPUT_DPI_VALUE[1]=135

# Output for XHDPI 
OUTPUT_DPI_NAME[2]="xhdpi"
OUTPUT_DPI_VALUE[2]=180

# Output for XXHDPI 
OUTPUT_DPI_NAME[3]="xxhdpi"
OUTPUT_DPI_VALUE[3]=270

# Output for XXXHDPI 
OUTPUT_DPI_NAME[4]="xxxhdpi"
OUTPUT_DPI_VALUE[4]=360


notify-send "BUILDING RESOURCES"

for dir in ${SOURCE_FOLDER}/*/
do
    dir=$(basename "$dir")
    source="${SOURCE_FOLDER}/${dir}"
    for (( i = 0 ; i < ${#OUTPUT_DPI_NAME[@]} ; i++ ))
    do
	folder="${dir}-${OUTPUT_DPI_NAME[$i]}"
	output="${OUTPUT_FOLDER}/${folder}"
	# Delete the folder and its content#
	rm ${output} -R -f
	# Recreate the empty folder 
    	mkdir ${output} 
        for fullfile in ${source}/*.svg 
        do
            filename=$(basename "$fullfile")
            filename="${filename%.*}"
            inkscape "$fullfile" --export-png "${output}/${filename}.png" -d  "${OUTPUT_DPI_VALUE[$i]}"
        done
    done
done

notify-send "DONE BUILDING RESOURCES :-)"

