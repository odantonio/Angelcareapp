Olá aqui é o antigo desenvolvedor.

Primeiramente, boa sorte. Eu entrei nesse projeto pegando projeto de outras pessoas. Caso vc esteja se questionando, SIM, é só isso mesmo!

O requisito do sistema está na cabeça das pessoas que te contrataram. Nunca recebi em 9 meses de projeto. Sempre fui questionado se eu recebi, falei várias vezes
mas parece que esquecem. Nunca vi o figma do projeto. Passei 4 meses lendo o código original do frontend para saber o que o programa fazia, tentar criar um requisito do sistema a partir dele.

No fim o mais próximo de um requisito de sistema é:
* O código original era um software de gestão de saúde. Ele possuía usuário, monitor, administrador e médico. Porém não havia nenhuma diferença entre eles.
O formulário preenchido era o mesmo para todos. Monitor e Administrador são personas não definidas. Médico era uma persona não criada ainda. No mesmo formulario, era requerido, mesmo para usuário, o CRM.
Como não foi implementado o médico, este campo foi comentado, mas existia.
* O código original usava Bloc e BlocProvider para gerenciar os estados. Estou usando o Provider para situações como o formulario. O Firebase tem seu proprio sistema de gerenciamento de estado.
Era através do bloc que era definido, através da API que eles criaram, usando um mockup server, que se definia se o usuário era Admin ou User(monitored) ou Monitor e assim definir qual tipo de screen seria exibida.
Não estou usando isso no momento. O backend não tratava disso. A identificação se um usuário era ou não administrador/monitor era pela própria conta. Como deveria ser. O front usava mais de um banco e encandeamento de bancos para
determinar se um usuário tinha permissões de adminitração. Essas incongruências entre os projetos eu não consegui resolver (Não houve comunicação entre as partes originais, assim cada um fez um código recebendo e enviando o que acharam necessários).
* O Programa deveria, pelo que entendi, ter um administrador, a pessoa responsável por contratar o serviço e adicionar usuários (?). Um médico ou assistente responsável por monitorar as condições dos pacientes (?).
* Como nunca houve definição entre os papéis, o código que vc está recebendo, implementa apenas o usuário.

Não está desenhada a condição de pagamento. Numa verão anterior eu implementei o payment do google (Tive QUE, pois nenhuma das condiçõe de exclusão de necessidade tinham sido contemplentadas),
mas como a empresa não tem site, não há como verificar, então, nem adicionei nesta versão. A API do google payment é bastante simples de implementar.

Caso haja a necessidade de alterar o código para Funções e criar um backend, conforme a documentação do firebase, pouca coisa será modificada no atual código.

Esta versão do projeto está desenvolvida flutter 3, na versão 3.10.2, usando Dart 3.0.2. Material 2.

>>>> Firebase_options.dart:
* Este arquivo é gerado automaticamente pelo flutterfire configure.
*
* Você terá que fazer alterações no Firebase. Para uma situação de emergência, a conta principal do Firebase está vinculada a minha conta google.
*
* Eu criei uma conta da AngelCorp, porém enquanto não houver a criação do site da angelcorp para que o google verifique a empresa, ela não tem
* muita utilidade. A conta da AngelCorp é uma conta que têm acesso, mas não tem como gerenciar o banco atual.
*
* A conta é uma conta Spark, sem custos. Mas que possibilita usar o banco. Para dar permissão à conta AngelCorp, precisava ser conta paga.
*
* Então aconselho vc, que está recebendo o código, crie um novo banco dentro usando a conta AngelCorp. É bem simples e rápido, use o cloud-firestore. Rode o flutterfire configure para substituir
* as configurações abaixo.

