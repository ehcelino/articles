
* Validação de campos - se as palavras de um campo se encontram em uma lista de palavras proibidas, se a palavra contém caracteres proibidos

* Paginação - seletores de página de acordo com o conteúdo, com indicador de página atual

* Usuário administrador - usuário especial com dashboard e recursos exclusivos, incluindo configuração geral do site pela gem rails-settings-cached

* Página de erro 404 - retorna a página de erro caso a página pedida não seja encontrada, com roteamento adequado para não interferir na visualização das imagens

* Comentários em comentários - sistema de comentários com profundidade configurável, comentários em comentários.

* Barra de links no topo da página - barra personalizada com geração de links de acordo com o login do usuário, menus dropdown com css e javascript e acessibilidade

* Parciais - parciais na pasta view/application, que podem ser usadas por qualquer view do sistema. Parcial de alerta, para receber os alertas flash, e parcial navbar, com a barra de navegação.

* JQuery - uso de JQuery para executar scripts no carregamento do dom, mais eficientes que javascript vanilla

* Layout admin - layout separado para gerar as páginas do admin

* Helpers - helper para extrair as imagens anexadas no rich text

* Like - ícone de like / unlike para cada artigo



obs: usar
before_action :remember_page, only: [:index, :show]
nos controllers das páginas que você quer que retornem à página anterior, e nas views usar
<%= link_to_previous_page("voltar") %>