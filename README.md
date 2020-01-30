# Hzero本地部署的基础环境

| 组件  | 描述                | 版本      |
| :---- | :------------------ | :-------- |
| JDK   | Java运行环境        | 1.8.0_172 |
| Nginx | 前端代理            | 1.8.1     |
| Node  | JavaScript 运行环境 | 10.15.0   |
| Git   | 源码管理            | 2.22.0    |
| Maven | 项目构建            | 3.3.9     |

通过docker-compose[本地部署编排](https://github.com/ChenQuan/docker-compose/blob/master/hzero-server/README.md)，包含如下组件：

| 组件           | 描述                | 版本      |
| :------------- | :------------------ | :-------- |
| JDK            | Java运行环境        | 1.8.0_172 |
| Nginx          | 前端代理            | 1.8.1     |
| Node           | JavaScript 运行环境 | 10.15.0   |
| Git            | 源码管理            | 2.22.0 |
| Maven          | 项目构建            | 3.3.9     |
| Redis | 缓存数据库   | 4.0.2                  |
| Mysql | 数据库       | 5.7.17                   |
