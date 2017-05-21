####################lambda1e-2############################
# import csv

# f1 = open('./Leukemia_t1_l2_.csv', 'r')
# f2 = open('./Leukemia_t1_l2_RAND.csv', 'r')
# f3 = open('./Leukemia_t4_l2_.csv', 'r')
# f4 = open('./Leukemia_t4_l2_RAND.csv', 'r')
# f5 = open('./Leukemia_t8_l2_.csv', 'r')
# f6 = open('./Leukemia_t8_l2_RAND.csv', 'r')
# f7 = open('./Leukemia_t32_l2_.csv', 'r')
# f8 = open('./Leukemia_t32_l2_RAND.csv', 'r')

# reader1 = csv.reader(f1)
# reader2 = csv.reader(f2)
# reader3 = csv.reader(f3)
# reader4 = csv.reader(f4)
# reader5 = csv.reader(f5)
# reader6 = csv.reader(f6)
# reader7 = csv.reader(f7)
# reader8 = csv.reader(f8)
# list = []

# list.append(reader1)
# list.append(reader2)
# list.append(reader3)
# list.append(reader4)
# list.append(reader5)
# list.append(reader6)
# list.append(reader7)
# list.append(reader8)

# f_all = open('./Leukemia_c001_1e-2.csv', 'wb')
# writer = csv.writer(f_all)

# for i in list:
# 	for row in i:
# 		writer.writerow(row)
# f1.close()
# f2.close()
# f3.close()
# f4.close()
# f5.close()
# f6.close()
# f7.close()
# f8.close()
# f_all.close()

####################lambda1e-6############################
# import csv

# f1 = open('./Leukemia_t1_l6_.csv', 'r')
# f2 = open('./Leukemia_t1_l6_RAND.csv', 'r')
# f3 = open('./Leukemia_t4_l6_.csv', 'r')
# f4 = open('./Leukemia_t4_l6_RAND.csv', 'r')
# f5 = open('./Leukemia_t8_l6_.csv', 'r')
# f6 = open('./Leukemia_t8_l6_RAND.csv', 'r')
# f7 = open('./Leukemia_t32_l6_.csv', 'r')
# f8 = open('./Leukemia_t32_l6_RAND.csv', 'r')

# reader1 = csv.reader(f1)
# reader2 = csv.reader(f2)
# reader3 = csv.reader(f3)
# reader4 = csv.reader(f4)
# reader5 = csv.reader(f5)
# reader6 = csv.reader(f6)
# reader7 = csv.reader(f7)
# reader8 = csv.reader(f8)
# list = []

# list.append(reader1)
# list.append(reader2)
# list.append(reader3)
# list.append(reader4)
# list.append(reader5)
# list.append(reader6)
# list.append(reader7)
# list.append(reader8)

# f_all = open('./Leukemia_c001_1e-6.csv', 'wb')
# writer = csv.writer(f_all)

# for i in list:
# 	for row in i:
# 		writer.writerow(row)
# f1.close()
# f2.close()
# f3.close()
# f4.close()
# f5.close()
# f6.close()
# f7.close()
# f8.close()
# f_all.close()

########################n1000p10000rho020#######################
# import csv

# f1 = open('./rho020_t16_l2_.csv', 'r')
# f2 = open('./rho020_t16_l2_RAND.csv', 'r')
# f3 = open('./rho020_t32_l2_.csv', 'r')
# f4 = open('./rho020_t32_l2_RAND.csv', 'r')
# f5 = open('./rho020_t64_l2_.csv', 'r')
# f6 = open('./rho020_t64_l2_RAND.csv', 'r')

# reader1 = csv.reader(f1)
# reader2 = csv.reader(f2)
# reader3 = csv.reader(f3)
# reader4 = csv.reader(f4)
# reader5 = csv.reader(f5)
# reader6 = csv.reader(f6)
# list = []

# list.append(reader1)
# list.append(reader2)
# list.append(reader3)
# list.append(reader4)
# list.append(reader5)
# list.append(reader6)

# f_all = open('./rho020_c001_1e-2.csv', 'wb')
# writer = csv.writer(f_all)

# for i in list:
# 	for row in i:
# 		writer.writerow(row)
# f1.close()
# f2.close()
# f3.close()
# f4.close()
# f5.close()
# f6.close()
# f_all.close()
########################n10000p1000rho020#######################
import csv

f1 = open('./2rho020_t16_l2_.csv', 'r')
f2 = open('./2rho020_t16_l2_RAND.csv', 'r')
f3 = open('./2rho020_t32_l2_.csv', 'r')
f4 = open('./2rho020_t32_l2_RAND.csv', 'r')
f5 = open('./2rho020_t64_l2_.csv', 'r')
f6 = open('./2rho020_t64_l2_RAND.csv', 'r')

reader1 = csv.reader(f1)
reader2 = csv.reader(f2)
reader3 = csv.reader(f3)
reader4 = csv.reader(f4)
reader5 = csv.reader(f5)
reader6 = csv.reader(f6)
list = []

list.append(reader1)
list.append(reader2)
list.append(reader3)
list.append(reader4)
list.append(reader5)
list.append(reader6)

f_all = open('./n10000p1000rho020_c001_1e-2.csv', 'wb')
writer = csv.writer(f_all)

for i in list:
	for row in i:
		writer.writerow(row)
f1.close()
f2.close()
f3.close()
f4.close()
f5.close()
f6.close()
f_all.close()