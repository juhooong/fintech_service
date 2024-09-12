import time
from datetime import date
import requests
import pandas as pd
from bs4 import BeautifulSoup as bs

today = date.today()
print(today, type(today))
today = str(today)

page = 1
page_size = 100
final_result_df = pd.DataFrame()
while True:
    url = "https://kind.krx.co.kr/corpgeneral/corpList.do"
    payload = dict(method='searchCorpList',pageIndex=page, currentPageSize=page_size,orderMode=3,orderStat='D',searchType=13, fiscalYearEnd='all', location='all')
    r = requests.get(url, params=payload)
    print(r.status_code, end="\r")
    soup = bs(r.text, 'lxml')
    total_items = int(soup.select_one(".info.type-00 > em").text.replace(",", ""))
    total_pages = total_items // page_size + 1
    print(f"{page}/{total_pages} 수집중", end="\r")
    keys = soup.select_one("table.list.type-00.tmt30")['summary'].split(", ")  
    result = {}
    for tr in soup.select('tr'):
        for idx, (key, td) in enumerate(zip(keys, tr.select('td'))):
            if idx == 0:
                kinds = [img['alt'].strip() for img in td.select('img')]  
                kind = ", ".join(kinds)
                code = td.select_one('a')['onclick'].split("'")[1]+"0" 
                result.setdefault('증권종류', []).append(kind)
                result.setdefault(key, []).append(td.text)   
                result.setdefault('종목코드', []).append(code)
            elif idx == 6:
                home_link = td.select_one('a')['href'] if td.string == None else ""  
                result.setdefault(key, []).append(home_link)
            else:
                result.setdefault(key, []).append(td.text)
    result_df = pd.DataFrame(result)
    final_result_df = pd.concat([final_result_df, result_df])
        
    if page < total_pages:
        page += 1
        time.sleep(5)
    else:
        break
    
import os
from sqlalchemy import create_engine, text
import pymysql
pymysql.install_as_MySQLdb()

db = "mysql"
dbtype = "pymysql"
user = "root"
password = "1234"
host = "127.0.0.1:3306"
database = "korean_stock"

engine = create_engine(f"{db}+{dbtype}://{user}:{password}@{host}")

conn = engine.connect()

conn.execute(text(f"DROP DATABASE IF EXISTS {database}"))
conn.execute(text(f"CREATE DATABASE {database}"))
conn.close()

today = today.replace("-", "_")
today

engine = create_engine(f"{db}+{dbtype}://{user}:{password}@{host}/{database}")
conn = engine.connect()

final_result_df.to_sql(f'company_info', con=conn, if_exists='replace', index=False)
conn.close()