import json
import datetime
import re

files = ["C:/Temp/WorkspacePy/AECID-WIN-Dataset_Benign.json", "C:/Temp/WorkspacePy/AECID-WIN-Dataset_Payload.json"]

for f_path in files:
    with open(f_path) as f, open(f_path + '.sort', 'w+') as out: 
        j = ""
        mode = "objects"
        first = True
        obj_list = []
        ev_list = []
        for line in f:
            if first:
                first = False
                if line == '[\n':
                    mode = "array"
                    continue
            if mode == "objects" or (mode == "array" and line != ']\n'):
                if mode == "array" and line == "  },\n":
                    line = "  }\n"
                j += line
            if (mode == "objects" and line == '}\n') or (mode == "array" and line == "  }\n"):
                ev = json.loads(j)
                ev_list.append(ev)
                t = datetime.datetime.strptime(ev['@timestamp'], '%Y-%m-%dT%H:%M:%S.%f%z')
                obj = {}
                obj["@timestamp"] = ev["@timestamp"]
                obj["winlog"] = {}
                obj["winlog"]["event_id"] = ev['winlog']['event_id']
                obj['winlog']['computer_name'] = ev['winlog']['computer_name']
                if "message" in ev:
                    ip_regex = r'\b192\.\d{1,3}\.\d{1,3}\.\d{1,3}\b'
                    ip_matches = re.search(ip_regex, ev['message'])
                    if ip_matches:
                        obj['ip_address'] = {}
                        obj['ip_address'] = ip_matches[0]

                if "event_data" in ev["winlog"]:
                    obj["winlog"]["event_data"] = {}
                    if "TargetImage" in ev['winlog']["event_data"]:
                        obj["winlog"]["event_data"]["TargetImage"] = ev['winlog']["event_data"]["TargetImage"]
                    if "SourceImage" in ev['winlog']["event_data"]:
                        obj["winlog"]["event_data"]["SourceImage"] = ev['winlog']["event_data"]["SourceImage"]
                    ## Extract IP address from winlog source / destination | Sysmon Event ID 3
                    if "SourceIp" in ev['winlog']["event_data"]:
                        obj["winlog"]["event_data"]["SourceIp"] = ev['winlog']["event_data"]["SourceIp"]
                    if "DestinationIp" in ev['winlog']["event_data"]:
                        obj["winlog"]["event_data"]["DestinationIp"] = ev['winlog']["event_data"]["DestinationIp"]
                    ## Extract CMD from winlog | Sysmon Event ID 1
                    if "CommandLine" in ev['winlog']["event_data"]:
                        obj["winlog"]["event_data"]["CommandLine"] = ev['winlog']["event_data"]["CommandLine"]
                        ## Write the CommandLine length to the object
                        obj["winlog"]["event_data"]["CommandLineLength"] = len(ev['winlog']["event_data"]["CommandLine"])

                obj_list.append(obj)
                j = ""
        print(str(j))
        print(len(obj_list))
        obj_list_sorted = sorted(obj_list, key=lambda d: d['@timestamp'])
        ev_list_sorted = sorted(ev_list, key=lambda d: d['@timestamp'])
        for ev in obj_list_sorted:
            out.write(json.dumps(ev) + '\n')
