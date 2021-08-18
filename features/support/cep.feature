#language: pt

Funcionalidade: CEP
    Para que eu possa verificar se a busca de CEP funciona
    Sendo um desenvolvedor
    Posso pesquisar um valor e verificar a resposta do serviço

    @cep_valido 
    Cenário: Consulta CEP válido
        Dado que o usuário insere um '<CEP>' válido
        Quando o serviço é consultado
        Então é retornado o CEP, logradouro, complemento, bairro, localidade, uf e ibge

        Exemplos:
        |    CEP   |
        | 12246870 |
        | 12248310 |
        | 12248330 | 

    @cep_inexistente
    Cenário: Consulta CEP inexistente
        Dado que o usuário insere um '<CEP>' que não exista na base dos correios
        Quando o serviço é consultado
        Então é retornado um atributo erro

        Exemplos:
        |    CEP   |
        | 00000000 |
        | 10000000 |
        | 99999999 |

    @cep_invalido
    Cenário: Consulta CEP com formato inválido
        Dado que o usuário insere um '<CEP>' com formato inválido
        Quando o serviço é consultado
        Então é retornado uma mensagem de erro

        Exemplos:
        |    CEP   |
        | abcdefgh |
        | 123      |
        |          |