

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

