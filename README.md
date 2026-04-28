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
