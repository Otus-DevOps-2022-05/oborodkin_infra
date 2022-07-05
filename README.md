# oborodkin_infra
oborodkin Infra repository

OTUS 2022-05

## 5 - Знакомство с облачной инфраструктурой и облачными сервисами

### Самостоятельное задание

Исследовать способ подключения к someinternalhost в одну команду из вашего рабочего устройства.

#### Решение

Использовать хост `bastion` как JumpServer с помощью ключа -J команды ssh.

`ssh -J appuser@<bastion> appuser@<internalhost>`

Испольуземая команда для моего окружения:

`ssh -i ~/.ssh/appuser -J appuser@51.250.79.62 appuser@10.128.0.21`

### Дополнительное задание

Предложить вариант решения для подключения из консоли при помощи
команды вида ssh someinternalhost из локальной консоли рабочего
устройства, чтобы подключение выполнялось по алиасу
someinternalhost.

#### Решение

Настроить проксирование stdio через хост basion.

Добавить файл конфигурации `~/.ssh/config`:

```
Host bastion
     Hostname 51.250.79.62
     User appuser
     Port 22
     IdentityFile ~/.ssh/appuser

Host internalhost
     User appuser
     ProxyCommand ssh bastion -W 10.128.0.21:22
```

Описание хоста internalhost позоволяет использовать краткую форму команды для подключения к хосту.

Результат выполнения `ssh basion` - попадаем сразу на внутренний хост, через прокси-хост bastion.

### Задание

Добавлен файл setupvpn.sh.

Добавлен файл cloud-bastion.ovpn

Конфигурация:

```
bastion_IP = 51.250.79.62
someinternalhost_IP = 10.128.0.21
```

## 6 - Основные сервисы Yandex Cloud

```
testapp_IP = 51.250.8.189
testapp_port = 9292
```

Используемая команда CLI для создания и запуска инстанса:

```
yc compute instance create \
  --name reddit-app \
  --hostname reddit-app \
  --cores=2 \
  --memory=4 \
  --core-fraction=20 \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata serial-port-enable=1 \
  --metadata-from-file user-data=user-data.yaml
```

## 7 - Модели управления инфраструктурой. Подготовка образов с помощью Packer 

Что сделано:

1)

Создан шаблон для Packer ubuntu16.json. Ключевые и дополнительные параметры вынесены в переменные.

Пример использования:

`packer build -var-file=variables.json.examples ./ubuntu16.json`

2)

Создан шаблон для Packer для подготовки bake-образа immutable.json

Пример использования:

`packer build -var-file=variables.json.examples ./immutable.json`

В папке files:
 * описание сервиса systemd `reddit-app.service`
 * дополнительные скрипт `deploy.sh` для деплоя ReditApp
 
3)

Создан shell-скрипт config-scripts/create-reddit-vm.sh с командой yc по созданию ВМ на основе подготовленного образа по шаблону immutable.json.

## 8 - Знакомство с Terraform

Что сделано:

1) Основное задание. Конфигурация Terraform:

* main.tf - конфигурация приложения
* variables.tf - входные параметры

2) Добавлен балансировкик lb.tf

3) Управление количеством ВМ через входную переменную

* variables.tf - добавлен входной параметр app_count. Значение указывает на кол-во создаваемых экземпляров ВМ
* main.tf - используется мета-аргумент `count`, через который задаётся кол-во создаваемых экземпляров ВМ
* lb.tf - динамическое построение блока target со списком целевых ВМ, на который балансируется трафик

## 9 - Принципы организации инфраструктурного кода и работа над инфраструктурой в команде на примере Terraform

Что сделано:

1) Основное и самостоятельно задание.

Конфигурация Terraform через модули.
Конфигурация для окружений stage, prod.
Дополнительные параметры для модулей: core_fraction, res_cores, res_memory.

Пример применение конфигурации для окружения prod:

```
cd prod
terraform init
terraform plan
terraform apply
```

2) Задание со звёздочкой

Создал ключ доступа для сервисной учётной записи для работы с Object Storage:

`yc iam access-key create --service-account-name terraformservice --description "Key for bucket"`

Создал и применил отдельную конфигурацию `terraform/bucket` для создания Object Storage в облаке.

Добавил отдельные переменные окружения для последующего использования при инициализации Terraform и подключения backend'а:

```
export SVC_ACCT_ACCESS_KEY="qwe..."
export SVC_ACCT_SECRET_KEY= "qwe..."
export BUCKET_NAME= "name..."
```

Команда для инициализации Terraform с backend в облаке:

```
terraform init \
  -backend-config="access_key=$SVC_ACCT_ACCESS_KEY" \
  -backend-config="secret_key=$SVC_ACCT_SECRET_KEY" \
  -backend-config="bucket=$BUCKET_NAME"
```

Запускал применение конфигурации одновременно stage и prod, не увидел, как работает блокировка.

Обе попытки применения конфигурации срабатывают, пока одна не отвалится из-за ошибки, что уже есть ресурс с таким именем.

