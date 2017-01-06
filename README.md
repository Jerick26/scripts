# utilities_scripts_command
##do_patch.sh
###description
a shell scription to patch batched where it is unavailable to use normal method patch, git patch.
###usage
step 1. make patch
$diff -u ta/query_server.ini ~/9-test/query_server.ini > ini.patch
step 2. execute patching
$./do_patch.sh ini.patch t?
