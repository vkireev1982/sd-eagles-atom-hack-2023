import yaml
import torch
import argparse
import pandas as pd

from transformers import pipeline, XLMRobertaTokenizerFast, XLMRobertaForTokenClassification

from utils import build_table, parse_texts
from entity_utils import get_loc_org


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("--config", type=str, help="path to yaml config file")
    return parser.parse_args()


if __name__ == "__main__":
    args = parse_args()
    with open(args.config) as f:
        cfg = yaml.load(f, Loader=yaml.FullLoader)

    with open(cfg["dataset"]["all_applic"]) as f:
        all_applic = f.read()

    df: pd.DataFrame = build_table(all_applic)
    texts = parse_texts(df["text"].tolist())
    tokenizer = XLMRobertaTokenizerFast.from_pretrained(cfg["model"]["tokenizer"])
    model = XLMRobertaForTokenClassification.from_pretrained(cfg["model"]["model"])
    device = torch.device("cuda") if cfg["model"]["use_cuda"] else torch.device("cpu")
    classifier = pipeline("ner", model=model, tokenizer=tokenizer, device=device)
    loc, org = get_loc_org(texts, classifier)
    df["location"] = loc
    df["organization"] = org
    df.to_csv(cfg["out"]["out_path_csv"], index=False)






