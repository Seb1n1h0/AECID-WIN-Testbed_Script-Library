import json
import datetime


files = ["C:/Temp/WorkspacePy/AECID-WIN-Dataset_Benign.json", "C:/Temp/WorkspacePy/AECID-WIN-Dataset_Payload.json"]

for f_path in files:
    with open(f_path, encoding="latin-1") as f:
        j = ""
        mode = "objects"
        first = True
        obj_list = []

        for line in f:
            if first:
                first = False
                if line.startswith('['):
                    mode = "array"
                    continue
            if mode == "objects" or (mode == "array" and line != ']\n'):
                if mode == "array" and line == "},\n": 
                    line = "}\n" 
                j += line
            if (mode == "objects" and line == '}\n') or (mode == "array" and line == "}\n"): 
                ev = json.loads(j)
                t = datetime.datetime.strptime(ev['@timestamp'], '%Y-%m-%dT%H:%M:%S.%f%z')
                obj_list.append({"time": t.timestamp(), "event": str(ev['winlog']['event_id']), "name": str(ev['winlog']['computer_name'])})
                j = ""
        print(str(j))
        print(len(obj_list))
        obj_list_sorted = sorted(obj_list, key=lambda d: d['time'])
        out_lists = []
        out_list = []
        prev_time = None
        for obj in obj_list_sorted:
            if prev_time is None or obj["time"] > prev_time + 60*60*24*5:
                if prev_time is not None:
                    print(f_path + ' breaks at ' + str(datetime.datetime.fromtimestamp(prev_time)) + ' -> ' + str(datetime.datetime.fromtimestamp(obj["time"])))
                    out_lists.append(out_list)
                out_list = [obj]
            else:
                out_list.append(obj)
            prev_time = obj["time"]
        out_lists.append(out_list)
        for i, ol in enumerate(out_lists):
            with open(f_path.split('.')[0] + '_' + str(i) + 'sebi.csv', 'w+') as out:
                out.write('time,event,name\n')
                for elem in ol:
                    out.write(str(elem["time"]) + ',' + str(elem["event"]) + ',' + str(elem["name"]) + '\n')
