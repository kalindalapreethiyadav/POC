import pandas as pd
import json
# load data using Python JSON module
with open(r"/python/examples/INVENTORY_DATA.json") as f:
    df = pd.read_json(f)