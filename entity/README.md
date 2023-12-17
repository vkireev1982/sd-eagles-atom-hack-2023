Инструкция по запуску

1) Скачиваем исходники модели "xlm-roberta-large-finetuned-conll03-english" https://huggingface.co/xlm-roberta-large-finetuned-conll03-english/tree/main.  
* Создаем папки model/ и tokenizer/
* В папке model/ должны находиться файлы pytorch_model.bin, config.json.
* В папке tokenizer/ должны находиться файлы sentencepiece.bpe.model, tokenizer.json.
2) Клонируем репу.
3) Проверяем, что пути в конфиге sd-eagles-atom-hack-2023/entity/config.yaml совпадают с исходниками.
4) Запускаем скрипт bash sd-eagles-atom-hack-2023/run_entity_pipeline.sh  