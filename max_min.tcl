proc max_min args {
   suppress_message UID-101
	suppress_message UID-101
	##########################
        # Get the user argument
	set comm_arg0 [lindex $args 0]
	set comm_arg1 [lindex $args 1]
	###########################       

 	set cells 0
	set path_no 1
	set all_paths [get_timing_paths -nworst 10 -path_type full -slack_lesser_than 10]
	echo [format "%10s %10s %10s %12s" "Path No" "Start" "End" "Slack"]
       	echo "-------------------------------------------------------------"
	foreach_in_collection path $all_paths {
		###################################
                # Slack time of paths
                
		#puts " Path : $path_no"
		set slack [get_attribute $path  slack]
		#puts " Slack: $slack"
		set start [get_attribute $path startpoint]
		set end [get_attribute $path endpoint]
		
		#puts " startpoint : $start endpoint: $end "
                set crpoint [get_attribute $path  crpr_common_point]
		#puts " CrPoint: $crpoint"
		echo [format "%10s %10s %10s %12s" $path_no $start $end $slack]
		incr path_no
		echo " "
		echo " "
	}
		##########################
		# Point info
	set path_no 1
	foreach_in_collection path $all_paths {
		puts " Path No : $path_no"
		echo [format "%10s %10s " "Object" "Arrival"]
		echo "-------------------------------------------------------------"
        	set all_point [get_attribute $path points]
		#puts "path_no:$path_no"
		foreach_in_collection point $all_point {
			set object [get_attribute $point object]
			set arrival [get_attribute $point arrival]
			#echo " "
			#puts "$object"
			echo [format "%10s %10s" $object $arrival]
		}
		incr path_no
		###########################
	}

	# Give all the cells and nets timing in the worst path
	if {[string match -path* $comm_arg0]} {
		set path [expr $comm_arg1 *1]
		#echo [format "%10s paths specified" $path]
		report_timing -nets -nworst $path
	}
	
	#array set count_cell {}
	#set all_cells [get_cells -hierarchical *]
	#foreach_in_collection cell $all_cells {
	#	set cell_name [get_attribute $cell full_name]
	#	set count_cell($cell_name) 1
		
		
	#}
	#foreach {name_cell count} [array get count_cell] {
	#puts "Cell_name : $name_cell count: $count"
	#}
}

#Define my arguments
define_proc_attributes max_min \
   -info "This script gives the max and min timing" \
   -define_args {
    }
