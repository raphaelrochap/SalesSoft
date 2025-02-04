# SalesSoft
Um gerenciador de pedidos de venda para Desktop.

## Considerações a cerca de decisões do projeto.

O projeto foi feito utilizando Delphi 12 CE.

Para conexão com o Banco de Dados foi utilizado o Firedac, e a biblioteca necessária para a conexão está disponível aqui neste repositório, o nome é: LIBMYSQL.DLL.

Para que se contecte com sucesso, basta ir no arquivo .ini no diretório do .exe e indicar o caminho da lib.

Em relação ao arquivo .ini, ele está versionado, mas assim que você executar o projeto, ele irá criar um automaticamente para você, basta configurá-lo e sua conexão será estabelecida no início da aplicação.

Optei por trocar o ícone do botão de Adicionar a grid em Runtime, para que ele seja diferente em modo de inclusão ou edição, para isso criei um arquivo .res novo com os respectivos ícones dentro.

A aplicação foi criada utilizando MVC, como pode ser observado pelas pastas no projeto.

Optei por criar uma tela de seleção genérica, entao ela pode mostrar dados de qualquer entidade para seleção.

Todos os recursos pedidos e proteções foram implementados.

Está versionado também, a query de criação das tabelas e o dump para recuperação dos dados. Tendo as tabelas Clientes e Produtos 20, registros cada para utilização do projeto.