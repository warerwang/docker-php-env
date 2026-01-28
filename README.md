# Docker PHP 开发环境

基于 Docker Compose 的 PHP 开发环境，集成了 PHP 8.2、Nginx、MySQL、MongoDB、Redis 和 RabbitMQ。

## 环境组成

### 服务列表

- **PHP 8.2-FPM** - PHP 运行环境
- **Nginx** - Web 服务器
- **MySQL 8.2** - 关系型数据库
- **MongoDB** - NoSQL 数据库
- **Redis** - 缓存服务
- **RabbitMQ** - 消息队列服务（含管理界面）

### PHP 扩展

本环境已安装以下 PHP 扩展：

#### 核心扩展
- **bcmath** - 任意精度数学运算
- **mysqli** - MySQL 改进扩展
- **pdo** & **pdo_mysql** - PDO MySQL 数据库驱动
- **gd** - 图像处理（支持 JPEG、PNG、FreeType）
- **zip** - ZIP 压缩
- **soap** - SOAP 协议支持
- **exif** - EXIF 元数据读取
- **sockets** - Socket 通信
- **pcntl** - 进程控制

#### PECL 扩展
- **Redis** - Redis 客户端
- **MongoDB 1.21.0** - MongoDB 驱动
- **Swoole** - 高性能异步网络通信引擎（启用 HTTP2、MySQL、Cares）
- **OpenTelemetry** - 可观测性追踪

#### 其他工具
- **Composer** - PHP 包管理器

## 端口映射

| 服务 | 主机端口 | 容器端口 | 说明 |
|------|---------|---------|------|
| PHP-FPM | 9000 | 9000 | PHP FastCGI |
| Nginx | 80 | 80 | HTTP |
| Nginx | 443 | 443 | HTTPS |
| MySQL | 3306 | 3306 | MySQL 服务 |
| MongoDB | 27017 | 27017 | MongoDB 服务 |
| Redis | 6379 | 6379 | Redis 服务 |
| RabbitMQ | 5672 | 5672 | AMQP 协议 |
| RabbitMQ | 15672 | 15672 | 管理界面 |

## 默认凭据

### MySQL
- Root 密码: `root`
- 数据库: `laravel`
- 用户名: `laravel`
- 密码: `laravel`

### MongoDB
- 用户名: `mongo`
- 密码: `mongo`

### RabbitMQ
- 用户名: `guest`
- 密码: `guest`
- 管理界面: http://localhost:15672

## 快速开始

### 启动所有服务
```bash
make up
# 或
docker-compose up -d
```

### 停止所有服务
```bash
make down
# 或
docker-compose down
```

### 查看服务状态
```bash
make ps
# 或
docker-compose ps
```

## 常用命令

```bash
make up        # 启动所有服务
make down      # 停止并移除所有容器
make start     # 启动已存在的容器
make stop      # 停止容器
make restart   # 重启容器
make pause     # 暂停容器
make unpause   # 恢复暂停的容器
make ps        # 查看容器状态
make clean     # 清理未使用的镜像和容器
make help      # 显示帮助信息
```

## 目录结构

```
.
├── docker-compose.yml    # Docker Compose 配置
├── Makefile             # 快捷命令
├── php/                 # PHP 配置
│   ├── Dockerfile       # PHP 镜像构建文件
│   ├── php.ini          # PHP 配置文件
│   ├── www.conf         # PHP-FPM 配置
│   └── conf.d/          # PHP 扩展配置
├── nginx/               # Nginx 配置
│   ├── conf.d/          # Nginx 站点配置
│   └── ssl/             # SSL 证书
├── projects/            # 项目代码目录
├── logs/                # 日志目录
│   ├── php/
│   ├── nginx/
│   ├── mysql/
│   ├── mongo/
│   └── rabbitmq/
├── mysql/data/          # MySQL 数据持久化
├── mongo/data/          # MongoDB 数据持久化
├── redis/data/          # Redis 数据持久化
└── rabbitmq/data/       # RabbitMQ 数据持久化
```

## 项目配置

### 添加新站点

1. 在 `nginx/conf.d/vhost/` 目录下创建站点配置文件
2. 将项目代码放入 `projects/` 目录
3. 重启 Nginx 服务：
   ```bash
   docker-compose restart nginx
   ```

### PHP 配置

- 主配置文件：`php/php.ini`
- FPM 配置：`php/www.conf`
- 扩展配置：`php/conf.d/`

### 日志查看

```bash
# PHP 日志
tail -f logs/php/error.log

# Nginx 日志
tail -f logs/nginx/access.log
tail -f logs/nginx/error.log

# MySQL 日志
tail -f logs/mysql/*.log
```

## 注意事项

1. 首次启动需要构建 PHP 镜像，可能需要几分钟
2. 数据库数据持久化在本地，删除容器不会丢失数据
3. 建议不要将 `mysql/data`、`mongo/data` 等数据目录提交到版本控制
4. SSL 证书文件存放在 `nginx/ssl/` 目录

## 系统要求

- Docker 20.10+
- Docker Compose 2.0+
- 至少 4GB 可用内存

## 时区设置

所有服务默认使用 UTC 时区，可在 `docker-compose.yml` 中修改 `TZ` 环境变量。

## 许可证

MIT
