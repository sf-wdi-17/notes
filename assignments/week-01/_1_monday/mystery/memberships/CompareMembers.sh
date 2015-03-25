# A shortcut method using comm to compare what's in a bunch of different files and find the intersections

readArr() {
	OIFS="$IFS"; # Set the current env delimeter to OIFS
	IFS=$'\n'; # Now set IFS to newline
	array=($(<$1)); # Slurp the file indicated by the argument into the array
	IFS="$OIFS"; # Reset IFS back to normal
	printf "%s\n" "${array[@]}"; # Now print out the array with each element on one line using printf
}

comm -1 -2 <(readArr Terminal_City_Library | LC_ALL=C sort) <(comm -1 -2 <(readArr Delta_SkyMiles | LC_ALL=C sort) <(comm -1 -2 <(readArr AAA | LC_ALL=C sort) <(readArr Museum_of_Bash_History | LC_ALL=C sort)))






# A different approach:
# index=0
# members=()
# while read aaa
# do
# 	while read delta
# 	do
# 		if [[ "$aaa" == "$delta" ]]; then
# 			# echo "Found within both files: $aaa"
# 			members[$index]="$aaa"
# 			index=$((index+1))
# 		fi
# 	done <$2	
# done <$1

# echo "The names in the array are:"
# printf "%s\n" "${members[@]}"

# echo "The current index is: $index"

# echo "The number of items in the array is: ${#members[*]}"

# ----------
# Yet another approach:
# indextwo=0
# memberstwo=()
# for e in ${members[@]}
# do
# 	while read museum
# 	do
# 		if [[ "e" == "$museum" ]]; then
# 			echo "A name in both files also in Museum File: $museum"
# 			memberstwo[$indextwo]="$e"
# 			indextwo=$((indextwo+1))
# 		fi
# 	done <Museum_of_Bash_History
# done

# echo "The names in the array after 3 files read are:"
# echo ${memberstwo[@]}

# echo "The number of items in the array is: ${#memberstwo[*]}"



