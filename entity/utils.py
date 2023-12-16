import re
import pandas as pd

from typing import List, Tuple, Dict, Any


SYMBOLS = ["II.", "III.", "IV.", "  ", "VI.", "VII", "VIII.", "IX"]

def extract_cgn(string: str) -> str:
    codes: List[str] = re.findall("[0-9]{9,}[A-Z]*[0-9]*", string)
    if len(codes) == 0:
        return ""
    code: str = re.findall("[0-9]+\S+", codes[0])[0]
    return code


def build_table(texts: List[str]) -> pd.DataFrame:
    texts = texts.split("*$*")[3:]
    docs = list(map(lambda x: x.split("\n")[2], texts))
    texts = list(map(lambda x: "\n".join(x.split("\n")[3:]), texts))
    df = pd.DataFrame(data=list(zip(docs, texts)), columns=["docs", "text"])
    df["text"] = df["text"].str.replace("&gt;", "")
    df["text"] = df["text"].str.replace("&lt;", "")
    df["text"] = df["text"].str.replace("&quot;", "")
    mask = df["text"].str.len() > 10
    df = df.loc[mask].reset_index(drop=True)
    df["docs"] = df["docs"].apply(lambda x: re.findall("[0-9]+-[0-9]+", x)[0])
    df["CGN"] = df["text"].apply(extract_cgn)
    return df

def parse_texts(texts: List[str]) -> Dict[int, Dict[str, str]]:
    res: Dict[int, Dict[str, str]] = {}
    for i, text in enumerate(texts):
        res[i] = parse_text(text)
    return res

def parse_text(text: str) -> Dict[str, str]:
    res: Dict[str, str] = {}
    rows = text.split("\n")
    cur = rows[0]
    tmp: List[str] = []
    for row in rows:
        if len(row) == 0:
            continue
        if row.split()[0] in SYMBOLS:
            res[cur] = "\n".join(tmp)
            tmp = []
            cur = row
        else:
            tmp.append(row)
    res[cur] = "\n".join(tmp)
    return res
