# Swift GitHub Repositories

Este projeto em Swift é um aplicativo para listar os repositórios de Swift mais populares do GitHub. Ele foi desenvolvido utilizando conceitos de Clean Architecture, MVI (Model-View-Intent) e outras boas práticas.

## Tecnologias e Frameworks

- **Swift** - Linguagem principal do projeto.
- **RxSwift** - Para gerenciamento reativo de eventos e respostas assíncronas.
- **Swinject** - Para Injeção de Dependência.
- **Alamofire** - Para gerenciamento de requisições de rede.
- **SwiftUI** - Interface do usuário.

## Estrutura do Projeto

O projeto segue a **Clean Architecture**, organizando o código nas camadas de:

1. **Data** - Para acesso a dados de rede e transformação de modelos.
2. **Domain** - Para lógica de negócio e regras específicas.
3. **Presentation** - Para as Views e Interações com o usuário.

As camadas são desacopladas para facilitar a manutenção e possibilitar testes unitários.

## Funcionalidades

- Listagem de repositórios populares com paginação
- Listagem de pull requests do repositório
- Detalhes do pull request em uma webview

## Testes

O projeto conta com cobertura de testes unitários para garantir a integridade e facilitar a manutenção do código.

## Requisitos

- iOS 13.0+
- Swift 5.0+

## Configuração do Ambiente

1. Clone o repositório.
2. Instale as dependências do projeto utilizando CocoaPods.
3. Abra o arquivo .xcworkspace no Xcode.
