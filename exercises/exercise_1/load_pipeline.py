
import dlt
import pandas as pd
from pathlib import Path
import os

@dlt.resource(write_disposition="replace")
def load_xlsx_resource(file_path: str, **kwargs):
    df = pd.read_excel(file_path, **kwargs)
    yield df


if __name__ == "__main__":
    working_directory = Path(__file__).parent

    os.chdir(working_directory)
    xlsx_path = working_directory / "data" / "iFood.xlsx"
    data = load_xlsx_resource(xlsx_path)
    print(data)
    pipeline = dlt.pipeline(
        pipeline_name='ifood',
        destination="snowflake",
        dataset_name='staging'
        )
    
    load_info = pipeline.run(data, table_name="ifood_marketing")

    
    print(load_info)
    
