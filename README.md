# Flutter Music Player

Projeto desenvolvido para a disciplina de Programação De Dispositivos Móveis

## Autoria

Kenji Henrique Ueyama Yashinishi

## Sobre o projeto

Este programa feito em flutter tem como objetivo o aprendizado da ferramenta, incorporando ela com padrões de desenvolvimento, UX e arquitetura do fluxo de dados.
Trata-se de um aplicativo de músicas, podendo carregar elas individualmente, ou em coleções na forma de playlists ou álbuns

### Particularidades

- O padrão adotado para seu desenvolvimento é o MVVM, sendo separado em camadas de Visualização e Dados.
- CRUD na forma de playlists.
  - Faz uso de formulário para sua criação.
  - Obriga um nome para a playlist, exibindo uma mensagem de erro na interface caso inexistente.
- Dados são atualmente apenas estáticos, portanto, qualquer interação com o Back-end é apenas por meio de mocks.
  - Dados que serão futuramente requisitados via API possuem tratamento de erros, e são formatados para seu respectivo tipo ao ser recebido.

### Adições futuras

- Interação com APIs de música reais.
- Reestruturação das Views por meio de uma tela principal que conterá a Navbar.
- Implementação do playback e queue de músicas.

## Instalação

O aplicativo pode ser instalado de duas formas, via apk na release ou via flutter através da source code.

#Via APK

- Na aba releases, baixe o .apk disponível e abra este arquivo no celular, isto irá instalar o aplicativo em seu android.

#Via Flutter

> [!Aviso]
> Certifique-se de que você tem o flutter configurado na sua máquina, caso contrário, os comandos não irão funcionar.
1. Habilite o modo desenvolvedor e debug via USB no seu dispositivo móvel, é recomendado ao leitor pesquisar como fazer isto de acordo com o modelo do seu celular.
2. Baixe o código fonte neste página.
3. Extraia o arquivo em algum local da sua máquina.
4. Abra a pasta ```music_player``` no terminal.
5. Conecte o celular à sua máquina.
6. Use o comando ```flutter devices``` e certifique-se de que o seu celular foi detectado pelo flutter.
7. Use o comando ```run -d <código do seu celular>```.
8. Aguarde (Pode demorar alguns minutos).
9. Caso nenhum erro tenha ocorrido, o aplicativo é instalado, e o debug via ambiente flutter é possível.
