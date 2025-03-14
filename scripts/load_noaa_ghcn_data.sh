#!/bin/bash
# load_noaa_data.sh - Script to load NOAA GHCN data to S3 data lake
# Usage: ./load_noaa_data.sh [target-bucket-name] [year]

set -e

TARGET_BUCKET=${1:-"hamoon-data-lake"}
YEAR=${2:-$(date +"%Y")}
SOURCE_BUCKET="noaa-ghcn-pds"

echo "Loading NOAA GHCN data to s3://${TARGET_BUCKET}/raw/noaa-ghcn/"

# Option 1: Load specific year CSV data
load_yearly_csv() {
  echo "Copying CSV data for year: ${YEAR}"
  aws s3 cp s3://${SOURCE_BUCKET}/csv/by_year/${YEAR}.csv s3://${TARGET_BUCKET}/raw/noaa-ghcn/csv/by_year/${YEAR}.csv
}

# Option 2: Load all parquet data
load_all_parquet() {
  echo "Syncing all parquet data"
  aws s3 sync s3://${SOURCE_BUCKET}/parquet/by_year s3://${TARGET_BUCKET}/raw/noaa-ghcn/parquet/
}

# Option 3: Load specific parquet partitions
load_parquet_year() {
  echo "Syncing parquet data for year: ${YEAR}"
  aws s3 sync s3://${SOURCE_BUCKET}/parquet/by_year/YEAR=${YEAR}/ s3://${TARGET_BUCKET}/raw/noaa-ghcn/parquet/year=${YEAR}/
}

# Run the desired loading function
case "$3" in
  "csv")
    load_yearly_csv
    ;;
  "parquet-year")
    load_parquet_year
    ;;
  "parquet-all")
    load_all_parquet
    ;;
  *)
    echo "Usage: $0 [target-bucket-name] [year] [csv|parquet-year|parquet-all]"
    ;;
esac

echo "Data load complete!"