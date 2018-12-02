import requests
import pandas as pd
import pathlib


URL_NORRIS = "https://www.itl.nist.gov/div898/strd/lls/data/LINKS/DATA/Norris.dat"
FILENAME_NORRIS = "norris.dat"
path = pathlib.Path(FILENAME_NORRIS)
if not path.exists():
  body = requests.get(URL_NORRIS).text.replace("\r\n", "\n").replace("\r","")  
  path.write_text(body)

#df=pd.read_csv(FILENAME_NORRIS, engine="c",skiprows=61, lineterminator="\n")
df=pd.read_csv(FILENAME_NORRIS, skiprows=59, delim_whitespace=True)


#with open(FILENAME_NORRIS) as f:
#    x = f.readlines()
