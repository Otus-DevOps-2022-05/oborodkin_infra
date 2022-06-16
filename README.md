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
