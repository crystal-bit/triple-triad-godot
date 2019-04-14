# What are these files?

- `triple-triad-source-data.txt` is a text file that I copy-pasted from [JStorar'sgameFAQ](https://gamefaqs.gamespot.com/pc/197342-final-fantasy-viii/faqs/4906)
- `json-data-generator.py` is a Python3 script that parses the previous .txt file and generates a JSON file with all the information needed for the game to run 
- `triple-triad-cards-data.json` is the JSON file created by the Python script. You can tweak this file if you want to change the attributes of a specific card

# How to generate a JSON file

Execute: 

```sh
python json-data-generator.py
```

