

# 安装

```
virtualenv -p python3  jupyter
source jupyter/bin/activate
python3 -m pip install --upgrade pip
python3 -m pip install jupyter
```

# 开启服务

```
jupyter notebook --ip=0.0.0.0 --port=8888 --allow-root 
```

# 参数

```text
--no-browser  # 启动jupyter Notebook服务但不打算打开浏览器
--ip=0.0.0.0  # 开启外网可访问
--port=8888   # 自定义端口，默认8888
```