## 特点

* 基础镜像：adoptopenjdk/openjdk11-openj9:alpine-jre
* 软源镜像：中国科学技术大学 mirrors.ustc.edu.cn
* 基础工具：wget, nano
* 中文时区：**Asia/Shanghai**
* 中文字体：**Noto Serif CJK SC** 样式**Regular**, 信息：`/usr/share/fonts/NotoSerifCJKsc-Regular.otf: Noto Serif CJK SC:style=Regular`

## 构建

```
$ docker build -t registry.cn-shanghai.aliyuncs.com/xm69/alpine-jre:11 .
```

## 测试

```
$ docker run -it --rm registry.cn-shanghai.aliyuncs.com/xm69/alpine-jre:11 java -version
```

## 使用

### 配置启动应用

将应用目录映射到容器中, 然后通过运行参数启动应用入口:
```
$ docker run -d --restart=always \
  -p 10000:6000 \
  -e POSTGRES_JDBC="jdbc:postgresql://172.17.0.1:10010" \
  -v ${PWD}/app:/app \
  --name "java-grpc" registry.cn-shanghai.aliyuncs.com/xm69/alpine-jre:11 \
  /app/bin/grpc
```
> 说明: `/app/bin/grpc`为应用入口.