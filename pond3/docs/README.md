# IMG Processor

Esta é uma aplicação de processamento de imagens em Flutter para dispositivos móveis.

## Pré-requisitos

Antes de começar a usar esta aplicação, verifique se o seguinte software está instalado em seu sistema:

- Flutter SDK: Você pode seguir as instruções de instalação no [site oficial do Flutter](https://flutter.dev/docs/get-started/install).
- Um dispositivo móvel ou um emulador para testar a aplicação.
- Docker

## Configuração

1. Para usar as funcionalidades do app, primeiro é necessário ativar o gateway no diretório `Modulo10/pond3/back`:

```bash
sudo docker compose up
```

2. Crie um arquivo .env com as suas configurações no diretório `Modulo10/pond3/img_processor`:

```bash
IMG_FILTER_URL = 'http://localhost:8001/img_filter'
LOGGER_URL     = 'http://localhost:8002/logger'
USER_MGMT_URL  = 'http://localhost:8003/user_mgmt'
```

3. Caso tenha um emulador para testar a aplicação, rode o comando:

```bash
flutter emulators --launch <device_name>
```

## Execução da Aplicação

1. Navegue até o diretório do projeto:

```bash
cd img_processor
```

2. Execute a aplicação:

```bash
flutter run
```

Isso iniciará a aplicação na sua máquina, dispositivo móvel ou emulador.

## IMG Processor em Ação!

Você pode conferir um vídeo do funcionamento do aplicativo clicando no link a seguir:
