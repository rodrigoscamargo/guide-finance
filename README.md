<p align="center">
  <a href="https://https://docs.cvcrm.com.br/">
  <a href="">
    <img src="https://i0.wp.com/pop-in.se/wp-content/uploads/2021/11/pokedex_3d.png?fit=1920%2C1080&ssl=1" height="120" width="200" alt="Unform" />
  </a>
</p>

<p align="center">Pokedx Franq</p>

<div align="center">


</div>

Tabela de conteúdos
=================

<!--ts-->
- [Tabela de conteúdos](#tabela-de-conteúdos)
    - [Pré-requisitos](#pré-requisitos)
    - [Testes de cobertura (coverage)](#testes-de-cobertura-coverage)
    - [Padrões](#padrões)
      - [Documentação estática de uma classe](#documentação-estática-de-uma-classe)
      - [Documentação estática de testes](#documentação-estática-de-testes)
    - [Organização de pastas dentro de um módulo || custom\_widget](#organização-de-pastas-dentro-de-um-módulo--custom_widget)
    - [Tests](#tests)
    - [Objetivo dos testes?](#objetivo-dos-testes)
    - [Teste técnico](#teste-técnico)
    - [Dificuldades](#dificuldades)
    - [Tasks](#tasks)
<!--te-->

### Pré-requisitos

Antes de começar, você vai precisar ter instalado em sua máquina as seguintes ferramentas:
[Git](https://git-scm.com), [Flutter](https://flutter.dev/docs/get-started/install). 
Além disto é bom ter um editor para trabalhar com o código como [VSCode](https://code.visualstudio.com/) ou [Android Studio](https://developer.android.com/studio?hl=pt)

### Testes de cobertura (coverage)

Verifica se os algoritimos de teste cobrem toda a lógica de cada função.

```bash
# executa o teste de cobertura e gera o arquivo coverage/lcov.info
flutter test --coverage
```

Para visualizar em uma página HTML é necessário a instalação do pacote `LCOV Code Coverage tool`. Após instalado, executar o comando abaixo para gerar os arquivos:

```bash
genhtml coverage/lcov.info -o html
```

Com os arquivos gerados, basta executar o arquivo index.html dentro da pasta `coverage/html/index.html`para ter acesso a cobertura dos arquivos do projeto.

### Padrões

#### Documentação estática de uma classe

```dart
import 'package:mobx/mobx.dart';

part 'docsstore.g.dart';

class DocumentationStore = _DocumentationStoreBase with _$DocumentationStore;

abstract class _DocumentationStoreBase with Store {
  /* Construtor */
  _DocumentationStoreBase();
  
  //----------------------------- Final variables -----------------------------//
  
  /* Variáveis finais*/
  
  /// Doc simples e direta informando pra quê serve ou o quê irá fazer
  final double spendingAmount = 120.0;
  
  //------------------------------- Observables -------------------------------//
  
  /* Observáveis do mobx */
  
  /// Doc simples e direta informando pra quê serve ou o quê irá fazer
  @observable
  int counter = 0;
  
  //----------------------------- Common variables -----------------------------//
  
  /* Variáveis comuns que não precisam estar observáveis */
  
  /// Doc simples e direta informando pra quê serve ou o quê irá fazer
  bool buttonWasTapped = false;

  //--------------------------------- Getters ---------------------------------//

  /* Getters */

  /// Doc simples e direta informando pra quê serve ou o quê irá fazer 
  int get previousCounter => count--;
  
  //--------------------------- Computed properties ---------------------------//
  
  /* Funções que dispara ações a partir de múltiplos observados */
  
  /// Doc simples e direta informando pra quê serve ou o quê irá fazer
  @computed
  String get counterText => 'The button was tapped $counter times!';
    
  //--------------------------------- Actions ---------------------------------//
  
  /* Funções que irão alterar os atributos(variáveis) observadas (obrigatório do padrão mobx) */
  
  /// Doc simples e direta informando pra quê serve ou o quê irá fazer
  @action
  void increment() => counter++;
  
  //-------------------------------- Functions --------------------------------//
  
  /* Funções que não precisam ser Action do mobx */
  
  /// Doc simples e direta informando pra quê serve ou o quê irá fazer
  void initData() {
    print('initialized');
  }
}
```

#### Documentação estática de testes

```dart
void main() {
  group('NomeDaClasse', () {
    group('função1:', () {
      test('O quê o test1 irá garantir', () {
        /* código do teste */
      });

      test('O quê o test2 irá garantir', () {
        /* código do teste */
      });
    });

    group('função2:', () {
      test('O quê o test1 irá garantir', () {
        /* código do teste */
      });

      test('O quê o test2 irá garantir', () {
        /* código do teste */
      });
  });
}
```



### Organização de pastas dentro de um módulo || custom_widget

```bash
.
├── custom_payment_widget.dart
├── domain
│   ├── entities
│   │   ├── pokedex_entity.dart
│   │   └──  pokemon_entity.dart
│   ├── errors
│   │   └── errors.dart
│   ├── repositories
│   │   └── pokemon_repository.dart
│   └── usecases
│       ├── get_all_pokemons_usecase.dart
│       └── get_all_pokemons_usecase.g.dart
├── external
│   └── data_source
│       ├── pokemon_datasouce_impl.dart
│       └── pokemon_datasouce_impl.g.dart
├── infra
│   ├── data_source
│   │   └── pokemon_ds.dart
│   ├── models
│   │   ├── pokedex_model.dart
│   │   └── pokemon_model.dart
│   │
│   └── repositories
│       ├── pokemon_repository_impl.dart
│       └── pokemon_repository_impl.g.dart
├── presenter
│   ├── stores
│   │   ├── pokemon_store.dart
│   │   └── pokemon_store.g.dart
│   ├── pages
│   │   └── pokemon_page.dart
│   └── components
│       └── pokedex
│           └── pokedex_button.dart
└── utils
    └── utils.dart
```

### Tests

### Objetivo dos testes?

O objetivo do teste unitário não é encontrar erros. É uma especificação para os comportamentos esperados do código em teste. O código em teste é a implementação para os comportamentos esperados. Portanto, o teste unitário e o código em teste são usados ​​para verificar a exatidão uns dos outros e se protegerem. Mais tarde, quando alguém alterou o código em teste e mudou o comportamento esperado pelo autor original, o teste falhará. Se o código estiver coberto por um teste unitário razoável, você pode manter o código sem quebrar a funcionalidade existente. É por isso que Michael Feathers define código legado como código sem teste unitário.


### Teste técnico
### Dificuldades
 Tive um pouco de dificulade para entender a API.

 ### Tasks

- [X] Configuração do Analytics
- [X] Configuração do Crash Analytics
- [x] Scroll infinito (Paginação)
- [x] Tela de detalhes do Pokemon
- [x] Unit test do modulo pokedex
- [ ] Integration test
- [ ] CI/CD com codemagic
- [ ] Custom pokemon
- [ ] Tela de cadastro


```
