import csv
with open('/Users/ym/Desktop/training.csv', 'rb') as f:
    reader = csv.reader(f)
    data_list = list(reader)

del data_list[0]

for i in range(len(data_list)):
	del data_list[i][0]
for i in range(len(data_list)):
	for j in range(len(data_list[i])):
		data_list[i][j] = float(data_list[i][j])

