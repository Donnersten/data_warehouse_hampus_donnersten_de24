import dlt
from pathlib import Path
import dagster as dg 
from dagster_dlt import DagsterDltResource, dlt_assets
from dagster_dbt import DbtCliResource, dbt_assets, DbtProject

# to load dlt scripts. 
import sys
sys.path.insert(0, "../data_extract_load")
from load_job_ads import jobads_source

# Data warehouse directory 
db_path = str(Path(__file__).parents[1] / "data_warehouse" / "job_ads.duckdb")

#===========================#
# DLT Assets                #
#===========================#

# Create DLT resource
dlt_resource = DagsterDltResource()

# Create DLT assets
@dlt_assets(
    dlt_source = jobads_source(),
    dlt_pipeline = dlt.pipeline(
        pipeline_name="jobsearch",
        dataset_name="staging",
        destination=dlt.destinations.duckdb(db_path),
    ),
)
def dlt_load(context: dg.AssetExecutionContext, dlt: DagsterDltResource):
    yield from dlt.run(context=context)
    
# pydantic, dependency injection, signature
# Logging 

#===========================#
# DBT Assets                #
#===========================#

# Related paths for dbt 
dbt_project_directory = Path(__file__).parents[1] / "data_transformation"
profiles_dir = Path.home() / ".dbt"

#Creatre dagster dbt project object
dbt_project = DbtProject(project_dir=dbt_project_directory, profiles_dir=profiles_dir)

dbt_resource = DbtCliResource(project_dir=dbt_project)

# Create a manifest json file
dbt_project.prepare_if_dev()

# Create dagster dbt assets
@dbt_assets(
    manifest=dbt_project.manifest_path)
def dbt_models(context: dg.AssetExecutionContext, dbt: DbtCliResource):
    yield from dbt.cli(["dbt build"], context=context).stream()


#===========================#
# JOBS                      #
#===========================#

job_dlt = dg.define_asset_job("job_dlt",
                              selection=dg.AssetSelection.keys("dlt_jobads_source_jobads_resource"))

job_dbt = dg.define_asset_job("job_dbt",
                              selection=dg.AssetSelection.key_prefixes("warehouse", "marts"))
#===========================#
# Schedule                  #
#===========================#

schedule_dlt = dg.ScheduleDefinition(
    job=job_dlt,
    cron_schedule="05 11 * * *"
)

#===========================#
# Sensor                    #
#===========================#

@dg.asset_sensor(asset_key=dg.AssetKey("dlt_jobads_source_jobads_resource"),
                 job_name="job_dbt")
def dlt_load_sensor():
    yield dg.RunRequest()

#===========================#
# Definition                #
#===========================#

defs = dg.Definitions(
    assets=[dlt_load, dbt_models],
    resources={"dlt": dlt_resource,
               "dbt": dbt_resource},
                jobs=[job_dlt, job_dbt],
                schedules=[schedule_dlt],
                sensors=[dlt_load_sensor]
               )

