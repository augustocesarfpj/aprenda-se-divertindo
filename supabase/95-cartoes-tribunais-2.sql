-- Aprenda se Divertindo · 95 · Baralho de cartões · trilha Tribunais · mais 500 cartões (total de 1.000)
-- Rode depois do 94-cartoes-saude-2.sql. Cole TUDO no SQL Editor e clique em Run. Pode rodar de novo sem problema.
--
insert into public.cartoes (id, trilha, materia, assunto, tipo, frente, verso, explicacao)
select id, trilha, materia, assunto, tipo, frente, verso, explicacao
from jsonb_to_recordset($c$[
{
"id": 2000005001,
"trilha": "tribunais",
"materia": "civ",
"assunto": "LINDB",
"tipo": "pergunta",
"frente": "Em quanto tempo a lei brasileira entra em vigor nos países estrangeiros, quando admitida, se não houver prazo?",
"verso": "3 meses depois de oficialmente publicada.",
"explicacao": "LINDB, art. 1º, § 1º. No Brasil, 45 dias."
},
{
"id": 2000005002,
"trilha": "tribunais",
"materia": "civ",
"assunto": "LINDB",
"tipo": "pergunta",
"frente": "O que a LINDB exige das decisões baseadas em valores jurídicos abstratos?",
"verso": "Que considerem as consequências práticas da decisão.",
"explicacao": "LINDB, art. 20, incluído pela Lei 13.655/2018."
},
{
"id": 2000005003,
"trilha": "tribunais",
"materia": "civ",
"assunto": "LINDB",
"tipo": "pergunta",
"frente": "Qual lei regula o começo e o fim da personalidade, o nome, a capacidade e os direitos de família, segundo a LINDB?",
"verso": "A lei do país em que a pessoa for domiciliada.",
"explicacao": "LINDB, art. 7º."
},
{
"id": 2000005004,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Pessoa natural",
"tipo": "pergunta",
"frente": "Quem pode exigir que cesse a lesão a direito da personalidade de pessoa morta?",
"verso": "O cônjuge sobrevivente ou qualquer parente em linha reta ou colateral até o 4º grau.",
"explicacao": "CC, art. 12, parágrafo único."
},
{
"id": 2000005005,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Pessoa natural",
"tipo": "pergunta",
"frente": "Pode-se usar a imagem de alguém para fins comerciais sem autorização?",
"verso": "Não. A publicação da imagem para fins comerciais sem autorização gera dano moral, independentemente de prova do prejuízo.",
"explicacao": "Súmula 403 do STJ e CC, art. 20."
},
{
"id": 2000005006,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Pessoa natural",
"tipo": "pergunta",
"frente": "Ninguém pode ser constrangido a submeter-se a quê, com risco de vida?",
"verso": "A tratamento médico ou a intervenção cirúrgica.",
"explicacao": "CC, art. 15."
},
{
"id": 2000005007,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Pessoa natural",
"tipo": "pergunta",
"frente": "Quando a pessoa pode alterar o prenome diretamente no cartório?",
"verso": "Após completar 18 anos, uma vez, sem precisar justificar, pela via extrajudicial.",
"explicacao": "Lei 6.015/1973, art. 56, com redação da Lei 14.382/2022."
},
{
"id": 2000005008,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Pessoa jurídica",
"tipo": "pergunta",
"frente": "O que é a sociedade limitada unipessoal?",
"verso": "Sociedade limitada constituída por uma só pessoa, que substituiu a antiga EIRELI.",
"explicacao": "CC, art. 1.052, § 1º, e Lei 14.195/2021."
},
{
"id": 2000005009,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Pessoa jurídica",
"tipo": "pares",
"frente": "Qual a diferença entre a teoria maior e a teoria menor da desconsideração da personalidade jurídica?",
"verso": "Maior (CC): exige abuso da personalidade, por desvio de finalidade ou confusão patrimonial. Menor (CDC e ambiental): basta a pessoa jurídica ser obstáculo ao ressarcimento.",
"explicacao": "CC, art. 50, e CDC, art. 28, § 5º."
},
{
"id": 2000005010,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Pessoa jurídica",
"tipo": "pergunta",
"frente": "O que é a desconsideração inversa da personalidade jurídica?",
"verso": "Atingir o patrimônio da pessoa jurídica por dívida do sócio que esconde bens na empresa.",
"explicacao": "CC, art. 50, § 3º."
},
{
"id": 2000005011,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Bens",
"tipo": "pergunta",
"frente": "O que são pertenças?",
"verso": "Bens que, sem ser partes integrantes, destinam-se de modo duradouro ao uso, serviço ou aformoseamento de outro, como os móveis de uma casa.",
"explicacao": "CC, art. 93. Em regra, não seguem o principal."
},
{
"id": 2000005012,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Bens",
"tipo": "pergunta",
"frente": "O que diz o princípio da gravitação jurídica?",
"verso": "O bem acessório segue o principal.",
"explicacao": "Ex.: os frutos pertencem ao dono da coisa."
},
{
"id": 2000005013,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Bens",
"tipo": "pares",
"frente": "Qual a diferença entre bens divisíveis e indivisíveis?",
"verso": "Divisíveis: podem ser fracionados sem alterar sua substância, diminuir muito o valor ou prejudicar o uso. Indivisíveis: não podem, por natureza, lei ou vontade das partes.",
"explicacao": "CC, arts. 87 e 88."
},
{
"id": 2000005014,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Negócio jurídico",
"tipo": "pergunta",
"frente": "Qual o prazo para anular negócio por coação?",
"verso": "4 anos, contados do dia em que ela cessar.",
"explicacao": "CC, art. 178, I."
},
{
"id": 2000005015,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Negócio jurídico",
"tipo": "pergunta",
"frente": "O que é a reserva mental?",
"verso": "Quando o declarante manifesta algo que não quer, sem que o outro saiba. A manifestação vale, salvo se o destinatário tinha conhecimento.",
"explicacao": "CC, art. 110."
},
{
"id": 2000005016,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Negócio jurídico",
"tipo": "pergunta",
"frente": "O que é a conversão do negócio jurídico nulo?",
"verso": "Se o negócio nulo tiver os requisitos de outro, este subsistirá quando se presumir que as partes o teriam querido.",
"explicacao": "CC, art. 170."
},
{
"id": 2000005017,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Negócio jurídico",
"tipo": "pergunta",
"frente": "O negócio jurídico nulo pode ser confirmado pelas partes?",
"verso": "Não. O nulo não é suscetível de confirmação nem convalesce com o tempo. O anulável pode ser confirmado.",
"explicacao": "CC, art. 169."
},
{
"id": 2000005018,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Prescrição",
"tipo": "pergunta",
"frente": "Qual o prazo de prescrição da pretensão do segurado contra o segurador?",
"verso": "1 ano.",
"explicacao": "CC, art. 206, § 1º, II."
},
{
"id": 2000005019,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Prescrição",
"tipo": "pergunta",
"frente": "Qual o prazo de prescrição dos aluguéis de prédios urbanos ou rústicos?",
"verso": "3 anos.",
"explicacao": "CC, art. 206, § 3º, I."
},
{
"id": 2000005020,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Prescrição",
"tipo": "pergunta",
"frente": "Qual o prazo para cobrar honorários de profissionais liberais?",
"verso": "5 anos, contados da conclusão dos serviços ou do fim do mandato.",
"explicacao": "CC, art. 206, § 5º, II."
},
{
"id": 2000005021,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Prescrição",
"tipo": "pergunta",
"frente": "A decadência convencional pode ser reconhecida de ofício pelo juiz?",
"verso": "Não. Só a decadência legal é conhecida de ofício.",
"explicacao": "CC, arts. 210 e 211."
},
{
"id": 2000005022,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Obrigações",
"tipo": "pergunta",
"frente": "Quem paga mal paga duas vezes: o que significa?",
"verso": "Quem paga a quem não é o credor ou seu representante, em regra, não fica liberado e pode ter de pagar de novo.",
"explicacao": "CC, art. 308. Exceção: pagamento de boa-fé ao credor putativo (art. 309)."
},
{
"id": 2000005023,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Obrigações",
"tipo": "pergunta",
"frente": "O que é dação em pagamento?",
"verso": "Quando o credor aceita receber prestação diversa da que lhe é devida.",
"explicacao": "CC, art. 356."
},
{
"id": 2000005024,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Obrigações",
"tipo": "pergunta",
"frente": "O que é sub-rogação?",
"verso": "Substituição do credor por quem paga a dívida, que passa a ter os mesmos direitos do credor original.",
"explicacao": "CC, arts. 346 a 351."
},
{
"id": 2000005025,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Obrigações",
"tipo": "pergunta",
"frente": "O que é remissão de dívidas?",
"verso": "Perdão da dívida pelo credor, aceito pelo devedor, que extingue a obrigação.",
"explicacao": "CC, art. 385."
},
{
"id": 2000005026,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Obrigações",
"tipo": "pares",
"frente": "Qual a diferença entre danos emergentes e lucros cessantes?",
"verso": "Danos emergentes: o que a vítima efetivamente perdeu. Lucros cessantes: o que razoavelmente deixou de ganhar.",
"explicacao": "CC, art. 402."
},
{
"id": 2000005027,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Obrigações",
"tipo": "pergunta",
"frente": "A obrigação de fazer personalíssima pode ser cumprida por terceiro?",
"verso": "Não. Se for infungível, só o devedor pode cumpri-la; a recusa gera perdas e danos.",
"explicacao": "CC, art. 247."
},
{
"id": 2000005028,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Contratos",
"tipo": "pergunta",
"frente": "Quando se forma o contrato entre ausentes, em regra?",
"verso": "Quando a aceitação é expedida (teoria da expedição), com exceções.",
"explicacao": "CC, art. 434."
},
{
"id": 2000005029,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Contratos",
"tipo": "pergunta",
"frente": "O que é o contrato preliminar?",
"verso": "Contrato em que as partes se obrigam a celebrar um contrato definitivo no futuro, como a promessa de compra e venda.",
"explicacao": "CC, arts. 462 a 466."
},
{
"id": 2000005030,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Contratos",
"tipo": "pergunta",
"frente": "O que é a estipulação em favor de terceiro?",
"verso": "Contrato em que uma parte se obriga a cumprir uma prestação em benefício de terceiro estranho ao contrato.",
"explicacao": "CC, art. 436. Ex.: seguro de vida."
},
{
"id": 2000005031,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Contratos",
"tipo": "pares",
"frente": "Qual a diferença entre distrato e resilição unilateral?",
"verso": "Distrato: as duas partes decidem extinguir o contrato. Resilição unilateral: uma parte encerra o contrato, quando a lei permite, por denúncia.",
"explicacao": "CC, arts. 472 e 473."
},
{
"id": 2000005032,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Compra e venda",
"tipo": "pergunta",
"frente": "O preço da compra e venda pode ser deixado ao arbítrio exclusivo de uma das partes?",
"verso": "Não. Nesse caso o contrato é nulo.",
"explicacao": "CC, art. 489."
},
{
"id": 2000005033,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Compra e venda",
"tipo": "pergunta",
"frente": "Qual o prazo máximo da cláusula de retrovenda?",
"verso": "3 anos.",
"explicacao": "CC, art. 505. O vendedor pode recomprar o imóvel restituindo o preço e as despesas."
},
{
"id": 2000005034,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Compra e venda",
"tipo": "pergunta",
"frente": "Qual o prazo máximo da preferência (preempção) convencional?",
"verso": "180 dias para bens móveis e 2 anos para imóveis.",
"explicacao": "CC, art. 513, parágrafo único."
},
{
"id": 2000005035,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Compra e venda",
"tipo": "pergunta",
"frente": "O que é a venda com reserva de domínio?",
"verso": "Venda de bem móvel em que o vendedor mantém a propriedade até o pagamento integral do preço.",
"explicacao": "CC, art. 521."
},
{
"id": 2000005036,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Contratos em espécie",
"tipo": "pergunta",
"frente": "Qual o prazo máximo do contrato de prestação de serviço no Código Civil?",
"verso": "4 anos.",
"explicacao": "CC, art. 598."
},
{
"id": 2000005037,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Contratos em espécie",
"tipo": "pergunta",
"frente": "O que é o contrato estimatório (venda em consignação)?",
"verso": "O consignante entrega bens móveis ao consignatário, que pode vendê-los pagando o preço ajustado ou devolvê-los no prazo.",
"explicacao": "CC, art. 534."
},
{
"id": 2000005038,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Contratos em espécie",
"tipo": "pergunta",
"frente": "O que é o contrato de depósito?",
"verso": "Contrato em que o depositário recebe um bem móvel para guardar até que o depositante o reclame.",
"explicacao": "CC, art. 627."
},
{
"id": 2000005039,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Contratos em espécie",
"tipo": "pergunta",
"frente": "O que é o mandato e como se instrumentaliza?",
"verso": "Contrato em que alguém recebe poderes para praticar atos ou administrar interesses em nome de outro. O instrumento é a procuração.",
"explicacao": "CC, art. 653."
},
{
"id": 2000005040,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Contratos em espécie",
"tipo": "pergunta",
"frente": "O que é o contrato de corretagem?",
"verso": "Contrato em que alguém se obriga a obter para outro um ou mais negócios, conforme as instruções recebidas, mediante remuneração.",
"explicacao": "CC, art. 722."
},
{
"id": 2000005041,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Contratos em espécie",
"tipo": "pergunta",
"frente": "No contrato de transporte de pessoas, é válida a cláusula que exclui a responsabilidade do transportador?",
"verso": "Não. É nula.",
"explicacao": "CC, art. 734. O transportador responde salvo força maior."
},
{
"id": 2000005042,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Contratos em espécie",
"tipo": "pergunta",
"frente": "Qual o prazo para o locador retomar o imóvel residencial por denúncia vazia?",
"verso": "Nos contratos escritos de 30 meses ou mais, ao fim do prazo, com aviso de 30 dias.",
"explicacao": "Lei 8.245/1991, art. 46."
},
{
"id": 2000005043,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Responsabilidade civil",
"tipo": "pergunta",
"frente": "O dano estético pode ser cumulado com o dano moral?",
"verso": "Sim.",
"explicacao": "Súmula 387 do STJ."
},
{
"id": 2000005044,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Responsabilidade civil",
"tipo": "pergunta",
"frente": "O que é a teoria da perda de uma chance?",
"verso": "Indenização pela perda de oportunidade séria e real de obter vantagem ou evitar prejuízo.",
"explicacao": "Aceita pelo STJ."
},
{
"id": 2000005045,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Responsabilidade civil",
"tipo": "pergunta",
"frente": "Quem responde pelo dano causado por coisas caídas de um prédio?",
"verso": "Quem habita o prédio ou parte dele.",
"explicacao": "CC, art. 938. Em condomínio, se não identificado, o condomínio."
},
{
"id": 2000005046,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Responsabilidade civil",
"tipo": "pergunta",
"frente": "Quem responde pelo dano causado por animal?",
"verso": "O dono ou detentor, se não provar culpa da vítima ou força maior.",
"explicacao": "CC, art. 936."
},
{
"id": 2000005047,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Responsabilidade civil",
"tipo": "pergunta",
"frente": "Os incapazes respondem pelos danos que causam?",
"verso": "Sim, de forma subsidiária e equitativa, se os responsáveis não tiverem obrigação ou meios de pagar, sem privá-los do necessário.",
"explicacao": "CC, art. 928."
},
{
"id": 2000005048,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Posse",
"tipo": "pares",
"frente": "Qual a diferença entre turbação, esbulho e ameaça à posse?",
"verso": "Turbação: perturbação parcial (cabe manutenção). Esbulho: perda da posse (cabe reintegração). Ameaça: risco de agressão (cabe interdito proibitório).",
"explicacao": "CC, art. 1.210."
},
{
"id": 2000005049,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Posse",
"tipo": "pergunta",
"frente": "O detentor (fâmulo da posse) é possuidor?",
"verso": "Não. Quem conserva a posse em nome de outro, em relação de dependência, é mero detentor.",
"explicacao": "CC, art. 1.198. Ex.: caseiro."
},
{
"id": 2000005050,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Propriedade",
"tipo": "pergunta",
"frente": "Quais as formas de acessão de imóveis?",
"verso": "Formação de ilhas, aluvião, avulsão, abandono de álveo, plantações e construções.",
"explicacao": "CC, art. 1.248."
},
{
"id": 2000005051,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Propriedade",
"tipo": "pares",
"frente": "Qual a diferença entre aluvião e avulsão?",
"verso": "Aluvião: acréscimo lento e imperceptível de terras às margens dos rios. Avulsão: deslocamento súbito de porção de terra por força natural violenta.",
"explicacao": "CC, arts. 1.250 e 1.251."
},
{
"id": 2000005052,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Propriedade",
"tipo": "pergunta",
"frente": "Qual o prazo da usucapião extraordinária de bens móveis?",
"verso": "5 anos, independentemente de título e boa-fé.",
"explicacao": "CC, art. 1.261. A ordinária de móveis é de 3 anos."
},
{
"id": 2000005053,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Propriedade",
"tipo": "pergunta",
"frente": "O que é a passagem forçada?",
"verso": "Direito do dono de imóvel sem saída para via pública de exigir do vizinho passagem, mediante indenização.",
"explicacao": "CC, art. 1.285."
},
{
"id": 2000005054,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Direitos reais",
"tipo": "pergunta",
"frente": "O que é o direito real de laje?",
"verso": "Direito do proprietário de uma construção-base de ceder a superfície superior ou inferior para que outro mantenha unidade distinta.",
"explicacao": "CC, art. 1.510-A, incluído pela Lei 13.465/2017."
},
{
"id": 2000005055,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Direitos reais",
"tipo": "pergunta",
"frente": "O que é o direito de superfície?",
"verso": "Direito de construir ou plantar em terreno alheio por tempo determinado, por escritura pública registrada.",
"explicacao": "CC, art. 1.369."
},
{
"id": 2000005056,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Direitos reais",
"tipo": "pergunta",
"frente": "O que é a servidão predial?",
"verso": "Direito real que impõe restrição a um imóvel (serviente) em proveito de outro (dominante), de donos diferentes.",
"explicacao": "CC, art. 1.378. Ex.: servidão de passagem."
},
{
"id": 2000005057,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Direitos reais",
"tipo": "pergunta",
"frente": "O que é a alienação fiduciária em garantia?",
"verso": "O devedor transfere ao credor a propriedade resolúvel do bem como garantia, ficando com a posse direta até quitar a dívida.",
"explicacao": "CC, art. 1.361, e Lei 9.514/1997 (imóveis)."
},
{
"id": 2000005058,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Condomínio",
"tipo": "pergunta",
"frente": "Qual o quórum para alterar a convenção do condomínio edilício?",
"verso": "2/3 dos votos dos condôminos.",
"explicacao": "CC, art. 1.351."
},
{
"id": 2000005059,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Condomínio",
"tipo": "pergunta",
"frente": "O condômino antissocial pode ser multado?",
"verso": "Sim, em até 10 vezes o valor da contribuição, após deliberação de 3/4 dos condôminos.",
"explicacao": "CC, art. 1.337, parágrafo único."
},
{
"id": 2000005060,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Família",
"tipo": "pergunta",
"frente": "Quais pessoas não podem casar (impedimentos)?",
"verso": "Ascendentes com descendentes, afins em linha reta, adotante com quem foi cônjuge do adotado, irmãos e colaterais até o 3º grau, adotado com filho do adotante, pessoas casadas e o cônjuge sobrevivente com o condenado por homicídio do outro.",
"explicacao": "CC, art. 1.521."
},
{
"id": 2000005061,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Família",
"tipo": "pares",
"frente": "Qual a diferença entre impedimentos e causas suspensivas do casamento?",
"verso": "Impedimentos tornam o casamento nulo. Causas suspensivas não anulam, mas impõem o regime de separação obrigatória.",
"explicacao": "CC, arts. 1.521 e 1.523."
},
{
"id": 2000005062,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Família",
"tipo": "pergunta",
"frente": "O que é o casamento putativo?",
"verso": "Casamento nulo ou anulável contraído de boa-fé por um ou ambos os cônjuges, que produz efeitos para o cônjuge de boa-fé e para os filhos.",
"explicacao": "CC, art. 1.561."
},
{
"id": 2000005063,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Família",
"tipo": "pergunta",
"frente": "O que é o regime de participação final nos aquestos?",
"verso": "Durante o casamento, cada cônjuge tem patrimônio próprio; na dissolução, cada um tem direito à metade dos bens adquiridos onerosamente pelo casal.",
"explicacao": "CC, art. 1.672."
},
{
"id": 2000005064,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Família",
"tipo": "pergunta",
"frente": "Quais atos um cônjuge não pode praticar sem autorização do outro, salvo na separação absoluta?",
"verso": "Alienar ou gravar imóveis, pleitear sobre esses bens, prestar fiança ou aval e fazer doação não remuneratória de bens comuns.",
"explicacao": "CC, art. 1.647 (outorga conjugal)."
},
{
"id": 2000005065,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Família",
"tipo": "pergunta",
"frente": "Até que grau vai o parentesco colateral no Código Civil?",
"verso": "Até o 4º grau.",
"explicacao": "CC, art. 1.592. Primos são parentes colaterais de 4º grau."
},
{
"id": 2000005066,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Família",
"tipo": "pergunta",
"frente": "Quais filhos se presumem concebidos na constância do casamento?",
"verso": "Os nascidos 180 dias após o início da convivência conjugal, os nascidos até 300 dias após a dissolução, e os havidos por reprodução assistida nas hipóteses legais.",
"explicacao": "CC, art. 1.597."
},
{
"id": 2000005067,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Família",
"tipo": "pergunta",
"frente": "O que são os alimentos gravídicos?",
"verso": "Valores para cobrir despesas da gravidez, devidos pelo suposto pai, que se convertem em pensão após o nascimento.",
"explicacao": "Lei 11.804/2008."
},
{
"id": 2000005068,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Família",
"tipo": "pergunta",
"frente": "Os avós podem ser obrigados a pagar alimentos aos netos?",
"verso": "Sim, de forma complementar e subsidiária, quando os pais não puderem pagar.",
"explicacao": "Súmula 596 do STJ."
},
{
"id": 2000005069,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Família",
"tipo": "pergunta",
"frente": "A maioridade do filho extingue automaticamente a pensão alimentícia?",
"verso": "Não. O cancelamento depende de decisão judicial, com contraditório.",
"explicacao": "Súmula 358 do STJ."
},
{
"id": 2000005070,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Família",
"tipo": "pergunta",
"frente": "A união estável pode ser reconhecida entre pessoas do mesmo sexo?",
"verso": "Sim.",
"explicacao": "STF, ADI 4.277 e ADPF 132 (2011)."
},
{
"id": 2000005071,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Família",
"tipo": "pares",
"frente": "Qual a diferença entre tutela e curatela?",
"verso": "Tutela: proteção de criança ou adolescente sem os pais (ou com pais destituídos do poder familiar). Curatela: proteção de maiores incapazes para atos patrimoniais.",
"explicacao": "CC, arts. 1.728 e 1.767."
},
{
"id": 2000005072,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Sucessões",
"tipo": "pergunta",
"frente": "O cônjuge concorre com os descendentes na herança?",
"verso": "Sim, salvo se casado em comunhão universal, separação obrigatória ou, na comunhão parcial, se o falecido não deixou bens particulares.",
"explicacao": "CC, art. 1.829, I."
},
{
"id": 2000005073,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Sucessões",
"tipo": "pergunta",
"frente": "Qual a quota mínima do cônjuge que concorre com descendentes comuns?",
"verso": "Não pode ser inferior a 1/4 da herança.",
"explicacao": "CC, art. 1.832."
},
{
"id": 2000005074,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Sucessões",
"tipo": "pergunta",
"frente": "Com quem o cônjuge concorre na falta de descendentes?",
"verso": "Com os ascendentes, qualquer que seja o regime de bens.",
"explicacao": "CC, art. 1.829, II."
},
{
"id": 2000005075,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Sucessões",
"tipo": "pergunta",
"frente": "Qual o direito real de habitação do cônjuge sobrevivente?",
"verso": "Direito de continuar morando no imóvel destinado à residência da família, se for o único dessa natureza a inventariar, qualquer que seja o regime.",
"explicacao": "CC, art. 1.831."
},
{
"id": 2000005076,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Sucessões",
"tipo": "pares",
"frente": "Qual a diferença entre herança jacente e herança vacante?",
"verso": "Jacente: não há herdeiro conhecido, e os bens ficam sob guarda de um curador. Vacante: declarada após as diligências, passando os bens ao poder público depois de 5 anos da abertura da sucessão.",
"explicacao": "CC, arts. 1.819 a 1.823."
},
{
"id": 2000005077,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Sucessões",
"tipo": "pergunta",
"frente": "O que é a colação?",
"verso": "Obrigação dos descendentes de trazer ao inventário o valor das doações recebidas do falecido em vida, para igualar as legítimas.",
"explicacao": "CC, art. 2.002."
},
{
"id": 2000005078,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Sucessões",
"tipo": "pergunta",
"frente": "Qual a idade mínima para fazer testamento?",
"verso": "16 anos.",
"explicacao": "CC, art. 1.860, parágrafo único."
},
{
"id": 2000005079,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Sucessões",
"tipo": "pergunta",
"frente": "Quantas testemunhas exige o testamento público e o particular?",
"verso": "Público: 2 testemunhas. Particular: 3 testemunhas.",
"explicacao": "CC, arts. 1.864 e 1.876. O cerrado exige 2."
},
{
"id": 2000005080,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Sucessões",
"tipo": "pergunta",
"frente": "O que é o codicilo?",
"verso": "Escrito particular, datado e assinado, para disposições sobre enterro, esmolas de pouca monta e móveis de pouco valor.",
"explicacao": "CC, art. 1.881."
},
{
"id": 2000005081,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Sucessões",
"tipo": "pergunta",
"frente": "Qual o prazo para propor a petição de herança, segundo o STJ?",
"verso": "10 anos (prescrição), contados da abertura da sucessão.",
"explicacao": "Entendimento do STJ, com base no art. 205 do CC."
},
{
"id": 2000005082,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Sucessões",
"tipo": "pergunta",
"frente": "O que são os sonegados?",
"verso": "Bens que o herdeiro oculta do inventário. Quem sonega perde o direito sobre eles.",
"explicacao": "CC, art. 1.992."
},
{
"id": 2000005083,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Consumidor",
"tipo": "pergunta",
"frente": "Quem é consumidor para o CDC?",
"verso": "Toda pessoa física ou jurídica que adquire ou utiliza produto ou serviço como destinatário final.",
"explicacao": "CDC, art. 2º. Equipara-se a coletividade de pessoas."
},
{
"id": 2000005084,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Consumidor",
"tipo": "pares",
"frente": "Qual a diferença entre fato do produto e vício do produto?",
"verso": "Fato (acidente de consumo): defeito que causa dano à saúde ou segurança. Vício: problema de qualidade ou quantidade que torna o produto impróprio ou diminui seu valor.",
"explicacao": "CDC, arts. 12 e 18."
},
{
"id": 2000005085,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Consumidor",
"tipo": "pergunta",
"frente": "Quais os prazos para reclamar de vícios aparentes no CDC?",
"verso": "30 dias para produtos e serviços não duráveis e 90 dias para os duráveis.",
"explicacao": "CDC, art. 26 (decadência)."
},
{
"id": 2000005086,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Consumidor",
"tipo": "pergunta",
"frente": "Quando o fornecedor tem de devolver em dobro?",
"verso": "Quando o consumidor é cobrado e paga quantia indevida, salvo engano justificável.",
"explicacao": "CDC, art. 42, parágrafo único."
},
{
"id": 2000005087,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Consumidor",
"tipo": "pergunta",
"frente": "O comerciante responde pelo fato do produto?",
"verso": "Só subsidiariamente: quando o fabricante não puder ser identificado, o produto não tiver identificação clara ou ele não conservar adequadamente produtos perecíveis.",
"explicacao": "CDC, art. 13."
},
{
"id": 2000005088,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Consumidor",
"tipo": "pergunta",
"frente": "O CDC se aplica às instituições financeiras?",
"verso": "Sim.",
"explicacao": "Súmula 297 do STJ."
},
{
"id": 2000005089,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Consumidor",
"tipo": "pergunta",
"frente": "Por quanto tempo uma informação negativa pode ficar em cadastro de inadimplentes?",
"verso": "Até 5 anos.",
"explicacao": "CDC, art. 43, § 1º, e Súmula 323 do STJ."
},
{
"id": 2000005090,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Consumidor",
"tipo": "pares",
"frente": "Qual a diferença entre publicidade enganosa e abusiva?",
"verso": "Enganosa: induz o consumidor a erro sobre o produto. Abusiva: discriminatória, que incita violência, explora medo ou se aproveita da deficiência de julgamento da criança, entre outras.",
"explicacao": "CDC, art. 37."
},
{
"id": 2000005091,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Consumidor",
"tipo": "pergunta",
"frente": "O que é venda casada?",
"verso": "Condicionar o fornecimento de produto ou serviço à compra de outro, ou a limites quantitativos sem justa causa. É prática abusiva.",
"explicacao": "CDC, art. 39, I."
},
{
"id": 2000005092,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Consumidor",
"tipo": "pergunta",
"frente": "Quando o juiz pode inverter o ônus da prova no CDC?",
"verso": "Quando a alegação do consumidor for verossímil ou ele for hipossuficiente, a critério do juiz.",
"explicacao": "CDC, art. 6º, VIII."
},
{
"id": 2000005093,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Consumidor",
"tipo": "pergunta",
"frente": "O que é a responsabilidade solidária na cadeia de fornecimento?",
"verso": "Todos os que participam da cadeia respondem solidariamente pelos vícios do produto ou serviço.",
"explicacao": "CDC, arts. 7º, parágrafo único, e 18."
},
{
"id": 2000005094,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Consumidor",
"tipo": "pergunta",
"frente": "O fornecedor pode enviar produto sem pedido e cobrar depois?",
"verso": "Não. O produto enviado sem solicitação é considerado amostra grátis.",
"explicacao": "CDC, art. 39, III, e parágrafo único."
},
{
"id": 2000005095,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Consumidor",
"tipo": "certo_errado",
"frente": "Certo ou errado? O prazo de arrependimento de 7 dias vale para compras feitas na loja física.",
"verso": "Errado. Vale para compras fora do estabelecimento comercial, como pela internet ou telefone.",
"explicacao": "CDC, art. 49."
},
{
"id": 2000005096,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Família",
"tipo": "certo_errado",
"frente": "Certo ou errado? O pai pode registrar o filho com o nome da mãe sem a presença dela, se casados.",
"verso": "Certo. Na constância do casamento, presume-se a paternidade, e o registro pode ser feito por qualquer dos pais.",
"explicacao": "Lei 6.015/1973, art. 52."
},
{
"id": 2000005097,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Obrigações",
"tipo": "certo_errado",
"frente": "Certo ou errado? Na solidariedade passiva, o credor pode cobrar a dívida toda de qualquer devedor.",
"verso": "Certo.",
"explicacao": "CC, art. 275."
},
{
"id": 2000005098,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Prescrição",
"tipo": "certo_errado",
"frente": "Certo ou errado? A prescrição pode ser alegada em qualquer grau de jurisdição.",
"verso": "Certo, pela parte a quem aproveita.",
"explicacao": "CC, art. 193."
},
{
"id": 2000005099,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Responsabilidade civil",
"tipo": "certo_errado",
"frente": "Certo ou errado? A sentença penal absolutória por negativa de autoria impede a ação de indenização no cível.",
"verso": "Certo. Quando o juízo criminal decide sobre a existência do fato ou sobre quem é o autor, isso não se questiona mais no cível.",
"explicacao": "CC, art. 935."
},
{
"id": 2000005100,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Família",
"tipo": "certo_errado",
"frente": "Certo ou errado? Pessoa maior de 70 anos pode escolher livremente o regime de bens no casamento.",
"verso": "Certo, desde a decisão do STF de 2024: a separação obrigatória pode ser afastada por escritura pública.",
"explicacao": "STF, Tema 1.236 (ARE 1.309.642)."
},
{
"id": 2000005101,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Sucessões",
"tipo": "lacuna",
"frente": "\"A legítima dos herdeiros necessários corresponde à ____ dos bens da herança.\"",
"verso": "metade",
"explicacao": "CC, art. 1.846."
},
{
"id": 2000005102,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Bens",
"tipo": "lacuna",
"frente": "\"Os bens públicos dominicais podem ser alienados, observadas as exigências da ____.\"",
"verso": "lei",
"explicacao": "CC, art. 101."
},
{
"id": 2000005103,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Normas fundamentais",
"tipo": "pergunta",
"frente": "O que diz o princípio da primazia do julgamento de mérito no CPC?",
"verso": "As partes têm direito de obter em prazo razoável a solução integral do mérito, e o juiz deve, sempre que possível, corrigir vícios em vez de extinguir o processo sem resolvê-lo.",
"explicacao": "CPC, arts. 4º, 139, IX, e 317."
},
{
"id": 2000005104,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Normas fundamentais",
"tipo": "pergunta",
"frente": "Qual o dever de cooperação no processo civil?",
"verso": "Todos os sujeitos do processo devem cooperar entre si para que se obtenha decisão de mérito justa, efetiva e em tempo razoável.",
"explicacao": "CPC, art. 6º."
},
{
"id": 2000005105,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Jurisdição e ação",
"tipo": "pergunta",
"frente": "Quais as condições da ação no CPC/2015?",
"verso": "Interesse e legitimidade.",
"explicacao": "CPC, art. 17. A possibilidade jurídica do pedido deixou de ser condição autônoma."
},
{
"id": 2000005106,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Jurisdição e ação",
"tipo": "pergunta",
"frente": "O que é a legitimação extraordinária?",
"verso": "Quando alguém pleiteia direito alheio em nome próprio, só admitida se autorizada pelo ordenamento jurídico.",
"explicacao": "CPC, art. 18. Ex.: substituto processual."
},
{
"id": 2000005107,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Competência",
"tipo": "pergunta",
"frente": "Qual o foro competente para o inventário?",
"verso": "O foro do último domicílio do autor da herança no Brasil.",
"explicacao": "CPC, art. 48."
},
{
"id": 2000005108,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Competência",
"tipo": "pergunta",
"frente": "Qual o foro competente nas ações de divórcio?",
"verso": "O do domicílio do guardião de filho incapaz; não havendo, o do último domicílio do casal; e, se nenhuma das partes residir nele, o do domicílio do réu. A vítima de violência doméstica tem foro próprio.",
"explicacao": "CPC, art. 53, I."
},
{
"id": 2000005109,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Competência",
"tipo": "pergunta",
"frente": "Quando ocorre a prorrogação da competência relativa?",
"verso": "Quando o réu não alega a incompetência relativa em preliminar de contestação.",
"explicacao": "CPC, art. 65."
},
{
"id": 2000005110,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Competência",
"tipo": "pergunta",
"frente": "Qual o efeito do reconhecimento da incompetência sobre as decisões já proferidas?",
"verso": "Em regra, conservam seus efeitos até que outra seja proferida pelo juízo competente, se for o caso.",
"explicacao": "CPC, art. 64, § 4º."
},
{
"id": 2000005111,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Sujeitos do processo",
"tipo": "pergunta",
"frente": "O que é a gratuidade da justiça e quem pode pedir?",
"verso": "Isenção de custas e honorários para pessoa natural ou jurídica, brasileira ou estrangeira, sem recursos suficientes.",
"explicacao": "CPC, art. 98. Presume-se verdadeira a alegação da pessoa natural."
},
{
"id": 2000005112,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Sujeitos do processo",
"tipo": "pergunta",
"frente": "Os honorários advocatícios podem ser compensados em caso de sucumbência recíproca?",
"verso": "Não. É vedada a compensação.",
"explicacao": "CPC, art. 85, § 14."
},
{
"id": 2000005113,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Sujeitos do processo",
"tipo": "pergunta",
"frente": "O que são honorários recursais?",
"verso": "Majoração dos honorários pelo tribunal ao julgar recurso, considerando o trabalho adicional.",
"explicacao": "CPC, art. 85, § 11, respeitados os limites do § 2º."
},
{
"id": 2000005114,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Sujeitos do processo",
"tipo": "pergunta",
"frente": "Quais as hipóteses de impedimento do juiz (exemplos)?",
"verso": "Atuou como advogado, perito ou MP no processo; conheceu dele em outro grau; é parte ou parente de parte; ou seu cônjuge ou parente é advogado no processo.",
"explicacao": "CPC, art. 144."
},
{
"id": 2000005115,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Sujeitos do processo",
"tipo": "pares",
"frente": "Qual a diferença entre impedimento e suspeição do juiz?",
"verso": "Impedimento: hipóteses objetivas, gera nulidade e permite ação rescisória. Suspeição: hipóteses subjetivas (amizade íntima, inimizade, interesse), deve ser alegada no prazo.",
"explicacao": "CPC, arts. 144 e 145."
},
{
"id": 2000005116,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Sujeitos do processo",
"tipo": "pergunta",
"frente": "Qual o prazo para alegar impedimento ou suspeição do juiz?",
"verso": "15 dias, contados do conhecimento do fato.",
"explicacao": "CPC, art. 146."
},
{
"id": 2000005117,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Litisconsórcio",
"tipo": "pergunta",
"frente": "O juiz pode limitar o litisconsórcio facultativo?",
"verso": "Sim, quando o número de litigantes comprometer a rápida solução do litígio ou dificultar a defesa ou o cumprimento da sentença.",
"explicacao": "CPC, art. 113, § 1º (litisconsórcio multitudinário)."
},
{
"id": 2000005118,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Intervenção de terceiros",
"tipo": "pergunta",
"frente": "O que é a denunciação da lide?",
"verso": "Intervenção em que a parte chama terceiro que tem obrigação de indenizá-la regressivamente caso perca a demanda.",
"explicacao": "CPC, art. 125. Ex.: chamar a seguradora."
},
{
"id": 2000005119,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Intervenção de terceiros",
"tipo": "pergunta",
"frente": "O que é o chamamento ao processo?",
"verso": "Intervenção em que o réu chama os codevedores solidários ou o devedor principal (no caso do fiador) para integrarem o processo.",
"explicacao": "CPC, art. 130."
},
{
"id": 2000005120,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Intervenção de terceiros",
"tipo": "pergunta",
"frente": "Quem pode ser amicus curiae?",
"verso": "Pessoa natural ou jurídica, órgão ou entidade especializada, com representatividade adequada, em causas relevantes, específicas ou de grande repercussão social.",
"explicacao": "CPC, art. 138. Não pode recorrer, salvo embargos de declaração e no IRDR."
},
{
"id": 2000005121,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Intervenção de terceiros",
"tipo": "pares",
"frente": "Qual a diferença entre assistência simples e litisconsorcial?",
"verso": "Simples: o assistente tem interesse jurídico em que a decisão favoreça o assistido, atuando como auxiliar. Litisconsorcial: a sentença influirá na relação jurídica entre o assistente e o adversário do assistido.",
"explicacao": "CPC, arts. 121 e 124."
},
{
"id": 2000005122,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Atos processuais",
"tipo": "pergunta",
"frente": "Qual o prazo do juiz para proferir sentença?",
"verso": "30 dias.",
"explicacao": "CPC, art. 226, III. Decisões interlocutórias: 10 dias; despachos: 5 dias."
},
{
"id": 2000005123,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Atos processuais",
"tipo": "pergunta",
"frente": "O que é o calendário processual?",
"verso": "Fixação, de comum acordo entre juiz e partes, das datas para a prática dos atos, dispensando intimações.",
"explicacao": "CPC, art. 191."
},
{
"id": 2000005124,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Atos processuais",
"tipo": "pergunta",
"frente": "Qual a regra de prazo para litisconsortes com advogados diferentes?",
"verso": "Prazo em dobro, de escritórios distintos, salvo em processos em autos eletrônicos.",
"explicacao": "CPC, art. 229."
},
{
"id": 2000005125,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Nulidades",
"tipo": "pergunta",
"frente": "Pode-se decretar nulidade se não houve prejuízo?",
"verso": "Não. Não se decreta nulidade sem prejuízo (pas de nullité sans grief).",
"explicacao": "CPC, arts. 282, § 1º, e 283."
},
{
"id": 2000005126,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Tutela provisória",
"tipo": "pergunta",
"frente": "Qual o prazo para aditar a petição inicial após a concessão de tutela antecipada antecedente?",
"verso": "15 dias ou outro maior fixado pelo juiz.",
"explicacao": "CPC, art. 303, § 1º, I."
},
{
"id": 2000005127,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Tutela provisória",
"tipo": "pergunta",
"frente": "Qual o prazo para formular o pedido principal após efetivada a tutela cautelar antecedente?",
"verso": "30 dias.",
"explicacao": "CPC, art. 308."
},
{
"id": 2000005128,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Tutela provisória",
"tipo": "pergunta",
"frente": "Em quanto tempo se pode rever a tutela antecipada estabilizada?",
"verso": "Em até 2 anos, por ação própria.",
"explicacao": "CPC, art. 304, § 5º."
},
{
"id": 2000005129,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Procedimento comum",
"tipo": "pergunta",
"frente": "O que o réu deve alegar em preliminar de contestação?",
"verso": "Matérias processuais como inexistência de citação, incompetência, incorreção do valor da causa, inépcia, perempção, litispendência, coisa julgada, conexão, incapacidade, convenção de arbitragem, ausência de legitimidade ou interesse e indevida gratuidade.",
"explicacao": "CPC, art. 337."
},
{
"id": 2000005130,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Procedimento comum",
"tipo": "pergunta",
"frente": "O que é o princípio da eventualidade na contestação?",
"verso": "O réu deve alegar toda a matéria de defesa na contestação, sob pena de preclusão.",
"explicacao": "CPC, art. 336."
},
{
"id": 2000005131,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Procedimento comum",
"tipo": "pergunta",
"frente": "O que é o julgamento antecipado parcial do mérito?",
"verso": "Decisão sobre parte dos pedidos que se mostrar incontroversa ou em condições de imediato julgamento.",
"explicacao": "CPC, art. 356. Recorrível por agravo de instrumento."
},
{
"id": 2000005132,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Procedimento comum",
"tipo": "pergunta",
"frente": "O que é o saneamento compartilhado?",
"verso": "Em causas complexas, o juiz designa audiência para fazer o saneamento em cooperação com as partes.",
"explicacao": "CPC, art. 357, § 3º."
},
{
"id": 2000005133,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Provas",
"tipo": "pergunta",
"frente": "O que é a distribuição dinâmica do ônus da prova?",
"verso": "O juiz pode atribuir o ônus de modo diverso, por decisão fundamentada, diante da impossibilidade ou excessiva dificuldade de cumprir o encargo ou da maior facilidade de obter a prova do fato contrário.",
"explicacao": "CPC, art. 373, § 1º."
},
{
"id": 2000005134,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Provas",
"tipo": "pergunta",
"frente": "Quem não pode depor como testemunha por ser incapaz?",
"verso": "Interdito por enfermidade ou deficiência mental, quem não tinha discernimento ao tempo dos fatos, menor de 16 anos e o cego e o surdo quando a ciência do fato depender dos sentidos que lhes faltam.",
"explicacao": "CPC, art. 447, § 1º."
},
{
"id": 2000005135,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Provas",
"tipo": "pergunta",
"frente": "O que é a ata notarial?",
"verso": "Documento lavrado por tabelião que atesta a existência e o modo de existir de algum fato, como o conteúdo de um site.",
"explicacao": "CPC, art. 384."
},
{
"id": 2000005136,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Sentença",
"tipo": "pergunta",
"frente": "Quando uma decisão não é considerada fundamentada, segundo o CPC (exemplos)?",
"verso": "Quando só reproduz ato normativo sem explicar sua relação com a causa, usa conceitos indeterminados sem explicar, invoca motivos genéricos ou não enfrenta os argumentos capazes de infirmar a conclusão.",
"explicacao": "CPC, art. 489, § 1º."
},
{
"id": 2000005137,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Sentença",
"tipo": "pergunta",
"frente": "Quais os limites objetivos da coisa julgada sobre questão prejudicial?",
"verso": "A resolução de questão prejudicial faz coisa julgada se dela depender o mérito, houver contraditório prévio e efetivo e o juízo for competente para resolvê-la como principal.",
"explicacao": "CPC, art. 503, § 1º."
},
{
"id": 2000005138,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Sentença",
"tipo": "pergunta",
"frente": "O que não faz coisa julgada?",
"verso": "Os motivos e a verdade dos fatos estabelecida como fundamento da sentença.",
"explicacao": "CPC, art. 504."
},
{
"id": 2000005139,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Cumprimento de sentença",
"tipo": "pergunta",
"frente": "Como se cobra a Fazenda Pública por quantia certa após a sentença?",
"verso": "Por precatório ou requisição de pequeno valor (RPV), após o prazo de 30 dias para impugnação.",
"explicacao": "CPC, arts. 534 e 535."
},
{
"id": 2000005140,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Cumprimento de sentença",
"tipo": "pergunta",
"frente": "Qual o prazo para o devedor de alimentos pagar, provar que pagou ou justificar, na execução sob pena de prisão?",
"verso": "3 dias.",
"explicacao": "CPC, art. 528."
},
{
"id": 2000005141,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Execução",
"tipo": "pergunta",
"frente": "Qual o efeito do pagamento integral em 3 dias na execução de título extrajudicial?",
"verso": "Os honorários fixados em 10% são reduzidos pela metade.",
"explicacao": "CPC, art. 827, § 1º."
},
{
"id": 2000005142,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Execução",
"tipo": "pergunta",
"frente": "O que é o parcelamento do débito na execução?",
"verso": "No prazo dos embargos, o executado que reconhece o crédito e deposita 30% do valor pode pedir para pagar o resto em até 6 parcelas mensais corrigidas.",
"explicacao": "CPC, art. 916."
},
{
"id": 2000005143,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Execução",
"tipo": "pergunta",
"frente": "O que é a adjudicação na execução?",
"verso": "Forma de expropriação em que o exequente ou outros legitimados ficam com o bem penhorado por preço não inferior ao da avaliação.",
"explicacao": "CPC, art. 876."
},
{
"id": 2000005144,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Execução",
"tipo": "pergunta",
"frente": "O que é a prescrição intercorrente na execução?",
"verso": "Prescrição que corre durante o processo, quando não são encontrados bens penhoráveis, após a suspensão de 1 ano.",
"explicacao": "CPC, art. 921, §§ 1º a 4º."
},
{
"id": 2000005145,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Execução",
"tipo": "pergunta",
"frente": "Qual o prazo dos embargos à execução de título extrajudicial?",
"verso": "15 dias, contados da juntada do mandado de citação.",
"explicacao": "CPC, art. 915. Não dependem de penhora."
},
{
"id": 2000005146,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Execução",
"tipo": "pergunta",
"frente": "Os embargos à execução suspendem automaticamente a execução?",
"verso": "Não. Só com requerimento, garantia do juízo e presença dos requisitos da tutela provisória.",
"explicacao": "CPC, art. 919."
},
{
"id": 2000005147,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Recursos",
"tipo": "pergunta",
"frente": "O que é a teoria da causa madura?",
"verso": "O tribunal pode julgar o mérito diretamente na apelação, se o processo estiver em condições de imediato julgamento.",
"explicacao": "CPC, art. 1.013, § 3º."
},
{
"id": 2000005148,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Recursos",
"tipo": "pergunta",
"frente": "As decisões interlocutórias não agraváveis precluem?",
"verso": "Não. Podem ser impugnadas em preliminar de apelação ou nas contrarrazões.",
"explicacao": "CPC, art. 1.009, § 1º."
},
{
"id": 2000005149,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Recursos",
"tipo": "pergunta",
"frente": "Quais são algumas decisões interlocutórias que cabem agravo de instrumento?",
"verso": "Tutelas provisórias, mérito do processo, rejeição da convenção de arbitragem, desconsideração da personalidade jurídica, gratuidade, exibição de documento e exclusão de litisconsorte.",
"explicacao": "CPC, art. 1.015. O STJ fixou taxatividade mitigada (Tema 988)."
},
{
"id": 2000005150,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Recursos",
"tipo": "pergunta",
"frente": "O que é a taxatividade mitigada do agravo de instrumento?",
"verso": "Cabe agravo de instrumento fora do rol do art. 1.015 quando houver urgência decorrente da inutilidade do julgamento da questão na apelação.",
"explicacao": "STJ, Tema 988."
},
{
"id": 2000005151,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Recursos",
"tipo": "pergunta",
"frente": "O que é a reformatio in pejus e ela é permitida?",
"verso": "Piora da situação do único recorrente pelo julgamento do seu próprio recurso. Em regra, é vedada.",
"explicacao": "Princípio da proibição da reforma para pior."
},
{
"id": 2000005152,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Recursos",
"tipo": "pergunta",
"frente": "O que é o recurso adesivo?",
"verso": "Recurso interposto pela parte que também sucumbiu, no prazo das contrarrazões, subordinado ao recurso principal.",
"explicacao": "CPC, art. 997. Cabe na apelação, no REsp e no RE."
},
{
"id": 2000005153,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Recursos",
"tipo": "pergunta",
"frente": "Qual a exigência para o recurso extraordinário ser admitido, além do prequestionamento?",
"verso": "A demonstração da repercussão geral da questão constitucional.",
"explicacao": "CF, art. 102, § 3º, e CPC, art. 1.035."
},
{
"id": 2000005154,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Recursos",
"tipo": "pergunta",
"frente": "O que exige a EC 125/2022 para o recurso especial?",
"verso": "A demonstração da relevância das questões de direito federal infraconstitucional.",
"explicacao": "CF, art. 105, §§ 2º e 3º."
},
{
"id": 2000005155,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Precedentes",
"tipo": "pergunta",
"frente": "O que é o incidente de assunção de competência (IAC)?",
"verso": "Incidente em que o órgão colegiado indicado pelo regimento julga recurso, remessa necessária ou causa originária com relevante questão de direito e grande repercussão social, sem repetição em múltiplos processos.",
"explicacao": "CPC, art. 947."
},
{
"id": 2000005156,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Precedentes",
"tipo": "pares",
"frente": "Qual a diferença entre distinguishing e overruling?",
"verso": "Distinguishing: o caso concreto é diferente do precedente, que não se aplica. Overruling: o precedente é superado e deixa de valer.",
"explicacao": "Técnicas de aplicação de precedentes (CPC, arts. 489, § 1º, VI, e 927, § 4º)."
},
{
"id": 2000005157,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Ação rescisória",
"tipo": "pergunta",
"frente": "Qual o depósito exigido para propor ação rescisória?",
"verso": "5% do valor da causa, limitado a 1.000 salários mínimos.",
"explicacao": "CPC, art. 968, II. Dispensados entes públicos e beneficiários da gratuidade."
},
{
"id": 2000005158,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Procedimentos especiais",
"tipo": "pergunta",
"frente": "Qual o prazo para o réu cumprir o mandado monitório ou opor embargos?",
"verso": "15 dias.",
"explicacao": "CPC, art. 701. Se pagar, fica isento de custas, com honorários de 5%."
},
{
"id": 2000005159,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Procedimentos especiais",
"tipo": "pergunta",
"frente": "Quando o inventário pode ser feito em cartório?",
"verso": "Se todos forem capazes e concordes, com advogado. Desde 2024, o CNJ admite mesmo com herdeiro incapaz ou testamento, com requisitos.",
"explicacao": "CPC, art. 610, e Resolução CNJ 571/2024."
},
{
"id": 2000005160,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Procedimentos especiais",
"tipo": "pergunta",
"frente": "Qual o prazo para instaurar o inventário?",
"verso": "2 meses, contados da abertura da sucessão, para terminar nos 12 meses seguintes.",
"explicacao": "CPC, art. 611."
},
{
"id": 2000005161,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Procedimentos especiais",
"tipo": "pergunta",
"frente": "Qual o prazo para opor embargos de terceiro no processo de execução?",
"verso": "Até 5 dias depois da adjudicação, alienação ou arrematação, mas sempre antes da assinatura da respectiva carta.",
"explicacao": "CPC, art. 675."
},
{
"id": 2000005162,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Procedimentos especiais",
"tipo": "pergunta",
"frente": "Qual a diferença entre posse nova e posse velha nas ações possessórias?",
"verso": "Posse nova: ação proposta em até 1 ano e dia da turbação ou esbulho, com rito especial e liminar. Posse velha: após esse prazo, segue o procedimento comum.",
"explicacao": "CPC, art. 558."
},
{
"id": 2000005163,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Juizados",
"tipo": "pergunta",
"frente": "Quem não pode ser parte no Juizado Especial Cível estadual?",
"verso": "Incapaz, preso, pessoas jurídicas de direito público, empresas públicas da União, massa falida e insolvente civil.",
"explicacao": "Lei 9.099/1995, art. 8º."
},
{
"id": 2000005164,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Mandado de segurança",
"tipo": "pergunta",
"frente": "O mandado de segurança substitui ação de cobrança?",
"verso": "Não.",
"explicacao": "Súmula 269 do STF."
},
{
"id": 2000005165,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Recursos",
"tipo": "certo_errado",
"frente": "Certo ou errado? No CPC, o juízo de admissibilidade da apelação é feito pelo juiz de primeiro grau.",
"verso": "Errado. O juízo de admissibilidade é feito só pelo tribunal.",
"explicacao": "CPC, art. 1.010, § 3º."
},
{
"id": 2000005166,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Atos processuais",
"tipo": "certo_errado",
"frente": "Certo ou errado? A Fazenda Pública tem prazo em dobro para todas as manifestações processuais.",
"verso": "Certo, contado da intimação pessoal, salvo quando a lei fixar prazo próprio para o ente público.",
"explicacao": "CPC, art. 183."
},
{
"id": 2000005167,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Procedimento comum",
"tipo": "certo_errado",
"frente": "Certo ou errado? A reconvenção pode ser proposta na própria contestação.",
"verso": "Certo.",
"explicacao": "CPC, art. 343."
},
{
"id": 2000005168,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Execução",
"tipo": "certo_errado",
"frente": "Certo ou errado? O bem de família pode ser penhorado para pagar dívida de pensão alimentícia.",
"verso": "Certo. É uma das exceções à impenhorabilidade.",
"explicacao": "Lei 8.009/1990, art. 3º, III."
},
{
"id": 2000005169,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Sentença",
"tipo": "lacuna",
"frente": "\"Transitada em julgado a decisão de mérito, considerar-se-ão deduzidas e repelidas todas as alegações e as defesas que a parte poderia opor. Esse é o efeito ____ da coisa julgada.\"",
"verso": "preclusivo",
"explicacao": "CPC, art. 508 (eficácia preclusiva)."
},
{
"id": 2000005170,
"trilha": "tribunais",
"materia": "prev",
"assunto": "Seguridade social",
"tipo": "pergunta",
"frente": "A saúde depende de contribuição para ser acessada?",
"verso": "Não. É direito de todos e dever do Estado, independentemente de contribuição.",
"explicacao": "CF, art. 196."
},
{
"id": 2000005171,
"trilha": "tribunais",
"materia": "prev",
"assunto": "Seguridade social",
"tipo": "pergunta",
"frente": "A assistência social exige contribuição?",
"verso": "Não. É prestada a quem dela necessitar, independentemente de contribuição.",
"explicacao": "CF, art. 203."
},
{
"id": 2000005172,
"trilha": "tribunais",
"materia": "prev",
"assunto": "Custeio",
"tipo": "pergunta",
"frente": "Qual o prazo para uma contribuição social nova começar a ser cobrada?",
"verso": "90 dias após a publicação da lei que a instituiu ou modificou (anterioridade nonagesimal).",
"explicacao": "CF, art. 195, § 6º."
},
{
"id": 2000005173,
"trilha": "tribunais",
"materia": "prev",
"assunto": "Custeio",
"tipo": "pergunta",
"frente": "As entidades beneficentes de assistência social pagam contribuição para a seguridade social?",
"verso": "Não. São imunes, cumpridas as exigências da lei complementar.",
"explicacao": "CF, art. 195, § 7º, e LC 187/2021."
},
{
"id": 2000005174,
"trilha": "tribunais",
"materia": "prev",
"assunto": "Custeio",
"tipo": "pergunta",
"frente": "Qual a alíquota do MEI para a previdência?",
"verso": "5% do salário mínimo.",
"explicacao": "Lei 8.212/1991, art. 21, § 2º, II, 'a'."
},
{
"id": 2000005175,
"trilha": "tribunais",
"materia": "prev",
"assunto": "Custeio",
"tipo": "pergunta",
"frente": "Qual a contribuição do segurado especial?",
"verso": "1,2% (1,1% previdência + 0,1% risco) sobre a receita bruta da comercialização da produção, mais 0,2% para o SENAR.",
"explicacao": "Lei 8.212/1991, art. 25."
},
{
"id": 2000005176,
"trilha": "tribunais",
"materia": "prev",
"assunto": "Segurados",
"tipo": "pergunta",
"frente": "Qual a idade mínima para filiar-se ao RGPS como segurado facultativo?",
"verso": "16 anos.",
"explicacao": "Decreto 3.048/1999, art. 11."
},
{
"id": 2000005177,
"trilha": "tribunais",
"materia": "prev",
"assunto": "Segurados",
"tipo": "pergunta",
"frente": "O síndico de condomínio remunerado é qual tipo de segurado?",
"verso": "Contribuinte individual.",
"explicacao": "Lei 8.213/1991, art. 11, V, 'f'."
},
{
"id": 2000005178,
"trilha": "tribunais",
"materia": "prev",
"assunto": "Segurados",
"tipo": "pergunta",
"frente": "Por quanto tempo o segurado mantém a qualidade após deixar de contribuir, em regra?",
"verso": "12 meses, prorrogáveis para 24 se tiver mais de 120 contribuições sem perda da qualidade, e mais 12 se desempregado.",
"explicacao": "Lei 8.213/1991, art. 15, II, §§ 1º e 2º."
},
{
"id": 2000005179,
"trilha": "tribunais",
"materia": "prev",
"assunto": "Segurados",
"tipo": "pergunta",
"frente": "Por quanto tempo o segurado preso mantém a qualidade de segurado após o livramento?",
"verso": "12 meses.",
"explicacao": "Lei 8.213/1991, art. 15, IV."
},
{
"id": 2000005180,
"trilha": "tribunais",
"materia": "prev",
"assunto": "Dependentes",
"tipo": "pergunta",
"frente": "A dependência econômica do cônjuge e dos filhos precisa ser provada?",
"verso": "Não, é presumida. A dos pais e irmãos deve ser comprovada.",
"explicacao": "Lei 8.213/1991, art. 16, § 4º."
},
{
"id": 2000005181,
"trilha": "tribunais",
"materia": "prev",
"assunto": "Carência",
"tipo": "pergunta",
"frente": "Qual a carência da aposentadoria por incapacidade permanente e do auxílio por incapacidade temporária?",
"verso": "12 contribuições mensais, salvo acidente, doença profissional ou doenças da lista.",
"explicacao": "Lei 8.213/1991, arts. 25, I, e 26, II."
},
{
"id": 2000005182,
"trilha": "tribunais",
"materia": "prev",
"assunto": "Carência",
"tipo": "pergunta",
"frente": "Qual a carência do salário-maternidade da contribuinte individual, facultativa e segurada especial?",
"verso": "10 contribuições mensais. Para a empregada, doméstica e avulsa não há carência.",
"explicacao": "Lei 8.213/1991, art. 25, III. O STF afastou a carência para a contribuinte individual (ADI 2.110)."
},
{
"id": 2000005183,
"trilha": "tribunais",
"materia": "prev",
"assunto": "Benefícios",
"tipo": "pergunta",
"frente": "Quais os requisitos da aposentadoria programada do homem que se filia ao RGPS após a EC 103/2019?",
"verso": "65 anos de idade e 20 anos de tempo de contribuição.",
"explicacao": "EC 103/2019, art. 19."
},
{
"id": 2000005184,
"trilha": "tribunais",
"materia": "prev",
"assunto": "Benefícios",
"tipo": "pergunta",
"frente": "Qual o valor do auxílio-acidente?",
"verso": "50% do salário de benefício.",
"explicacao": "Lei 8.213/1991, art. 86, § 1º. Tem natureza indenizatória e pode ser inferior ao mínimo."
},
{
"id": 2000005185,
"trilha": "tribunais",
"materia": "prev",
"assunto": "Benefícios",
"tipo": "pergunta",
"frente": "O auxílio-acidente pode ser acumulado com aposentadoria?",
"verso": "Não, desde a Lei 9.528/1997.",
"explicacao": "Lei 8.213/1991, art. 86, § 2º, e Súmula 507 do STJ."
},
{
"id": 2000005186,
"trilha": "tribunais",
"materia": "prev",
"assunto": "Benefícios",
"tipo": "pergunta",
"frente": "Quem tem direito ao acréscimo de 25% na aposentadoria?",
"verso": "O aposentado por incapacidade permanente que necessite de assistência permanente de outra pessoa.",
"explicacao": "Lei 8.213/1991, art. 45. O STF limitou a essa aposentadoria (Tema 1.095)."
},
{
"id": 2000005187,
"trilha": "tribunais",
"materia": "prev",
"assunto": "Benefícios",
"tipo": "pergunta",
"frente": "O salário-maternidade é devido na adoção?",
"verso": "Sim, ao segurado ou segurada que adotar ou obtiver guarda judicial para adoção de criança de até 12 anos, por 120 dias.",
"explicacao": "Lei 8.213/1991, art. 71-A."
},
{
"id": 2000005188,
"trilha": "tribunais",
"materia": "prev",
"assunto": "Benefícios",
"tipo": "pergunta",
"frente": "O que é a aposentadoria especial?",
"verso": "Aposentadoria devida ao segurado exposto a agentes nocivos químicos, físicos ou biológicos prejudiciais à saúde, com tempo reduzido de 15, 20 ou 25 anos.",
"explicacao": "Lei 8.213/1991, art. 57. Após a EC 103/2019, há idade mínima."
},
{
"id": 2000005189,
"trilha": "tribunais",
"materia": "prev",
"assunto": "Benefícios",
"tipo": "pergunta",
"frente": "Quais as idades mínimas da aposentadoria especial após a EC 103/2019?",
"verso": "55, 58 ou 60 anos, para atividades de 15, 20 ou 25 anos de exposição.",
"explicacao": "EC 103/2019, art. 19, § 1º, I."
},
{
"id": 2000005190,
"trilha": "tribunais",
"materia": "prev",
"assunto": "Benefícios",
"tipo": "pergunta",
"frente": "Qual o tempo de contribuição exigido na aposentadoria da pessoa com deficiência grave?",
"verso": "25 anos (homem) e 20 anos (mulher).",
"explicacao": "LC 142/2013, art. 3º, I."
},
{
"id": 2000005191,
"trilha": "tribunais",
"materia": "prev",
"assunto": "Benefícios",
"tipo": "pergunta",
"frente": "Qual a idade na aposentadoria por idade da pessoa com deficiência?",
"verso": "60 anos (homem) e 55 anos (mulher), com 15 anos de contribuição na condição de deficiente.",
"explicacao": "LC 142/2013, art. 3º, IV."
},
{
"id": 2000005192,
"trilha": "tribunais",
"materia": "prev",
"assunto": "Pensão por morte",
"tipo": "pergunta",
"frente": "Quando a pensão por morte é vitalícia para o cônjuge?",
"verso": "Quando o cônjuge tem 45 anos ou mais na data do óbito, com pelo menos 18 contribuições do segurado e 2 anos de casamento ou união estável.",
"explicacao": "Lei 8.213/1991, art. 77, § 2º, V, 'c', com idades atualizadas por portaria."
},
{
"id": 2000005193,
"trilha": "tribunais",
"materia": "prev",
"assunto": "Pensão por morte",
"tipo": "pergunta",
"frente": "A partir de quando é devida a pensão por morte requerida em até 90 dias do óbito?",
"verso": "Desde a data do óbito.",
"explicacao": "Lei 8.213/1991, art. 74, I. Para filhos menores de 16, o prazo é de 180 dias."
},
{
"id": 2000005194,
"trilha": "tribunais",
"materia": "prev",
"assunto": "Pensão por morte",
"tipo": "pergunta",
"frente": "O condenado por homicídio doloso do segurado tem direito à pensão por morte?",
"verso": "Não. Perde o direito o condenado por crime doloso de que resultou a morte do segurado.",
"explicacao": "Lei 8.213/1991, art. 74, § 1º."
},
{
"id": 2000005195,
"trilha": "tribunais",
"materia": "prev",
"assunto": "Benefícios",
"tipo": "pergunta",
"frente": "O que é o BPC/LOAS?",
"verso": "Benefício assistencial de 1 salário mínimo à pessoa com deficiência e ao idoso de 65 anos ou mais que não tenham meios de se manter.",
"explicacao": "CF, art. 203, V, e Lei 8.742/1993, art. 20."
},
{
"id": 2000005196,
"trilha": "tribunais",
"materia": "prev",
"assunto": "Benefícios",
"tipo": "pergunta",
"frente": "O BPC gera direito a pensão por morte ou 13º?",
"verso": "Não. Não gera pensão nem abono anual, por ser benefício assistencial.",
"explicacao": "Lei 8.742/1993, art. 21-A e Decreto 6.214/2007."
},
{
"id": 2000005197,
"trilha": "tribunais",
"materia": "prev",
"assunto": "Benefícios",
"tipo": "pergunta",
"frente": "Qual o prazo decadencial para revisar o ato de concessão de benefício previdenciário?",
"verso": "10 anos.",
"explicacao": "Lei 8.213/1991, art. 103."
},
{
"id": 2000005198,
"trilha": "tribunais",
"materia": "prev",
"assunto": "Benefícios",
"tipo": "pergunta",
"frente": "O que é a reabilitação profissional?",
"verso": "Serviço que proporciona ao segurado incapacitado, parcial ou totalmente, os meios para reingressar no mercado de trabalho.",
"explicacao": "Lei 8.213/1991, art. 89."
},
{
"id": 2000005199,
"trilha": "tribunais",
"materia": "prev",
"assunto": "Acidente do trabalho",
"tipo": "pergunta",
"frente": "Quais situações se equiparam a acidente do trabalho (exemplos)?",
"verso": "Doença profissional, doença do trabalho, acidente no local e horário de trabalho por agressão ou sabotagem e acidente a serviço da empresa fora do local.",
"explicacao": "Lei 8.213/1991, arts. 20 e 21."
},
{
"id": 2000005200,
"trilha": "tribunais",
"materia": "prev",
"assunto": "Acidente do trabalho",
"tipo": "pergunta",
"frente": "Qual o prazo para a empresa comunicar o acidente do trabalho (CAT)?",
"verso": "Até o 1º dia útil seguinte ao da ocorrência; em caso de morte, de imediato.",
"explicacao": "Lei 8.213/1991, art. 22."
},
{
"id": 2000005201,
"trilha": "tribunais",
"materia": "prev",
"assunto": "Acidente do trabalho",
"tipo": "pergunta",
"frente": "Qual a estabilidade do empregado que sofreu acidente do trabalho?",
"verso": "12 meses após a cessação do auxílio por incapacidade temporária acidentário.",
"explicacao": "Lei 8.213/1991, art. 118."
},
{
"id": 2000005202,
"trilha": "tribunais",
"materia": "prev",
"assunto": "RPPS",
"tipo": "pergunta",
"frente": "O que é a previdência complementar do servidor (Funpresp)?",
"verso": "Regime de previdência complementar para o servidor que ingressou após sua criação, que recebe do RPPS até o teto do RGPS e pode contribuir para receber acima.",
"explicacao": "CF, art. 40, §§ 14 a 16."
},
{
"id": 2000005203,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Conceitos",
"tipo": "pergunta",
"frente": "O que é arquivística?",
"verso": "Disciplina que estuda as funções do arquivo e os princípios e técnicas a serem observados na produção, organização, guarda, preservação e utilização dos arquivos.",
"explicacao": "Dicionário Brasileiro de Terminologia Arquivística."
},
{
"id": 2000005204,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Conceitos",
"tipo": "pares",
"frente": "Qual a diferença entre arquivo e biblioteca?",
"verso": "Arquivo: documentos produzidos organicamente nas atividades da instituição, em geral exemplares únicos. Biblioteca: documentos colecionados por interesse cultural ou técnico, em geral com vários exemplares.",
"explicacao": "Diferença por origem e finalidade."
},
{
"id": 2000005205,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Conceitos",
"tipo": "pares",
"frente": "Qual a diferença entre arquivo e museu?",
"verso": "Arquivo: documentos produzidos organicamente com fins administrativos e de prova. Museu: objetos colecionados por valor artístico, histórico ou cultural, para exposição.",
"explicacao": "Diferença por origem e finalidade."
},
{
"id": 2000005206,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Conceitos",
"tipo": "pergunta",
"frente": "O que é documento ostensivo?",
"verso": "Documento de acesso livre, cuja divulgação não prejudica a administração.",
"explicacao": "Classificação quanto à natureza (sigilo)."
},
{
"id": 2000005207,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Conceitos",
"tipo": "pergunta",
"frente": "O que é documento especial?",
"verso": "Documento em linguagem não textual, suporte não convencional ou formato e dimensões excepcionais, que exige procedimentos específicos.",
"explicacao": "Ex.: mapas, fotografias, filmes, discos."
},
{
"id": 2000005208,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Conceitos",
"tipo": "pergunta",
"frente": "O que é documento iconográfico?",
"verso": "Documento com imagens fixas, impressas, desenhadas ou fotografadas.",
"explicacao": "Ex.: fotografias, gravuras, desenhos."
},
{
"id": 2000005209,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Conceitos",
"tipo": "pergunta",
"frente": "O que é documento cartográfico?",
"verso": "Documento que representa, em formato reduzido, áreas geográficas, geológicas, topográficas e similares.",
"explicacao": "Ex.: mapas e plantas."
},
{
"id": 2000005210,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Conceitos",
"tipo": "pergunta",
"frente": "O que é documento filmográfico?",
"verso": "Documento em película cinematográfica ou fita magnética com imagens em movimento, com ou sem som.",
"explicacao": "Ex.: filmes e vídeos."
},
{
"id": 2000005211,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Conceitos",
"tipo": "pergunta",
"frente": "O que é documento micrográfico?",
"verso": "Documento em suporte fílmico resultante da microrreprodução de imagens.",
"explicacao": "Ex.: microfilme e microficha."
},
{
"id": 2000005212,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Conceitos",
"tipo": "pergunta",
"frente": "O que é documento informático (digital)?",
"verso": "Documento codificado em dígitos binários, acessível por meio de sistema computacional.",
"explicacao": "Pode ser nato-digital ou digitalizado."
},
{
"id": 2000005213,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Princípios",
"tipo": "pergunta",
"frente": "O que é o princípio da unicidade?",
"verso": "Os documentos de arquivo conservam seu caráter único em função do contexto em que foram produzidos, apesar da forma, gênero, tipo ou suporte.",
"explicacao": "Princípio arquivístico."
},
{
"id": 2000005214,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Princípios",
"tipo": "pergunta",
"frente": "O que é o princípio da cumulatividade?",
"verso": "O arquivo é uma formação progressiva, natural e orgânica.",
"explicacao": "Princípio arquivístico."
},
{
"id": 2000005215,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Ciclo de vida",
"tipo": "pergunta",
"frente": "Qual a principal característica do arquivo corrente?",
"verso": "Documentos em curso ou consultados frequentemente, conservados junto aos órgãos produtores.",
"explicacao": "Primeira idade."
},
{
"id": 2000005216,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Ciclo de vida",
"tipo": "pergunta",
"frente": "Qual a principal característica do arquivo intermediário?",
"verso": "Documentos de uso pouco frequente que aguardam, em depósito, a eliminação ou o recolhimento para guarda permanente.",
"explicacao": "Segunda idade."
},
{
"id": 2000005217,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Ciclo de vida",
"tipo": "pergunta",
"frente": "Qual a principal característica do arquivo permanente?",
"verso": "Documentos preservados definitivamente em razão de seu valor histórico, probatório e informativo.",
"explicacao": "Terceira idade. São inalienáveis e imprescritíveis."
},
{
"id": 2000005218,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Ciclo de vida",
"tipo": "pergunta",
"frente": "Os documentos de valor permanente podem ser eliminados?",
"verso": "Não. São inalienáveis e imprescritíveis.",
"explicacao": "Lei 8.159/1991, art. 10."
},
{
"id": 2000005219,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Gestão de documentos",
"tipo": "pergunta",
"frente": "O que é tramitação?",
"verso": "Curso do documento desde a sua produção ou recepção até o cumprimento de sua função administrativa.",
"explicacao": "Também chamada de movimentação."
},
{
"id": 2000005220,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Gestão de documentos",
"tipo": "pergunta",
"frente": "O que é a autuação?",
"verso": "Formação de processo: termo que registra a abertura do processo, com número, data e assunto.",
"explicacao": "Procedimento de protocolo."
},
{
"id": 2000005221,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Gestão de documentos",
"tipo": "pergunta",
"frente": "O que é a juntada por anexação?",
"verso": "União definitiva de um processo a outro, quando há o mesmo interessado e assunto, prevalecendo o processo mais antigo.",
"explicacao": "Procedimento de protocolo."
},
{
"id": 2000005222,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Gestão de documentos",
"tipo": "pergunta",
"frente": "O que é a juntada por apensação?",
"verso": "União provisória de processos com o objetivo de estudo uniforme, mantendo cada um sua identidade.",
"explicacao": "Procedimento de protocolo."
},
{
"id": 2000005223,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Gestão de documentos",
"tipo": "pergunta",
"frente": "O que é o desapensamento?",
"verso": "Separação física de processos que estavam apensados.",
"explicacao": "Procedimento de protocolo."
},
{
"id": 2000005224,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Gestão de documentos",
"tipo": "pergunta",
"frente": "O que é o desentranhamento?",
"verso": "Retirada de folhas ou peças de um processo, mediante justificativa e termo próprio.",
"explicacao": "Procedimento de protocolo."
},
{
"id": 2000005225,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Classificação",
"tipo": "pergunta",
"frente": "O que é o plano de classificação de documentos?",
"verso": "Esquema de distribuição de documentos em classes, de acordo com métodos de arquivamento específicos, elaborado a partir do estudo das estruturas e funções da instituição.",
"explicacao": "Instrumento de gestão da fase corrente."
},
{
"id": 2000005226,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Classificação",
"tipo": "pergunta",
"frente": "Qual a estrutura do Código de Classificação do Conarq para atividades-meio?",
"verso": "Decimal: classes, subclasses, grupos e subgrupos, com a classe 000 para Administração Geral.",
"explicacao": "Resolução Conarq 14/2001 (atualizado)."
},
{
"id": 2000005227,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Classificação",
"tipo": "pergunta",
"frente": "O que é a ordenação?",
"verso": "Disposição dos documentos dentro de cada classe ou série, segundo um critério (alfabético, numérico, cronológico).",
"explicacao": "Diferente da classificação, que define as classes."
},
{
"id": 2000005228,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Métodos de arquivamento",
"tipo": "pergunta",
"frente": "O que é o método geográfico?",
"verso": "Arquivamento por local de procedência ou destino: estado, cidade, país.",
"explicacao": "Método direto."
},
{
"id": 2000005229,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Métodos de arquivamento",
"tipo": "pergunta",
"frente": "O que é o método ideográfico?",
"verso": "Arquivamento por assuntos, em ordem alfabética (dicionária ou enciclopédica) ou numérica (duplex, decimal, unitermo).",
"explicacao": "Útil para documentos ordenados por tema."
},
{
"id": 2000005230,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Métodos de arquivamento",
"tipo": "pergunta",
"frente": "O que é o método numérico simples?",
"verso": "Atribuição de número a cada correspondente, na ordem de chegada, com índice alfabético remissivo.",
"explicacao": "Método indireto."
},
{
"id": 2000005231,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Métodos de arquivamento",
"tipo": "pergunta",
"frente": "O que é o método mnemônico?",
"verso": "Combinação de letras representando assuntos, para facilitar a memorização.",
"explicacao": "Método alfanumérico pouco usado hoje."
},
{
"id": 2000005232,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Arquivamento",
"tipo": "pergunta",
"frente": "Como se ordenam alfabeticamente os nomes de pessoas físicas?",
"verso": "Pelo último sobrenome, seguido do prenome: 'Silva, João Carlos'.",
"explicacao": "Regra 1 de alfabetação."
},
{
"id": 2000005233,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Arquivamento",
"tipo": "pergunta",
"frente": "Como se arquivam sobrenomes que exprimem grau de parentesco (Filho, Júnior, Neto)?",
"verso": "Junto ao último sobrenome, sem considerar o parentesco na ordenação: 'Almeida Filho, José'.",
"explicacao": "Regra de alfabetação."
},
{
"id": 2000005234,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Arquivamento",
"tipo": "pergunta",
"frente": "Como se ordenam as iniciais abreviativas de prenomes?",
"verso": "Antes dos nomes que começam com a mesma letra.",
"explicacao": "Regra de alfabetação."
},
{
"id": 2000005235,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Arquivamento",
"tipo": "pergunta",
"frente": "Como se arquivam nomes de empresas e instituições?",
"verso": "Como estão escritos, sem considerar artigos e preposições iniciais.",
"explicacao": "Regra de alfabetação: 'Companhia Brasileira de...'."
},
{
"id": 2000005236,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Avaliação",
"tipo": "pares",
"frente": "Qual a diferença entre valor primário e valor secundário dos documentos?",
"verso": "Primário: valor imediato para a administração que produziu o documento. Secundário: valor para outros fins (histórico, probatório, informativo).",
"explicacao": "Teoria das três idades."
},
{
"id": 2000005237,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Avaliação",
"tipo": "pergunta",
"frente": "Quem deve elaborar a tabela de temporalidade e conduzir a avaliação nos órgãos públicos?",
"verso": "A Comissão Permanente de Avaliação de Documentos (CPAD).",
"explicacao": "Decreto 10.148/2019."
},
{
"id": 2000005238,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Avaliação",
"tipo": "pergunta",
"frente": "O que é a eliminação de documentos?",
"verso": "Destruição de documentos sem valor permanente, após o prazo de guarda, com autorização da instituição arquivística pública e publicação de edital.",
"explicacao": "Lei 8.159/1991, art. 9º, e Resolução Conarq 40/2014."
},
{
"id": 2000005239,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Avaliação",
"tipo": "pergunta",
"frente": "O que é o recolhimento?",
"verso": "Entrada de documentos no arquivo permanente.",
"explicacao": "Diferente da transferência, que é para o intermediário."
},
{
"id": 2000005240,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Preservação",
"tipo": "pergunta",
"frente": "O que é a desinfestação?",
"verso": "Eliminação de insetos e outros agentes biológicos do acervo.",
"explicacao": "Procedimento de conservação."
},
{
"id": 2000005241,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Preservação",
"tipo": "pergunta",
"frente": "O que é a microfilmagem?",
"verso": "Reprodução de documentos em filme em tamanho reduzido, para preservação e acesso.",
"explicacao": "Lei 5.433/1968. O microfilme tem valor legal."
},
{
"id": 2000005242,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Arquivos permanentes",
"tipo": "pergunta",
"frente": "O que é o guia como instrumento de pesquisa?",
"verso": "Instrumento que fornece informações gerais sobre os fundos e coleções de um ou mais arquivos.",
"explicacao": "O mais genérico dos instrumentos."
},
{
"id": 2000005243,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Arquivos permanentes",
"tipo": "pergunta",
"frente": "O que é o catálogo como instrumento de pesquisa?",
"verso": "Instrumento que descreve unidades documentais (itens) de uma série ou coleção, de forma detalhada.",
"explicacao": "Mais específico que o inventário."
},
{
"id": 2000005244,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Arquivos permanentes",
"tipo": "pergunta",
"frente": "O que é a NOBRADE?",
"verso": "Norma Brasileira de Descrição Arquivística, que adapta as normas internacionais ISAD(G) e ISAAR(CPF).",
"explicacao": "Resolução Conarq 28/2008."
},
{
"id": 2000005245,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Documento digital",
"tipo": "pergunta",
"frente": "O documento digitalizado pode substituir o original em papel?",
"verso": "Pode, se digitalizado com os requisitos da lei e do decreto, salvo documentos de valor histórico, que devem ser preservados.",
"explicacao": "Lei 12.682/2012 e Decreto 10.278/2020."
},
{
"id": 2000005246,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Legislação",
"tipo": "pergunta",
"frente": "Quais são as categorias de arquivos públicos quanto à esfera?",
"verso": "Federais, estaduais, do Distrito Federal e municipais.",
"explicacao": "Lei 8.159/1991, art. 17."
},
{
"id": 2000005247,
"trilha": "tribunais",
"materia": "arq",
"assunto": "Arquivamento",
"tipo": "certo_errado",
"frente": "Certo ou errado? No arquivamento alfabético de nomes estrangeiros, considera-se o último sobrenome, salvo nomes espanhóis e orientais.",
"verso": "Certo. Nomes espanhóis são registrados pelo penúltimo sobrenome (de família do pai), e orientais como se apresentam.",
"explicacao": "Regras de alfabetação."
},
{
"id": 2000005248,
"trilha": "tribunais",
"materia": "gest",
"assunto": "Administração geral",
"tipo": "pergunta",
"frente": "Qual o foco da Administração Científica de Taylor?",
"verso": "As tarefas: racionalização do trabalho do operário, estudo de tempos e movimentos e especialização.",
"explicacao": "Ênfase na tarefa."
},
{
"id": 2000005249,
"trilha": "tribunais",
"materia": "gest",
"assunto": "Administração geral",
"tipo": "pergunta",
"frente": "Qual o foco da Teoria Clássica de Fayol?",
"verso": "A estrutura organizacional e os princípios gerais de administração.",
"explicacao": "Ênfase na estrutura."
},
{
"id": 2000005250,
"trilha": "tribunais",
"materia": "gest",
"assunto": "Administração geral",
"tipo": "pergunta",
"frente": "Qual experiência deu origem à Teoria das Relações Humanas?",
"verso": "A experiência de Hawthorne, conduzida por Elton Mayo.",
"explicacao": "Ênfase nas pessoas e nos grupos informais."
},
{
"id": 2000005251,
"trilha": "tribunais",
"materia": "gest",
"assunto": "Administração geral",
"tipo": "pergunta",
"frente": "Qual a ideia central da Teoria da Contingência?",
"verso": "Não há uma única melhor forma de administrar: tudo depende das condições do ambiente e da tecnologia.",
"explicacao": "Abordagem situacional."
},
{
"id": 2000005252,
"trilha": "tribunais",
"materia": "gest",
"assunto": "Administração geral",
"tipo": "pergunta",
"frente": "O que propõe a Teoria dos Sistemas aplicada à administração?",
"verso": "A organização é um sistema aberto, que interage com o ambiente, com entradas, processamento, saídas e retroalimentação.",
"explicacao": "Conceitos como sinergia, homeostase e entropia."
},
{
"id": 2000005253,
"trilha": "tribunais",
"materia": "gest",
"assunto": "Administração geral",
"tipo": "pergunta",
"frente": "O que é a Administração por Objetivos (APO)?",
"verso": "Técnica em que chefes e subordinados definem juntos os objetivos, acompanham resultados e avaliam o desempenho.",
"explicacao": "Proposta por Peter Drucker."
},
{
"id": 2000005254,
"trilha": "tribunais",
"materia": "gest",
"assunto": "Planejamento",
"tipo": "pares",
"frente": "Qual a diferença entre planejamento estratégico, tático e operacional?",
"verso": "Estratégico: alta direção, longo prazo, toda a organização. Tático: nível intermediário, médio prazo, por área. Operacional: nível operacional, curto prazo, tarefas.",
"explicacao": "Níveis do planejamento."
},
{
"id": 2000005255,
"trilha": "tribunais",
"materia": "gest",
"assunto": "Planejamento",
"tipo": "pergunta",
"frente": "O que são as 5 forças de Porter?",
"verso": "Rivalidade entre concorrentes, ameaça de novos entrantes, ameaça de substitutos, poder de barganha dos fornecedores e poder de barganha dos clientes.",
"explicacao": "Análise do ambiente competitivo."
},
{
"id": 2000005256,
"trilha": "tribunais",
"materia": "gest",
"assunto": "Planejamento",
"tipo": "pergunta",
"frente": "O que significa a sigla SMART para metas?",
"verso": "Específica, mensurável, atingível, relevante e temporal.",
"explicacao": "Critérios para formular metas."
},
{
"id": 2000005257,
"trilha": "tribunais",
"materia": "gest",
"assunto": "Organização",
"tipo": "pares",
"frente": "Qual a diferença entre centralização e descentralização?",
"verso": "Centralização: decisões concentradas no topo. Descentralização: autoridade para decidir distribuída aos níveis inferiores.",
"explicacao": "Conceitos de estrutura organizacional."
},
{
"id": 2000005258,
"trilha": "tribunais",
"materia": "gest",
"assunto": "Organização",
"tipo": "pergunta",
"frente": "O que é a departamentalização por clientes?",
"verso": "Agrupamento das atividades de acordo com o tipo de cliente atendido.",
"explicacao": "Ex.: setores para pessoa física e pessoa jurídica."
},
{
"id": 2000005259,
"trilha": "tribunais",
"materia": "gest",
"assunto": "Organização",
"tipo": "pergunta",
"frente": "O que é a estrutura linear?",
"verso": "Estrutura baseada na autoridade única e na linha direta de comando de chefe para subordinado.",
"explicacao": "Origem militar; simples, mas rígida."
},
{
"id": 2000005260,
"trilha": "tribunais",
"materia": "gest",
"assunto": "Organização",
"tipo": "pergunta",
"frente": "O que é a estrutura linha-staff?",
"verso": "Combina órgãos de linha (execução e comando) com órgãos de staff (assessoria e consultoria, sem autoridade de linha).",
"explicacao": "Muito usada em organizações grandes."
},
{
"id": 2000005261,
"trilha": "tribunais",
"materia": "gest",
"assunto": "Direção",
"tipo": "pares",
"frente": "Quais são os fatores da teoria dos dois fatores de Herzberg?",
"verso": "Higiênicos (salário, condições, chefia): evitam insatisfação. Motivacionais (reconhecimento, responsabilidade, crescimento): geram satisfação.",
"explicacao": "Teoria de Herzberg."
},
{
"id": 2000005262,
"trilha": "tribunais",
"materia": "gest",
"assunto": "Direção",
"tipo": "pergunta",
"frente": "Quais são os estilos de liderança clássicos (White e Lippitt)?",
"verso": "Autocrático, democrático e liberal (laissez-faire).",
"explicacao": "Estudos sobre estilos de liderança."
},
{
"id": 2000005263,
"trilha": "tribunais",
"materia": "gest",
"assunto": "Qualidade",
"tipo": "pergunta",
"frente": "O que é o diagrama de Ishikawa?",
"verso": "Diagrama de causa e efeito (espinha de peixe) que organiza as possíveis causas de um problema, geralmente pelos 6M.",
"explicacao": "Método, máquina, mão de obra, material, meio ambiente e medida."
},
{
"id": 2000005264,
"trilha": "tribunais",
"materia": "gest",
"assunto": "Qualidade",
"tipo": "pergunta",
"frente": "O que é o brainstorming?",
"verso": "Técnica de geração de ideias em grupo, sem críticas, para estimular a criatividade.",
"explicacao": "Usada para identificar problemas e soluções."
},
{
"id": 2000005265,
"trilha": "tribunais",
"materia": "gest",
"assunto": "Processos",
"tipo": "pergunta",
"frente": "O que é BPM?",
"verso": "Gerenciamento de processos de negócio: abordagem para identificar, desenhar, executar, medir, monitorar e melhorar processos.",
"explicacao": "Business Process Management."
},
{
"id": 2000005266,
"trilha": "tribunais",
"materia": "gest",
"assunto": "Processos",
"tipo": "pergunta",
"frente": "O que é a notação BPMN?",
"verso": "Notação gráfica padrão para modelar processos de negócio.",
"explicacao": "Usa eventos, atividades, gateways e fluxos."
},
{
"id": 2000005267,
"trilha": "tribunais",
"materia": "gest",
"assunto": "Gestão de pessoas",
"tipo": "pergunta",
"frente": "O que é a tendência central na avaliação de desempenho?",
"verso": "Quando o avaliador evita notas extremas e dá conceitos médios a todos.",
"explicacao": "Erro comum de avaliação."
},
{
"id": 2000005268,
"trilha": "tribunais",
"materia": "gest",
"assunto": "Gestão de pessoas",
"tipo": "pergunta",
"frente": "O que é clima organizacional?",
"verso": "Percepção dos membros sobre o ambiente de trabalho, que influencia a motivação e o comportamento.",
"explicacao": "Diferente de cultura, que são os valores e crenças compartilhados."
},
{
"id": 2000005269,
"trilha": "tribunais",
"materia": "gest",
"assunto": "Gestão de pessoas",
"tipo": "pares",
"frente": "Qual a diferença entre recrutamento interno e externo?",
"verso": "Interno: busca candidatos na própria organização. Externo: busca candidatos no mercado.",
"explicacao": "Interno motiva e é mais barato; externo traz novas ideias."
},
{
"id": 2000005270,
"trilha": "tribunais",
"materia": "gest",
"assunto": "Comunicação",
"tipo": "pergunta",
"frente": "Quais os elementos do processo de comunicação?",
"verso": "Emissor, mensagem, canal, receptor, código, ruído e feedback.",
"explicacao": "Modelo clássico de comunicação."
},
{
"id": 2000005271,
"trilha": "tribunais",
"materia": "gest",
"assunto": "Comunicação",
"tipo": "pergunta",
"frente": "O que é a comunicação informal (rádio-peão)?",
"verso": "Comunicação não oficial que circula entre as pessoas fora dos canais formais.",
"explicacao": "Pode ser rápida, mas gerar boatos."
},
{
"id": 2000005272,
"trilha": "tribunais",
"materia": "gest",
"assunto": "Administração pública",
"tipo": "pergunta",
"frente": "Quais os três modelos de administração pública no Brasil?",
"verso": "Patrimonialista, burocrático e gerencial.",
"explicacao": "Evolução histórica da administração pública."
},
{
"id": 2000005273,
"trilha": "tribunais",
"materia": "gest",
"assunto": "Administração pública",
"tipo": "pergunta",
"frente": "Qual a característica principal do modelo patrimonialista?",
"verso": "Confusão entre o patrimônio público e o privado do governante, com nepotismo e corrupção.",
"explicacao": "Predominou até 1930 no Brasil."
},
{
"id": 2000005274,
"trilha": "tribunais",
"materia": "gest",
"assunto": "Administração pública",
"tipo": "pergunta",
"frente": "Qual reforma introduziu o modelo burocrático no Brasil?",
"verso": "A reforma de Getúlio Vargas, com a criação do DASP em 1938.",
"explicacao": "Busca da impessoalidade e do mérito."
},
{
"id": 2000005275,
"trilha": "tribunais",
"materia": "gest",
"assunto": "Administração pública",
"tipo": "pergunta",
"frente": "Qual a ênfase da administração gerencial?",
"verso": "Foco em resultados, no cidadão-cliente, na descentralização, no controle a posteriori e na flexibilidade.",
"explicacao": "Nova Gestão Pública (New Public Management)."
},
{
"id": 2000005276,
"trilha": "tribunais",
"materia": "gest",
"assunto": "Administração pública",
"tipo": "pergunta",
"frente": "O que é o governo eletrônico (e-gov)?",
"verso": "Uso de tecnologias da informação para oferecer serviços e informações públicas ao cidadão.",
"explicacao": "No Brasil, a Lei 14.129/2021 trata do Governo Digital."
},
{
"id": 2000005277,
"trilha": "tribunais",
"materia": "gest",
"assunto": "Administração pública",
"tipo": "pergunta",
"frente": "O que é o orçamento participativo?",
"verso": "Mecanismo em que a população participa da decisão sobre parte dos investimentos públicos.",
"explicacao": "Exemplo clássico: Porto Alegre."
},
{
"id": 2000005278,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Princípios",
"tipo": "pergunta",
"frente": "O que é o princípio da segurança jurídica na administração?",
"verso": "Proteção da confiança do administrado, vedando aplicação retroativa de nova interpretação.",
"explicacao": "Lei 9.784/1999, art. 2º, parágrafo único, XIII."
},
{
"id": 2000005279,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Princípios",
"tipo": "pergunta",
"frente": "O que é o princípio da motivação?",
"verso": "Dever de indicar os pressupostos de fato e de direito que fundamentam a decisão administrativa.",
"explicacao": "Lei 9.784/1999, arts. 2º e 50."
},
{
"id": 2000005280,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Organização",
"tipo": "pergunta",
"frente": "O que é a teoria do órgão?",
"verso": "Os atos praticados pelos agentes são imputados à pessoa jurídica a que pertencem, pois o agente age como parte do órgão.",
"explicacao": "Teoria da imputação volitiva de Otto Gierke."
},
{
"id": 2000005281,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Organização",
"tipo": "pergunta",
"frente": "Os órgãos públicos têm personalidade jurídica?",
"verso": "Não. São centros de competência despersonalizados.",
"explicacao": "Alguns órgãos independentes têm capacidade processual para defender suas prerrogativas."
},
{
"id": 2000005282,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Organização",
"tipo": "pares",
"frente": "Qual a diferença entre desconcentração e descentralização?",
"verso": "Desconcentração: distribuição de competências dentro da mesma pessoa jurídica, com hierarquia. Descentralização: transferência para outra pessoa jurídica, sem hierarquia.",
"explicacao": "Conceitos de organização administrativa."
},
{
"id": 2000005283,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Organização",
"tipo": "pergunta",
"frente": "O que é a tutela (supervisão ministerial)?",
"verso": "Controle finalístico que a administração direta exerce sobre a indireta, sem hierarquia.",
"explicacao": "Decreto-Lei 200/1967, art. 19."
},
{
"id": 2000005284,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Organização",
"tipo": "pergunta",
"frente": "O que é uma agência reguladora?",
"verso": "Autarquia em regime especial, com autonomia reforçada e dirigentes com mandato fixo, que regula setores específicos.",
"explicacao": "Lei 13.848/2019."
},
{
"id": 2000005285,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Organização",
"tipo": "pergunta",
"frente": "O que é uma agência executiva?",
"verso": "Qualificação dada a autarquia ou fundação que celebra contrato de gestão com o ministério supervisor e tem plano estratégico de reestruturação.",
"explicacao": "Lei 9.649/1998, art. 51."
},
{
"id": 2000005286,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Organização",
"tipo": "pergunta",
"frente": "O que são as OSCIPs?",
"verso": "Organizações da sociedade civil de interesse público, qualificadas pelo Ministério da Justiça, que firmam termo de parceria com o poder público.",
"explicacao": "Lei 9.790/1999."
},
{
"id": 2000005287,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Atos administrativos",
"tipo": "pergunta",
"frente": "O que é o ato administrativo composto?",
"verso": "Ato formado pela vontade de um órgão, que depende da verificação de outro para produzir efeitos.",
"explicacao": "Ex.: ato que depende de visto ou homologação."
},
{
"id": 2000005288,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Atos administrativos",
"tipo": "pergunta",
"frente": "O que é a convalidação de ato administrativo?",
"verso": "Correção de ato com vício sanável (competência ou forma), com efeitos retroativos, quando não houver lesão ao interesse público nem prejuízo a terceiros.",
"explicacao": "Lei 9.784/1999, art. 55."
},
{
"id": 2000005289,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Atos administrativos",
"tipo": "pares",
"frente": "Qual a diferença entre cassação e caducidade do ato administrativo?",
"verso": "Cassação: extinção porque o beneficiário descumpriu condições. Caducidade: extinção porque uma lei nova tornou inadmissível a situação antes permitida.",
"explicacao": "Formas de extinção do ato."
},
{
"id": 2000005290,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Atos administrativos",
"tipo": "pergunta",
"frente": "O que é a contraposição como forma de extinção do ato?",
"verso": "Extinção de um ato pela edição de outro com efeitos contrários.",
"explicacao": "Ex.: exoneração extingue os efeitos da nomeação."
},
{
"id": 2000005291,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Atos administrativos",
"tipo": "pergunta",
"frente": "Qual o prazo para a administração anular atos favoráveis aos destinatários, salvo má-fé?",
"verso": "5 anos, contados da data em que foram praticados.",
"explicacao": "Lei 9.784/1999, art. 54."
},
{
"id": 2000005292,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Poderes",
"tipo": "pergunta",
"frente": "O que é abuso de poder e suas espécies?",
"verso": "Uso irregular do poder. Espécies: excesso de poder (atua além da competência) e desvio de poder ou finalidade (atua com fim diverso do previsto).",
"explicacao": "Ambos geram nulidade do ato."
},
{
"id": 2000005293,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Licitações",
"tipo": "pergunta",
"frente": "Quais os limites de valor para dispensa de licitação na Lei 14.133/2021, atualizados?",
"verso": "Obras e serviços de engenharia: cerca de R$ 125 mil. Outros serviços e compras: cerca de R$ 62 mil.",
"explicacao": "Lei 14.133/2021, art. 75, I e II, com valores atualizados anualmente por decreto."
},
{
"id": 2000005294,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Contratos",
"tipo": "pergunta",
"frente": "Qual o prazo máximo dos contratos de serviços e fornecimentos contínuos na Lei 14.133/2021?",
"verso": "Até 5 anos, prorrogáveis até 10 anos.",
"explicacao": "Lei 14.133/2021, arts. 106 e 107."
},
{
"id": 2000005295,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Contratos",
"tipo": "pergunta",
"frente": "Quais os limites para acréscimos e supressões unilaterais nos contratos administrativos?",
"verso": "Até 25% do valor inicial atualizado; na reforma de edifício ou equipamento, acréscimo de até 50%.",
"explicacao": "Lei 14.133/2021, art. 125."
},
{
"id": 2000005296,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Serviços públicos",
"tipo": "pergunta",
"frente": "O que é a encampação?",
"verso": "Retomada do serviço pelo poder concedente durante a concessão, por interesse público, com lei autorizativa e indenização prévia.",
"explicacao": "Lei 8.987/1995, art. 37."
},
{
"id": 2000005297,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Serviços públicos",
"tipo": "pergunta",
"frente": "O que é a parceria público-privada (PPP)?",
"verso": "Concessão especial, patrocinada ou administrativa, com contraprestação pecuniária do poder público ao parceiro privado.",
"explicacao": "Lei 11.079/2004."
},
{
"id": 2000005298,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Responsabilidade do Estado",
"tipo": "pergunta",
"frente": "A responsabilidade do Estado por omissão é objetiva ou subjetiva?",
"verso": "A doutrina tradicional diz subjetiva (culpa do serviço), mas o STF tem aplicado a responsabilidade objetiva quando há dever específico de agir.",
"explicacao": "Ex.: morte de detento (RE 841.526, Tema 592)."
},
{
"id": 2000005299,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Agentes públicos",
"tipo": "pergunta",
"frente": "O que é a estabilidade do servidor público?",
"verso": "Garantia de permanência no serviço público do servidor efetivo após 3 anos de efetivo exercício e aprovação em avaliação especial de desempenho.",
"explicacao": "CF, art. 41."
},
{
"id": 2000005300,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Agentes públicos",
"tipo": "pergunta",
"frente": "Quando o servidor estável pode perder o cargo?",
"verso": "Por sentença judicial transitada em julgado, processo administrativo com ampla defesa, avaliação periódica de desempenho insuficiente e excesso de despesa com pessoal.",
"explicacao": "CF, arts. 41, § 1º, e 169, § 4º."
},
{
"id": 2000005301,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Agentes públicos",
"tipo": "pergunta",
"frente": "O que é a disponibilidade do servidor?",
"verso": "Situação do servidor estável cujo cargo foi extinto ou declarado desnecessário, que fica inativo com remuneração proporcional ao tempo de serviço até ser aproveitado.",
"explicacao": "CF, art. 41, § 3º."
},
{
"id": 2000005302,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Processo administrativo",
"tipo": "pergunta",
"frente": "Qual o prazo para interpor recurso administrativo na Lei 9.784/1999?",
"verso": "10 dias, contados da ciência ou divulgação oficial da decisão.",
"explicacao": "Lei 9.784/1999, art. 59."
},
{
"id": 2000005303,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Processo administrativo",
"tipo": "pergunta",
"frente": "Por quantas instâncias, no máximo, tramita o recurso administrativo na Lei 9.784/1999?",
"verso": "3 instâncias administrativas, salvo disposição legal diversa.",
"explicacao": "Lei 9.784/1999, art. 57."
},
{
"id": 2000005304,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Processo administrativo",
"tipo": "pergunta",
"frente": "Pode haver reformatio in pejus no recurso administrativo?",
"verso": "Sim, desde que o recorrente seja cientificado para formular alegações antes da decisão. Na revisão, não.",
"explicacao": "Lei 9.784/1999, arts. 64 e 65."
},
{
"id": 2000005305,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Processo administrativo",
"tipo": "pergunta",
"frente": "É exigível depósito prévio para recorrer na esfera administrativa?",
"verso": "Não.",
"explicacao": "Súmula Vinculante 21 do STF."
},
{
"id": 2000005306,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Controle",
"tipo": "pergunta",
"frente": "O que diz a Súmula Vinculante 3 sobre processos no TCU?",
"verso": "Nos processos perante o TCU, asseguram-se contraditório e ampla defesa quando a decisão puder resultar em anulação ou revogação de ato benéfico ao interessado, exceto na apreciação inicial da legalidade de aposentadoria, reforma e pensão.",
"explicacao": "STF, Súmula Vinculante 3."
},
{
"id": 2000005307,
"trilha": "tribunais",
"materia": "const",
"assunto": "Poder Judiciário",
"tipo": "pergunta",
"frente": "Quantos ministros compõem o STF e quais os requisitos?",
"verso": "11 ministros, brasileiros natos, com mais de 35 e menos de 70 anos, notável saber jurídico e reputação ilibada.",
"explicacao": "CF, art. 101, com redação da EC 122/2022."
},
{
"id": 2000005308,
"trilha": "tribunais",
"materia": "const",
"assunto": "Poder Judiciário",
"tipo": "pergunta",
"frente": "Quantos ministros compõem o STJ, no mínimo?",
"verso": "33 ministros.",
"explicacao": "CF, art. 104."
},
{
"id": 2000005309,
"trilha": "tribunais",
"materia": "const",
"assunto": "Poder Judiciário",
"tipo": "pergunta",
"frente": "Como se distribuem as vagas do STJ?",
"verso": "1/3 de juízes dos TRFs, 1/3 de desembargadores dos TJs e 1/3, em partes iguais, de advogados e membros do MP.",
"explicacao": "CF, art. 104, parágrafo único."
},
{
"id": 2000005310,
"trilha": "tribunais",
"materia": "const",
"assunto": "Poder Judiciário",
"tipo": "pergunta",
"frente": "Quantos membros tem o CNJ e quem o preside?",
"verso": "15 membros, com mandato de 2 anos, presidido pelo Presidente do STF.",
"explicacao": "CF, art. 103-B."
},
{
"id": 2000005311,
"trilha": "tribunais",
"materia": "const",
"assunto": "Poder Judiciário",
"tipo": "pergunta",
"frente": "O CNJ tem competência jurisdicional?",
"verso": "Não. É órgão de controle administrativo e financeiro do Judiciário e do cumprimento dos deveres dos juízes.",
"explicacao": "CF, art. 103-B, § 4º. Não exerce controle sobre o STF."
},
{
"id": 2000005312,
"trilha": "tribunais",
"materia": "const",
"assunto": "Poder Judiciário",
"tipo": "pergunta",
"frente": "Como funciona a escolha no quinto constitucional?",
"verso": "O órgão de classe forma lista sêxtupla; o tribunal reduz a lista tríplice; o chefe do Executivo escolhe um nome em 20 dias.",
"explicacao": "CF, art. 94, parágrafo único."
},
{
"id": 2000005313,
"trilha": "tribunais",
"materia": "const",
"assunto": "Poder Judiciário",
"tipo": "pergunta",
"frente": "Quando o juiz de primeiro grau adquire vitaliciedade?",
"verso": "Após 2 anos de exercício.",
"explicacao": "CF, art. 95, I. Nos tribunais, pelo quinto, é adquirida na posse."
},
{
"id": 2000005314,
"trilha": "tribunais",
"materia": "const",
"assunto": "Poder Judiciário",
"tipo": "pergunta",
"frente": "Quais vedações se aplicam aos juízes (exemplos)?",
"verso": "Exercer outro cargo ou função, salvo uma de magistério; receber custas ou participação em processo; dedicar-se a atividade político-partidária; e advogar no juízo ou tribunal do qual se afastou antes de 3 anos.",
"explicacao": "CF, art. 95, parágrafo único."
},
{
"id": 2000005315,
"trilha": "tribunais",
"materia": "const",
"assunto": "Poder Judiciário",
"tipo": "pergunta",
"frente": "Quanto tempo de atividade jurídica se exige para ingressar na magistratura?",
"verso": "3 anos de atividade jurídica, para bacharel em Direito.",
"explicacao": "CF, art. 93, I."
},
{
"id": 2000005316,
"trilha": "tribunais",
"materia": "const",
"assunto": "Poder Judiciário",
"tipo": "pergunta",
"frente": "Quantos ministros tem o TST?",
"verso": "27 ministros.",
"explicacao": "CF, art. 111-A, com redação da EC 122/2022."
},
{
"id": 2000005317,
"trilha": "tribunais",
"materia": "const",
"assunto": "Poder Judiciário",
"tipo": "pergunta",
"frente": "Qual a composição do TSE?",
"verso": "7 membros: 3 do STF, 2 do STJ e 2 advogados de notável saber jurídico indicados pelo STF e nomeados pelo Presidente.",
"explicacao": "CF, art. 119."
},
{
"id": 2000005318,
"trilha": "tribunais",
"materia": "const",
"assunto": "Poder Judiciário",
"tipo": "pergunta",
"frente": "Qual a composição mínima dos TRFs?",
"verso": "7 juízes, recrutados quando possível na respectiva região.",
"explicacao": "CF, art. 107."
},
{
"id": 2000005319,
"trilha": "tribunais",
"materia": "const",
"assunto": "Poder Judiciário",
"tipo": "pergunta",
"frente": "Quais órgãos da Justiça Eleitoral estão previstos na CF?",
"verso": "TSE, TREs, juízes eleitorais e juntas eleitorais.",
"explicacao": "CF, art. 118."
},
{
"id": 2000005320,
"trilha": "tribunais",
"materia": "const",
"assunto": "Poder Judiciário",
"tipo": "pergunta",
"frente": "Quais órgãos compõem a Justiça do Trabalho?",
"verso": "TST, TRTs e juízes do trabalho.",
"explicacao": "CF, art. 111."
},
{
"id": 2000005321,
"trilha": "tribunais",
"materia": "const",
"assunto": "Poder Judiciário",
"tipo": "pergunta",
"frente": "O que é a súmula vinculante e quem pode editá-la?",
"verso": "Súmula aprovada por 2/3 dos membros do STF, após reiteradas decisões constitucionais, que vincula o Judiciário e a administração pública.",
"explicacao": "CF, art. 103-A."
},
{
"id": 2000005322,
"trilha": "tribunais",
"materia": "const",
"assunto": "Poder Judiciário",
"tipo": "pergunta",
"frente": "Qual a consequência de ato administrativo ou decisão que contraria súmula vinculante?",
"verso": "Cabe reclamação ao STF, que pode anular o ato ou cassar a decisão.",
"explicacao": "CF, art. 103-A, § 3º."
},
{
"id": 2000005323,
"trilha": "tribunais",
"materia": "const",
"assunto": "Poder Judiciário",
"tipo": "pergunta",
"frente": "O que é a cláusula de reserva de plenário?",
"verso": "Só pelo voto da maioria absoluta dos membros ou do órgão especial os tribunais podem declarar a inconstitucionalidade de lei.",
"explicacao": "CF, art. 97, e Súmula Vinculante 10."
},
{
"id": 2000005324,
"trilha": "tribunais",
"materia": "const",
"assunto": "Poder Judiciário",
"tipo": "pergunta",
"frente": "Quando os tribunais podem criar órgão especial?",
"verso": "Nos tribunais com mais de 25 julgadores, com 11 a 25 membros.",
"explicacao": "CF, art. 93, XI. Metade por antiguidade e metade por eleição."
},
{
"id": 2000005325,
"trilha": "tribunais",
"materia": "const",
"assunto": "Poder Judiciário",
"tipo": "pergunta",
"frente": "As sessões e julgamentos do Judiciário são públicos?",
"verso": "Sim, e todas as decisões devem ser fundamentadas, sob pena de nulidade; a lei pode limitar a presença para preservar a intimidade.",
"explicacao": "CF, art. 93, IX."
},
{
"id": 2000005326,
"trilha": "tribunais",
"materia": "const",
"assunto": "Poder Judiciário",
"tipo": "pergunta",
"frente": "A atividade jurisdicional pode ter férias coletivas?",
"verso": "Não nos juízos e tribunais de segundo grau; a atividade é ininterrupta, com plantão nos dias sem expediente.",
"explicacao": "CF, art. 93, XII."
},
{
"id": 2000005327,
"trilha": "tribunais",
"materia": "const",
"assunto": "Poder Judiciário",
"tipo": "pergunta",
"frente": "Qual a competência do STJ para julgar recurso especial?",
"verso": "Julgar causas decididas em única ou última instância pelos TRFs ou TJs quando a decisão contrariar lei federal, julgar válido ato de governo local contestado em face de lei federal ou divergir de outro tribunal na interpretação de lei federal.",
"explicacao": "CF, art. 105, III."
},
{
"id": 2000005328,
"trilha": "tribunais",
"materia": "const",
"assunto": "Funções essenciais",
"tipo": "pergunta",
"frente": "O que é a Defensoria Pública?",
"verso": "Instituição permanente, essencial à função jurisdicional, que presta orientação jurídica e defesa dos necessitados, em todos os graus.",
"explicacao": "CF, art. 134."
},
{
"id": 2000005329,
"trilha": "tribunais",
"materia": "const",
"assunto": "Funções essenciais",
"tipo": "pergunta",
"frente": "Quem nomeia o Procurador-Geral da República?",
"verso": "O Presidente da República, entre integrantes da carreira com mais de 35 anos, após aprovação do Senado por maioria absoluta, para mandato de 2 anos, permitida recondução.",
"explicacao": "CF, art. 128, § 1º."
},
{
"id": 2000005330,
"trilha": "tribunais",
"materia": "pen",
"assunto": "Crimes contra a administração da justiça",
"tipo": "pergunta",
"frente": "O que é o crime de falso testemunho?",
"verso": "Fazer afirmação falsa, negar ou calar a verdade como testemunha, perito, contador, tradutor ou intérprete em processo judicial, administrativo, inquérito ou juízo arbitral.",
"explicacao": "CP, art. 342. Deixa de ser punível se o agente se retrata antes da sentença."
},
{
"id": 2000005331,
"trilha": "tribunais",
"materia": "pen",
"assunto": "Crimes contra a administração da justiça",
"tipo": "pergunta",
"frente": "O que é a comunicação falsa de crime ou contravenção?",
"verso": "Provocar a ação de autoridade comunicando a ocorrência de crime ou contravenção que sabe não ter ocorrido.",
"explicacao": "CP, art. 340."
},
{
"id": 2000005332,
"trilha": "tribunais",
"materia": "pen",
"assunto": "Crimes contra a administração da justiça",
"tipo": "pergunta",
"frente": "O que é o patrocínio infiel?",
"verso": "Trair, na qualidade de advogado ou procurador, o dever profissional, prejudicando interesse cujo patrocínio em juízo lhe foi confiado.",
"explicacao": "CP, art. 355."
},
{
"id": 2000005333,
"trilha": "tribunais",
"materia": "pen",
"assunto": "Crimes contra a administração da justiça",
"tipo": "pergunta",
"frente": "O que é o favorecimento pessoal?",
"verso": "Auxiliar autor de crime a fugir da ação da autoridade pública.",
"explicacao": "CP, art. 348. Fica isento de pena ascendente, descendente, cônjuge ou irmão do criminoso."
},
{
"id": 2000005334,
"trilha": "tribunais",
"materia": "pen",
"assunto": "Crimes contra a administração da justiça",
"tipo": "pergunta",
"frente": "O que é o favorecimento real?",
"verso": "Prestar a criminoso, fora dos casos de coautoria ou receptação, auxílio para tornar seguro o proveito do crime.",
"explicacao": "CP, art. 349."
},
{
"id": 2000005335,
"trilha": "tribunais",
"materia": "pen",
"assunto": "Crimes contra a administração da justiça",
"tipo": "pergunta",
"frente": "O que é a desobediência a decisão judicial sobre perda ou suspensão de direito?",
"verso": "Exercer função, atividade, direito ou múnus de que foi suspenso ou privado por decisão judicial.",
"explicacao": "CP, art. 359."
},
{
"id": 2000005336,
"trilha": "tribunais",
"materia": "pen",
"assunto": "Crimes contra a administração pública",
"tipo": "pergunta",
"frente": "O que é a violação de sigilo funcional?",
"verso": "Revelar fato de que tem ciência em razão do cargo e que deva permanecer em segredo, ou facilitar-lhe a revelação.",
"explicacao": "CP, art. 325."
},
{
"id": 2000005337,
"trilha": "tribunais",
"materia": "ppen",
"assunto": "Ação penal",
"tipo": "pergunta",
"frente": "Qual o prazo para oferecer denúncia com réu preso e solto?",
"verso": "5 dias (preso) e 15 dias (solto).",
"explicacao": "CPP, art. 46."
},
{
"id": 2000005338,
"trilha": "tribunais",
"materia": "ppen",
"assunto": "Ação penal",
"tipo": "pergunta",
"frente": "O que é o perdão do ofendido?",
"verso": "Ato do querelante que desiste do prosseguimento da ação penal privada; só produz efeito se aceito pelo querelado.",
"explicacao": "CP, art. 106, e CPP, art. 51."
},
{
"id": 2000005339,
"trilha": "tribunais",
"materia": "ppen",
"assunto": "Procedimentos",
"tipo": "pergunta",
"frente": "Qual o prazo da resposta à acusação no procedimento comum?",
"verso": "10 dias.",
"explicacao": "CPP, art. 396."
},
{
"id": 2000005340,
"trilha": "tribunais",
"materia": "ppen",
"assunto": "Procedimentos",
"tipo": "pergunta",
"frente": "Quantas testemunhas podem ser arroladas no procedimento comum ordinário e sumário?",
"verso": "Ordinário: até 8. Sumário: até 5.",
"explicacao": "CPP, arts. 401 e 532."
},
{
"id": 2000005341,
"trilha": "tribunais",
"materia": "ppen",
"assunto": "Procedimentos",
"tipo": "pergunta",
"frente": "O que é a absolvição sumária no procedimento comum?",
"verso": "Absolvição após a resposta à acusação quando há excludente manifesta de ilicitude ou culpabilidade (salvo inimputabilidade), o fato não é crime ou está extinta a punibilidade.",
"explicacao": "CPP, art. 397."
},
{
"id": 2000005342,
"trilha": "tribunais",
"materia": "ppen",
"assunto": "Procedimentos",
"tipo": "pergunta",
"frente": "Quais as fases do procedimento do júri?",
"verso": "1ª fase: juízo de formação da culpa (sumário da culpa). 2ª fase: julgamento em plenário.",
"explicacao": "Procedimento bifásico (CPP, arts. 406 a 497)."
},
{
"id": 2000005343,
"trilha": "tribunais",
"materia": "ppen",
"assunto": "Recursos",
"tipo": "pergunta",
"frente": "Qual o prazo da apelação no processo penal?",
"verso": "5 dias, com 8 dias para as razões.",
"explicacao": "CPP, arts. 593 e 600."
},
{
"id": 2000005344,
"trilha": "tribunais",
"materia": "ppen",
"assunto": "Recursos",
"tipo": "pergunta",
"frente": "Qual o prazo do recurso em sentido estrito?",
"verso": "5 dias.",
"explicacao": "CPP, art. 586."
},
{
"id": 2000005345,
"trilha": "tribunais",
"materia": "ppen",
"assunto": "Recursos",
"tipo": "pergunta",
"frente": "Cabe recurso contra a decisão que recebe a denúncia?",
"verso": "Não cabe recurso; pode ser impugnada por habeas corpus. Contra a rejeição, cabe recurso em sentido estrito.",
"explicacao": "CPP, art. 581, I."
},
{
"id": 2000005346,
"trilha": "tribunais",
"materia": "ppen",
"assunto": "Prisão",
"tipo": "pergunta",
"frente": "O que é a audiência de custódia?",
"verso": "Apresentação do preso ao juiz em até 24 horas da prisão, para avaliar a legalidade e a necessidade da prisão.",
"explicacao": "CPP, art. 310."
},
{
"id": 2000005347,
"trilha": "tribunais",
"materia": "ppen",
"assunto": "Prisão",
"tipo": "pergunta",
"frente": "Com que frequência deve ser revista a necessidade da prisão preventiva?",
"verso": "A cada 90 dias, de ofício, por decisão fundamentada.",
"explicacao": "CPP, art. 316, parágrafo único."
},
{
"id": 2000005348,
"trilha": "tribunais",
"materia": "ppen",
"assunto": "Juizado Especial Criminal",
"tipo": "pergunta",
"frente": "Quais os requisitos da suspensão condicional do processo?",
"verso": "Crime com pena mínima de até 1 ano, réu não processado nem condenado por outro crime, e requisitos do sursis. Período de prova de 2 a 4 anos.",
"explicacao": "Lei 9.099/1995, art. 89."
},
{
"id": 2000005349,
"trilha": "tribunais",
"materia": "port",
"assunto": "Concordância",
"tipo": "pergunta",
"frente": "Qual a concordância correta: 'Fazem dois anos' ou 'Faz dois anos'?",
"verso": "'Faz dois anos'. O verbo fazer indicando tempo é impessoal e fica no singular.",
"explicacao": "Regra de concordância com verbos impessoais."
},
{
"id": 2000005350,
"trilha": "tribunais",
"materia": "port",
"assunto": "Concordância",
"tipo": "pergunta",
"frente": "Qual a forma correta: 'Haviam muitas pessoas' ou 'Havia muitas pessoas'?",
"verso": "'Havia muitas pessoas'. O verbo haver no sentido de existir é impessoal.",
"explicacao": "Regra de concordância."
},
{
"id": 2000005351,
"trilha": "tribunais",
"materia": "port",
"assunto": "Concordância",
"tipo": "pergunta",
"frente": "Qual a concordância de 'anexo' e 'incluso'?",
"verso": "Concordam com o substantivo: 'Seguem anexas as cópias'; 'Vai inclusa a nota'.",
"explicacao": "Adjetivos variáveis."
},
{
"id": 2000005352,
"trilha": "tribunais",
"materia": "port",
"assunto": "Concordância",
"tipo": "pergunta",
"frente": "Qual a concordância de 'menos' e 'alerta'?",
"verso": "São invariáveis: 'menos pessoas', 'os soldados estão alerta'.",
"explicacao": "Palavras invariáveis."
},
{
"id": 2000005353,
"trilha": "tribunais",
"materia": "port",
"assunto": "Concordância",
"tipo": "pergunta",
"frente": "Como fica a concordância com 'a maioria de' seguido de plural?",
"verso": "O verbo pode ficar no singular (com o núcleo) ou no plural (com o especificador): 'A maioria dos alunos faltou/faltaram'.",
"explicacao": "Concordância com expressão partitiva."
},
{
"id": 2000005354,
"trilha": "tribunais",
"materia": "port",
"assunto": "Regência",
"tipo": "pergunta",
"frente": "Qual a regência correta do verbo 'assistir' no sentido de ver?",
"verso": "Transitivo indireto, com preposição 'a': 'Assisti ao filme'.",
"explicacao": "No sentido de ajudar, é transitivo direto: 'O médico assistiu o paciente'."
},
{
"id": 2000005355,
"trilha": "tribunais",
"materia": "port",
"assunto": "Regência",
"tipo": "pergunta",
"frente": "Qual a regência do verbo 'visar' no sentido de pretender?",
"verso": "Transitivo indireto: 'Visamos ao progresso'. Muitos gramáticos aceitam sem preposição antes de infinitivo.",
"explicacao": "No sentido de mirar ou dar visto, é transitivo direto."
},
{
"id": 2000005356,
"trilha": "tribunais",
"materia": "port",
"assunto": "Regência",
"tipo": "pergunta",
"frente": "Qual a regência do verbo 'implicar' no sentido de acarretar?",
"verso": "Transitivo direto: 'A decisão implica mudanças' (sem 'em', segundo a norma tradicional).",
"explicacao": "Regência verbal."
},
{
"id": 2000005357,
"trilha": "tribunais",
"materia": "port",
"assunto": "Crase",
"tipo": "pergunta",
"frente": "Há crase antes de palavra masculina?",
"verso": "Em regra, não. Exceção: quando está subentendida a expressão 'à moda de': 'bife à milanesa', 'gol à Pelé'.",
"explicacao": "Regras de crase."
},
{
"id": 2000005358,
"trilha": "tribunais",
"materia": "port",
"assunto": "Crase",
"tipo": "pergunta",
"frente": "Há crase antes de horas?",
"verso": "Sim, quando indica hora determinada: 'Chegou às 10 horas'.",
"explicacao": "Mas não depois de preposição: 'desde as 8 horas'."
},
{
"id": 2000005359,
"trilha": "tribunais",
"materia": "port",
"assunto": "Crase",
"tipo": "pergunta",
"frente": "A crase é obrigatória antes de pronome possessivo feminino?",
"verso": "Não, é facultativa no singular: 'Refiro-me a/à sua irmã'.",
"explicacao": "Facultativa porque o artigo antes do possessivo é opcional."
},
{
"id": 2000005360,
"trilha": "tribunais",
"materia": "port",
"assunto": "Pontuação",
"tipo": "pergunta",
"frente": "Deve-se separar com vírgula o sujeito do verbo?",
"verso": "Não.",
"explicacao": "Erro grave: 'Os alunos, estudaram muito'."
},
{
"id": 2000005361,
"trilha": "tribunais",
"materia": "port",
"assunto": "Pontuação",
"tipo": "pergunta",
"frente": "Qual a pontuação para o vocativo?",
"verso": "O vocativo é sempre separado por vírgula: 'Senhor juiz, peço a palavra'.",
"explicacao": "Regra de pontuação."
},
{
"id": 2000005362,
"trilha": "tribunais",
"materia": "port",
"assunto": "Colocação pronominal",
"tipo": "pergunta",
"frente": "Pode-se começar frase com pronome oblíquo átono?",
"verso": "Não, segundo a norma-padrão: 'Me dá' deve ser 'Dá-me'.",
"explicacao": "Regra da colocação pronominal."
},
{
"id": 2000005363,
"trilha": "tribunais",
"materia": "port",
"assunto": "Redação oficial",
"tipo": "pergunta",
"frente": "Qual o único expediente padrão de comunicação no Poder Executivo federal após a 3ª edição do Manual?",
"verso": "O ofício.",
"explicacao": "Memorando e aviso foram unificados no ofício (padrão ofício)."
},
{
"id": 2000005364,
"trilha": "tribunais",
"materia": "port",
"assunto": "Ortografia",
"tipo": "pergunta",
"frente": "Qual a diferença entre 'mal' e 'mau'?",
"verso": "'Mal' é advérbio ou substantivo, oposto de 'bem'. 'Mau' é adjetivo, oposto de 'bom'.",
"explicacao": "Ex.: 'Ele agiu mal'; 'Ele é um mau aluno'."
},
{
"id": 2000005365,
"trilha": "tribunais",
"materia": "port",
"assunto": "Ortografia",
"tipo": "pergunta",
"frente": "Qual a diferença entre 'senão' e 'se não'?",
"verso": "'Senão': caso contrário, mas sim, a não ser. 'Se não': caso não (conjunção condicional + negação).",
"explicacao": "Ex.: 'Estude, senão perderá'; 'Se não chover, irei'."
},
{
"id": 2000005366,
"trilha": "tribunais",
"materia": "port",
"assunto": "Ortografia",
"tipo": "pergunta",
"frente": "Qual a diferença entre 'onde' e 'aonde'?",
"verso": "'Onde': lugar em que se está (verbos estáticos). 'Aonde': lugar para o qual se vai (verbos de movimento).",
"explicacao": "Ex.: 'Onde você mora?'; 'Aonde você vai?'."
},
{
"id": 2000005367,
"trilha": "tribunais",
"materia": "port",
"assunto": "Ortografia",
"tipo": "pergunta",
"frente": "Qual a diferença entre 'tampouco' e 'tão pouco'?",
"verso": "'Tampouco': também não. 'Tão pouco': muito pouco.",
"explicacao": "Ex.: 'Não estudou, tampouco trabalhou'; 'Comeu tão pouco'."
},
{
"id": 2000005368,
"trilha": "tribunais",
"materia": "inf",
"assunto": "Segurança",
"tipo": "pergunta",
"frente": "Quais os princípios básicos da segurança da informação?",
"verso": "Confidencialidade, integridade e disponibilidade (tríade CID). Também se citam autenticidade e irretratabilidade.",
"explicacao": "Base da segurança da informação."
},
{
"id": 2000005369,
"trilha": "tribunais",
"materia": "inf",
"assunto": "Segurança",
"tipo": "pergunta",
"frente": "O que é a certificação digital?",
"verso": "Documento eletrônico que identifica uma pessoa ou entidade e permite assinar documentos com validade jurídica, emitido por autoridade certificadora.",
"explicacao": "No Brasil, ICP-Brasil (MP 2.200-2/2001)."
},
{
"id": 2000005370,
"trilha": "tribunais",
"materia": "inf",
"assunto": "Internet",
"tipo": "pergunta",
"frente": "O que é computação em nuvem?",
"verso": "Uso de recursos computacionais (armazenamento, processamento, programas) pela internet, sob demanda.",
"explicacao": "Modelos: IaaS, PaaS e SaaS."
},
{
"id": 2000005371,
"trilha": "tribunais",
"materia": "inf",
"assunto": "Internet",
"tipo": "pares",
"frente": "Qual a diferença entre HTTP e HTTPS?",
"verso": "HTTP: transferência sem criptografia. HTTPS: com criptografia (TLS), protegendo os dados transmitidos.",
"explicacao": "O cadeado no navegador indica HTTPS."
},
{
"id": 2000005372,
"trilha": "tribunais",
"materia": "inf",
"assunto": "Internet",
"tipo": "pergunta",
"frente": "O que é a navegação anônima (privativa) e o que ela não faz?",
"verso": "Não guarda histórico, cookies e dados de formulário no computador, mas não esconde a navegação do provedor, da empresa ou dos sites.",
"explicacao": "Recurso dos navegadores."
},
{
"id": 2000005373,
"trilha": "tribunais",
"materia": "inf",
"assunto": "Pacote Office",
"tipo": "pergunta",
"frente": "Qual função do Excel retorna o valor procurado em uma coluna de uma tabela?",
"verso": "PROCV (ou PROCX nas versões mais novas).",
"explicacao": "Ex.: =PROCV(valor;tabela;coluna;0)."
},
{
"id": 2000005374,
"trilha": "tribunais",
"materia": "inf",
"assunto": "Pacote Office",
"tipo": "pergunta",
"frente": "O que faz a função SE no Excel?",
"verso": "Testa uma condição e retorna um valor se verdadeira e outro se falsa.",
"explicacao": "Ex.: =SE(A1>=7;\"Aprovado\";\"Reprovado\")."
},
{
"id": 2000005375,
"trilha": "tribunais",
"materia": "inf",
"assunto": "Pacote Office",
"tipo": "pergunta",
"frente": "O que indica o $ em uma referência como $A$1 no Excel?",
"verso": "Referência absoluta: a linha e a coluna não mudam ao copiar a fórmula.",
"explicacao": "A1: relativa; $A1 ou A$1: mista."
},
{
"id": 2000005376,
"trilha": "tribunais",
"materia": "inf",
"assunto": "Pacote Office",
"tipo": "pergunta",
"frente": "Qual o atalho para desfazer a última ação no Windows e no Office?",
"verso": "Ctrl + Z.",
"explicacao": "Ctrl + Y refaz."
},
{
"id": 2000005377,
"trilha": "tribunais",
"materia": "rl",
"assunto": "Lógica proposicional",
"tipo": "pergunta",
"frente": "Qual a negação de 'Todos os servidores são pontuais'?",
"verso": "'Algum servidor não é pontual'.",
"explicacao": "Negação de 'todo' é 'algum... não'."
},
{
"id": 2000005378,
"trilha": "tribunais",
"materia": "rl",
"assunto": "Lógica proposicional",
"tipo": "pergunta",
"frente": "Qual a negação de 'Nenhum juiz é parcial'?",
"verso": "'Algum juiz é parcial'.",
"explicacao": "Negação de 'nenhum' é 'algum'."
},
{
"id": 2000005379,
"trilha": "tribunais",
"materia": "rl",
"assunto": "Lógica proposicional",
"tipo": "pergunta",
"frente": "Qual a negação de 'Se chove, então a rua molha'?",
"verso": "'Chove e a rua não molha'.",
"explicacao": "~(p → q) ≡ p ∧ ~q."
},
{
"id": 2000005380,
"trilha": "tribunais",
"materia": "rl",
"assunto": "Lógica proposicional",
"tipo": "pergunta",
"frente": "Qual a equivalência da condicional 'Se p, então q' pela contrapositiva?",
"verso": "'Se não q, então não p'.",
"explicacao": "p → q ≡ ~q → ~p."
},
{
"id": 2000005381,
"trilha": "tribunais",
"materia": "rl",
"assunto": "Lógica proposicional",
"tipo": "pergunta",
"frente": "Quando a disjunção 'p ou q' é falsa?",
"verso": "Só quando p e q são falsas.",
"explicacao": "Tabela-verdade da disjunção."
},
{
"id": 2000005382,
"trilha": "tribunais",
"materia": "rl",
"assunto": "Lógica proposicional",
"tipo": "pergunta",
"frente": "Qual a equivalência de 'Se p, então q' usando 'ou'?",
"verso": "'Não p ou q'.",
"explicacao": "p → q ≡ ~p ∨ q."
},
{
"id": 2000005383,
"trilha": "tribunais",
"materia": "rl",
"assunto": "Lógica proposicional",
"tipo": "pergunta",
"frente": "O que é uma tautologia?",
"verso": "Proposição composta sempre verdadeira, quaisquer que sejam os valores das proposições simples.",
"explicacao": "Ex.: p ∨ ~p."
},
{
"id": 2000005384,
"trilha": "tribunais",
"materia": "rl",
"assunto": "Matemática",
"tipo": "pergunta",
"frente": "Quantos anagramas tem a palavra JUIZ?",
"verso": "24 (4! = 24).",
"explicacao": "Permutação simples de 4 letras distintas."
},
{
"id": 2000005385,
"trilha": "tribunais",
"materia": "rl",
"assunto": "Matemática",
"tipo": "pergunta",
"frente": "De quantas formas se escolhem 3 servidores entre 6 para uma comissão?",
"verso": "20 formas (C(6,3) = 20).",
"explicacao": "Combinação: a ordem não importa."
},
{
"id": 2000005386,
"trilha": "tribunais",
"materia": "rl",
"assunto": "Matemática",
"tipo": "pergunta",
"frente": "Qual a probabilidade de tirar um número par em um dado comum?",
"verso": "1/2 (3 casos favoráveis em 6).",
"explicacao": "Probabilidade clássica."
},
{
"id": 2000005387,
"trilha": "tribunais",
"materia": "rl",
"assunto": "Matemática",
"tipo": "pergunta",
"frente": "Um produto de R$ 200 teve aumento de 10% e depois desconto de 10%. Qual o preço final?",
"verso": "R$ 198.",
"explicacao": "200 × 1,1 × 0,9 = 198."
},
{
"id": 2000005388,
"trilha": "tribunais",
"materia": "trib",
"assunto": "Tributário",
"tipo": "pergunta",
"frente": "As custas judiciais têm natureza de quê?",
"verso": "Taxa.",
"explicacao": "Entendimento do STF. Por isso, sujeitam-se às limitações do poder de tributar."
},
{
"id": 2000005389,
"trilha": "tribunais",
"materia": "trib",
"assunto": "Tributário",
"tipo": "pergunta",
"frente": "Qual o prazo de prescrição para a Fazenda cobrar o crédito tributário?",
"verso": "5 anos, contados da constituição definitiva do crédito.",
"explicacao": "CTN, art. 174."
},
{
"id": 2000005390,
"trilha": "tribunais",
"materia": "trib",
"assunto": "Tributário",
"tipo": "pergunta",
"frente": "O que é a denúncia espontânea?",
"verso": "Confissão da infração com pagamento do tributo e juros antes de qualquer procedimento fiscal, que afasta a multa.",
"explicacao": "CTN, art. 138. Não se aplica a tributos declarados e pagos com atraso (Súmula 360 do STJ)."
},
{
"id": 2000005391,
"trilha": "tribunais",
"materia": "trib",
"assunto": "Execução fiscal",
"tipo": "pergunta",
"frente": "Qual o prazo para o executado pagar ou garantir a execução fiscal?",
"verso": "5 dias, contados da citação.",
"explicacao": "Lei 6.830/1980, art. 8º."
},
{
"id": 2000005392,
"trilha": "tribunais",
"materia": "pcd",
"assunto": "Pessoa com deficiência",
"tipo": "pergunta",
"frente": "Qual a definição de pessoa com deficiência na Lei 13.146/2015?",
"verso": "Aquela que tem impedimento de longo prazo de natureza física, mental, intelectual ou sensorial que, em interação com barreiras, pode obstruir sua participação plena na sociedade.",
"explicacao": "Lei 13.146/2015, art. 2º."
},
{
"id": 2000005393,
"trilha": "tribunais",
"materia": "pcd",
"assunto": "Pessoa com deficiência",
"tipo": "pergunta",
"frente": "A deficiência afeta a capacidade civil da pessoa?",
"verso": "Não. A deficiência não afeta a plena capacidade civil, inclusive para casar, constituir união estável e exercer direitos reprodutivos.",
"explicacao": "Lei 13.146/2015, art. 6º."
},
{
"id": 2000005394,
"trilha": "tribunais",
"materia": "ia",
"assunto": "Inteligência artificial",
"tipo": "pergunta",
"frente": "O que a Resolução CNJ 615/2025 regula?",
"verso": "O uso de inteligência artificial no Poder Judiciário, com regras de governança, transparência e supervisão humana.",
"explicacao": "Substituiu a Resolução CNJ 332/2020."
},
{
"id": 2000005395,
"trilha": "tribunais",
"materia": "sust",
"assunto": "Sustentabilidade",
"tipo": "pergunta",
"frente": "O que é a Agenda 2030 da ONU?",
"verso": "Plano de ação global com 17 Objetivos de Desenvolvimento Sustentável (ODS) e 169 metas.",
"explicacao": "Adotado em 2015. O Judiciário brasileiro aderiu por meio do CNJ."
},
{
"id": 2000005396,
"trilha": "tribunais",
"materia": "sust",
"assunto": "Sustentabilidade",
"tipo": "pergunta",
"frente": "O que é o Plano de Logística Sustentável (PLS) no Judiciário?",
"verso": "Instrumento de planejamento com objetivos, metas e ações para práticas de sustentabilidade e racionalização de gastos nos tribunais.",
"explicacao": "Resolução CNJ 400/2021."
},
{
"id": 2000005397,
"trilha": "tribunais",
"materia": "sust",
"assunto": "Sustentabilidade",
"tipo": "pergunta",
"frente": "O que são os 3 pilares do desenvolvimento sustentável?",
"verso": "Ambiental, social e econômico.",
"explicacao": "Também chamado de tripé da sustentabilidade."
},
{
"id": 2000005398,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Bens públicos",
"tipo": "pares",
"frente": "Quais as três categorias de bens públicos no Código Civil?",
"verso": "Uso comum do povo (rios, ruas, praças), uso especial (edifícios de repartições) e dominicais (patrimônio disponível, como terras devolutas).",
"explicacao": "CC, art. 99."
},
{
"id": 2000005399,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Bens públicos",
"tipo": "pergunta",
"frente": "O que é a afetação de um bem público?",
"verso": "Atribuição de uma destinação pública ao bem, tornando-o de uso comum ou especial.",
"explicacao": "A desafetação retira a destinação, tornando-o dominical."
},
{
"id": 2000005400,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Bens públicos",
"tipo": "pares",
"frente": "Qual a diferença entre autorização, permissão e concessão de uso de bem público?",
"verso": "Autorização: ato unilateral, discricionário e precário, no interesse do particular. Permissão: ato unilateral e precário, com interesse público. Concessão: contrato administrativo, mais estável.",
"explicacao": "Formas de uso privativo de bem público."
},
{
"id": 2000005401,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Intervenção na propriedade",
"tipo": "pergunta",
"frente": "O que é a requisição administrativa?",
"verso": "Uso de bem ou serviço particular pelo poder público em caso de iminente perigo público, com indenização posterior se houver dano.",
"explicacao": "CF, art. 5º, XXV."
},
{
"id": 2000005402,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Intervenção na propriedade",
"tipo": "pergunta",
"frente": "O que é o tombamento?",
"verso": "Intervenção que protege bens de valor histórico, artístico, paisagístico ou cultural, impondo restrições ao uso e à alteração.",
"explicacao": "Decreto-Lei 25/1937."
},
{
"id": 2000005403,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Intervenção na propriedade",
"tipo": "pergunta",
"frente": "O que é a ocupação temporária?",
"verso": "Uso transitório de imóvel particular pelo poder público para obras ou serviços de interesse público, como guardar máquinas perto de uma obra.",
"explicacao": "Indenização se houver dano."
},
{
"id": 2000005404,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Intervenção na propriedade",
"tipo": "pergunta",
"frente": "O que é a servidão administrativa?",
"verso": "Direito real público que permite ao poder público usar propriedade particular para serviço de interesse coletivo, como passagem de rede elétrica.",
"explicacao": "Indenização só se houver prejuízo."
},
{
"id": 2000005405,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Intervenção na propriedade",
"tipo": "pergunta",
"frente": "O que é a limitação administrativa?",
"verso": "Imposição geral, gratuita e unilateral que condiciona o uso da propriedade à função social, como recuos de construção.",
"explicacao": "Em regra, não gera indenização."
},
{
"id": 2000005406,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Intervenção na propriedade",
"tipo": "pergunta",
"frente": "Qual o prazo de caducidade do decreto de desapropriação por utilidade pública?",
"verso": "5 anos.",
"explicacao": "Decreto-Lei 3.365/1941, art. 10. Por interesse social, 2 anos."
},
{
"id": 2000005407,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Intervenção na propriedade",
"tipo": "pergunta",
"frente": "O que é a retrocessão?",
"verso": "Direito do expropriado de reaver o bem quando o poder público não lhe dá destinação pública (tredestinação ilícita).",
"explicacao": "CC, art. 519."
},
{
"id": 2000005408,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Intervenção na propriedade",
"tipo": "pergunta",
"frente": "O que é a desapropriação confiscatória?",
"verso": "Expropriação sem indenização de propriedades onde forem localizadas culturas ilegais de plantas psicotrópicas ou exploração de trabalho escravo.",
"explicacao": "CF, art. 243."
},
{
"id": 2000005409,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Servidores",
"tipo": "pergunta",
"frente": "Qual o prazo para o servidor nomeado tomar posse na Lei 8.112/1990?",
"verso": "30 dias, contados da publicação do ato de provimento.",
"explicacao": "Lei 8.112/1990, art. 13, § 1º."
},
{
"id": 2000005410,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Servidores",
"tipo": "pergunta",
"frente": "Qual o prazo para o servidor empossado entrar em exercício?",
"verso": "15 dias, contados da data da posse.",
"explicacao": "Lei 8.112/1990, art. 15, § 1º."
},
{
"id": 2000005411,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Servidores",
"tipo": "pergunta",
"frente": "O que é a reintegração do servidor?",
"verso": "Reinvestidura do servidor estável no cargo anteriormente ocupado quando sua demissão é invalidada por decisão administrativa ou judicial, com ressarcimento de todas as vantagens.",
"explicacao": "Lei 8.112/1990, art. 28."
},
{
"id": 2000005412,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Servidores",
"tipo": "pergunta",
"frente": "O que é a recondução do servidor?",
"verso": "Retorno do servidor estável ao cargo anteriormente ocupado, por inabilitação em estágio probatório de outro cargo ou reintegração do anterior ocupante.",
"explicacao": "Lei 8.112/1990, art. 29."
},
{
"id": 2000005413,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Servidores",
"tipo": "pergunta",
"frente": "O que é a reversão do servidor?",
"verso": "Retorno à atividade de servidor aposentado, por invalidez quando insubsistentes os motivos ou no interesse da administração, nas condições da lei.",
"explicacao": "Lei 8.112/1990, art. 25."
},
{
"id": 2000005414,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Servidores",
"tipo": "pergunta",
"frente": "Quantos dias de férias tem o servidor federal por ano?",
"verso": "30 dias, que podem ser acumulados até o máximo de 2 períodos, no caso de necessidade do serviço.",
"explicacao": "Lei 8.112/1990, art. 77. Exige 12 meses de exercício para o primeiro período."
},
{
"id": 2000005415,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Servidores",
"tipo": "pergunta",
"frente": "Qual a jornada máxima semanal do servidor na Lei 8.112/1990?",
"verso": "40 horas semanais, observados os limites mínimo e máximo de 6 e 8 horas diárias.",
"explicacao": "Lei 8.112/1990, art. 19."
},
{
"id": 2000005416,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Servidores",
"tipo": "pergunta",
"frente": "Quais as licenças previstas na Lei 8.112/1990 (exemplos)?",
"verso": "Por motivo de doença em pessoa da família, por afastamento do cônjuge, para serviço militar, para atividade política, para capacitação, para tratar de interesses particulares e para mandato classista.",
"explicacao": "Lei 8.112/1990, art. 81."
},
{
"id": 2000005417,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Servidores",
"tipo": "pergunta",
"frente": "Por quanto tempo pode durar a licença para tratar de interesses particulares?",
"verso": "Até 3 anos consecutivos, sem remuneração, a critério da administração, para servidor que não esteja em estágio probatório.",
"explicacao": "Lei 8.112/1990, art. 91."
},
{
"id": 2000005418,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Servidores",
"tipo": "pergunta",
"frente": "Quantos dias de licença para capacitação o servidor tem e quando?",
"verso": "Até 3 meses, a cada quinquênio de efetivo exercício, com remuneração.",
"explicacao": "Lei 8.112/1990, art. 87."
},
{
"id": 2000005419,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Servidores",
"tipo": "pergunta",
"frente": "Por quanto tempo o servidor pode se ausentar por casamento ou falecimento de familiar?",
"verso": "8 dias consecutivos.",
"explicacao": "Lei 8.112/1990, art. 97, III."
},
{
"id": 2000005420,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Processo disciplinar",
"tipo": "pergunta",
"frente": "Qual o prazo para conclusão da sindicância?",
"verso": "Até 30 dias, prorrogáveis por igual período.",
"explicacao": "Lei 8.112/1990, art. 145, parágrafo único."
},
{
"id": 2000005421,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Acesso à informação",
"tipo": "pergunta",
"frente": "Quais os prazos máximos de sigilo das informações classificadas na LAI?",
"verso": "Ultrassecreta: 25 anos. Secreta: 15 anos. Reservada: 5 anos.",
"explicacao": "Lei 12.527/2011, art. 24."
},
{
"id": 2000005422,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Acesso à informação",
"tipo": "pergunta",
"frente": "É preciso justificar o pedido de acesso à informação?",
"verso": "Não. São vedadas exigências relativas aos motivos do pedido.",
"explicacao": "Lei 12.527/2011, art. 10, § 3º."
},
{
"id": 2000005423,
"trilha": "tribunais",
"materia": "adm",
"assunto": "Acesso à informação",
"tipo": "pergunta",
"frente": "Qual a diferença entre transparência ativa e passiva?",
"verso": "Ativa: o órgão divulga informações por iniciativa própria. Passiva: o órgão fornece informações a pedido do cidadão.",
"explicacao": "Lei 12.527/2011, arts. 8º e 10."
},
{
"id": 2000005424,
"trilha": "tribunais",
"materia": "const",
"assunto": "Controle de constitucionalidade",
"tipo": "pergunta",
"frente": "Quem pode propor ADI perante o STF?",
"verso": "Presidente da República, Mesas do Senado, da Câmara, de Assembleia Legislativa e da Câmara Legislativa do DF, governador, PGR, Conselho Federal da OAB, partido político com representação no Congresso e confederação sindical ou entidade de classe de âmbito nacional.",
"explicacao": "CF, art. 103."
},
{
"id": 2000005425,
"trilha": "tribunais",
"materia": "const",
"assunto": "Controle de constitucionalidade",
"tipo": "pergunta",
"frente": "Quais legitimados da ADI precisam demonstrar pertinência temática?",
"verso": "Mesas das Assembleias Legislativas e da Câmara Legislativa, governadores e confederações sindicais ou entidades de classe de âmbito nacional.",
"explicacao": "Legitimados especiais, segundo o STF."
},
{
"id": 2000005426,
"trilha": "tribunais",
"materia": "const",
"assunto": "Controle de constitucionalidade",
"tipo": "pergunta",
"frente": "O que é a ADPF?",
"verso": "Arguição de descumprimento de preceito fundamental, ação subsidiária para evitar ou reparar lesão a preceito fundamental por ato do poder público, inclusive leis anteriores à CF e municipais.",
"explicacao": "Lei 9.882/1999."
},
{
"id": 2000005427,
"trilha": "tribunais",
"materia": "const",
"assunto": "Controle de constitucionalidade",
"tipo": "pergunta",
"frente": "O que é a ADO?",
"verso": "Ação direta de inconstitucionalidade por omissão, contra a falta de medida para tornar efetiva norma constitucional.",
"explicacao": "CF, art. 103, § 2º."
},
{
"id": 2000005428,
"trilha": "tribunais",
"materia": "const",
"assunto": "Controle de constitucionalidade",
"tipo": "pares",
"frente": "Qual a diferença entre controle difuso e concentrado de constitucionalidade?",
"verso": "Difuso: qualquer juiz ou tribunal, no caso concreto, com efeitos entre as partes. Concentrado: só o STF (ou TJ, para leis estaduais e municipais em face da Constituição estadual), em abstrato, com efeitos para todos.",
"explicacao": "Sistema misto brasileiro."
},
{
"id": 2000005429,
"trilha": "tribunais",
"materia": "const",
"assunto": "Controle de constitucionalidade",
"tipo": "pergunta",
"frente": "O que é a modulação dos efeitos na declaração de inconstitucionalidade?",
"verso": "Possibilidade de o STF, por 2/3 dos membros, restringir os efeitos ou definir o momento a partir do qual a decisão terá eficácia, por segurança jurídica ou excepcional interesse social.",
"explicacao": "Lei 9.868/1999, art. 27."
},
{
"id": 2000005430,
"trilha": "tribunais",
"materia": "const",
"assunto": "Controle de constitucionalidade",
"tipo": "pergunta",
"frente": "Qual o papel do Senado no controle difuso?",
"verso": "Suspender, por resolução, a execução de lei declarada inconstitucional por decisão definitiva do STF.",
"explicacao": "CF, art. 52, X."
},
{
"id": 2000005431,
"trilha": "tribunais",
"materia": "const",
"assunto": "Organização do Estado",
"tipo": "pergunta",
"frente": "Quais são os bens da União na Constituição (exemplos)?",
"verso": "Terras devolutas indispensáveis à defesa, lagos e rios em terrenos de seu domínio ou que banhem mais de um estado, ilhas oceânicas, mar territorial, terrenos de marinha, recursos minerais e cavidades subterrâneas.",
"explicacao": "CF, art. 20."
},
{
"id": 2000005432,
"trilha": "tribunais",
"materia": "const",
"assunto": "Organização do Estado",
"tipo": "pergunta",
"frente": "Como se cria um novo município?",
"verso": "Por lei estadual, dentro do período fixado em lei complementar federal, após estudos de viabilidade e consulta plebiscitária às populações envolvidas.",
"explicacao": "CF, art. 18, § 4º."
},
{
"id": 2000005433,
"trilha": "tribunais",
"materia": "const",
"assunto": "Organização do Estado",
"tipo": "pergunta",
"frente": "Quais são os princípios constitucionais sensíveis?",
"verso": "Forma republicana, sistema representativo e regime democrático, direitos da pessoa humana, autonomia municipal, prestação de contas da administração e aplicação do mínimo em saúde e educação.",
"explicacao": "CF, art. 34, VII. Sua violação autoriza intervenção federal."
},
{
"id": 2000005434,
"trilha": "tribunais",
"materia": "const",
"assunto": "Poder Legislativo",
"tipo": "pergunta",
"frente": "Quais matérias não podem ser objeto de medida provisória (exemplos)?",
"verso": "Nacionalidade, cidadania, direitos políticos, partidos, direito eleitoral, direito penal, processual penal e processual civil, organização do Judiciário e do MP, planos plurianuais e orçamento (salvo crédito extraordinário) e matéria reservada a lei complementar.",
"explicacao": "CF, art. 62, § 1º."
},
{
"id": 2000005435,
"trilha": "tribunais",
"materia": "const",
"assunto": "Poder Legislativo",
"tipo": "pergunta",
"frente": "Qual o prazo de vigência da medida provisória?",
"verso": "60 dias, prorrogáveis uma vez por mais 60.",
"explicacao": "CF, art. 62, §§ 3º e 7º. O prazo se suspende no recesso."
},
{
"id": 2000005436,
"trilha": "tribunais",
"materia": "const",
"assunto": "Poder Legislativo",
"tipo": "pergunta",
"frente": "Quem pode convocar Ministro de Estado para prestar informações?",
"verso": "A Câmara dos Deputados, o Senado ou qualquer de suas comissões. A ausência sem justificativa é crime de responsabilidade.",
"explicacao": "CF, art. 50."
},
{
"id": 2000005437,
"trilha": "tribunais",
"materia": "const",
"assunto": "Poder Legislativo",
"tipo": "pergunta",
"frente": "O que é a imunidade material dos parlamentares?",
"verso": "Deputados e senadores são invioláveis, civil e penalmente, por suas opiniões, palavras e votos.",
"explicacao": "CF, art. 53."
},
{
"id": 2000005438,
"trilha": "tribunais",
"materia": "const",
"assunto": "Poder Executivo",
"tipo": "pergunta",
"frente": "Quem sucede o Presidente da República no impedimento simultâneo dele e do vice?",
"verso": "Na ordem: Presidente da Câmara, Presidente do Senado e Presidente do STF.",
"explicacao": "CF, art. 80."
},
{
"id": 2000005439,
"trilha": "tribunais",
"materia": "const",
"assunto": "Poder Executivo",
"tipo": "pergunta",
"frente": "O que acontece se os cargos de Presidente e Vice ficarem vagos nos 2 últimos anos do mandato?",
"verso": "Eleição indireta pelo Congresso Nacional em 30 dias.",
"explicacao": "CF, art. 81, § 1º. Nos 2 primeiros anos, eleição direta em 90 dias."
},
{
"id": 2000005440,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Ausência",
"tipo": "pergunta",
"frente": "Quando se pode requerer a sucessão definitiva do ausente?",
"verso": "10 anos depois do trânsito em julgado da sentença que concede a sucessão provisória, ou se o ausente tiver 80 anos e as últimas notícias forem de 5 anos atrás.",
"explicacao": "CC, arts. 37 e 38."
},
{
"id": 2000005441,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Domicílio",
"tipo": "pergunta",
"frente": "Qual o domicílio do servidor público e do militar?",
"verso": "Servidor: o lugar em que exerce permanentemente suas funções. Militar: onde serve (o da Marinha e Aeronáutica, a sede do comando).",
"explicacao": "CC, art. 76 (domicílio necessário)."
},
{
"id": 2000005442,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Domicílio",
"tipo": "pergunta",
"frente": "Qual o domicílio do preso?",
"verso": "O lugar em que cumprir a sentença.",
"explicacao": "CC, art. 76, parágrafo único."
},
{
"id": 2000005443,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Contratos em espécie",
"tipo": "pergunta",
"frente": "A doação pode ser revogada por ingratidão do donatário?",
"verso": "Sim, em casos como atentado contra a vida do doador, ofensa física, injúria grave, calúnia ou recusa de alimentos.",
"explicacao": "CC, arts. 555 e 557."
},
{
"id": 2000005444,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Contratos em espécie",
"tipo": "pergunta",
"frente": "O que é a doação inoficiosa?",
"verso": "Doação da parte que excede o que o doador poderia dispor em testamento no momento da liberalidade. Essa parte é nula.",
"explicacao": "CC, art. 549."
},
{
"id": 2000005445,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Contratos em espécie",
"tipo": "pergunta",
"frente": "O que é o benefício de ordem na fiança?",
"verso": "Direito do fiador de exigir que primeiro sejam executados os bens do devedor.",
"explicacao": "CC, art. 827. Pode ser renunciado no contrato."
},
{
"id": 2000005446,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Contratos em espécie",
"tipo": "pergunta",
"frente": "Qual o prazo do comodato sem prazo convencionado?",
"verso": "Presume-se o necessário para o uso concedido.",
"explicacao": "CC, art. 581."
},
{
"id": 2000005447,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Contratos em espécie",
"tipo": "pares",
"frente": "Qual a diferença entre comodato e mútuo?",
"verso": "Comodato: empréstimo gratuito de coisa infungível, que deve ser devolvida. Mútuo: empréstimo de coisa fungível, que transfere a propriedade e é devolvida em igual quantidade e qualidade.",
"explicacao": "CC, arts. 579 e 586."
},
{
"id": 2000005448,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Contratos em espécie",
"tipo": "pergunta",
"frente": "No contrato de seguro, o que acontece se o segurado agravar intencionalmente o risco?",
"verso": "Perde o direito à garantia.",
"explicacao": "CC, art. 768."
},
{
"id": 2000005449,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Atos unilaterais",
"tipo": "pergunta",
"frente": "O que é a promessa de recompensa?",
"verso": "Quem promete publicamente recompensa a quem preencher certa condição ou prestar certo serviço fica obrigado a cumpri-la.",
"explicacao": "CC, art. 854."
},
{
"id": 2000005450,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Atos unilaterais",
"tipo": "pergunta",
"frente": "O que é a gestão de negócios?",
"verso": "Intervenção de alguém, sem autorização, na gestão de negócio alheio, conforme o interesse e a vontade presumível do dono.",
"explicacao": "CC, art. 861."
},
{
"id": 2000005451,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Atos unilaterais",
"tipo": "pergunta",
"frente": "O que é o pagamento indevido e qual a consequência?",
"verso": "Pagamento de algo que não era devido. Quem recebeu fica obrigado a restituir.",
"explicacao": "CC, art. 876."
},
{
"id": 2000005452,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Atos unilaterais",
"tipo": "pergunta",
"frente": "O que é o enriquecimento sem causa?",
"verso": "Quem, sem justa causa, se enriquecer à custa de outrem fica obrigado a restituir o indevidamente auferido, com atualização.",
"explicacao": "CC, art. 884."
},
{
"id": 2000005453,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Títulos de crédito",
"tipo": "pergunta",
"frente": "Quais os princípios dos títulos de crédito?",
"verso": "Cartularidade, literalidade e autonomia.",
"explicacao": "Conceito clássico de Vivante."
},
{
"id": 2000005454,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Títulos de crédito",
"tipo": "pergunta",
"frente": "O que é o aval?",
"verso": "Garantia pessoal dada por terceiro em título de crédito, que se torna responsável pelo pagamento.",
"explicacao": "CC, art. 897. Diferente da fiança, é autônomo."
},
{
"id": 2000005455,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Títulos de crédito",
"tipo": "pergunta",
"frente": "Qual o prazo para executar o cheque?",
"verso": "6 meses, contados do fim do prazo de apresentação (30 dias na mesma praça e 60 dias em praças diferentes).",
"explicacao": "Lei 7.357/1985, arts. 33 e 59."
},
{
"id": 2000005456,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Família",
"tipo": "pergunta",
"frente": "A guarda compartilhada é a regra quando os pais não chegam a acordo?",
"verso": "Sim, quando ambos estão aptos a exercer o poder familiar, salvo se um declarar que não deseja a guarda ou houver risco de violência doméstica.",
"explicacao": "CC, art. 1.584, § 2º."
},
{
"id": 2000005457,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Família",
"tipo": "pergunta",
"frente": "O que é alienação parental?",
"verso": "Interferência na formação psicológica da criança ou adolescente, promovida por um dos genitores ou quem tenha a guarda, para que repudie o outro genitor.",
"explicacao": "Lei 12.318/2010."
},
{
"id": 2000005458,
"trilha": "tribunais",
"materia": "civ",
"assunto": "Família",
"tipo": "pergunta",
"frente": "O divórcio pode ser feito em cartório?",
"verso": "Sim, por escritura pública, se consensual, com advogado. Sem filhos incapazes ou com as questões dos filhos já resolvidas judicialmente.",
"explicacao": "CPC, art. 733, e Resolução CNJ 35/2007."
},
{
"id": 2000005459,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Procedimentos especiais",
"tipo": "pergunta",
"frente": "O que é a ação de consignação em pagamento?",
"verso": "Ação do devedor para se liberar da obrigação depositando a quantia ou a coisa devida quando o credor se recusa a receber ou há dúvida sobre quem deve receber.",
"explicacao": "CPC, art. 539, e CC, art. 335."
},
{
"id": 2000005460,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Procedimentos especiais",
"tipo": "pergunta",
"frente": "O que é a ação de exigir contas?",
"verso": "Ação de quem tem o direito de exigir contas de quem administra seus bens ou interesses.",
"explicacao": "CPC, art. 550."
},
{
"id": 2000005461,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Procedimentos especiais",
"tipo": "pergunta",
"frente": "O que é a oposição no CPC/2015?",
"verso": "Ação de quem pretende, no todo ou em parte, a coisa ou o direito disputado entre autor e réu, proposta contra ambos.",
"explicacao": "CPC, art. 682. Deixou de ser intervenção de terceiros."
},
{
"id": 2000005462,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Procedimentos especiais",
"tipo": "pergunta",
"frente": "O que é a habilitação no processo civil?",
"verso": "Procedimento para substituir a parte falecida por seus sucessores no processo.",
"explicacao": "CPC, art. 687."
},
{
"id": 2000005463,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Procedimentos especiais",
"tipo": "pergunta",
"frente": "O que é a ação de dissolução parcial de sociedade?",
"verso": "Ação para resolver a sociedade em relação a um sócio (morte, exclusão, retirada) e apurar seus haveres.",
"explicacao": "CPC, art. 599."
},
{
"id": 2000005464,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Procedimentos especiais",
"tipo": "pergunta",
"frente": "O que é a homologação do penhor legal?",
"verso": "Procedimento em que o credor com penhor legal, como o hoteleiro, pede a homologação judicial ou extrajudicial do penhor.",
"explicacao": "CPC, art. 703."
},
{
"id": 2000005465,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Procedimentos especiais",
"tipo": "pergunta",
"frente": "Qual o rito das ações de família no CPC?",
"verso": "Procedimento especial com prioridade para a solução consensual, audiência de mediação e conciliação e citação sem cópia da inicial.",
"explicacao": "CPC, arts. 693 a 699."
},
{
"id": 2000005466,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Processo coletivo",
"tipo": "pergunta",
"frente": "Quem pode propor ação civil pública?",
"verso": "MP, Defensoria Pública, União, estados, DF, municípios, autarquias, empresas públicas, fundações, sociedades de economia mista e associações constituídas há pelo menos 1 ano.",
"explicacao": "Lei 7.347/1985, art. 5º."
},
{
"id": 2000005467,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Processo coletivo",
"tipo": "pergunta",
"frente": "Quem pode propor ação popular?",
"verso": "Qualquer cidadão (eleitor).",
"explicacao": "CF, art. 5º, LXXIII, e Lei 4.717/1965."
},
{
"id": 2000005468,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Processo coletivo",
"tipo": "pergunta",
"frente": "O autor da ação popular paga custas e honorários se perder?",
"verso": "Não, salvo comprovada má-fé.",
"explicacao": "CF, art. 5º, LXXIII."
},
{
"id": 2000005469,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Processo coletivo",
"tipo": "pergunta",
"frente": "Qual o prazo para propor ação popular?",
"verso": "5 anos.",
"explicacao": "Lei 4.717/1965, art. 21."
},
{
"id": 2000005470,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Processo coletivo",
"tipo": "pares",
"frente": "Quais as espécies de direitos coletivos no CDC?",
"verso": "Difusos: indivisíveis, titulares indeterminados ligados por circunstâncias de fato. Coletivos em sentido estrito: indivisíveis, grupo ligado por relação jurídica base. Individuais homogêneos: divisíveis, de origem comum.",
"explicacao": "CDC, art. 81, parágrafo único."
},
{
"id": 2000005471,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Processo coletivo",
"tipo": "pergunta",
"frente": "O que é o termo de ajustamento de conduta (TAC)?",
"verso": "Compromisso tomado pelos órgãos públicos legitimados para que o interessado ajuste sua conduta às exigências legais, com eficácia de título executivo extrajudicial.",
"explicacao": "Lei 7.347/1985, art. 5º, § 6º."
},
{
"id": 2000005472,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Habeas data e mandado de injunção",
"tipo": "pergunta",
"frente": "Para que serve o habeas data?",
"verso": "Para conhecer ou retificar informações pessoais em registros ou bancos de dados de entidades governamentais ou de caráter público.",
"explicacao": "CF, art. 5º, LXXII, e Lei 9.507/1997."
},
{
"id": 2000005473,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Habeas data e mandado de injunção",
"tipo": "pergunta",
"frente": "Qual a condição para impetrar habeas data?",
"verso": "Prova da recusa ao acesso às informações ou da demora em fornecê-las.",
"explicacao": "Súmula 2 do STJ e Lei 9.507/1997, art. 8º."
},
{
"id": 2000005474,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Habeas data e mandado de injunção",
"tipo": "pergunta",
"frente": "Qual o efeito da decisão no mandado de injunção, segundo a Lei 13.300/2016?",
"verso": "Em regra, eficácia entre as partes, com prazo para o legislador editar a norma e as condições para o exercício do direito; pode ter eficácia ultra partes ou erga omnes.",
"explicacao": "Lei 13.300/2016, art. 9º."
},
{
"id": 2000005475,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Juizados",
"tipo": "pergunta",
"frente": "Qual o teto dos Juizados Especiais da Fazenda Pública?",
"verso": "60 salários mínimos.",
"explicacao": "Lei 12.153/2009, art. 2º."
},
{
"id": 2000005476,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Juizados",
"tipo": "pergunta",
"frente": "No Juizado Especial Cível, é obrigatória a presença das partes na audiência?",
"verso": "Sim. A ausência do autor extingue o processo; a do réu gera revelia.",
"explicacao": "Lei 9.099/1995, arts. 20 e 51, I."
},
{
"id": 2000005477,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Mediação",
"tipo": "pergunta",
"frente": "O que é a mediação segundo a Lei 13.140/2015?",
"verso": "Atividade técnica exercida por terceiro imparcial sem poder decisório que auxilia as partes a identificar ou desenvolver soluções consensuais.",
"explicacao": "Lei 13.140/2015, art. 1º, parágrafo único."
},
{
"id": 2000005478,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Mediação",
"tipo": "pares",
"frente": "Qual a diferença entre conciliador e mediador no CPC?",
"verso": "Conciliador: atua preferencialmente quando não há vínculo anterior entre as partes e pode sugerir soluções. Mediador: atua quando há vínculo anterior e ajuda as partes a restabelecer o diálogo.",
"explicacao": "CPC, art. 165, §§ 2º e 3º."
},
{
"id": 2000005479,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Arbitragem",
"tipo": "pergunta",
"frente": "A sentença arbitral precisa de homologação judicial?",
"verso": "Não. Produz os mesmos efeitos da sentença judicial e é título executivo judicial.",
"explicacao": "Lei 9.307/1996, art. 31, e CPC, art. 515, VII."
},
{
"id": 2000005480,
"trilha": "tribunais",
"materia": "pciv",
"assunto": "Arbitragem",
"tipo": "pergunta",
"frente": "Qual o prazo para pedir a anulação da sentença arbitral?",
"verso": "90 dias, contados do recebimento da notificação da sentença.",
"explicacao": "Lei 9.307/1996, art. 33, § 1º."
},
{
"id": 2000005481,
"trilha": "tribunais",
"materia": "port",
"assunto": "Semântica",
"tipo": "pares",
"frente": "Qual a diferença entre 'eminente' e 'iminente'?",
"verso": "Eminente: ilustre, elevado. Iminente: prestes a acontecer.",
"explicacao": "Parônimos."
},
{
"id": 2000005482,
"trilha": "tribunais",
"materia": "port",
"assunto": "Semântica",
"tipo": "pares",
"frente": "Qual a diferença entre 'deferir' e 'diferir'?",
"verso": "Deferir: conceder, atender. Diferir: adiar ou ser diferente.",
"explicacao": "Parônimos muito usados no Judiciário."
},
{
"id": 2000005483,
"trilha": "tribunais",
"materia": "port",
"assunto": "Semântica",
"tipo": "pares",
"frente": "Qual a diferença entre 'mandado' e 'mandato'?",
"verso": "Mandado: ordem judicial. Mandato: delegação de poderes ou período de exercício de cargo eletivo.",
"explicacao": "Parônimos."
},
{
"id": 2000005484,
"trilha": "tribunais",
"materia": "port",
"assunto": "Semântica",
"tipo": "pares",
"frente": "Qual a diferença entre 'tráfego' e 'tráfico'?",
"verso": "Tráfego: trânsito, movimento. Tráfico: comércio ilegal.",
"explicacao": "Parônimos."
},
{
"id": 2000005485,
"trilha": "tribunais",
"materia": "port",
"assunto": "Semântica",
"tipo": "pares",
"frente": "Qual a diferença entre 'descriminar' e 'discriminar'?",
"verso": "Descriminar: deixar de considerar crime. Discriminar: distinguir ou tratar de forma desigual.",
"explicacao": "Parônimos."
},
{
"id": 2000005486,
"trilha": "tribunais",
"materia": "port",
"assunto": "Sintaxe",
"tipo": "pergunta",
"frente": "O que é o sujeito indeterminado?",
"verso": "Sujeito que existe, mas não se quer ou não se pode identificar: verbo na 3ª pessoa do plural sem referente ou na 3ª do singular com 'se' (índice de indeterminação).",
"explicacao": "Ex.: 'Roubaram meu carro'; 'Precisa-se de vendedores'."
},
{
"id": 2000005487,
"trilha": "tribunais",
"materia": "port",
"assunto": "Sintaxe",
"tipo": "pares",
"frente": "Qual a diferença entre 'se' partícula apassivadora e índice de indeterminação do sujeito?",
"verso": "Apassivadora: com verbo transitivo direto, o verbo concorda com o sujeito ('Vendem-se casas'). Índice de indeterminação: com verbo intransitivo, transitivo indireto ou de ligação, o verbo fica no singular ('Precisa-se de casas').",
"explicacao": "Diferença muito cobrada em provas."
},
{
"id": 2000005488,
"trilha": "tribunais",
"materia": "port",
"assunto": "Sintaxe",
"tipo": "pergunta",
"frente": "O que é o aposto?",
"verso": "Termo que explica, especifica ou resume outro termo da oração, geralmente entre vírgulas.",
"explicacao": "Ex.: 'Brasília, capital do Brasil, foi inaugurada em 1960'."
},
{
"id": 2000005489,
"trilha": "tribunais",
"materia": "port",
"assunto": "Sintaxe",
"tipo": "pares",
"frente": "Qual a diferença entre oração adjetiva restritiva e explicativa?",
"verso": "Restritiva: limita o sentido do antecedente, sem vírgulas. Explicativa: acrescenta informação, entre vírgulas.",
"explicacao": "Ex.: 'Os alunos que estudaram passaram' x 'Os alunos, que estudaram, passaram'."
},
{
"id": 2000005490,
"trilha": "tribunais",
"materia": "port",
"assunto": "Verbos",
"tipo": "pergunta",
"frente": "Qual a forma correta: 'Se eu ver' ou 'Se eu vir'?",
"verso": "'Se eu vir'. O futuro do subjuntivo de ver é vir.",
"explicacao": "Ex.: 'Quando eu vir o resultado, aviso'."
},
{
"id": 2000005491,
"trilha": "tribunais",
"materia": "port",
"assunto": "Verbos",
"tipo": "pergunta",
"frente": "Qual a forma correta: 'Se ele propor' ou 'Se ele propuser'?",
"verso": "'Se ele propuser'. Os derivados de pôr seguem sua conjugação.",
"explicacao": "Ex.: compuser, dispuser, supuser."
},
{
"id": 2000005492,
"trilha": "tribunais",
"materia": "port",
"assunto": "Verbos",
"tipo": "pergunta",
"frente": "Qual a forma correta: 'Eu intermedio' ou 'Eu intermedeio'?",
"verso": "'Eu intermedeio'. Mediar, ansiar, remediar, incendiar e odiar (MARIO) se conjugam como odiar.",
"explicacao": "Ex.: medeio, anseio, remedeio, incendeio, odeio."
},
{
"id": 2000005493,
"trilha": "tribunais",
"materia": "inf",
"assunto": "Proteção de dados",
"tipo": "pergunta",
"frente": "O que é dado pessoal sensível na LGPD?",
"verso": "Dado sobre origem racial ou étnica, convicção religiosa, opinião política, filiação sindical, saúde, vida sexual, dado genético ou biométrico, vinculado a uma pessoa natural.",
"explicacao": "Lei 13.709/2018, art. 5º, II."
},
{
"id": 2000005494,
"trilha": "tribunais",
"materia": "inf",
"assunto": "Proteção de dados",
"tipo": "pergunta",
"frente": "O que é o encarregado (DPO) na LGPD?",
"verso": "Pessoa indicada pelo controlador para atuar como canal de comunicação entre o controlador, os titulares e a ANPD.",
"explicacao": "Lei 13.709/2018, art. 5º, VIII."
},
{
"id": 2000005495,
"trilha": "tribunais",
"materia": "inf",
"assunto": "Proteção de dados",
"tipo": "pares",
"frente": "Qual a diferença entre controlador e operador na LGPD?",
"verso": "Controlador: toma as decisões sobre o tratamento dos dados. Operador: realiza o tratamento em nome do controlador.",
"explicacao": "Lei 13.709/2018, art. 5º, VI e VII."
},
{
"id": 2000005496,
"trilha": "tribunais",
"materia": "inf",
"assunto": "Proteção de dados",
"tipo": "pergunta",
"frente": "O que é a anonimização de dados?",
"verso": "Uso de meios técnicos pelos quais um dado perde a possibilidade de associação, direta ou indireta, a um indivíduo.",
"explicacao": "Lei 13.709/2018, art. 5º, XI. Dado anonimizado não é dado pessoal."
},
{
"id": 2000005497,
"trilha": "tribunais",
"materia": "rl",
"assunto": "Matemática",
"tipo": "pergunta",
"frente": "Uma tarefa é feita por 4 servidores em 6 dias. Em quantos dias 3 servidores fazem a mesma tarefa?",
"verso": "8 dias.",
"explicacao": "Regra de três inversa: 4 × 6 = 3 × x, x = 8."
},
{
"id": 2000005498,
"trilha": "tribunais",
"materia": "rl",
"assunto": "Matemática",
"tipo": "pergunta",
"frente": "Qual o juro simples de R$ 1.000 a 2% ao mês durante 5 meses?",
"verso": "R$ 100.",
"explicacao": "J = C × i × t = 1.000 × 0,02 × 5."
},
{
"id": 2000005499,
"trilha": "tribunais",
"materia": "rl",
"assunto": "Lógica proposicional",
"tipo": "pergunta",
"frente": "Qual a negação de 'João é juiz e Maria é promotora'?",
"verso": "'João não é juiz ou Maria não é promotora'.",
"explicacao": "Lei de De Morgan: ~(p ∧ q) ≡ ~p ∨ ~q."
},
{
"id": 2000005500,
"trilha": "tribunais",
"materia": "rl",
"assunto": "Lógica proposicional",
"tipo": "pergunta",
"frente": "Qual a negação de 'Ana estuda ou trabalha'?",
"verso": "'Ana não estuda e não trabalha'.",
"explicacao": "Lei de De Morgan: ~(p ∨ q) ≡ ~p ∧ ~q."
}
]$c$::jsonb) as x(id integer, trilha text, materia text, assunto text, tipo text, frente text, verso text, explicacao text)
on conflict (id) do update set trilha = excluded.trilha, materia = excluded.materia, assunto = excluded.assunto, tipo = excluded.tipo,
  frente = excluded.frente, verso = excluded.verso, explicacao = excluded.explicacao, ativa = true, atualizado_em = now();

select trilha, count(*) as cartoes, public.cartoes_versao() as versao from public.cartoes where ativa group by trilha;
