Dado('que o usuário insere um {string} válido') do |cep_valido|
    @cep = cep_valido
end
  
Quando('o serviço é consultado') do
    @result = HTTParty.get("https://viacep.com.br/ws/#{@cep}/json/")
end
  
Então('é retornado o CEP, logradouro, complemento, bairro, localidade, uf e ibge') do
    @endereco = @result.parsed_response
    
    #verifica se o cep retornado é o mesmo passado na chamada do serviço.
    expect((@endereco['cep']).delete("-")).to eql @cep
    
    expect(@endereco).to have_key 'cep'
    expect(@endereco).to have_key 'logradouro'
    expect(@endereco).to have_key 'complemento'
    expect(@endereco).to have_key 'bairro'
    expect(@endereco).to have_key 'localidade'
    expect(@endereco).to have_key 'uf'
    expect(@endereco).to have_key 'ibge'

    expect(@endereco['cep']).not_to be_nil
    expect(@endereco['logradouro']).not_to be_nil
    expect(@endereco['complemento']).not_to be_nil
    expect(@endereco['bairro']).not_to be_nil
    expect(@endereco['localidade']).not_to be_nil
    expect(@endereco['uf']).not_to be_nil
    expect(@endereco['ibge']).not_to be_nil

    
end
  
Dado('que o usuário insere um {string} que não exista na base dos correios') do |cep_inexistente|
    @cep=cep_inexistente
end
  
Então('é retornado um atributo erro') do
    @endereco = @result.parsed_response
    expect(@endereco['erro']).to eql true
    expect(@endereco).to have_key 'erro'

end
  
Dado('que o usuário insere um {string} com formato inválido') do |cep_invalido|
    @cep=cep_invalido
end
  
Então('é retornado uma mensagem de erro') do
    #a validação poderia ser feita através de statuscode, além da mensagem.  
    #expect(@result.code).to eql 400  
    expect(@result).to include('Erro 400')
    expect(@result).to include("Verifique a sua URL (Bad Request)")
end