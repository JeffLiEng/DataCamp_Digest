result <- data_summary(weather)

# Update this test so it passes
expect_equal(result$sd, c(2.1, 3.6), tolerance = 0.10)

expected_result <- list(
  ID = c("Day", "Temp"),
  min = c(1L, 14L),
  median = c(4L, 19L),
  sd = c(2.16024689946929, 3.65148371670111),
  max = c(7L, 24L)
)

# Write a passing test that compares expected_result to result
expect_equivalent(result, expected_result)