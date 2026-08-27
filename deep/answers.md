# From the Deep

In this problem, you'll write freeform responses to the questions provided in the specification.

## Random Partitioning

One reason to adopt this approach is that the observations will be evenly distributed across all boats.
However, a reason not to adopt it is that querying for observations within a specific time range requires running the query on all boats, making it less efficient.

## Partitioning by Hour

A reason to adopt this approach is that a query for a specific time range (like midnight to 1am) only needs to be run on one specific boat.
On the other hand, a reason not to adopt it is that the data will not be evenly distributed, since most observations happen between midnight and 1am, one boat will be severely overloaded.

## Partitioning by Hash Value

One reason to adopt this approach is that observations are evenly distributed, and querying for a specific, exact timestamp only requires asking one boat.
A reason not to adopt it is that querying for a range of time still requires asking all boats, since sequential timestamps will have scattered hash values.
