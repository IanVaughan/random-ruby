#!/bin/bash

start=$1
end=$2

run() {
    #echo "Hash,XXX Count,Require Time,Ping Time,Prod Lines,Spec Lines,Spec Count,Spec Runtime,Spec End-to-End,Test doubles"
    #full_command="echo $hash,$xxx_count,$require_time,$ping_time,$prod_lines,$spec_lines,$spec_count,$spec_runtime,$spec_end_to_end,$test_doubles"
    echo "Hash,XXX Count,Prod Lines,Spec Lines,Test doubles"
    full_command="echo $hash,$xxx_count,$prod_lines,$spec_lines,$test_doubles"
    $(dirname $0)/run-command-on-git-revisions -v $start $end "$full_command"
}

# Get the hash
hash='`git log -1 --pretty=%h`'

# Count the XXXs (TODOs)
xxx_count='`grep -ri XXX --include="*.rb" . | wc -l`'

# The runtime as reported by the perf specs (don't exist for the first
# hundredish commits)
#require_time='`rspec perf/raptor_load_perf_spec.rb | grep RAPTOR_REQUIRE_RUNTIME | cut -d " " -f 2`'

# The runtime for 1000 'ping' requests as reported by the perf specs (don't
# exist for the first four hundredish commits)
#ping_time='`rspec perf/ping_perf_spec.rb | grep RAPTOR_PING_RUNTIME | cut -d " " -f 2`'

# Lines of code
prod_lines='`find lib -iname "*.rb" | xargs cat | wc -l`'
spec_lines='`find spec -iname "*.rb" | xargs cat | wc -l`'

# Spec runtime and count
# Look for a line with "examples" or "tests" because there's a mixture of
# minitest and rspec in the history.
#spec_count='`script/test | grep "examples\|tests" | cut -d " " -f 1`'
#spec_runtime='`script/test | grep "Finished in" | cut -d " " -f 3`'

# Spec end to end time
# We use `time`, which sends its output to stderr. We redirect stderr to stdout
# so we can slice it.
#spec_end_to_end='`(time -p script/test) 2>&1 1>/dev/null | grep real | cut -d " " -f 2`'

test_doubles='`grep -r --include="*.rb" "\<stub\|mock\|double\|should_receive\>" spec | wc -l`'

run

