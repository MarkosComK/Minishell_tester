#!/bin/bash

# Path to your minishell executable
MINISHELL=../minishell

# Directory where expected outputs are stored
EXPECTED_DIR=expected_outputs

# Directory where actual outputs will be stored
ACTUAL_DIR=actual_outputs

# Create directories for outputs
mkdir -p $ACTUAL_DIR

# Test status tracking
passed_tests=0
failed_tests=0

# Function to run a single test
run_test() {
	test_name=$1
	input_file="inputs/${test_name}.txt"
	expected_output_file="${EXPECTED_DIR}/${test_name}.txt"
	actual_output_file="${ACTUAL_DIR}/${test_name}.txt"

	# Run the command in minishell and capture output
	$MINISHELL < $input_file > $actual_output_file

	# Compare actual output to expected output
	if diff $expected_output_file $actual_output_file; then
		echo "[PASS] Test '$test_name'"
		passed_tests=$((passed_tests+1))
	else
		echo "[FAIL] Test '$test_name'"
		failed_tests=$((failed_tests+1))
	fi
}

# Test cases
tests=("syntax" "basic_commands")

# Run each test
for test in "${tests[@]}"; do
	run_test $test
done

# Summary
echo "=========================="
echo "Passed tests: $passed_tests"
echo "Failed tests: $failed_tests"
echo "=========================="

if [ $failed_tests -eq 0 ]; then
	exit 0
else
	exit 1
fi

