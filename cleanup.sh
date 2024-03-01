#! /bin/bash

#var to hold num of total moved files + initalization
total_files_moved=0

#var to hold num of total size of files moved
total_size=0

#array to track total num of files moved per case (per category)
declare -A files_moved_per_category
files_moved_per_category[images]=0
files_moved_per_category[documents]=0
files_moved_per_category[pdfs]=0
files_moved_per_category[executables]=0
files_moved_per_category[data]=0
files_moved_per_category[unknown]=0

#array to track total size moved per case (per category)
declare -A size_per_category
size_per_category[images]=0
size_per_category[documents]=0
size_per_category[pdfs]=0
size_per_category[executables]=0
size_per_category[data]=0
size_per_category[unknown]=0

#creating the directories if not already there ig 
for dir in images documents pdfs executables data unknown; do
    if [ ! -d "$dir" ]; then
        echo "Directory '$dir' does not exist. Creating directory..."
        mkdir "$dir"
    else
        echo "Directory '$dir' already exists. Skipping creation."
    fi
done 

echo "Moving files into their respective directories..."

#for loop w case statement where each case represents a category 
#moves them to where they should be (or where my code says lol who knows if it works i totally dont i hope it works pls god work u should work pls compile and run like asked )
for file in my_directory/*; do 

    #make sure not a directory file
    if [ ! -d "$file" ]; then

        #get file size RAH
        size=$(stat -c %s "file")

        # increment total size
        ((total_size += size))

        #checking if it has executable perms first 
        if [ -x "$file" ]; then
            # Check if the file has executable permission
            mv "$file" executables/
            ((files_moved_per_category[executables]++)) #increment file moved per cat
            ((size_per_category[executables] += size)) #increment size per cat
        else
    ((total_files_moved++)) #incrementing total files moved

    #case statement to help readability , each case = category
    #determines file type based on extension / perms
        case "$file" in 
            #images ... jpg jpeg png gif
            *.jpg|*.jpeg|*.png|*.gif)
                mv "$file" images/
                ((files_moved_per_category[images]++))
                ((size_per_category[images] += size))
                ;;

            #documents ...  txt, docx, doc, pages, key, pptx, ppt, odt, md
            *.txt|*.docx|*.doc|*.pages|*.key|*.pptx|*.ppt|*.odt|*.md)
                mv "$file" documents/
                ((files_moved_per_category[documents]++))
                ((size_per_category[documents] += size))
                ;;

            # pfds .. pdf
            *pdf)
                mv "$file" pdfs/
                ((files_moved_per_category[pdfs]++))
                ((size_per_category[pdfs]+= size))
                ;;

            #executables ... executable permission OR sh, exe
            *.sh|*.exe)
                mv "$file" executables/
                ((files_moved_per_category[executables]++))
                ((size_per_category[executables]+= size))
                ;;

            #data ... csv, xlsx, json
            *.csv|*.xlsx|*.json)
                mv "$file" data/
                ((files_moved_per_category[data]++))
                ((size_per_category[data] += size))
                ;;

            #unkown .. remaining files
            *)
                mv "$file" unknown/ 
                ((files_moved_per_category[unknown]++))
                ((size_per_category[unknown] += size))
                ;;
        esac
    fi
    fi



    
done

echo "File move complete. Total Files moved:    $total_files_moved"
echo "Total size of files moved:     $total_size bytes"

### avg file size
average=$((total_size / total_files_moved))
echo "Average file size for all files: $average bytes"

   
echo "** Breakdown per category **"

echo "**Images**"
echo "Total moved ${files_moved_per_category[images]}, total size ${size_per_category[images]}"
if [ "$total_files_moved" -ne 0 ]; then
    # Calculate average file size for images
    average_images=$((size_per_category[images] / files_moved_per_category[images]))
    echo "Average file size: $average_images bytes"
else
    echo "No files moved in the Images category."
fi


echo "**Documents**"
echo "Total moved: ${size_per_category[documents]}"
echo "Total size: ${size_per_category[documents]} bytes"
if [ "$total_files_moved" -ne 0 ]; then
    # Calculate average file size for images
    average_documents=$((size_per_category[documents] / files_moved_per_category[documents]))
    echo "Average file size: $average_documents bytes"
else
    echo "No files moved in the Documents category."
fi

echo "**PDFs**"
echo "Total moved: ${size_per_category[pdfs]}"
echo "Total size: ${size_per_category[pdfs]} bytes"

if [ "$total_files_moved" -ne 0 ]; then
    # Calculate average file size for images
    average_pdfs=$((size_per_category[pdfs] / files_moved_per_category[pdfs]))
    echo "Average file size: $average_pdfs bytes"
else
    echo "No files moved in the pdfs category."
fi

echo "**Executables**"
echo "Total moved: ${size_per_category[executables]}"
echo "Total size: ${size_per_category[executables]} bytes"
if [ "$total_files_moved" -ne 0 ]; then
    # Calculate average file size for images
    average_executables=$((size_per_category[executables] / files_moved_per_category[executables]))
    echo "Average file size: $average_executables bytes"
else
    echo "No files moved in the executables category."
fi

echo "**Data**"
echo "Total moved: ${size_per_category[data]}"
echo "Total size: ${size_per_category[data]} bytes"
if [ "$total_files_moved" -ne 0 ]; then
    # Calculate average file size for images
    average_data=$((size_per_category[data] / files_moved_per_category[data]))
    echo "Average file size: $average_data bytes"
else
    echo "No files moved in the data category."
fi

echo "**Unknown**"
echo "Total moved: ${size_per_category[unknown]}"
echo "Total size: ${size_per_category[unknown]} bytes"
if [ "$total_files_moved" -ne 0 ]; then
    # Calculate average file size for images
    average_unknown=$((size_per_category[unknown] / files_moved_per_category[unknown]))
    echo "Average file size: $average_unknown bytes"
else
    echo "No files moved in the unknown category."
fi
