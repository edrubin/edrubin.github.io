#!/user/bin/env bash

# sync poisson cardio mortality results
rsync -avP \
    trogdor:/run/media/ed/Data/pm-predictions/data/results/mortality/ \
    ./slides/data/

# sync county-aggregate of monitor and prediction summaries (aggregated across months)
rsync -avP \
    trogdor:/run/media/ed/Data/pm-predictions/data/processed/combined/pm-county-epa-pred.csv \
    ./slides/data

# sync PM discrepancy maps
rsync -avP \
    trogdor:/run/media/ed/Data/pm-predictions/figures/discrepancies \
    ./slides/images/error
