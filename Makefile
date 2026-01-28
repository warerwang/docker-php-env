.PHONY: up down start stop restart pause unpause ps clean

# 启动所有服务
up:
	docker-compose up -d

# 停止并移除所有容器
down:
	docker-compose down

# 启动已存在的容器
start:
	docker-compose start

# 停止容器
stop:
	docker-compose stop

# 重启容器
restart:
	docker-compose restart

# 暂停容器
pause:
	docker-compose pause

# 恢复暂停的容器
unpause:
	docker-compose unpause

# 查看容器状态
ps:
	docker-compose ps

# 清理未使用的镜像和容器
clean:
	docker image prune -f
	docker container prune -f

# 显示帮助信息
help:
	@echo "使用说明:"
	@echo "make up        - 启动所有服务"
	@echo "make down      - 停止并移除所有容器"
	@echo "make start     - 启动已存在的容器"
	@echo "make stop      - 停止容器"
	@echo "make restart   - 重启容器"
	@echo "make pause     - 暂停容器"
	@echo "make unpause   - 恢复暂停的容器"
	@echo "make ps        - 查看容器状态"
	@echo "make clean     - 清理未使用的镜像和容器" 