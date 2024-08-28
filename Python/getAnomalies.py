import json

#with open('anomalies_valid2.txt') as f, open('anomalies_valid.csv', 'w+') as out:
#with open('anomalies_test2.txt') as f, open('anomalies_test.csv', 'w+') as out:
#with open('anomalies_payload.txt') as f, open('anomalies_payload.csv', 'w+') as out:
with open ('C://Temp//WorkspacePy//anomalies_malicious_master5_unique.json') as f, open('anomalies_payload_final.csv', 'w+') as out:
    out.write("time,event,name,type\n")
    for line in f:
        j = json.loads(line)
        #print(j['AnalysisComponent']["AffectedLogAtomValues"])
        #print(j["LogData"]["Timestamps"])
        logline = j["LogData"]["RawLogData"][0]
        ev_id = logline[logline.find("\"event_id\": \""):].split(' ')[1].replace("\"", "").replace(",", "").replace("}", "")
        computer_name = logline[logline.find("\"computer_name\": \""):].split(' ')[1].replace("\"", "").replace(",", "").replace("}", "")
        #out.write(str(j["LogData"]["Timestamps"][0]) + ',' + str(j['AnalysisComponent']["AffectedLogAtomValues"][1]) + ',' + str(j['AnalysisComponent']["AffectedLogAtomValues"][0]) + ',' + str(j['AnalysisComponent']["AnalysisComponentName"]) + '\n')
        out.write(str(j["LogData"]["Timestamps"][0]) + ',' + str(ev_id) + ',' + str(computer_name) + ',' + str(j['AnalysisComponent']["AnalysisComponentName"]) + '\n')
