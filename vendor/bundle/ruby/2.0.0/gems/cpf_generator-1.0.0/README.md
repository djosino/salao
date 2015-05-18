# CpfGenerator

Gerador de cpf para testes. É algo bem básico usado para gerar cpfs válidos para ser usados em testes.

EN: This is a simple gem to create brazilian cpf numbers to be used for software tests

## Instalação

Adicione essa linha no Gemfile da sua aplicação:

    gem 'cpf_generator', require: false

Execute o bundle para instalar:

    $ bundle

Ou se preferir, instale no seu sistema:

    $ gem install cpf_generator

## Uso

A gem te disponibiliza dois métodos para gerar cpf. **formatted** e **unformatted**

	require 'cpf_generator'

	# Para gerar um cpf formatado
	CpfGenerator.formatted => # 710.743.079-33

	# Para gerar um cpf não formatado
	CpfGenerator.unformatted => # 71074307933


## Contribuindo

1. Faça um Fork
2. Crie um novo branch para a sua modificação (`git checkout -b my-new-feature`)
3. Commit suas alterações (`git commit -am 'Add some feature'`)
4. Faça um Push para o branch (`git push origin my-new-feature`)
5. Crie um novo Pull Request
