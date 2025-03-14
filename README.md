# Hamoon Project

A data lake infrastructure and ETL project.

## Data Loading

The project includes scripts for loading data from public datasets into your data lake.

### NOAA GHCN Climate Data

To load NOAA Global Historical Climatology Network data from the AWS Open Data Registry, use the provided script:

```bash
# Basic usage (loads current year's CSV data to default bucket)
./scripts/load_noaa_data.sh

# Specify target bucket and year
./scripts/load_noaa_data.sh hamoon-data-lake 2023 csv

# Load specific year's parquet data
./scripts/load_noaa_data.sh hamoon-data-lake 2022 parquet-year

# Load all parquet data (caution: large dataset)
./scripts/load_noaa_data.sh hamoon-data-lake 2023 parquet-all
```

The script will copy data from the source bucket `noaa-ghcn-pds` to your target S3 bucket, maintaining a similar directory structure.

## Infrastructure

The project uses Terraform to manage the cloud infrastructure. See the `infrastructure/` directory for details.
