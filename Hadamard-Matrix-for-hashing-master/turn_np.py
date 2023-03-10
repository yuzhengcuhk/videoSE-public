# 直接上代码
import numpy as np
import pandas as pd

title = 'coco_64_database_label'  # 读取的文件名
data = np.load(title + '.npy')  # 读取numpy文件
data_df = pd.DataFrame(data)  # 利用pandas库对数据进行格式转换

# create and writer pd.DataFrame to excel
writer = pd.ExcelWriter(title + '.xlsx')  # 生成一个excel文件
data_df.to_excel(writer, 'page_1')  # 数据写入excel文件
writer.save()  # 保存excel文件
