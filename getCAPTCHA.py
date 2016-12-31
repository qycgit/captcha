# -*- coding: UTF-8 -*-
import requests, os



    # url = 'https://passport.bilibili.com/captcha'
    # url = 'https://passport.sohu.com/apiv2/picture_captcha?userid=rewr&time=0.002703735636188309'
    # url='https://passport.csdn.net/ajax/verifyhandler.ashx?rand=14806719274.36'
    # url='https://login.sina.com.cn/cgi/pin.php?r=1448288508298&lang=zh&type=hollow'
saveDir = './data/'
if not os.path.exists(saveDir):
    os.mkdir(saveDir)
url="http://mis.teach.ustc.edu.cn/randomImage.do?date=%271469451446894%27"

for i in range(50):
    r=requests.get(url)
    p=r._content
    pic=open(saveDir+str(i)+".jpg","wb")
    pic.write(p)
    pic.close()