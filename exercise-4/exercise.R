# Exercise 4: practicing with dplyr

# Install the `nycflights13` package. Load (`library()`) the package.
# You'll also need to load `dplyr`


# The data frame `flights` should now be accessible to you.
# Use functions to inspect it: how many rows and columns does it have?
# What are the names of the columns?
# Use `??flights` to search for documentation on the data set (for what the 
# columns represent)
library('dplyr')
install.packages("nycflights13")
library(nycflights13)
??flights
View(flights)
# Use `dplyr` to give the data frame a new column that is the amount of time
# gained or lost while flying (that is: how much of the delay arriving occured
# during flight, as opposed to before departing).
flights <- mutate(flights, time_lost_or_gained = arr_delay - dep_delay)
View(flights)
# Use `dplyr` to sort your data frame in descending order by the column you just
# created. Remember to save this as a variable (or in the same one!)
flights <- arrange(flights, -time_lost_or_gained)
View(flights)
# For practice, repeat the last 2 steps in a single statement using the pipe
# operator. You can clear your environmental variables to "reset" the data frame
flights <- mutate(flights, time_lost_or_gained = arr_delay - dep_delay) %>% arrange(flights, -time_lost_or_gained)

# Make a histogram of the amount of time gained using the `hist()` function
hist(flights$time_lost_or_gained)

# On average, did flights gain or lose time?
# Note: use the `na.rm = TRUE` argument to remove NA values from your aggregation
mean(flights$time_lost_or_gained, na.rm = TRUE)

# Create a data.frame of flights headed to SeaTac ('SEA'), only including the
# origin, destination, and the "gain_in_air" column you just created
dest_sea <- flights %>% select(origin, dest, time_lost_or_gained) %>% filter(dest == 'SEA')
View(dest_sea)
# On average, did flights to SeaTac gain or loose time?


# Consider flights from JFK to SEA. What was the average, min, and max air time
# of those flights? Bonus: use pipes to answer this question in one statement
# (without showing any other data)!
summary <- flights %>% filter(origin == "JFK", dest == "SEA") %>%
  summarise(
    avg_time = mean(time_lost_or_gained, na.rm =T),
    min_time = min(time_lost_or_gained, na.rm =T),
    max_time = max(time_lost_or_gained, na.rm =T)
    )
summary

