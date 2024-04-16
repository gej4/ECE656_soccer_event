
import json

# Using triple quotes to define the string
json_string = '[{"refereeId": 385909, "role": "referee"}, {"refereeId": 385917, "role": "firstAssistant"}, {"refereeId": 384889, "role": "secondAssistant"}, {"refereeId": 381853, "role": "fourthOfficial"}]'


try:
    data = json.loads(json_string)
    referee_info = []
    for referee in data:
        if 'refereeId' in referee and 'role' in referee:
            referee_info.append({
                'refereeId': referee['refereeId'],
                'role': referee['role']
            })
    print(referee_info)
except json.JSONDecodeError as e:
    print("Failed to decode JSON:", e)
