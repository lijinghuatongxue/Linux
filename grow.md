## git忽略上传特殊文件和文件夹

在根目录下创建 文件 

```
touch .gitignore  #里面写入声明，哪些文件不上传
```

示范

```
*.py[cod]
*.so
*.egg
*.egg-info
dist
build
mysite/myapp
db.ini
deploy_key_rsa
```

然后git add上传这个文件让git识别