proc read_from_file {argv} {
	set filename [lindex $argv 0]
	set f [open $filename]
	set line [read $f]
	return $line
}
proc quad_solver {arguments} {
	set a [lindex $arguments 0]
	set b [lindex $arguments 1]
	set c [lindex $arguments 2]
	set d [expr {$b*$b - 4.*$a*$c}]
	if {$d < 0} {
		set fileId [open "output.txt" "w"]
		puts -nonewline $fileId	 "Discriminant is a not valid"
	} else {
		set d [expr sqrt($d)]
	}
	if {$b < 0} {
		set s [expr {-$b + $d}]
	} else {
		set s [expr {-$b - $d}]
	}
	set r0 [expr {$s / (2. * $a)}]
	set r1 [expr {(2. * $c) / $s}]
	return [list $r0 $r1]
}

proc initialize_value {argv} {
	set expression [read_from_file $argv ]
	set wordList [regexp -inline -all -- {\S+} $expression]
	set y {}
	foreach x $wordList {
		lappend y $x
	}
	return $y
}

proc test_result {argv} {
	set fp [open "golden.txt" r]
	set golden_result [read $fp]
	close $fp
	set list_of_arguments [initialize_value $argv]
	set result [quad_solver $list_of_arguments]
	if {$result == $golden_result} {
		set fileId [open "output.txt" "w"]
		puts -nonewline $fileId "Test passed \n"
	} else {
		set fileId [open "output.txt" "w"]
		puts -nonewline $fileId "Test Failed\n "
	}
}

proc main {argv} {
	test_result $argv
}

main $argv
