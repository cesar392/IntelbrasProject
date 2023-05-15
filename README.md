
# IntelbrasProject

Este é o projeto de candidatura para a vaga de emprego na empresa Intelbras.

## Descrição

Este projeto é uma aplicação iOS que permite gerenciar dispositivos de vídeo e centrais de alarme. Ele foi desenvolvido como parte do processo seletivo para a empresa Intelbras. A aplicação permite criar, visualizar e favoritar dispositivos de vídeo.

## Funcionalidades Implementadas

-   Criação de dispositivos de vídeo
-   Visualização de dispositivos de vídeo e centrais de alarme
-   Filtros de favoritos, dispositivos de vídeo e centrais de alarme
-   Favoritar dispositivos de vídeo e centrais de alarme
-   Exibição de lista de dispositivos de favoritados

## Funcionalidades Faltantes

-   Criar centrais de alarme
-   Opção para deleção de dispositivos (não habilitada para o usuário)
-   Caixa de busca para filtrar dispositivos
-   Implementação do banco de dados para armazenar os dispositivos
-   Tratamento de erros e mensagens de feedback ao usuário

## Tecnologias Utilizadas

-   Linguagem: Swift
-   Framework: UIKit
-   Biblioteca: RxSwift
-   Gerenciador de dependências: CocoaPods

## Arquitetura

Este projeto segue a arquitetura MVVM (Model-View-ViewModel) com uma camada adicional de Service e Repository. A estrutura geral da arquitetura é a seguinte:

-   **Model**: Representa os dados do aplicativo, incluindo as entidades e os objetos de transferência de dados (DTOs).
-   **View**: Responsável pela exibição dos elementos visuais na interface do usuário. Neste projeto, as Views são implementadas através de ViewControllers e Storyboards.
-   **ViewModel**: Fornece a lógica de apresentação para as Views. É responsável por processar os dados e prepará-los para serem exibidos pela View. Além disso, também lida com a interação do usuário e ações relacionadas a ela.
-   **Service**: Faz a comunicação com serviços externos, como APIs, e lida com as requisições e respostas.
-   **Repository**: Gerencia o acesso aos dados, seja por meio de serviços externos, bancos de dados ou outros mecanismos de armazenamento.

## Como Executar o Projeto

1.  Clone este repositório em sua máquina local.
2.  Abra um terminal na pasta do projeto e execute `pod install`
4.  Navegue até o diretório do projeto.
5.  Abra o arquivo `IntelbrasProject.xcodeproj` no Xcode.
6.  Compile e execute o projeto no simulador ou dispositivo iOS.

## Observações

-   Certifique-se de ter o Xcode e as dependências necessárias instaladas.
-   A implementação das funcionalidades faltantes podem ser feitas nos locais marcados por comentários no código.

## Contribuição

Este projeto foi desenvolvido como parte de um processo seletivo e não está aberto para contribuições externas no momento.

## Autor

Cesar Comelli
cesarhccomelli@gmail.com
[LinkedIn](https://www.linkedin.com/in/cesar-comelli-6a463b207/)
