FROM adoptopenjdk/openjdk11-openj9:alpine-jre

# https://github.com/googlefonts/noto-cjk/raw/master/NotoSerifCJKsc-Regular.otf
ENV FONT_URL="https://file.lilu.red:444/font/NotoSerifCJKsc-Regular.otf"

RUN set -eux && \
  #修正错误
  #/usr/glibc-compat/sbin/ldconfig: /usr/glibc-compat/lib/ld-linux-x86-64.so.2 is not a symbolic link
  mv /usr/glibc-compat/lib/ld-linux-x86-64.so.2 /usr/glibc-compat/lib/ld-linux-x86-64.so && \
  ln -s /usr/glibc-compat/lib/ld-linux-x86-64.so /usr/glibc-compat/lib/ld-linux-x86-64.so.2 && \
  \
  #设置源
  echo "http://mirrors.ustc.edu.cn/alpine/edge/main/" > /etc/apk/repositories && \
  echo "http://mirrors.ustc.edu.cn/alpine/edge/community/" >> /etc/apk/repositories && \
  echo "http://mirrors.ustc.edu.cn/alpine/edge/testing/" >> /etc/apk/repositories && \
  apk update && \
  #设置时区
  apk add tzdata && \
  cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
  echo "Asia/Shanghai" > /etc/timezone && \
  date && \
  apk del tzdata && \
  \
  #安装工具
  apk add wget nano && \
  \
  #安装中文字体
  apk add --no-cache fontconfig && \
  mkdir -p /usr/share/fonts/ && \
  wget ${FONT_URL} --no-check-certificate -O /usr/share/fonts/NotoSerifCJKsc-Regular.otf && \
  fc-cache -fv &&\
  fc-list :lang=zh && \
  \
  # 清理
  rm -rf /var/cache/* && \
  # 测试
  java -version
