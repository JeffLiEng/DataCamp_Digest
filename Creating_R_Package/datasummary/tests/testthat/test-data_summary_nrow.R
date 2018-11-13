# Create a summary of the iris dataset using your data_summary() function
iris_summary <- data_summary(iris)

# Count how many rows are returned
summary_rows <- nrow(iris_summary) 

# Use expect_equal to test that calling data_summary() on iris returns 4 rows
expect_equal(summary_rows, 4)