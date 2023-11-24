#!/usr/bin/python
import datetime as dt
import os

#.txtfiles directory en files naar lijst.
txtDir = '/home/jensd/stats'
placeholder = 1

#sjabloonfile 
sjabloon = '/home/jensd/sjabloon.md'

afkortingen = ['GER','STDEV', 'MinER', 'MaxER']

with open(sjabloon, 'r') as template:
    template_inhoud = template.read()

for txtFile in os.listdir(txtDir): # 3 x
    file = os.path.join(txtDir, txtFile)
    with open(file, 'r') as file:
        for line in file:
            for afk in afkortingen:
                afk_index = line.find(afk) #bepaal regel
                if afk_index != -1:
                    waarde = line[afk_index + len(afk)+1:].strip() #plaats waarde in variabele
                    #plaatsen in inhoud
                    template_inhoud = template_inhoud.replace(f'[{placeholder}]', str(waarde))
                    placeholder += 1
                       

template_inhoud = template_inhoud.replace('[DATE]', str(dt.datetime.now()))
if not os.path.exists('/home/jensd/MD'):
    os.mkdir('MD')
output = dt.datetime.now().strftime("%Y%m%d-%H%M%S")
output_file = f'/home/jensd/MD/{output}_rapport.md'
with open(output_file, 'w') as output_file:
    output_file.write(template_inhoud)