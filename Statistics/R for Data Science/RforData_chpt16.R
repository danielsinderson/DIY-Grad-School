library(tidyverse)


x1 <- c("Dec", "Apr", "Jan", "Mar")
x2 <- c("Dec", "Apr", "Jam", "Mar")

month_levels <- c(
  "Jan", "Feb", "Mar", "Apr", "May", "Jun",
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
)

y1 <- factor(x1, levels = month_levels)
y1
sort(x1) # sorts alphabetically, because it's a list of strings
sort(y1) # sorts by level order (so temporally), because it's a list of factors

y2 <- factor(x2, levels = month_levels)
y2 # any entry that's not in the levels will be assigned NA

y3 <- fct(x2, levels = month_levels) # won't compute with entries not in levels
y3 # doesn't exist; got error instead


levels(y1) # print factor levels



gss_cat # general US social survey is built in!!
glimpse(gss_cat)
?gss_cat

gss_cat |>
  count(race)



relig_summary <- gss_cat |>
  group_by(relig) |>
  summarize(
    tvhours = mean(tvhours, na.rm = TRUE),
    n = n()
  )

ggplot(relig_summary, aes(x = tvhours, y = relig)) +
  geom_point()

ggplot(relig_summary, aes(x = tvhours, y = fct_reorder(relig, tvhours))) +
  geom_point()



rincome_summary <- gss_cat |>
  group_by(rincome) |>
  summarize(
    age = mean(age, na.rm = TRUE),
    n = n()
  )

ggplot(rincome_summary, aes(x = age, y = fct_relevel(rincome, "Not applicable"))) +
  geom_point()


# examine the proportion of marital status by age group
by_age <- gss_cat |>
  filter(!is.na(age)) |>
  count(age, marital) |>
  group_by(age) |>
  mutate(
    prop = n / sum(n)
  )

ggplot(by_age, aes(x = age, y = prop, color = marital)) +
  geom_line(linewidth = 1) +
  scale_color_brewer(palette = "Set1")

ggplot(by_age, aes(x = age, y = prop, color = fct_reorder2(marital, age, prop))) +
  geom_line(linewidth = 1) +
  scale_color_brewer(palette = "Set1") +
  labs(color = "marital")

# order factors by frequency
# number of different marital statuses
gss_cat |>
  mutate(marital = marital |> fct_infreq() |> fct_rev()) |>
  ggplot(aes(x = marital)) +
  geom_bar()


gss_cat |>
  mutate(
    partyid = fct_collapse(partyid,
      "other" = c("No answer", "Don't know", "Other party"),
      "rep" = c("Strong republican", "Not str republican"),
      "ind" = c("Ind,near rep", "Independent", "Ind,near dem"),
      "dem" = c("Not str democrat", "Strong democrat")
    )
  ) |>
  count(partyid)


gss_cat |>
  mutate(relig = fct_lump_lowfreq(relig)) |>
  count(relig)


# Exercises

# this is terrible to read unless you flip the coordinates
# the bin names are too dang long
# I wish there was more info on this; the factors are weird
# and there's a weird granularity below $25,000 and then NONE above
gss_cat |>
  ggplot(aes(x = rincome)) +
  geom_bar() +
  coord_flip()


# Not surprising
gss_cat |>
  count(relig) |>
  arrange(desc(n))

# Surprising
gss_cat |>
  count(partyid) |>
  arrange(desc(n))


# denomination only applies to "Protestant" and, to a lesser extent, "Christian"
gss_cat |>
  ggplot(aes(x = relig, fill = denom)) +
  geom_bar() +
  coord_flip()

# due to the outliers, median would be a better measure of centrality than mean
gss_cat |>
  count(tvhours) |>
  arrange(desc(tvhours))


glimpse(gss_cat)

gss_cat |>
  distinct(marital) |>
  arrange(marital)

gss_cat |>
  distinct(race) |>
  arrange(race)

gss_cat |>
  distinct(rincome) |>
  arrange(rincome)

gss_cat |>
  distinct(partyid) |>
  arrange(partyid)

gss_cat |>
  distinct(relig) |>
  arrange(relig)
