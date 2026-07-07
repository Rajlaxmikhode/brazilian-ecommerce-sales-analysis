
import csv
input_file  = r'C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\olist_order_reviews_dataset.csv'
output_file = r'C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\olist_order_reviews_clean.csv'
with open(input_file, 'r', encoding='utf-8-sig', newline='') as fin, open(output_file, 'w', encoding='utf-8', newline='') as fout:
    reader = csv.reader(fin, skipinitialspace=True)
    writer = csv.writer(fout, quoting=csv.QUOTE_MINIMAL, lineterminator='\n')
    for row in reader:
        cleaned = [field.replace('\n', ' ').replace('\r', ' ').replace('\"', '') for field in row]
        writer.writerow(cleaned)
print('Done!')
