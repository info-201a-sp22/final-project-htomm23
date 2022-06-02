
## What do the graphs represent?

This data visualization displays the relationships between the Social Vulnerability Index(SVI) and the 15 variables for estimate demonstrated in the image of introduction page respectfully. Each point on the scatter plot represents an observation, or a county's data from the year of 2018. The SVI is graphed on the y axis while users can select the desired variable to be displayed on the x-axis and see their overall correlations. 

## How to interpret the graph?

The higher the SVI value is, the closer it is to 1, which corresponds to the top part of the graph. The higher the value or the percentage of the population of variable selected, the further it is from the origin, which corresponds to the right part of the graph. In this way, if

- The points form an upward sloping trend, the higher the percentage of selected value, the higher the SVI. This represents that the selected variable has a _positive_ correlation with the SVI value, **but indicates that it has a negative effect on a community's social vulnerability.** (ex. Unemployment rate)

- The points form a downward sloping trend, the higher the percentage of selected value, the lower the SVI. This represents that the selected variable has a _negative_ correlation with the SVI value, **but indicates that it has a positive effect on a community's social vulnerability.** (ex. Per capita income)

- The points tend to converge in a line, the residuals are small, which corresponds with a small margin of error. This represents that this correlation is less likely to happen by chance and the selected variable has a **strong** relationship with the SVI.(ex. No vehicle rate)

- The points are spread out but a linear trend can still be observed, the residuals are medium, which corresponds with a regular margin of error. This represents that this correlation is relatively less likely to happen by chance and the selected variable has a **weak** relationship with the SVI. (ex. Disabled population rate)

- The points are _(1) dispersed and no obvious trend can be observed_ or _(2) aggregated around the y-axis_, the residuals are big, which corresponds with a big margin of error. This represents that this correlation is likely to happen by chance and the selected variable has **no obvious** relationship with the SVI. (ex. Minority population rate, 10+ unit housing rate)

## Summary and Insights

Most of the relationships should be a match with what we and the users expect to see: the more people who are below poverty/unemployed/has no high school diploma/are disabled/are single parent/has more people living in a shelter than its designed population/has no vehicle, the more vulnerable a county is. On the contrary, the more each person earn, the lower the SVI. On the other hand, we couldn't tell the effect of minority population rate, insufficient English population rate, 10+ unit housing rate, and group quarter rate on a county's SVI value.

There are three interesting variable that stood out among the 15 that we covered: _Age 65+ rate, Age 17- rate, and Mobile homes rate_.

- **Age 65+ rate**: This is the most surprising variable. We thought the more old people in a county, the more resources we need in order to take extra care of them from being hurt. For example, if an earthquake causes injury to a county, the hospitals may need to have more beds if there are more old people regardless if they injured by the earthquake or not. However, it turns out that **The more old people in a county, the less vulnerable a county is.** Since we don't have more information to analyze its reason, we took a guess that it may because of their profound experiences of encountering all kinds of events.

- **Age 17- rate**: This variable shows a vertical and slightly to the right trend, representing the population of teenagers below the age of 17 has a **little positive to almost no effect on a county's SVI.** We didn't expect it to has such a neutral correlation with a county's social vulnerability, but the result is reasonable. The skills of teenagers below 17 varies a lot depends on individuals. The elder kids may be able to help the county out when there's a situation, but smaller kids require extra attention or help (just like what we've expected for the old people). This explains the little tilted trend to the right.

- **Mobile homes rate**: The graph of this variable is kind of unique since it spares out the upper left corner but still maintains a **faint positive correlation**. We think the positive correlation is valid because mobile homes are less stable than other unit housing, which in most cases indicates that the condition of households is not good enough to buy a permanent house. On the other hand, this variable has a big margin of error because the mobile houses may also allow households to escape from emergency accidents. So we think the dispersion of the points may be caused by this uncertainty and the other significant omitted variables.