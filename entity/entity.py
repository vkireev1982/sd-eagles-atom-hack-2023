import re

from typing import Tuple, List, Dict, Any
from tqdm.auto import tqdm
from transformers import TokenClassificationPipeline

def normlize_text(text: str) -> str:
    text = re.sub("\n", ". ", text)
    text = re.sub("\s+", " ", text)
    return text

def merge_text(tokens: List[Dict[str, Any]]):
    if len(tokens) == 0:
        return {}
    entities: Dict[str, List[str]] = {}
    start = tokens[0]["start"]
    end = tokens[0]["end"]
    entity = tokens[0]["entity"]
    for token in tokens[1:]:
        if end >= token["start"] - 1:
            end = token["end"]
        else:
            if entity in entities:
                entities[entity].append((start, end))
            else:
                entities[entity] = [(start, end)]
            start = token["start"]
            end = token["end"]
            entity = token["entity"]
    if entity in entities:
        entities[entity].append((start, end))
    else:
        entities[entity] = [(start, end)]
    return entities

def get_loc_org(data: List[Dict[str, str]], classifier: TokenClassificationPipeline) -> Tuple[List[str], List[str]]:
    res = []
    for id_doc, doc in tqdm(data.items()):
        glav_name, content = list(doc.items())[0]
        content = normlize_text(content)
        out = classifier(content)
        out = merge_text(out)
        d_tmp = {}
        for type_entity, entities in out.items():
            tmp = []
            for entity in entities:
                text_entity = content[entity[0]:entity[1]]
                tmp.append(text_entity)
            d_tmp[type_entity] = ",".join(tmp)
        res.append(d_tmp)
    loc = list(map(lambda x: x["I-LOC"] if "I-LOC" in x else "", res))
    org = list(map(lambda x: x["I-ORG"] if "I-ORG" in x else "", res))
    return loc, org