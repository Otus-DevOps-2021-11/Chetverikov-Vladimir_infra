# Chetverikov-Vladimir_infra
Chetverikov-Vladimir Infra repository

Данные для подключения:

bastion_IP = 51.250.9.137
someinternalhost_IP = 10.128.0.31


###Самостоятельное задание
Исследовать способ подключения к **someinternalhost** в одну
команду из вашего рабочего устройства, проверить работоспособность
найденного решения и внести его в **README.md** в вашем репозитории

###Решение
Для подключения можно использовать следующую команду
>ssh -i C:\Users\Professional\.ssh\appuser\appuser -J appuser@51.250.9.137 appuser@10.128.0.31

где:

_C:\Users\Professional\.ssh\appuser\appuser_ - путь к приватному ключу (Windows)

_appuser@51.250.9.137_ - пользователь и публичный IP **bastion**

_appuser@10.128.0.31_ - пользователь и внутрениий IP **someinternalhost**

###Дополнительное задание:

Предложить вариант решения для подключения из консоли при помощи
команды вида
>ssh someinternalhost

из локальной консоли рабочего устройства, чтобы подключение выполнялось по алиасу
**someinternalhost** и внести его в **README.md** в вашем репозитории

###Решение
Используем алиасы через добавление в конфигурационный файл ssh клиента.

Для этого на локальной машине в файл конфигурации

_C:\Users\Professional\.ssh\config_ (Windows)

добавляются следующие настройки:
```
Host bastion
    HostName 51.250.9.137
    Port 22
    User appuser
    IdentityFile C:\Users\Professional\.ssh\appuser\appuser
Host someinternalhost
    HostName 10.128.0.31
    Port 22
    User appuser
    ProxyJump bastion
```
После чего подключение к **someinternalhost** через **bastion** выглядит как
>ssh someinternalhost

а к хосту **bastion** как
> ssh bastion


###Дополнительное задание
Сейчас веб-интерфейс VPN-сервера Pritunl работает с самоподписанным сертификатом. И браузер постоянно ругается на это.
С помощью сервисов реализуйте использование валидного сертификата для панели управления VPN сервера.

###Решение
Реализовано использование валидного сертификата. Посмотреть можно по адресу:
> https://51.250.9.137.sslip.io/
