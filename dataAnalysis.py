#!/usr/bin/python
import pandas as pd
import matplotlib.pyplot as plt
import os
if not os.path.exists('/home/jensd/reports'):
    os.mkdir('reports')
    
if not os.path.exists('/home/jensd/stats'):
    os.mkdir('stats')

csv_dir = '/home/jensd/csvfiles'

# Loop door elk CSV-bestand in het opgegeven directory
for csv_file in os.listdir(csv_dir):
    csv_path = os.path.join(csv_dir, csv_file)

    # Lees het CSV-bestand in een DataFrame
    df = pd.read_csv(csv_path)

    # Converteer de 'Tijd' kolom naar een datetime object
    df['Tijd'] = pd.to_datetime(df['Tijd'])

    # Sorteer de gegevens op tijd
    df = df.sort_values(by='Tijd')
    file_name = csv_file.replace(".csv", "")
    # Genereer een lijnplot van de Exchange Rate over de tijd
    plt.figure(figsize=(10, 6))
    plt.plot(df['Tijd'], df['Exchange Rate'], marker='o')
    plt.title(f'Exchange Rate over de tijd {file_name}')
    plt.xlabel('Tijd')
    plt.ylabel('Exchange Rate')
    plt.grid(True)
    plt.savefig(f'/home/jensd/reports/exchange_rate_plot_{file_name}.png')

    # Bereken basis-statistieken
    mean_exchange_rate = df['Exchange Rate'].mean()
    std_exchange_rate = df['Exchange Rate'].std()
    min_exchange_rate = df['Exchange Rate'].min()
    max_exchange_rate = df['Exchange Rate'].max()

    statistiekFile=(f'/home/jensd/stats/{file_name}.txt')
    with open(statistiekFile, 'w') as f:
        f.write(f"\n\nAnalyseresultaten voor {file_name}:\n")
        f.write(f"GER {mean_exchange_rate}\n")
        f.write(f"STDEV: {std_exchange_rate}\n")
        f.write(f"MinER: {min_exchange_rate}\n")
        f.write(f"MaxER: {max_exchange_rate}\n")