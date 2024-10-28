import json


with open ('C://Temp//WorkspacePy//anomalies_malicious_unique.json') as f, open('anomalies_payload.csv', 'w+') as out:
    out.write("time,event,name,type\n")
    for line in f:
        j = json.loads(line)
        logline = j["LogData"]["RawLogData"][0]
        ev_id = logline[logline.find("\"event_id\": \""):].split(' ')[1].replace("\"", "").replace(",", "").replace("}", "")
        computer_name = logline[logline.find("\"computer_name\": \""):].split(' ')[1].replace("\"", "").replace(",", "").replace("}", "")
        out.write(str(j["LogData"]["Timestamps"][0]) + ',' + str(ev_id) + ',' + str(computer_name) + ',' + str(j['AnalysisComponent']["AnalysisComponentName"]) + '\n')
