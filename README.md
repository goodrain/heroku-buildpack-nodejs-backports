# Heroku buildpack for Node.js

![heroku-buildpack-featuerd](https://cloud.githubusercontent.com/assets/51578/6953435/52e1af5c-d897-11e4-8712-35fbd4d471b1.png)

云帮 Node.js 语言源码构建核心部分是基于[Heroku buildpack for Node.js](https://github.com/heroku/heroku-buildpack-nodejs) 来实现的。

## 工作原理

当buildpack在您代码的根目录下检测到`package.json`文件，您的应用被识别为Node.js程序。若`package.json`文件不存在请手动或使用 `npm init` 命令创建并配置需要的依赖和其它信息。

## 文档

以下文章了解更多：

- [云帮支持Node.js](http://www.rainbond.com/docs/stable/user-lang-docs/ndjs/lang-ndjs-overview.html)


## 配置

### 指定一个node版本

当前支持v0.10.*、v0.12.*、v0.8.*、v2.3.1、v4.*.*、v5.*.*、v6.*.* (目前支持到v6.5.0) 版本，您可以在 `package.json` 里使用 engines 指定版本：

```bash
{
      "name": "demo",							#自定义名称
      "description": "this is a node demo",		#描述
      "version": "0.0.1",						#自定义版本
      "engines": {								#engines
        "node": "4.1.0"							#node版本
      }
}
```

> 提示：npm 版本的指定是非必要的，因为npm与node时绑定的

## **环境变量**

系统会设置以下的环境变量，NODE_ENV 环境变量默认是 production。

```bash
   # 默认 NODE_ENV 是 production
   export NODE_ENV=${NODE_ENV:-production}
   # 添加node的二进制文件目录到PATH
   PATH=vendor/node/bin:bin:node_modules/.bin:$PATH
```

## 授权

根据 MIT 授权获得许可。 请参阅LICENSE文件
