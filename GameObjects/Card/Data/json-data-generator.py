import json

# enable debug prints
DEBUG = False 

def get_attributes_array_from_data(card_data):
    # initialize the array with the correct values
    attributes_array = [
        card_data[3], card_data[4], card_data[5], card_data[6]
    ]
    # print(attributes_array)
    # convert "A" values to "10"
    attributes_array = [convert_attribute_value_to_integer(attr) for attr in attributes_array]
    # return the array
    return attributes_array

def convert_attribute_value_to_integer(attribute):
    # print(attribute, type(attribute))
    if type(attribute) is str and attribute == "A":
        return 10
    else:
        return int(attribute)

def get_card_data_from_line(line):
    # detect how many words are used for the name
    line_elements = line.split()
    index = 1 
    card_name = "" 
    while line_elements[index] not in ["Monster", "GF", "Boss", "Player"]:
        card_name += line_elements[index]
        index += 1
    # words
    del line_elements[1:index]
    line_elements.insert(1, card_name)
    return line_elements 

with open("triple-triad-source-data.txt") as file:
    converted_cards = []
    current_line = 0
    for line in file:
        current_line += 1
        # skip the first 8 lines
        if current_line < 8:
            continue
        # skip headers
        if "===" in line:
            if DEBUG:
                print("Skipping header")
            continue
        # split line in multiple pieces
        card_data = get_card_data_from_line(line)
        #
        if DEBUG:
            print("------------")
            print("Level {}\nName {}\nType {}".format(card_data[0], card_data[1], card_data[2]))
            print("Attrs {} {} {} {}".format(card_data[3], card_data[4], card_data[5], card_data[6]))

        converted_cards.append({
            "id": len(converted_cards),
            "group": len(converted_cards)//8,
            "group_index": len(converted_cards)%8,
            "name": card_data[1],
            "attributes": get_attributes_array_from_data(card_data),
            "element": card_data[7]
        })


# convert dict to JSON
json_data = json.dumps(converted_cards)
# open file to write data into
with open("triple-triad-cards-data.json", "w") as output_file:
    output_file.write(json_data)