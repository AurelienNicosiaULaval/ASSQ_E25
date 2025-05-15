data("mtcars")

# lm

# ggplot



# code brouillon

mtcars%>%ggplot(aes(x=mpg,y=disp)) +
  geom_point() + geom_smooth(method = "lm",se = FALSE) +
  labs(title = "Scatter plot of 
       mpg vs disp with linear regression line",x = "Miles per gallon (mpg)",
       y = "Displacement (disp)"                 ) +
  theme_minimal()
