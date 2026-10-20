-- Aprenda se Divertindo · 96 · Baralho de cartões · trilha Administrativa · 500 cartões (primeiro baralho próprio)
-- Rode depois do 95-cartoes-tribunais-2.sql. Cole TUDO no SQL Editor e clique em Run. Pode rodar de novo sem problema.
--
insert into public.cartoes (id, trilha, materia, assunto, tipo, frente, verso, explicacao)
select id, trilha, materia, assunto, tipo, frente, verso, explicacao
from jsonb_to_recordset($c$[
{
"id": 2000005501,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Conceitos",
"tipo": "pergunta",
"frente": "O que é orçamento público?",
"verso": "Instrumento de planejamento que estima as receitas e fixa as despesas do governo para um exercício financeiro.",
"explicacao": "No Brasil, a LOA é aprovada por lei."
},
{
"id": 2000005502,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Conceitos",
"tipo": "pergunta",
"frente": "Qual a duração do exercício financeiro no Brasil?",
"verso": "Coincide com o ano civil: de 1º de janeiro a 31 de dezembro.",
"explicacao": "Lei 4.320/1964, art. 34."
},
{
"id": 2000005503,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Conceitos",
"tipo": "pergunta",
"frente": "O orçamento brasileiro é autorizativo ou impositivo?",
"verso": "É tradicionalmente autorizativo, mas as emendas parlamentares individuais e de bancada e a programação em geral passaram a ter execução obrigatória, com ressalvas.",
"explicacao": "CF, art. 165, §§ 10 e 11, e art. 166, §§ 9º e 12 (EC 86/2015, 100/2019 e 102/2019)."
},
{
"id": 2000005504,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Tipos de orçamento",
"tipo": "pergunta",
"frente": "O que é o orçamento-programa?",
"verso": "Orçamento que vincula os recursos a programas de governo, com objetivos, metas e indicadores de resultado.",
"explicacao": "Adotado no Brasil a partir da Lei 4.320/1964 e do Decreto-Lei 200/1967."
},
{
"id": 2000005505,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Tipos de orçamento",
"tipo": "pergunta",
"frente": "O que é o orçamento incremental?",
"verso": "Orçamento elaborado a partir do anterior, com ajustes marginais nos valores.",
"explicacao": "Prática comum, criticada por perpetuar gastos."
},
{
"id": 2000005506,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Princípios",
"tipo": "pergunta",
"frente": "O que é o princípio da universalidade?",
"verso": "A LOA deve conter todas as receitas e todas as despesas dos Poderes, fundos, órgãos e entidades.",
"explicacao": "Lei 4.320/1964, arts. 3º e 4º, e CF, art. 165, § 5º."
},
{
"id": 2000005507,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Princípios",
"tipo": "pergunta",
"frente": "O que é o princípio da unidade (totalidade)?",
"verso": "Cada ente deve ter um só orçamento para cada exercício.",
"explicacao": "Lei 4.320/1964, art. 2º. A LOA reúne os orçamentos fiscal, da seguridade e de investimento."
},
{
"id": 2000005508,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Princípios",
"tipo": "pergunta",
"frente": "O que é o princípio da anualidade (periodicidade)?",
"verso": "O orçamento vale por um período determinado, o exercício financeiro.",
"explicacao": "Lei 4.320/1964, art. 2º."
},
{
"id": 2000005509,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Princípios",
"tipo": "pergunta",
"frente": "Quais são exceções ao princípio da não vinculação de impostos (exemplos)?",
"verso": "Repartição constitucional de impostos, recursos para saúde e educação, atividades da administração tributária e prestação de garantias às operações de crédito por antecipação de receita.",
"explicacao": "CF, art. 167, IV."
},
{
"id": 2000005510,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Princípios",
"tipo": "pergunta",
"frente": "O que é o princípio da publicidade orçamentária?",
"verso": "O orçamento deve ser publicado e divulgado para conhecimento da sociedade.",
"explicacao": "CF, art. 37, e art. 165, § 3º."
},
{
"id": 2000005511,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Instrumentos de planejamento",
"tipo": "pergunta",
"frente": "Quais são os três instrumentos de planejamento orçamentário da CF?",
"verso": "Plano Plurianual (PPA), Lei de Diretrizes Orçamentárias (LDO) e Lei Orçamentária Anual (LOA).",
"explicacao": "CF, art. 165."
},
{
"id": 2000005512,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Instrumentos de planejamento",
"tipo": "pergunta",
"frente": "Quais anexos a LRF exige na LDO?",
"verso": "Anexo de Metas Fiscais e Anexo de Riscos Fiscais.",
"explicacao": "LRF, art. 4º, §§ 1º e 3º."
},
{
"id": 2000005513,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Ciclo orçamentário",
"tipo": "pergunta",
"frente": "Quais os prazos de envio do PPA, da LDO e da LOA ao Congresso, no âmbito federal?",
"verso": "PPA e LOA: até 31 de agosto (4 meses antes do fim do exercício). LDO: até 15 de abril (8 meses e meio antes).",
"explicacao": "ADCT, art. 35, § 2º."
},
{
"id": 2000005514,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Ciclo orçamentário",
"tipo": "pergunta",
"frente": "Qual comissão examina os projetos de leis orçamentárias?",
"verso": "A Comissão Mista de Planos, Orçamentos Públicos e Fiscalização (CMO).",
"explicacao": "CF, art. 166, § 1º."
},
{
"id": 2000005515,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Ciclo orçamentário",
"tipo": "pergunta",
"frente": "Quem tem a iniciativa das leis orçamentárias?",
"verso": "O chefe do Poder Executivo, privativamente.",
"explicacao": "CF, art. 84, XXIII, e art. 165."
},
{
"id": 2000005516,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Emendas",
"tipo": "pergunta",
"frente": "O que são as transferências especiais (emendas Pix)?",
"verso": "Emendas individuais repassadas diretamente ao ente beneficiado, sem convênio e sem finalidade definida, que passam a pertencer ao ente.",
"explicacao": "CF, art. 166-A, incluído pela EC 105/2019."
},
{
"id": 2000005517,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Créditos adicionais",
"tipo": "pergunta",
"frente": "O que são créditos adicionais?",
"verso": "Autorizações de despesa não computadas ou insuficientemente dotadas na Lei de Orçamento.",
"explicacao": "Lei 4.320/1964, art. 40."
},
{
"id": 2000005518,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Créditos adicionais",
"tipo": "pares",
"frente": "Qual a finalidade de cada crédito adicional?",
"verso": "Suplementar: reforçar dotação existente. Especial: despesa sem dotação específica. Extraordinário: despesas urgentes e imprevisíveis (guerra, comoção interna, calamidade).",
"explicacao": "Lei 4.320/1964, art. 41."
},
{
"id": 2000005519,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Créditos adicionais",
"tipo": "pergunta",
"frente": "O crédito suplementar precisa de lei específica?",
"verso": "Não necessariamente: a própria LOA pode autorizar a abertura até determinado limite.",
"explicacao": "CF, art. 165, § 8º (exceção ao princípio da exclusividade)."
},
{
"id": 2000005520,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Créditos adicionais",
"tipo": "pares",
"frente": "Qual a diferença entre transposição, remanejamento e transferência?",
"verso": "Remanejamento: realocação entre órgãos. Transposição: entre programas do mesmo órgão. Transferência: entre categorias econômicas do mesmo programa e órgão. Todas exigem lei.",
"explicacao": "CF, art. 167, VI."
},
{
"id": 2000005521,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Receita",
"tipo": "pergunta",
"frente": "Quais são as categorias econômicas da receita orçamentária?",
"verso": "Receitas correntes e receitas de capital.",
"explicacao": "Lei 4.320/1964, art. 11."
},
{
"id": 2000005522,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Receita",
"tipo": "pergunta",
"frente": "O que é o lançamento da receita?",
"verso": "Ato que verifica a procedência do crédito fiscal, a pessoa devedora e inscreve o débito.",
"explicacao": "Lei 4.320/1964, art. 53."
},
{
"id": 2000005523,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Receita",
"tipo": "pergunta",
"frente": "Qual o regime contábil da receita orçamentária na Lei 4.320/1964?",
"verso": "Pertencem ao exercício as receitas nele arrecadadas (regime de caixa).",
"explicacao": "Lei 4.320/1964, art. 35, I. Na contabilidade patrimonial, adota-se a competência."
},
{
"id": 2000005524,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Receita",
"tipo": "pergunta",
"frente": "O que é receita extraorçamentária?",
"verso": "Entrada que não pertence ao ente e será devolvida, como cauções, depósitos, consignações e ARO.",
"explicacao": "Não integra a LOA."
},
{
"id": 2000005525,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Receita",
"tipo": "pergunta",
"frente": "A receita da dívida ativa é corrente ou de capital?",
"verso": "Segue a natureza do crédito original: dívida ativa tributária é receita corrente.",
"explicacao": "Classificação da receita pela origem."
},
{
"id": 2000005526,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Receita",
"tipo": "pergunta",
"frente": "O que é a renúncia de receita na LRF?",
"verso": "Anistia, remissão, subsídio, crédito presumido, isenção não geral, alteração de alíquota ou base de cálculo que reduza tributos e outros benefícios.",
"explicacao": "LRF, art. 14, § 1º."
},
{
"id": 2000005527,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Receita",
"tipo": "pergunta",
"frente": "Quais as condições para conceder renúncia de receita na LRF?",
"verso": "Estimativa do impacto orçamentário-financeiro em 3 exercícios, atendimento à LDO e demonstração de que não afetará as metas ou adoção de medidas de compensação.",
"explicacao": "LRF, art. 14."
},
{
"id": 2000005528,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Despesa",
"tipo": "pares",
"frente": "Qual a diferença entre investimentos e inversões financeiras?",
"verso": "Investimentos: obras, equipamentos e material permanente que aumentam o patrimônio. Inversões: aquisição de imóveis ou bens já em uso, ou participação em capital de empresas, sem aumentar o PIB.",
"explicacao": "Lei 4.320/1964, art. 12, §§ 4º e 5º."
},
{
"id": 2000005529,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Despesa",
"tipo": "pergunta",
"frente": "Quais são os tipos de empenho?",
"verso": "Ordinário (valor exato, pagamento único), estimativo (valor não conhecido, como água e luz) e global (valor certo, pago em parcelas, como contratos).",
"explicacao": "Lei 4.320/1964, art. 60."
},
{
"id": 2000005530,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Despesa",
"tipo": "pergunta",
"frente": "O que é a ordem de pagamento?",
"verso": "Despacho da autoridade competente determinando que a despesa liquidada seja paga.",
"explicacao": "Lei 4.320/1964, art. 64."
},
{
"id": 2000005531,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Despesa",
"tipo": "pergunta",
"frente": "Qual o regime contábil da despesa orçamentária na Lei 4.320/1964?",
"verso": "Pertencem ao exercício as despesas nele legalmente empenhadas (regime de competência).",
"explicacao": "Lei 4.320/1964, art. 35, II. Por isso se fala em regime misto."
},
{
"id": 2000005532,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Despesa",
"tipo": "pergunta",
"frente": "O que é a classificação funcional da despesa?",
"verso": "Classificação por função e subfunção, que indica em que área de atuação o governo gasta.",
"explicacao": "Portaria MOG 42/1999. Ex.: função saúde, subfunção atenção básica."
},
{
"id": 2000005533,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Despesa",
"tipo": "pergunta",
"frente": "O que é a classificação programática da despesa?",
"verso": "Organização da despesa em programas e ações (projetos, atividades e operações especiais).",
"explicacao": "Indica para que se gasta."
},
{
"id": 2000005534,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Despesa",
"tipo": "pares",
"frente": "Qual a diferença entre projeto, atividade e operação especial?",
"verso": "Projeto: ações limitadas no tempo que expandem ou aperfeiçoam a ação do governo. Atividade: ações contínuas para manter a ação do governo. Operação especial: despesas que não geram produto, como dívida e transferências.",
"explicacao": "Classificação das ações orçamentárias."
},
{
"id": 2000005535,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Restos a pagar",
"tipo": "pergunta",
"frente": "Qual a vedação da LRF sobre despesas nos dois últimos quadrimestres do mandato?",
"verso": "O titular do Poder não pode contrair obrigação que não possa ser cumprida integralmente no mandato, ou que tenha parcelas no exercício seguinte sem disponibilidade de caixa.",
"explicacao": "LRF, art. 42."
},
{
"id": 2000005536,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Execução",
"tipo": "pergunta",
"frente": "Quando ocorre a limitação de empenho (contingenciamento)?",
"verso": "Quando, ao fim de um bimestre, a receita pode não comportar o cumprimento das metas de resultado primário ou nominal.",
"explicacao": "LRF, art. 9º."
},
{
"id": 2000005537,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Execução",
"tipo": "pares",
"frente": "Qual a diferença entre descentralização de créditos e de recursos financeiros?",
"verso": "Créditos: transferência da autorização orçamentária (destaque entre órgãos, provisão dentro do órgão). Recursos financeiros: movimentação de dinheiro (cota, repasse e sub-repasse).",
"explicacao": "Execução orçamentária e financeira."
},
{
"id": 2000005538,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Execução",
"tipo": "pares",
"frente": "Qual a diferença entre destaque e provisão?",
"verso": "Destaque: descentralização de créditos entre órgãos diferentes (externa). Provisão: entre unidades do mesmo órgão (interna).",
"explicacao": "Descentralização de créditos."
},
{
"id": 2000005539,
"trilha": "administrativa",
"materia": "afo",
"assunto": "LRF",
"tipo": "pergunta",
"frente": "Como se divide o limite de pessoal dos municípios?",
"verso": "Legislativo (com TCM, se houver): 6%. Executivo: 54%.",
"explicacao": "LRF, art. 20, III."
},
{
"id": 2000005540,
"trilha": "administrativa",
"materia": "afo",
"assunto": "LRF",
"tipo": "pergunta",
"frente": "Como se divide o limite de pessoal da União entre os Poderes?",
"verso": "Legislativo (com TCU): 2,5%. Judiciário: 6%. Executivo: 40,9%. MPU: 0,6%.",
"explicacao": "LRF, art. 20, I."
},
{
"id": 2000005541,
"trilha": "administrativa",
"materia": "afo",
"assunto": "LRF",
"tipo": "pergunta",
"frente": "O que é o limite de alerta da despesa com pessoal?",
"verso": "90% do limite máximo. O Tribunal de Contas alerta o Poder.",
"explicacao": "LRF, art. 59, § 1º, II."
},
{
"id": 2000005542,
"trilha": "administrativa",
"materia": "afo",
"assunto": "LRF",
"tipo": "pergunta",
"frente": "O que é o limite prudencial e o que ele proíbe?",
"verso": "95% do limite máximo. Proíbe concessão de vantagens e reajustes (salvo revisão geral), criação de cargos, alteração de estrutura de carreira, provimento de cargos (salvo reposição em educação, saúde e segurança) e hora extra.",
"explicacao": "LRF, art. 22, parágrafo único."
},
{
"id": 2000005543,
"trilha": "administrativa",
"materia": "afo",
"assunto": "LRF",
"tipo": "pergunta",
"frente": "Qual a periodicidade de verificação dos limites de despesa com pessoal?",
"verso": "Ao final de cada quadrimestre.",
"explicacao": "LRF, art. 22."
},
{
"id": 2000005544,
"trilha": "administrativa",
"materia": "afo",
"assunto": "LRF",
"tipo": "pergunta",
"frente": "O que é nulo de pleno direito nos 180 dias anteriores ao fim do mandato?",
"verso": "O ato que resulte em aumento da despesa com pessoal.",
"explicacao": "LRF, art. 21, II, com redação da LC 173/2020."
},
{
"id": 2000005545,
"trilha": "administrativa",
"materia": "afo",
"assunto": "LRF",
"tipo": "pergunta",
"frente": "O que se exige para criar despesa obrigatória de caráter continuado?",
"verso": "Estimativa do impacto orçamentário-financeiro e demonstração da origem dos recursos, com compensação por aumento permanente de receita ou redução permanente de despesa.",
"explicacao": "LRF, art. 17, §§ 1º e 2º."
},
{
"id": 2000005546,
"trilha": "administrativa",
"materia": "afo",
"assunto": "LRF",
"tipo": "pergunta",
"frente": "Quem fiscaliza o cumprimento da LRF?",
"verso": "O Poder Legislativo, diretamente ou com o auxílio do Tribunal de Contas, e o sistema de controle interno de cada Poder e do MP.",
"explicacao": "LRF, art. 59."
},
{
"id": 2000005547,
"trilha": "administrativa",
"materia": "afo",
"assunto": "LRF",
"tipo": "pergunta",
"frente": "Quais as sanções institucionais ao ente que não institui e arrecada todos os seus impostos?",
"verso": "Fica proibido de receber transferências voluntárias.",
"explicacao": "LRF, art. 11, parágrafo único."
},
{
"id": 2000005548,
"trilha": "administrativa",
"materia": "afo",
"assunto": "LRF",
"tipo": "pergunta",
"frente": "Quais as exigências da LRF para receber transferência voluntária (exemplos)?",
"verso": "Dotação específica, comprovação de que está em dia com tributos e empréstimos, cumprimento dos limites de pessoal e dívida e aplicação dos mínimos em saúde e educação.",
"explicacao": "LRF, art. 25, § 1º."
},
{
"id": 2000005549,
"trilha": "administrativa",
"materia": "afo",
"assunto": "LRF",
"tipo": "pergunta",
"frente": "É permitido usar transferência voluntária para pagar pessoal?",
"verso": "Não. É vedada a utilização para pagamento de despesas com pessoal ativo, inativo e pensionista.",
"explicacao": "CF, art. 167, X, e LRF, art. 25, § 1º, III."
},
{
"id": 2000005550,
"trilha": "administrativa",
"materia": "afo",
"assunto": "LRF",
"tipo": "pergunta",
"frente": "Quando é proibida a ARO?",
"verso": "Enquanto existir operação anterior não resgatada e no último ano de mandato do chefe do Executivo.",
"explicacao": "LRF, art. 38, IV."
},
{
"id": 2000005551,
"trilha": "administrativa",
"materia": "afo",
"assunto": "LRF",
"tipo": "pares",
"frente": "Qual a diferença entre resultado primário e resultado nominal?",
"verso": "Primário: receitas menos despesas, excluídos juros e encargos da dívida. Nominal: inclui os juros, mostrando a variação da dívida.",
"explicacao": "Metas fixadas no Anexo de Metas Fiscais da LDO."
},
{
"id": 2000005552,
"trilha": "administrativa",
"materia": "afo",
"assunto": "LRF",
"tipo": "pergunta",
"frente": "O que é a dívida pública mobiliária?",
"verso": "Dívida representada por títulos emitidos pela União, inclusive os do Banco Central, estados e municípios.",
"explicacao": "LRF, art. 29, II."
},
{
"id": 2000005553,
"trilha": "administrativa",
"materia": "afo",
"assunto": "LRF",
"tipo": "pergunta",
"frente": "Qual a vedação da LRF ao Banco Central em relação a operações de crédito?",
"verso": "É vedado ao Banco Central emitir títulos da dívida pública e conceder empréstimos ao Tesouro, salvo exceções.",
"explicacao": "LRF, arts. 34 e 35, e CF, art. 164, § 1º."
},
{
"id": 2000005554,
"trilha": "administrativa",
"materia": "afo",
"assunto": "LRF",
"tipo": "pergunta",
"frente": "Em que prazo devem ser disponibilizadas em tempo real informações sobre a execução orçamentária?",
"verso": "Até o primeiro dia útil subsequente à data do registro contábil, em meio eletrônico de acesso público.",
"explicacao": "LRF, art. 48, § 1º, II, e art. 48-A."
},
{
"id": 2000005555,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Orçamento na CF",
"tipo": "pergunta",
"frente": "O que é vedado pelo art. 167 da CF (exemplos)?",
"verso": "Início de programas não incluídos na LOA, despesas que excedam créditos, operações de crédito acima das despesas de capital, vinculação de impostos, abertura de crédito sem autorização e créditos ilimitados.",
"explicacao": "CF, art. 167."
},
{
"id": 2000005556,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Orçamento na CF",
"tipo": "pergunta",
"frente": "Pode haver investimento com duração superior a um exercício sem previsão no PPA?",
"verso": "Não, sob pena de crime de responsabilidade.",
"explicacao": "CF, art. 167, § 1º."
},
{
"id": 2000005557,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Orçamento na CF",
"tipo": "pergunta",
"frente": "Qual o mínimo que a União deve aplicar em educação?",
"verso": "18% da receita resultante de impostos. Estados, DF e municípios: 25%.",
"explicacao": "CF, art. 212."
},
{
"id": 2000005558,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Orçamento na CF",
"tipo": "pergunta",
"frente": "Qual o mínimo que a União deve aplicar em ações e serviços de saúde?",
"verso": "15% da receita corrente líquida. Estados: 12% e municípios: 15% da receita de impostos e transferências.",
"explicacao": "CF, art. 198, § 2º, e LC 141/2012."
},
{
"id": 2000005559,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Controle",
"tipo": "pergunta",
"frente": "Quais as finalidades do controle interno?",
"verso": "Avaliar o cumprimento das metas do PPA e a execução dos orçamentos, comprovar a legalidade e avaliar os resultados, controlar operações de crédito e apoiar o controle externo.",
"explicacao": "CF, art. 74."
},
{
"id": 2000005560,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Controle",
"tipo": "pergunta",
"frente": "O que acontece se o responsável pelo controle interno souber de irregularidade e não comunicar ao TCU?",
"verso": "Responde solidariamente.",
"explicacao": "CF, art. 74, § 1º."
},
{
"id": 2000005561,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Controle",
"tipo": "pergunta",
"frente": "As decisões do Tribunal de Contas que imputam débito ou multa têm qual eficácia?",
"verso": "Eficácia de título executivo.",
"explicacao": "CF, art. 71, § 3º."
},
{
"id": 2000005562,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Fundos",
"tipo": "pergunta",
"frente": "É permitido criar fundos sem autorização legislativa?",
"verso": "Não. É vedada a instituição de fundos de qualquer natureza sem prévia autorização legislativa.",
"explicacao": "CF, art. 167, IX."
},
{
"id": 2000005563,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Contabilidade pública",
"tipo": "pergunta",
"frente": "Quais os balanços exigidos pela Lei 4.320/1964?",
"verso": "Balanço orçamentário, balanço financeiro, balanço patrimonial e demonstração das variações patrimoniais.",
"explicacao": "Lei 4.320/1964, art. 101."
},
{
"id": 2000005564,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Contabilidade pública",
"tipo": "pergunta",
"frente": "O que é o superávit financeiro apurado no balanço patrimonial?",
"verso": "Diferença positiva entre o ativo financeiro e o passivo financeiro, conjugando os créditos adicionais transferidos e as operações de crédito vinculadas.",
"explicacao": "Lei 4.320/1964, art. 43, § 2º."
},
{
"id": 2000005565,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Contabilidade pública",
"tipo": "pergunta",
"frente": "O que é o excesso de arrecadação?",
"verso": "Saldo positivo das diferenças, acumuladas mês a mês, entre a arrecadação prevista e a realizada, considerando a tendência do exercício.",
"explicacao": "Lei 4.320/1964, art. 43, § 3º."
},
{
"id": 2000005566,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Contabilidade pública",
"tipo": "pergunta",
"frente": "O que é o SIAFI?",
"verso": "Sistema Integrado de Administração Financeira do Governo Federal, que registra a execução orçamentária, financeira e patrimonial.",
"explicacao": "Implantado em 1987."
},
{
"id": 2000005567,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Princípios",
"tipo": "certo_errado",
"frente": "Certo ou errado? O princípio da exclusividade impede que a LOA autorize operações de crédito por antecipação de receita.",
"verso": "Errado. A autorização para operações de crédito, inclusive por ARO, é exceção expressa ao princípio.",
"explicacao": "CF, art. 165, § 8º."
},
{
"id": 2000005568,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Despesa",
"tipo": "certo_errado",
"frente": "Certo ou errado? Pode haver pagamento de despesa sem a liquidação.",
"verso": "Errado. O pagamento só ocorre após a regular liquidação.",
"explicacao": "Lei 4.320/1964, art. 62."
},
{
"id": 2000005569,
"trilha": "administrativa",
"materia": "afo",
"assunto": "LRF",
"tipo": "certo_errado",
"frente": "Certo ou errado? A LRF se aplica a empresas estatais dependentes.",
"verso": "Certo.",
"explicacao": "LRF, art. 1º, § 3º, I, 'b', e art. 2º, III."
},
{
"id": 2000005570,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Instrumentos de planejamento",
"tipo": "lacuna",
"frente": "\"A lei de diretrizes orçamentárias compreenderá as ____ e prioridades da administração pública federal.\"",
"verso": "metas",
"explicacao": "CF, art. 165, § 2º."
},
{
"id": 2000005571,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Restos a pagar",
"tipo": "lacuna",
"frente": "\"Consideram-se restos a pagar as despesas ____ mas não pagas até o dia 31 de dezembro.\"",
"verso": "empenhadas",
"explicacao": "Lei 4.320/1964, art. 36."
},
{
"id": 2000005572,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Teorias administrativas",
"tipo": "pergunta",
"frente": "Qual o foco da Teoria Neoclássica?",
"verso": "Retomada dos princípios clássicos com foco na prática, nos objetivos e nos resultados.",
"explicacao": "Autores como Peter Drucker. Base da APO."
},
{
"id": 2000005573,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Teorias administrativas",
"tipo": "pergunta",
"frente": "Qual o foco da Teoria Comportamental?",
"verso": "O comportamento das pessoas nas organizações, a motivação e o processo decisório.",
"explicacao": "Autores como Herbert Simon, Maslow, Herzberg e McGregor."
},
{
"id": 2000005574,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Teorias administrativas",
"tipo": "pergunta",
"frente": "O que é a racionalidade limitada de Herbert Simon?",
"verso": "As pessoas decidem com informação e capacidade limitadas, buscando soluções satisfatórias, não ótimas.",
"explicacao": "Teoria das decisões."
},
{
"id": 2000005575,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Teorias administrativas",
"tipo": "pergunta",
"frente": "O que é o Desenvolvimento Organizacional (DO)?",
"verso": "Abordagem de mudança planejada da cultura e da estrutura da organização, com base nas ciências do comportamento.",
"explicacao": "Surgiu nos anos 1960."
},
{
"id": 2000005576,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Teorias administrativas",
"tipo": "pergunta",
"frente": "O que é o fordismo?",
"verso": "Modelo de produção em massa com linha de montagem, padronização e especialização do trabalho.",
"explicacao": "Henry Ford, início do século XX."
},
{
"id": 2000005577,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Teorias administrativas",
"tipo": "pergunta",
"frente": "O que é o toyotismo?",
"verso": "Modelo de produção enxuta, com just in time, kanban, trabalhador polivalente e controle de qualidade total.",
"explicacao": "Alternativa flexível ao fordismo."
},
{
"id": 2000005578,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Teorias administrativas",
"tipo": "pergunta",
"frente": "O que é homeostase na Teoria dos Sistemas?",
"verso": "Tendência do sistema a manter o equilíbrio interno diante de mudanças no ambiente.",
"explicacao": "Conceito sistêmico."
},
{
"id": 2000005579,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Teorias administrativas",
"tipo": "pergunta",
"frente": "O que é entropia na Teoria dos Sistemas?",
"verso": "Tendência do sistema à desorganização e à deterioração.",
"explicacao": "Sistemas abertos combatem a entropia importando energia do ambiente (entropia negativa)."
},
{
"id": 2000005580,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Teorias administrativas",
"tipo": "pergunta",
"frente": "O que é sinergia?",
"verso": "Quando o todo produz mais que a soma das partes.",
"explicacao": "Conceito sistêmico: 2 + 2 = 5."
},
{
"id": 2000005581,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Teorias administrativas",
"tipo": "pergunta",
"frente": "O que é equifinalidade?",
"verso": "Um sistema pode alcançar o mesmo resultado partindo de condições iniciais diferentes e por caminhos diferentes.",
"explicacao": "Conceito de sistemas abertos."
},
{
"id": 2000005582,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Planejamento",
"tipo": "pergunta",
"frente": "O que é a matriz BCG?",
"verso": "Ferramenta que classifica produtos ou unidades em estrela, vaca leiteira, ponto de interrogação e abacaxi, conforme crescimento e participação no mercado.",
"explicacao": "Boston Consulting Group."
},
{
"id": 2000005583,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Planejamento",
"tipo": "pergunta",
"frente": "Quais as estratégias genéricas de Porter?",
"verso": "Liderança em custo, diferenciação e enfoque.",
"explicacao": "Estratégias competitivas."
},
{
"id": 2000005584,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Planejamento",
"tipo": "pergunta",
"frente": "O que é o cenário prospectivo?",
"verso": "Técnica de planejamento que constrói visões alternativas do futuro para orientar decisões.",
"explicacao": "Usada em planejamento estratégico."
},
{
"id": 2000005585,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Planejamento",
"tipo": "pares",
"frente": "Qual a diferença entre objetivo e meta?",
"verso": "Objetivo: resultado desejado, mais amplo e qualitativo. Meta: desdobramento quantificado e com prazo do objetivo.",
"explicacao": "Conceitos de planejamento."
},
{
"id": 2000005586,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Planejamento",
"tipo": "pergunta",
"frente": "O que é indicador de desempenho?",
"verso": "Medida quantitativa ou qualitativa que permite acompanhar o alcance de metas e resultados.",
"explicacao": "Ex.: tempo médio de atendimento."
},
{
"id": 2000005587,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Planejamento",
"tipo": "pares",
"frente": "Qual a diferença entre indicadores de eficiência, eficácia e efetividade?",
"verso": "Eficiência: relação entre recursos e produtos. Eficácia: alcance das metas. Efetividade: impacto na sociedade.",
"explicacao": "Classificação de indicadores."
},
{
"id": 2000005588,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Projetos",
"tipo": "pergunta",
"frente": "O que é projeto segundo o PMBOK?",
"verso": "Esforço temporário empreendido para criar um produto, serviço ou resultado único.",
"explicacao": "Diferente de operação, que é contínua."
},
{
"id": 2000005589,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Projetos",
"tipo": "pergunta",
"frente": "Quais as fases do ciclo de vida de um projeto?",
"verso": "Início, organização e preparação, execução do trabalho e encerramento.",
"explicacao": "Grupos de processos: iniciação, planejamento, execução, monitoramento e controle, e encerramento."
},
{
"id": 2000005590,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Projetos",
"tipo": "pergunta",
"frente": "O que é a restrição tripla em projetos?",
"verso": "Equilíbrio entre escopo, tempo e custo, que afeta a qualidade.",
"explicacao": "Mudança em um afeta os demais."
},
{
"id": 2000005591,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Projetos",
"tipo": "pergunta",
"frente": "O que é a EAP (estrutura analítica do projeto)?",
"verso": "Decomposição hierárquica do escopo total do projeto em pacotes de trabalho menores.",
"explicacao": "Work Breakdown Structure (WBS)."
},
{
"id": 2000005592,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Projetos",
"tipo": "pergunta",
"frente": "O que é o caminho crítico de um projeto?",
"verso": "Sequência de atividades que determina a duração mínima do projeto; atraso em qualquer uma atrasa o projeto.",
"explicacao": "Atividades sem folga."
},
{
"id": 2000005593,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Projetos",
"tipo": "pergunta",
"frente": "O que é o gráfico de Gantt?",
"verso": "Gráfico de barras que mostra as atividades de um projeto ao longo do tempo.",
"explicacao": "Ferramenta de cronograma."
},
{
"id": 2000005594,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Projetos",
"tipo": "pergunta",
"frente": "O que é o escritório de projetos (PMO)?",
"verso": "Estrutura que padroniza processos de gestão de projetos e facilita o compartilhamento de recursos e metodologias.",
"explicacao": "Project Management Office."
},
{
"id": 2000005595,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Projetos",
"tipo": "pergunta",
"frente": "O que são metodologias ágeis?",
"verso": "Abordagens de gestão de projetos com entregas incrementais, ciclos curtos, colaboração com o cliente e adaptação a mudanças.",
"explicacao": "Ex.: Scrum e Kanban."
},
{
"id": 2000005596,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Projetos",
"tipo": "pergunta",
"frente": "O que é a sprint no Scrum?",
"verso": "Ciclo de trabalho de duração fixa, de até 1 mês, em que se entrega um incremento do produto.",
"explicacao": "Eventos: planejamento, reunião diária, revisão e retrospectiva."
},
{
"id": 2000005597,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Projetos",
"tipo": "pergunta",
"frente": "Quais os papéis do Scrum?",
"verso": "Product Owner, Scrum Master e Desenvolvedores.",
"explicacao": "Scrum Guide 2020."
},
{
"id": 2000005598,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Conflitos",
"tipo": "pergunta",
"frente": "O conflito é sempre prejudicial à organização?",
"verso": "Não. Na visão interacionista, um nível moderado de conflito pode estimular a criatividade e a inovação.",
"explicacao": "Conflitos funcionais x disfuncionais."
},
{
"id": 2000005599,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Negociação",
"tipo": "pergunta",
"frente": "O que é a negociação ganha-ganha (integrativa)?",
"verso": "Negociação em que as partes buscam soluções que atendam aos interesses de ambas.",
"explicacao": "Oposta à distributiva (ganha-perde)."
},
{
"id": 2000005600,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Negociação",
"tipo": "pergunta",
"frente": "O que é a BATNA (MAANA)?",
"verso": "A melhor alternativa à negociação de um acordo: o que a parte fará se não houver acordo.",
"explicacao": "Conceito do método de Harvard."
},
{
"id": 2000005601,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Atendimento",
"tipo": "pergunta",
"frente": "O que é o Código de Defesa do Usuário do Serviço Público?",
"verso": "Lei que estabelece direitos e deveres dos usuários de serviços públicos, ouvidorias e a Carta de Serviços ao Usuário.",
"explicacao": "Lei 13.460/2017."
},
{
"id": 2000005602,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Gestão de pessoas",
"tipo": "pergunta",
"frente": "O que é a avaliação de desempenho por incidentes críticos?",
"verso": "Método que registra comportamentos extremamente positivos ou negativos do avaliado.",
"explicacao": "Método de avaliação."
},
{
"id": 2000005603,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Gestão de pessoas",
"tipo": "pergunta",
"frente": "O que é a escala gráfica na avaliação de desempenho?",
"verso": "Método que avalia fatores de desempenho em uma escala de graus, do ótimo ao insuficiente.",
"explicacao": "Método mais usado, mas sujeito a efeito halo."
},
{
"id": 2000005604,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Gestão de pessoas",
"tipo": "pergunta",
"frente": "O que é a avaliação por escolha forçada?",
"verso": "Método em que o avaliador escolhe, entre blocos de frases, a que melhor e a que pior descreve o avaliado.",
"explicacao": "Reduz a subjetividade."
},
{
"id": 2000005605,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Gestão de pessoas",
"tipo": "pergunta",
"frente": "Quais as etapas do processo de treinamento?",
"verso": "Diagnóstico (levantamento de necessidades), desenho (programação), implementação (execução) e avaliação.",
"explicacao": "Ciclo do treinamento."
},
{
"id": 2000005606,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Gestão de pessoas",
"tipo": "pergunta",
"frente": "Quais os níveis de avaliação de treinamento de Kirkpatrick?",
"verso": "Reação, aprendizagem, comportamento e resultados.",
"explicacao": "Modelo de 4 níveis."
},
{
"id": 2000005607,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Gestão de pessoas",
"tipo": "pergunta",
"frente": "O que é rotatividade (turnover)?",
"verso": "Fluxo de entradas e saídas de pessoas na organização em determinado período.",
"explicacao": "Índice alto pode indicar problemas de clima ou remuneração."
},
{
"id": 2000005608,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Gestão de pessoas",
"tipo": "pergunta",
"frente": "O que é absenteísmo?",
"verso": "Frequência ou duração das ausências e atrasos dos trabalhadores.",
"explicacao": "Indicador de gestão de pessoas."
},
{
"id": 2000005609,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Gestão de pessoas",
"tipo": "pergunta",
"frente": "O que é a análise e descrição de cargos?",
"verso": "Descrição: o que o ocupante faz (tarefas). Análise: requisitos para ocupar o cargo (conhecimentos, habilidades, responsabilidades).",
"explicacao": "Base para recrutamento e remuneração."
},
{
"id": 2000005610,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Comportamento organizacional",
"tipo": "pergunta",
"frente": "O que é empowerment?",
"verso": "Delegação de poder e autonomia às pessoas para tomarem decisões e assumirem responsabilidades.",
"explicacao": "Empoderamento dos colaboradores."
},
{
"id": 2000005611,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Comportamento organizacional",
"tipo": "pergunta",
"frente": "O que é o groupthink (pensamento de grupo)?",
"verso": "Tendência de um grupo coeso a buscar consenso a qualquer custo, suprimindo opiniões divergentes.",
"explicacao": "Prejudica a qualidade das decisões."
},
{
"id": 2000005612,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Comportamento organizacional",
"tipo": "pergunta",
"frente": "O que é cultura organizacional segundo Schein?",
"verso": "Conjunto de pressupostos básicos compartilhados, em 3 níveis: artefatos, valores declarados e pressupostos básicos.",
"explicacao": "Edgar Schein."
},
{
"id": 2000005613,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Comportamento organizacional",
"tipo": "pergunta",
"frente": "O que é poder de referência?",
"verso": "Poder baseado na admiração e identificação que as pessoas têm com o líder.",
"explicacao": "French e Raven: legítimo, coercitivo, de recompensa, de competência e de referência."
},
{
"id": 2000005614,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Comportamento organizacional",
"tipo": "pares",
"frente": "Qual a diferença entre poder e autoridade?",
"verso": "Poder: capacidade de influenciar pessoas. Autoridade: poder legítimo, decorrente do cargo.",
"explicacao": "Conceitos de liderança."
},
{
"id": 2000005615,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Gestão da informação",
"tipo": "pergunta",
"frente": "O que é gestão do conhecimento?",
"verso": "Processo de criar, capturar, compartilhar e usar o conhecimento na organização.",
"explicacao": "Nonaka e Takeuchi: espiral do conhecimento."
},
{
"id": 2000005616,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Gestão da informação",
"tipo": "pares",
"frente": "Qual a diferença entre conhecimento tácito e explícito?",
"verso": "Tácito: pessoal, difícil de formalizar (experiência). Explícito: formalizado e transmitido em documentos e manuais.",
"explicacao": "Nonaka e Takeuchi."
},
{
"id": 2000005617,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Gestão da informação",
"tipo": "pergunta",
"frente": "Quais as 4 conversões do conhecimento no modelo SECI?",
"verso": "Socialização, externalização, combinação e internalização.",
"explicacao": "Nonaka e Takeuchi."
},
{
"id": 2000005618,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Riscos",
"tipo": "pergunta",
"frente": "O que é gestão de riscos?",
"verso": "Processo de identificar, analisar, avaliar, tratar e monitorar eventos que possam afetar os objetivos da organização.",
"explicacao": "ISO 31000 e COSO."
},
{
"id": 2000005619,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Riscos",
"tipo": "pergunta",
"frente": "Quais as respostas possíveis a um risco?",
"verso": "Evitar, reduzir (mitigar), compartilhar (transferir) e aceitar.",
"explicacao": "Tratamento de riscos."
},
{
"id": 2000005620,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Riscos",
"tipo": "pergunta",
"frente": "O que é compliance?",
"verso": "Conjunto de mecanismos para assegurar o cumprimento de leis, normas e padrões éticos na organização.",
"explicacao": "No setor público, programas de integridade."
},
{
"id": 2000005621,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Inovação",
"tipo": "pergunta",
"frente": "O que é inovação incremental e radical?",
"verso": "Incremental: melhorias graduais em produtos ou processos existentes. Radical: cria algo totalmente novo, mudando o mercado.",
"explicacao": "Tipos de inovação."
},
{
"id": 2000005622,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Inovação",
"tipo": "pergunta",
"frente": "O que é design thinking?",
"verso": "Abordagem de solução de problemas centrada nas pessoas, com etapas como empatia, definição, ideação, prototipação e teste.",
"explicacao": "Usada também em laboratórios de inovação pública."
},
{
"id": 2000005623,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Administração pública",
"tipo": "pergunta",
"frente": "O que é o modelo de administração pública societal?",
"verso": "Modelo que enfatiza a participação social na formulação e no controle das políticas públicas, como conselhos e orçamento participativo.",
"explicacao": "Paes de Paula."
},
{
"id": 2000005624,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Administração pública",
"tipo": "pergunta",
"frente": "O que é o Novo Serviço Público (Denhardt)?",
"verso": "Modelo que vê o cidadão como cidadão, não cliente, e destaca o interesse público, a democracia e o servir.",
"explicacao": "Crítica à Nova Gestão Pública."
},
{
"id": 2000005625,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Administração pública",
"tipo": "pergunta",
"frente": "O que é a Lei do Governo Digital?",
"verso": "Lei que trata de princípios, regras e instrumentos para o aumento da eficiência pública por meio da desburocratização, inovação e transformação digital.",
"explicacao": "Lei 14.129/2021."
},
{
"id": 2000005626,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Administração pública",
"tipo": "pergunta",
"frente": "O que proíbe a Lei 13.726/2018 (Lei da Desburocratização)?",
"verso": "Exigir do cidadão reconhecimento de firma, autenticação de cópia e documentos que o próprio poder público já tem, entre outros.",
"explicacao": "Racionaliza atos e procedimentos."
},
{
"id": 2000005627,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Políticas públicas",
"tipo": "pergunta",
"frente": "Quais as fases do ciclo de políticas públicas?",
"verso": "Identificação do problema, formação da agenda, formulação de alternativas, tomada de decisão, implementação e avaliação.",
"explicacao": "Modelo de Secchi."
},
{
"id": 2000005628,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Políticas públicas",
"tipo": "pares",
"frente": "Qual a diferença entre implementação top-down e bottom-up?",
"verso": "Top-down: de cima para baixo, decidida no topo e executada pela base. Bottom-up: valoriza a discricionariedade dos implementadores na ponta.",
"explicacao": "Modelos de implementação."
},
{
"id": 2000005629,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Conceitos",
"tipo": "pergunta",
"frente": "O que é o fundo de arquivo?",
"verso": "Conjunto de documentos de uma mesma proveniência.",
"explicacao": "Termo equivalente a arquivo."
},
{
"id": 2000005630,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Conceitos",
"tipo": "pergunta",
"frente": "O que é a coleção, em arquivologia?",
"verso": "Conjunto de documentos com características comuns, reunidos intencionalmente, sem respeitar a proveniência.",
"explicacao": "Oposto ao fundo, que é orgânico."
},
{
"id": 2000005631,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Conceitos",
"tipo": "pergunta",
"frente": "O que é a série documental?",
"verso": "Subdivisão do fundo que reúne documentos de uma mesma função, atividade ou espécie.",
"explicacao": "Unidade do quadro de arranjo."
},
{
"id": 2000005632,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Conceitos",
"tipo": "pergunta",
"frente": "O que é o dossiê?",
"verso": "Unidade documental em que se reúnem documentos de natureza diversa sobre um mesmo assunto, pessoa ou ação.",
"explicacao": "Ex.: dossiê funcional do servidor."
},
{
"id": 2000005633,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Tipologia",
"tipo": "pares",
"frente": "Qual a diferença entre gênero e espécie documental?",
"verso": "Gênero: configuração conforme o suporte e a forma de registro (textual, iconográfico, cartográfico). Espécie: forma do documento conforme a informação (ofício, relatório).",
"explicacao": "Classificação documental."
},
{
"id": 2000005634,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Tipologia",
"tipo": "pergunta",
"frente": "O que é a diplomática?",
"verso": "Disciplina que estuda a estrutura formal dos documentos para verificar sua autenticidade.",
"explicacao": "Base da tipologia documental."
},
{
"id": 2000005635,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Conceitos",
"tipo": "pares",
"frente": "Qual a diferença entre documento original, cópia e minuta?",
"verso": "Original: primeiro documento completo e efetivo. Cópia: reprodução do original. Minuta: versão preliminar para revisão.",
"explicacao": "Estágios de preparação."
},
{
"id": 2000005636,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Conceitos",
"tipo": "pergunta",
"frente": "O que é o documento de arquivo ostensivo em contraste com o sigiloso?",
"verso": "Ostensivo: livre acesso. Sigiloso: acesso restrito por conter informações que exigem proteção.",
"explicacao": "Classificação quanto à natureza do assunto."
},
{
"id": 2000005637,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Conceitos",
"tipo": "pergunta",
"frente": "O que são documentos de atividade-meio e atividade-fim?",
"verso": "Meio: produzidos nas funções administrativas de apoio (pessoal, material). Fim: produzidos nas funções específicas da instituição.",
"explicacao": "O Conarq tem códigos de classificação para ambos."
},
{
"id": 2000005638,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Gestão documental",
"tipo": "pergunta",
"frente": "O que é a transferência de documentos?",
"verso": "Passagem de documentos do arquivo corrente para o intermediário.",
"explicacao": "Diferente do recolhimento (para o permanente)."
},
{
"id": 2000005639,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Gestão documental",
"tipo": "pergunta",
"frente": "O que é o arquivo setorial e o arquivo central?",
"verso": "Setorial: arquivo corrente junto ao setor que produz os documentos. Central: reúne documentos de vários setores sob uma coordenação.",
"explicacao": "Sistemas de arquivo."
},
{
"id": 2000005640,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Gestão documental",
"tipo": "pares",
"frente": "Qual a diferença entre sistema de arquivo centralizado e descentralizado?",
"verso": "Centralizado: todos os documentos ficam em um só local. Descentralizado: os documentos ficam junto aos setores, com controle técnico central.",
"explicacao": "Organização de arquivos correntes."
},
{
"id": 2000005641,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Gestão documental",
"tipo": "pergunta",
"frente": "O que é o empréstimo em arquivo?",
"verso": "Saída temporária de documento do arquivo para consulta, com registro e prazo de devolução.",
"explicacao": "Controle feito por guia-fora ou registro."
},
{
"id": 2000005642,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Gestão documental",
"tipo": "pergunta",
"frente": "O que é a guia-fora?",
"verso": "Indicador colocado no lugar do documento retirado do arquivo, com dados de quem o retirou.",
"explicacao": "Controle de empréstimo."
},
{
"id": 2000005643,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Gestão documental",
"tipo": "pergunta",
"frente": "Quais são as atividades da fase de produção na gestão de documentos?",
"verso": "Elaboração de formulários, padronização, controle de cópias, uso de reprografia e escolha de materiais.",
"explicacao": "Primeira fase da gestão documental."
},
{
"id": 2000005644,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Gestão documental",
"tipo": "pergunta",
"frente": "O que é o diagnóstico de arquivo?",
"verso": "Análise da situação dos arquivos de uma instituição: volume, estado de conservação, organização e condições de guarda.",
"explicacao": "Primeiro passo para organizar um acervo."
},
{
"id": 2000005645,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Avaliação",
"tipo": "pergunta",
"frente": "O que é a amostragem na avaliação de documentos?",
"verso": "Seleção de parte representativa de um conjunto documental destinado à eliminação, para guarda permanente.",
"explicacao": "Preserva a memória das atividades rotineiras."
},
{
"id": 2000005646,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Avaliação",
"tipo": "pergunta",
"frente": "O que é a listagem de eliminação de documentos?",
"verso": "Relação dos documentos a serem eliminados, submetida à aprovação da autoridade competente.",
"explicacao": "Acompanha o edital de ciência de eliminação."
},
{
"id": 2000005647,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Avaliação",
"tipo": "pergunta",
"frente": "O que é o edital de ciência de eliminação?",
"verso": "Publicação que dá conhecimento público da intenção de eliminar documentos, com prazo para manifestação de interessados.",
"explicacao": "Resolução Conarq 40/2014."
},
{
"id": 2000005648,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Avaliação",
"tipo": "pares",
"frente": "Qual a diferença entre valor probatório e valor informativo?",
"verso": "Probatório: prova a origem, as funções e a estrutura da instituição. Informativo: contém informações úteis sobre pessoas, lugares e fatos.",
"explicacao": "Tipos de valor secundário (Schellenberg)."
},
{
"id": 2000005649,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Preservação",
"tipo": "pares",
"frente": "Qual a diferença entre conservação, preservação e restauração?",
"verso": "Preservação: ações gerais para manter o acervo. Conservação: ações preventivas para retardar a deterioração. Restauração: intervenção para recuperar documento danificado.",
"explicacao": "Conceitos de preservação."
},
{
"id": 2000005650,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Preservação",
"tipo": "pergunta",
"frente": "O que é a acidez do papel e como afeta o documento?",
"verso": "Presença de ácidos no papel que o tornam amarelado e quebradiço com o tempo.",
"explicacao": "Tratamento: desacidificação."
},
{
"id": 2000005651,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Documento digital",
"tipo": "pergunta",
"frente": "O que é a cadeia de custódia digital?",
"verso": "Linha contínua de custodiadores responsáveis pelo documento digital, que garante sua autenticidade.",
"explicacao": "Preservação digital."
},
{
"id": 2000005652,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Documento digital",
"tipo": "pergunta",
"frente": "O que é a obsolescência tecnológica?",
"verso": "Perda de acesso a documentos digitais porque o hardware, o software ou o formato deixaram de ser usados.",
"explicacao": "Combatida por migração e emulação."
},
{
"id": 2000005653,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Documento digital",
"tipo": "pares",
"frente": "Qual a diferença entre migração e emulação na preservação digital?",
"verso": "Migração: transfere o documento para formato ou suporte atual. Emulação: recria o ambiente tecnológico original para acessar o documento.",
"explicacao": "Estratégias de preservação digital."
},
{
"id": 2000005654,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Documento digital",
"tipo": "pergunta",
"frente": "O que são metadados?",
"verso": "Dados estruturados que descrevem o documento: contexto, conteúdo, estrutura e histórico.",
"explicacao": "Essenciais para a gestão e preservação digital."
},
{
"id": 2000005655,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Documento digital",
"tipo": "pergunta",
"frente": "Quais os formatos de arquivo recomendados para preservação de documentos textuais digitais?",
"verso": "PDF/A e formatos abertos e documentados.",
"explicacao": "PDF/A é a versão do PDF para arquivamento de longo prazo."
},
{
"id": 2000005656,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Legislação",
"tipo": "pergunta",
"frente": "Quem pode autorizar a eliminação de documentos públicos na esfera federal?",
"verso": "A instituição arquivística pública na sua esfera de competência; na União, o Arquivo Nacional.",
"explicacao": "Lei 8.159/1991, art. 9º."
},
{
"id": 2000005657,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Legislação",
"tipo": "pergunta",
"frente": "O que é o SIGA na administração federal?",
"verso": "Sistema de Gestão de Documentos e Arquivos da administração pública federal, que organiza as atividades de gestão de documentos nos órgãos do Executivo.",
"explicacao": "Decreto 4.915/2003. O Arquivo Nacional é o órgão central."
},
{
"id": 2000005658,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Judiciário",
"tipo": "pergunta",
"frente": "O que é o Proname?",
"verso": "Programa Nacional de Gestão Documental e Memória do Poder Judiciário, do CNJ.",
"explicacao": "Resolução CNJ 324/2020."
},
{
"id": 2000005659,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Judiciário",
"tipo": "pergunta",
"frente": "Qual o instrumento do Judiciário que define prazos de guarda dos processos?",
"verso": "A Tabela de Temporalidade de Documentos e Processos do Poder Judiciário, no âmbito do Proname.",
"explicacao": "Resolução CNJ 324/2020."
},
{
"id": 2000005660,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Métodos de arquivamento",
"tipo": "pergunta",
"frente": "O que é o método alfanumérico?",
"verso": "Combinação de letras e números para ordenar documentos, sem precisar de índice.",
"explicacao": "Método semi-indireto."
},
{
"id": 2000005661,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Métodos de arquivamento",
"tipo": "pergunta",
"frente": "O que é o método numérico cronológico?",
"verso": "Os documentos são numerados e ordenados por data, além do número.",
"explicacao": "Comum em protocolos."
},
{
"id": 2000005662,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Métodos de arquivamento",
"tipo": "pergunta",
"frente": "O que é o método por assunto em ordem dicionária?",
"verso": "Assuntos isolados dispostos em ordem alfabética, como em um dicionário.",
"explicacao": "Variação do método ideográfico."
},
{
"id": 2000005663,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Métodos de arquivamento",
"tipo": "pergunta",
"frente": "O que é o método por assunto em ordem enciclopédica?",
"verso": "Assuntos agrupados sob títulos gerais e dispostos alfabeticamente.",
"explicacao": "Variação do método ideográfico."
},
{
"id": 2000005664,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Processo administrativo",
"tipo": "pergunta",
"frente": "Quem pode iniciar o processo administrativo na Lei 9.784/1999?",
"verso": "A administração, de ofício, ou o interessado, por requerimento.",
"explicacao": "Lei 9.784/1999, art. 5º."
},
{
"id": 2000005665,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Processo administrativo",
"tipo": "pergunta",
"frente": "Quem são os legitimados como interessados no processo administrativo?",
"verso": "Titulares de direitos ou interesses, terceiros que possam ser afetados, organizações e associações representativas (direitos coletivos) e pessoas ou associações (direitos difusos).",
"explicacao": "Lei 9.784/1999, art. 9º."
},
{
"id": 2000005666,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Processo administrativo",
"tipo": "pergunta",
"frente": "A partir de que idade se é capaz para o processo administrativo?",
"verso": "18 anos, salvo previsão especial em ato normativo próprio.",
"explicacao": "Lei 9.784/1999, art. 10."
},
{
"id": 2000005667,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Processo administrativo",
"tipo": "pergunta",
"frente": "Quando é permitida a avocação de competência?",
"verso": "Em caráter excepcional e temporário, por motivos relevantes devidamente justificados, de órgão hierarquicamente inferior.",
"explicacao": "Lei 9.784/1999, art. 15."
},
{
"id": 2000005668,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Processo administrativo",
"tipo": "pergunta",
"frente": "O ato de delegação pode ser revogado?",
"verso": "Sim, a qualquer tempo, pela autoridade delegante.",
"explicacao": "Lei 9.784/1999, art. 14, § 2º."
},
{
"id": 2000005669,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Processo administrativo",
"tipo": "pergunta",
"frente": "As decisões tomadas por delegação são consideradas de quem?",
"verso": "Do delegado: consideram-se editadas por ele.",
"explicacao": "Lei 9.784/1999, art. 14, § 3º."
},
{
"id": 2000005670,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Processo administrativo",
"tipo": "pergunta",
"frente": "Quem está impedido de atuar no processo administrativo?",
"verso": "Quem tenha interesse direto ou indireto na matéria, tenha participado como perito, testemunha ou representante, ou esteja litigando com o interessado ou seu cônjuge.",
"explicacao": "Lei 9.784/1999, art. 18."
},
{
"id": 2000005671,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Processo administrativo",
"tipo": "pergunta",
"frente": "Em que horário os atos do processo administrativo devem ser realizados?",
"verso": "Em dias úteis, no horário normal de funcionamento da repartição.",
"explicacao": "Lei 9.784/1999, art. 23."
},
{
"id": 2000005672,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Processo administrativo",
"tipo": "pergunta",
"frente": "Qual o prazo geral para a prática de atos no processo administrativo, se não houver outro?",
"verso": "5 dias, prorrogáveis até o dobro, mediante justificação.",
"explicacao": "Lei 9.784/1999, art. 24."
},
{
"id": 2000005673,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Processo administrativo",
"tipo": "pergunta",
"frente": "Com que antecedência mínima deve ser feita a intimação para comparecimento?",
"verso": "3 dias úteis.",
"explicacao": "Lei 9.784/1999, art. 26, § 2º."
},
{
"id": 2000005674,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Processo administrativo",
"tipo": "pergunta",
"frente": "O desatendimento da intimação implica confissão no processo administrativo?",
"verso": "Não importa reconhecimento da verdade dos fatos nem renúncia a direito.",
"explicacao": "Lei 9.784/1999, art. 27."
},
{
"id": 2000005675,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Processo administrativo",
"tipo": "pergunta",
"frente": "Qual o prazo para a autoridade reconsiderar a decisão recorrida antes de encaminhar o recurso?",
"verso": "5 dias.",
"explicacao": "Lei 9.784/1999, art. 56, § 1º."
},
{
"id": 2000005676,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Processo administrativo",
"tipo": "pergunta",
"frente": "Qual o prazo para decidir o recurso administrativo?",
"verso": "30 dias, contados do recebimento dos autos, prorrogáveis por igual período.",
"explicacao": "Lei 9.784/1999, art. 59, § 1º."
},
{
"id": 2000005677,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Processo administrativo",
"tipo": "pergunta",
"frente": "O recurso administrativo tem efeito suspensivo?",
"verso": "Em regra, não, salvo disposição legal em contrário ou justo receio de prejuízo de difícil reparação.",
"explicacao": "Lei 9.784/1999, art. 61."
},
{
"id": 2000005678,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Processo administrativo",
"tipo": "pergunta",
"frente": "Quando o recurso administrativo não será conhecido?",
"verso": "Fora do prazo, perante órgão incompetente, por quem não seja legitimado ou após exaurida a esfera administrativa.",
"explicacao": "Lei 9.784/1999, art. 63."
},
{
"id": 2000005679,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Processo administrativo",
"tipo": "pergunta",
"frente": "Quem tem prioridade na tramitação do processo administrativo?",
"verso": "Maiores de 60 anos, pessoas com deficiência e portadores de doenças graves especificadas em lei.",
"explicacao": "Lei 9.784/1999, art. 69-A."
},
{
"id": 2000005680,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Processo administrativo",
"tipo": "pergunta",
"frente": "O que é a revisão do processo administrativo sancionador?",
"verso": "Pedido, a qualquer tempo, quando surgirem fatos novos ou circunstâncias relevantes que justifiquem a inadequação da sanção.",
"explicacao": "Lei 9.784/1999, art. 65. Não pode agravar a sanção."
},
{
"id": 2000005681,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Licitações",
"tipo": "pergunta",
"frente": "Qual modalidade se usa para bens e serviços comuns?",
"verso": "Pregão.",
"explicacao": "Lei 14.133/2021, art. 6º, XLI, e art. 29."
},
{
"id": 2000005682,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Licitações",
"tipo": "pergunta",
"frente": "Quais são exemplos de inexigibilidade de licitação?",
"verso": "Fornecedor exclusivo, contratação de artista consagrado, serviços técnicos especializados de natureza predominantemente intelectual com notória especialização e credenciamento.",
"explicacao": "Lei 14.133/2021, art. 74."
},
{
"id": 2000005683,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Licitações",
"tipo": "pergunta",
"frente": "O que é o agente de contratação?",
"verso": "Servidor designado para tomar decisões, acompanhar o trâmite da licitação e conduzir as fases até a homologação.",
"explicacao": "Lei 14.133/2021, art. 8º. No pregão, é chamado de pregoeiro."
},
{
"id": 2000005684,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Licitações",
"tipo": "pergunta",
"frente": "O que é o estudo técnico preliminar (ETP)?",
"verso": "Documento da fase preparatória que caracteriza o interesse público envolvido e sua melhor solução, base do termo de referência ou projeto básico.",
"explicacao": "Lei 14.133/2021, art. 6º, XX, e art. 18."
},
{
"id": 2000005685,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Licitações",
"tipo": "pergunta",
"frente": "O que é o sistema de registro de preços?",
"verso": "Procedimento para registro formal de preços para contratações futuras, que gera a ata de registro de preços.",
"explicacao": "Lei 14.133/2021, art. 6º, XLV, e arts. 82 a 86."
},
{
"id": 2000005686,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Licitações",
"tipo": "pergunta",
"frente": "Qual a validade da ata de registro de preços na Lei 14.133/2021?",
"verso": "1 ano, prorrogável por igual período, se comprovado que o preço é vantajoso.",
"explicacao": "Lei 14.133/2021, art. 84."
},
{
"id": 2000005687,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Licitações",
"tipo": "pergunta",
"frente": "O que é o PNCP?",
"verso": "Portal Nacional de Contratações Públicas, sítio oficial para divulgação dos atos exigidos pela Lei 14.133/2021.",
"explicacao": "Lei 14.133/2021, art. 174."
},
{
"id": 2000005688,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Licitações",
"tipo": "pergunta",
"frente": "Qual o prazo para impugnar o edital na Lei 14.133/2021?",
"verso": "Até 3 dias úteis antes da data de abertura do certame.",
"explicacao": "Lei 14.133/2021, art. 164."
},
{
"id": 2000005689,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Licitações",
"tipo": "pergunta",
"frente": "Qual o prazo do recurso na licitação da Lei 14.133/2021?",
"verso": "3 dias úteis, contados da intimação ou da lavratura da ata.",
"explicacao": "Lei 14.133/2021, art. 165."
},
{
"id": 2000005690,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Licitações",
"tipo": "pergunta",
"frente": "Quais as sanções administrativas da Lei 14.133/2021?",
"verso": "Advertência, multa, impedimento de licitar e contratar (até 3 anos) e declaração de inidoneidade (de 3 a 6 anos).",
"explicacao": "Lei 14.133/2021, art. 156."
},
{
"id": 2000005691,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Licitações",
"tipo": "pergunta",
"frente": "Quais os critérios de desempate na Lei 14.133/2021, na ordem?",
"verso": "Disputa final, avaliação do desempenho contratual prévio, ações de equidade de gênero no trabalho e programa de integridade.",
"explicacao": "Lei 14.133/2021, art. 60."
},
{
"id": 2000005692,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Contratos",
"tipo": "pergunta",
"frente": "O que é a matriz de riscos no contrato administrativo?",
"verso": "Cláusula que define os riscos e responsabilidades entre as partes e caracteriza o equilíbrio econômico-financeiro inicial.",
"explicacao": "Lei 14.133/2021, art. 6º, XXVII, e art. 103."
},
{
"id": 2000005693,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Contratos",
"tipo": "pergunta",
"frente": "Qual o limite da garantia contratual na Lei 14.133/2021?",
"verso": "Até 5% do valor inicial do contrato, podendo chegar a 10% conforme a complexidade e os riscos.",
"explicacao": "Lei 14.133/2021, art. 98. Em obras de grande vulto, seguro-garantia de até 30%."
},
{
"id": 2000005694,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Contratos",
"tipo": "pergunta",
"frente": "Quais as modalidades de garantia contratual?",
"verso": "Caução em dinheiro ou títulos da dívida pública, seguro-garantia e fiança bancária.",
"explicacao": "Lei 14.133/2021, art. 96, § 1º."
},
{
"id": 2000005695,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Contratos",
"tipo": "pergunta",
"frente": "Qual o prazo de atraso de pagamento da administração que permite ao contratado suspender a execução?",
"verso": "Superior a 2 meses.",
"explicacao": "Lei 14.133/2021, art. 137, § 3º, II."
},
{
"id": 2000005696,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Contratos",
"tipo": "pergunta",
"frente": "O que é a teoria da imprevisão?",
"verso": "Revisão do contrato por fato imprevisível ou previsível de consequências incalculáveis que torna a execução excessivamente onerosa.",
"explicacao": "Fundamento do reequilíbrio econômico-financeiro."
},
{
"id": 2000005697,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Contratos",
"tipo": "pares",
"frente": "Qual a diferença entre fato do príncipe e fato da administração?",
"verso": "Fato do príncipe: ato geral do poder público que afeta indiretamente o contrato (ex.: aumento de tributo). Fato da administração: ação ou omissão da própria administração contratante que afeta diretamente o contrato.",
"explicacao": "Hipóteses de reequilíbrio."
},
{
"id": 2000005698,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Contratos",
"tipo": "pergunta",
"frente": "Pode-se contratar verbalmente com a administração?",
"verso": "Em regra, não. É nulo o contrato verbal, salvo pequenas compras ou serviços de pronto pagamento de até cerca de R$ 12 mil (valor atualizado).",
"explicacao": "Lei 14.133/2021, art. 95, § 2º."
},
{
"id": 2000005699,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Agentes públicos",
"tipo": "pergunta",
"frente": "O que é o agente político?",
"verso": "Agente que ocupa cargos do primeiro escalão do Estado, com atribuições constitucionais, como chefes do Executivo, ministros e parlamentares.",
"explicacao": "Classificação de agentes públicos."
},
{
"id": 2000005700,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Agentes públicos",
"tipo": "pares",
"frente": "Qual a diferença entre cargo, emprego e função pública?",
"verso": "Cargo: unidade de atribuições com regime estatutário. Emprego: vínculo contratual pela CLT. Função: conjunto de atribuições sem cargo ou emprego (ex.: função de confiança ou temporária).",
"explicacao": "Conceitos de agentes públicos."
},
{
"id": 2000005701,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Agentes públicos",
"tipo": "pergunta",
"frente": "Quem pode ocupar função de confiança?",
"verso": "Exclusivamente servidores ocupantes de cargo efetivo.",
"explicacao": "CF, art. 37, V. Cargos em comissão podem ser ocupados por pessoas de fora, respeitado o mínimo legal de servidores de carreira."
},
{
"id": 2000005702,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Agentes públicos",
"tipo": "pergunta",
"frente": "A contratação temporária exige concurso?",
"verso": "Não. Exige processo seletivo simplificado, para atender necessidade temporária de excepcional interesse público.",
"explicacao": "CF, art. 37, IX, e Lei 8.745/1993."
},
{
"id": 2000005703,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Agentes públicos",
"tipo": "pergunta",
"frente": "Qual o prazo de validade do concurso público?",
"verso": "Até 2 anos, prorrogável uma vez por igual período.",
"explicacao": "CF, art. 37, III."
},
{
"id": 2000005704,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Agentes públicos",
"tipo": "pergunta",
"frente": "O candidato aprovado dentro do número de vagas tem direito à nomeação?",
"verso": "Sim, tem direito subjetivo à nomeação dentro do prazo de validade, salvo situações excepcionais.",
"explicacao": "STF, Tema 161 (RE 598.099)."
},
{
"id": 2000005705,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Agentes públicos",
"tipo": "pergunta",
"frente": "O exame psicotécnico pode ser exigido em concurso?",
"verso": "Só se previsto em lei, com critérios objetivos e possibilidade de recurso.",
"explicacao": "Súmula Vinculante 44."
},
{
"id": 2000005706,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Agentes públicos",
"tipo": "pergunta",
"frente": "Quais as hipóteses de acumulação remunerada de cargos públicos permitidas?",
"verso": "Dois de professor; um de professor com outro técnico ou científico; dois de profissionais de saúde com profissão regulamentada. Sempre com compatibilidade de horários.",
"explicacao": "CF, art. 37, XVI."
},
{
"id": 2000005707,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Agentes públicos",
"tipo": "pergunta",
"frente": "Qual o teto remuneratório no serviço público?",
"verso": "O subsídio mensal dos ministros do STF, com subtetos nos estados e municípios.",
"explicacao": "CF, art. 37, XI."
},
{
"id": 2000005708,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Controle",
"tipo": "pergunta",
"frente": "O que é o controle administrativo?",
"verso": "Controle exercido pela própria administração sobre seus atos, por autotutela, de ofício ou por provocação.",
"explicacao": "Inclui recursos, revisão e supervisão."
},
{
"id": 2000005709,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Controle",
"tipo": "pergunta",
"frente": "O que é o controle social da administração?",
"verso": "Controle exercido pelos cidadãos e pela sociedade civil, por audiências públicas, conselhos, ouvidorias e denúncias ao Tribunal de Contas.",
"explicacao": "CF, art. 74, § 2º."
},
{
"id": 2000005710,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Controle",
"tipo": "pergunta",
"frente": "Qualquer cidadão pode denunciar irregularidades ao TCU?",
"verso": "Sim, qualquer cidadão, partido, associação ou sindicato.",
"explicacao": "CF, art. 74, § 2º."
},
{
"id": 2000005711,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Responsabilidade civil",
"tipo": "pergunta",
"frente": "As concessionárias de serviço público respondem objetivamente perante não usuários?",
"verso": "Sim.",
"explicacao": "STF, RE 591.874 (Tema 130)."
},
{
"id": 2000005712,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Lei anticorrupção",
"tipo": "pergunta",
"frente": "O que a Lei 12.846/2013 (Lei Anticorrupção) regula?",
"verso": "A responsabilização objetiva, administrativa e civil, de pessoas jurídicas por atos contra a administração pública, nacional ou estrangeira.",
"explicacao": "Também chamada de Lei da Empresa Limpa."
},
{
"id": 2000005713,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Lei anticorrupção",
"tipo": "pergunta",
"frente": "Qual a multa máxima prevista na Lei Anticorrupção?",
"verso": "De 0,1% a 20% do faturamento bruto do último exercício anterior ao processo, nunca inferior à vantagem auferida.",
"explicacao": "Lei 12.846/2013, art. 6º, I."
},
{
"id": 2000005714,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Lei anticorrupção",
"tipo": "pergunta",
"frente": "O que é o acordo de leniência?",
"verso": "Acordo com a pessoa jurídica que colabora efetivamente com as investigações, podendo reduzir a multa em até 2/3.",
"explicacao": "Lei 12.846/2013, art. 16."
},
{
"id": 2000005715,
"trilha": "administrativa",
"materia": "const",
"assunto": "Administração Pública",
"tipo": "pergunta",
"frente": "O que é vedado na publicidade dos atos do governo?",
"verso": "Constar nomes, símbolos ou imagens que caracterizem promoção pessoal de autoridades ou servidores.",
"explicacao": "CF, art. 37, § 1º."
},
{
"id": 2000005716,
"trilha": "administrativa",
"materia": "const",
"assunto": "Administração Pública",
"tipo": "pergunta",
"frente": "O servidor em exercício de mandato eletivo federal ou estadual fica como?",
"verso": "Afastado do cargo.",
"explicacao": "CF, art. 38, I."
},
{
"id": 2000005717,
"trilha": "administrativa",
"materia": "const",
"assunto": "Administração Pública",
"tipo": "pergunta",
"frente": "Como fica o servidor investido no mandato de prefeito?",
"verso": "Afastado do cargo, podendo optar pela remuneração.",
"explicacao": "CF, art. 38, II."
},
{
"id": 2000005718,
"trilha": "administrativa",
"materia": "const",
"assunto": "Administração Pública",
"tipo": "pergunta",
"frente": "Como fica o servidor eleito vereador?",
"verso": "Se houver compatibilidade de horários, acumula cargo e mandato com as duas remunerações; se não, afasta-se e pode optar pela remuneração.",
"explicacao": "CF, art. 38, III."
},
{
"id": 2000005719,
"trilha": "administrativa",
"materia": "const",
"assunto": "Administração Pública",
"tipo": "pergunta",
"frente": "O que é a revisão geral anual da remuneração dos servidores?",
"verso": "Revisão sempre na mesma data e sem distinção de índices, por lei específica de iniciativa privativa do chefe de cada Poder.",
"explicacao": "CF, art. 37, X."
},
{
"id": 2000005720,
"trilha": "administrativa",
"materia": "const",
"assunto": "Administração Pública",
"tipo": "pergunta",
"frente": "O que é o direito de greve do servidor público?",
"verso": "Direito exercido nos termos e limites de lei específica. Enquanto ela não existe, aplica-se a lei de greve do setor privado, no que couber.",
"explicacao": "CF, art. 37, VII, e STF, MIs 670, 708 e 712."
},
{
"id": 2000005721,
"trilha": "administrativa",
"materia": "const",
"assunto": "Administração Pública",
"tipo": "pergunta",
"frente": "O servidor público civil pode se sindicalizar?",
"verso": "Sim. É garantido o direito à livre associação sindical.",
"explicacao": "CF, art. 37, VI. O militar não pode."
},
{
"id": 2000005722,
"trilha": "administrativa",
"materia": "const",
"assunto": "Administração Pública",
"tipo": "pergunta",
"frente": "Quais servidores não podem fazer greve, segundo o STF?",
"verso": "Policiais civis e demais servidores que atuam diretamente na segurança pública.",
"explicacao": "STF, ARE 654.432 (Tema 541)."
},
{
"id": 2000005723,
"trilha": "administrativa",
"materia": "const",
"assunto": "Direitos sociais",
"tipo": "pergunta",
"frente": "Qual a duração máxima da jornada de trabalho na CF?",
"verso": "8 horas diárias e 44 semanais, facultada a compensação.",
"explicacao": "CF, art. 7º, XIII."
},
{
"id": 2000005724,
"trilha": "administrativa",
"materia": "const",
"assunto": "Direitos sociais",
"tipo": "pergunta",
"frente": "Qual a duração da licença-maternidade e da licença-paternidade na CF?",
"verso": "Maternidade: 120 dias. Paternidade: 5 dias (ADCT), até lei específica.",
"explicacao": "CF, art. 7º, XVIII e XIX, e ADCT, art. 10, § 1º."
},
{
"id": 2000005725,
"trilha": "administrativa",
"materia": "const",
"assunto": "Direitos sociais",
"tipo": "pergunta",
"frente": "Qual o adicional mínimo da hora extra na CF?",
"verso": "50% sobre a hora normal.",
"explicacao": "CF, art. 7º, XVI."
},
{
"id": 2000005726,
"trilha": "administrativa",
"materia": "const",
"assunto": "Direitos sociais",
"tipo": "pergunta",
"frente": "Qual o prazo prescricional dos créditos trabalhistas?",
"verso": "5 anos para os trabalhadores urbanos e rurais, até o limite de 2 anos após a extinção do contrato.",
"explicacao": "CF, art. 7º, XXIX."
},
{
"id": 2000005727,
"trilha": "administrativa",
"materia": "const",
"assunto": "Direitos fundamentais",
"tipo": "pergunta",
"frente": "Qual a diferença entre direitos de 1ª, 2ª e 3ª geração?",
"verso": "1ª: liberdades civis e políticas. 2ª: direitos sociais, econômicos e culturais (igualdade). 3ª: direitos difusos, como meio ambiente e paz (fraternidade).",
"explicacao": "Classificação de Karel Vasak."
},
{
"id": 2000005728,
"trilha": "administrativa",
"materia": "const",
"assunto": "Direitos fundamentais",
"tipo": "pergunta",
"frente": "O que é a eficácia horizontal dos direitos fundamentais?",
"verso": "Aplicação dos direitos fundamentais nas relações entre particulares.",
"explicacao": "Admitida pelo STF."
},
{
"id": 2000005729,
"trilha": "administrativa",
"materia": "const",
"assunto": "Ordem social",
"tipo": "pergunta",
"frente": "O ensino público é gratuito em estabelecimentos oficiais?",
"verso": "Sim. É garantida a gratuidade do ensino público em estabelecimentos oficiais.",
"explicacao": "CF, art. 206, IV. Súmula Vinculante 12: taxa de matrícula em universidade pública é inconstitucional."
},
{
"id": 2000005730,
"trilha": "administrativa",
"materia": "const",
"assunto": "Ordem social",
"tipo": "pergunta",
"frente": "A partir de que idade a educação básica é obrigatória e gratuita?",
"verso": "Dos 4 aos 17 anos.",
"explicacao": "CF, art. 208, I."
},
{
"id": 2000005731,
"trilha": "administrativa",
"materia": "const",
"assunto": "Ordem social",
"tipo": "pergunta",
"frente": "Qual a proteção constitucional ao idoso no transporte?",
"verso": "Aos maiores de 65 anos é garantida a gratuidade dos transportes coletivos urbanos.",
"explicacao": "CF, art. 230, § 2º."
},
{
"id": 2000005732,
"trilha": "administrativa",
"materia": "const",
"assunto": "Ordem social",
"tipo": "pergunta",
"frente": "O que é o meio ambiente ecologicamente equilibrado na CF?",
"verso": "Bem de uso comum do povo e essencial à sadia qualidade de vida, que o poder público e a coletividade devem defender e preservar para as presentes e futuras gerações.",
"explicacao": "CF, art. 225."
},
{
"id": 2000005733,
"trilha": "administrativa",
"materia": "const",
"assunto": "Tributação e orçamento",
"tipo": "pergunta",
"frente": "Quais os impostos da União (exemplos)?",
"verso": "Importação, exportação, renda, produtos industrializados, operações financeiras, propriedade territorial rural e grandes fortunas.",
"explicacao": "CF, art. 153. A EC 132/2023 criou o imposto seletivo e a CBS."
},
{
"id": 2000005734,
"trilha": "administrativa",
"materia": "const",
"assunto": "Tributação e orçamento",
"tipo": "pergunta",
"frente": "Quais os impostos dos municípios?",
"verso": "IPTU, ITBI e ISS (este a ser substituído pelo IBS com a reforma tributária).",
"explicacao": "CF, art. 156."
},
{
"id": 2000005735,
"trilha": "administrativa",
"materia": "const",
"assunto": "Tributação e orçamento",
"tipo": "pergunta",
"frente": "Quais os impostos dos estados?",
"verso": "ITCMD, ICMS (a ser substituído pelo IBS) e IPVA.",
"explicacao": "CF, art. 155."
},
{
"id": 2000005736,
"trilha": "administrativa",
"materia": "const",
"assunto": "Poder Executivo",
"tipo": "pergunta",
"frente": "Quais são os crimes de responsabilidade do Presidente da República (exemplos)?",
"verso": "Atos contra a existência da União, o livre exercício dos Poderes, os direitos políticos, individuais e sociais, a segurança interna, a probidade na administração, a lei orçamentária e o cumprimento das leis e decisões judiciais.",
"explicacao": "CF, art. 85."
},
{
"id": 2000005737,
"trilha": "administrativa",
"materia": "const",
"assunto": "Poder Executivo",
"tipo": "pergunta",
"frente": "O Presidente pode ser responsabilizado por atos estranhos ao exercício de suas funções durante o mandato?",
"verso": "Não, na vigência do mandato.",
"explicacao": "CF, art. 86, § 4º (irresponsabilidade penal relativa)."
},
{
"id": 2000005738,
"trilha": "administrativa",
"materia": "const",
"assunto": "Poder Legislativo",
"tipo": "pergunta",
"frente": "Qual o número de deputados federais por estado?",
"verso": "Proporcional à população, com mínimo de 8 e máximo de 70 por estado. Territórios elegem 4.",
"explicacao": "CF, art. 45, §§ 1º e 2º."
},
{
"id": 2000005739,
"trilha": "administrativa",
"materia": "const",
"assunto": "Poder Legislativo",
"tipo": "pergunta",
"frente": "O que são as CPIs e quais seus poderes?",
"verso": "Comissões parlamentares de inquérito, com poderes de investigação próprios das autoridades judiciais, criadas por 1/3 dos membros, com fato determinado e prazo certo.",
"explicacao": "CF, art. 58, § 3º."
},
{
"id": 2000005740,
"trilha": "administrativa",
"materia": "const",
"assunto": "Poder Legislativo",
"tipo": "pergunta",
"frente": "A CPI pode decretar prisão, salvo em flagrante, ou interceptação telefônica?",
"verso": "Não. Essas medidas têm reserva de jurisdição.",
"explicacao": "Entendimento do STF. A CPI pode quebrar sigilos bancário, fiscal e de dados telefônicos."
},
{
"id": 2000005741,
"trilha": "administrativa",
"materia": "const",
"assunto": "Poder Legislativo",
"tipo": "pergunta",
"frente": "Qual o prazo para o Presidente sancionar ou vetar um projeto de lei?",
"verso": "15 dias úteis. O silêncio importa sanção.",
"explicacao": "CF, art. 66, §§ 1º e 3º."
},
{
"id": 2000005742,
"trilha": "administrativa",
"materia": "const",
"assunto": "Poder Legislativo",
"tipo": "pergunta",
"frente": "Qual o quórum para derrubar o veto presidencial?",
"verso": "Maioria absoluta dos deputados e senadores, em sessão conjunta.",
"explicacao": "CF, art. 66, § 4º."
},
{
"id": 2000005743,
"trilha": "administrativa",
"materia": "const",
"assunto": "Remédios constitucionais",
"tipo": "pergunta",
"frente": "Quem pode impetrar habeas corpus?",
"verso": "Qualquer pessoa, em seu favor ou de outrem, sem advogado. O juiz pode concedê-lo de ofício.",
"explicacao": "CPP, art. 654."
},
{
"id": 2000005744,
"trilha": "administrativa",
"materia": "port",
"assunto": "Classes de palavras",
"tipo": "pergunta",
"frente": "Qual a função do 'que' em 'O livro que comprei é ótimo'?",
"verso": "Pronome relativo: retoma 'livro' e introduz oração adjetiva.",
"explicacao": "Pode ser substituído por 'o qual'."
},
{
"id": 2000005745,
"trilha": "administrativa",
"materia": "port",
"assunto": "Classes de palavras",
"tipo": "pergunta",
"frente": "Qual a função do 'que' em 'Espero que você venha'?",
"verso": "Conjunção integrante: introduz oração substantiva.",
"explicacao": "Pode ser substituída por 'isso': 'Espero isso'."
},
{
"id": 2000005746,
"trilha": "administrativa",
"materia": "port",
"assunto": "Classes de palavras",
"tipo": "pergunta",
"frente": "Qual a diferença entre 'porque', 'por que', 'porquê' e 'por quê'?",
"verso": "'Por que': perguntas e 'pelo qual'. 'Por quê': no fim da frase. 'Porque': explicação ou causa. 'Porquê': substantivo, com artigo.",
"explicacao": "Ex.: 'Não sei o porquê'."
},
{
"id": 2000005747,
"trilha": "administrativa",
"materia": "port",
"assunto": "Classes de palavras",
"tipo": "pergunta",
"frente": "Qual a diferença entre 'a fim de' e 'afim'?",
"verso": "'A fim de': com a finalidade de. 'Afim': semelhante, que tem afinidade.",
"explicacao": "Ex.: 'Estudou a fim de passar'; 'áreas afins'."
},
{
"id": 2000005748,
"trilha": "administrativa",
"materia": "port",
"assunto": "Classes de palavras",
"tipo": "pergunta",
"frente": "Qual a diferença entre 'demais' e 'de mais'?",
"verso": "'Demais': excessivamente ou os outros. 'De mais': oposto de 'de menos'.",
"explicacao": "Ex.: 'Falou demais'; 'Não vi nada de mais'."
},
{
"id": 2000005749,
"trilha": "administrativa",
"materia": "port",
"assunto": "Classes de palavras",
"tipo": "pergunta",
"frente": "Qual a diferença entre 'há' e 'a' em expressões de tempo?",
"verso": "'Há': tempo passado (faz). 'A': tempo futuro ou distância.",
"explicacao": "Ex.: 'Cheguei há 2 dias'; 'Viajo daqui a 2 dias'."
},
{
"id": 2000005750,
"trilha": "administrativa",
"materia": "port",
"assunto": "Classes de palavras",
"tipo": "pergunta",
"frente": "Qual a diferença entre 'em vez de' e 'ao invés de'?",
"verso": "'Em vez de': no lugar de. 'Ao invés de': ao contrário de, só para ideias opostas.",
"explicacao": "Ex.: 'Ao invés de subir, desceu'."
},
{
"id": 2000005751,
"trilha": "administrativa",
"materia": "port",
"assunto": "Conjunções",
"tipo": "pergunta",
"frente": "Qual a relação de sentido de 'embora' e 'conquanto'?",
"verso": "Concessão.",
"explicacao": "Exigem o verbo no subjuntivo: 'Embora chovesse, saiu'."
},
{
"id": 2000005752,
"trilha": "administrativa",
"materia": "port",
"assunto": "Conjunções",
"tipo": "pergunta",
"frente": "Qual a relação de sentido de 'contudo', 'todavia' e 'no entanto'?",
"verso": "Adversidade (oposição).",
"explicacao": "Conjunções coordenativas adversativas."
},
{
"id": 2000005753,
"trilha": "administrativa",
"materia": "port",
"assunto": "Conjunções",
"tipo": "pergunta",
"frente": "Qual a relação de sentido de 'à medida que' e 'à proporção que'?",
"verso": "Proporção.",
"explicacao": "Diferente de 'na medida em que', que indica causa."
},
{
"id": 2000005754,
"trilha": "administrativa",
"materia": "port",
"assunto": "Conjunções",
"tipo": "pergunta",
"frente": "Qual a relação de sentido de 'conforme', 'consoante' e 'segundo'?",
"verso": "Conformidade.",
"explicacao": "Conjunções subordinativas conformativas."
},
{
"id": 2000005755,
"trilha": "administrativa",
"materia": "port",
"assunto": "Conjunções",
"tipo": "pergunta",
"frente": "Qual a relação de sentido de 'para que' e 'a fim de que'?",
"verso": "Finalidade.",
"explicacao": "Conjunções subordinativas finais."
},
{
"id": 2000005756,
"trilha": "administrativa",
"materia": "port",
"assunto": "Conjunções",
"tipo": "pergunta",
"frente": "Qual a relação de sentido de 'caso' e 'desde que' (com subjuntivo)?",
"verso": "Condição.",
"explicacao": "Ex.: 'Desde que estude, passará'."
},
{
"id": 2000005757,
"trilha": "administrativa",
"materia": "port",
"assunto": "Concordância",
"tipo": "pergunta",
"frente": "Qual a concordância com 'é proibido' e 'é necessário'?",
"verso": "Invariáveis se o substantivo não tiver determinante ('É proibido entrada'); variam se tiver ('É proibida a entrada').",
"explicacao": "Expressões do tipo 'é bom', 'é preciso'."
},
{
"id": 2000005758,
"trilha": "administrativa",
"materia": "port",
"assunto": "Concordância",
"tipo": "pergunta",
"frente": "Qual a concordância de 'meio' como advérbio e como numeral?",
"verso": "Advérbio (= um pouco): invariável ('Ela está meio cansada'). Numeral (= metade): varia ('meia hora').",
"explicacao": "Regra de concordância nominal."
},
{
"id": 2000005759,
"trilha": "administrativa",
"materia": "port",
"assunto": "Concordância",
"tipo": "pergunta",
"frente": "Qual a concordância de 'bastante'?",
"verso": "Adjetivo ou pronome (= suficientes, muitos): varia ('bastantes provas'). Advérbio: invariável ('estudaram bastante').",
"explicacao": "Regra de concordância nominal."
},
{
"id": 2000005760,
"trilha": "administrativa",
"materia": "port",
"assunto": "Concordância",
"tipo": "pergunta",
"frente": "Qual a concordância de 'mesmo' e 'próprio'?",
"verso": "Concordam com o termo a que se referem: 'Elas mesmas fizeram'.",
"explicacao": "Como advérbio (= realmente), 'mesmo' é invariável."
},
{
"id": 2000005761,
"trilha": "administrativa",
"materia": "port",
"assunto": "Concordância",
"tipo": "pergunta",
"frente": "Qual a concordância de 'obrigado'?",
"verso": "Concorda com quem agradece: homem diz 'obrigado'; mulher diz 'obrigada'.",
"explicacao": "Concordância nominal."
},
{
"id": 2000005762,
"trilha": "administrativa",
"materia": "port",
"assunto": "Concordância",
"tipo": "pergunta",
"frente": "Como concorda o verbo com sujeito composto posposto?",
"verso": "Pode ir para o plural ou concordar com o núcleo mais próximo: 'Chegaram/Chegou o diretor e os assessores'.",
"explicacao": "Concordância verbal."
},
{
"id": 2000005763,
"trilha": "administrativa",
"materia": "port",
"assunto": "Concordância",
"tipo": "pergunta",
"frente": "Qual a concordância do verbo 'ser' com horas e datas?",
"verso": "Concorda com o numeral: 'São 10 horas'; 'É uma hora'. Com dias: 'Hoje são 15' ou 'Hoje é dia 15'.",
"explicacao": "Concordância do verbo ser."
},
{
"id": 2000005764,
"trilha": "administrativa",
"materia": "port",
"assunto": "Concordância",
"tipo": "pergunta",
"frente": "Qual a concordância com 'um dos que'?",
"verso": "O verbo vai, preferencialmente, para o plural: 'Ele foi um dos que mais estudaram'.",
"explicacao": "Concordância verbal."
},
{
"id": 2000005765,
"trilha": "administrativa",
"materia": "port",
"assunto": "Regência",
"tipo": "pergunta",
"frente": "Qual a regência do verbo 'chegar'?",
"verso": "Pede a preposição 'a' para destino: 'Cheguei ao trabalho' (não 'no trabalho').",
"explicacao": "Verbos de movimento."
},
{
"id": 2000005766,
"trilha": "administrativa",
"materia": "port",
"assunto": "Regência",
"tipo": "pergunta",
"frente": "Qual a regência de 'pagar' e 'perdoar'?",
"verso": "Direto para coisa e indireto para pessoa: 'Paguei a conta ao cobrador'.",
"explicacao": "Regência verbal."
},
{
"id": 2000005767,
"trilha": "administrativa",
"materia": "port",
"assunto": "Regência",
"tipo": "pergunta",
"frente": "Qual a regência do verbo 'informar'?",
"verso": "Admite 'informar algo a alguém' ou 'informar alguém de/sobre algo'.",
"explicacao": "Verbo transitivo direto e indireto."
},
{
"id": 2000005768,
"trilha": "administrativa",
"materia": "port",
"assunto": "Regência",
"tipo": "pergunta",
"frente": "Qual a regência do verbo 'proceder' no sentido de realizar?",
"verso": "Transitivo indireto: 'Procedeu-se à leitura da ata'.",
"explicacao": "Por isso há crase."
},
{
"id": 2000005769,
"trilha": "administrativa",
"materia": "port",
"assunto": "Crase",
"tipo": "pergunta",
"frente": "Há crase em 'Fui a Bahia'?",
"verso": "Sim: 'Fui à Bahia', pois se diz 'Voltei da Bahia'.",
"explicacao": "Macete: se volta da, crase há; se volta de, crase pra quê?"
},
{
"id": 2000005770,
"trilha": "administrativa",
"materia": "port",
"assunto": "Crase",
"tipo": "pergunta",
"frente": "Há crase antes de 'casa' e 'terra'?",
"verso": "Não, quando 'casa' é o próprio lar e 'terra' é oposto a bordo. Sim, se determinadas: 'Fui à casa dos meus pais'.",
"explicacao": "Regra de crase."
},
{
"id": 2000005771,
"trilha": "administrativa",
"materia": "port",
"assunto": "Crase",
"tipo": "pergunta",
"frente": "Há crase em locuções adverbiais femininas?",
"verso": "Sim: 'às vezes', 'à noite', 'às pressas', 'à vista'.",
"explicacao": "Regra de crase."
},
{
"id": 2000005772,
"trilha": "administrativa",
"materia": "port",
"assunto": "Acentuação",
"tipo": "pergunta",
"frente": "Por que 'voo' e 'enjoo' não têm mais acento?",
"verso": "O Acordo Ortográfico aboliu o acento em 'oo' e 'ee' ('veem', 'creem').",
"explicacao": "Novo Acordo Ortográfico."
},
{
"id": 2000005773,
"trilha": "administrativa",
"materia": "port",
"assunto": "Acentuação",
"tipo": "pergunta",
"frente": "Qual a regra de acentuação das proparoxítonas?",
"verso": "Todas são acentuadas.",
"explicacao": "Ex.: 'lâmpada', 'público'."
},
{
"id": 2000005774,
"trilha": "administrativa",
"materia": "port",
"assunto": "Acentuação",
"tipo": "pergunta",
"frente": "Qual a diferença entre 'tem' e 'têm'?",
"verso": "'Tem': 3ª pessoa do singular. 'Têm': 3ª do plural.",
"explicacao": "Ex.: 'Ele tem'; 'Eles têm'. Derivados: 'detém', 'detêm'."
},
{
"id": 2000005775,
"trilha": "administrativa",
"materia": "port",
"assunto": "Hífen",
"tipo": "pergunta",
"frente": "Usa-se hífen em 'autoestima' e 'antissocial'?",
"verso": "Não. Prefixo terminado em vogal junta-se a palavra iniciada por vogal diferente ('autoestima'); com 'r' ou 's', dobra-se a consoante ('antissocial').",
"explicacao": "Novo Acordo Ortográfico."
},
{
"id": 2000005776,
"trilha": "administrativa",
"materia": "port",
"assunto": "Hífen",
"tipo": "pergunta",
"frente": "Usa-se hífen em 'micro-ondas' e 'anti-inflamatório'?",
"verso": "Sim. Usa-se hífen quando o prefixo termina com a mesma vogal que inicia a palavra seguinte.",
"explicacao": "Novo Acordo Ortográfico."
},
{
"id": 2000005777,
"trilha": "administrativa",
"materia": "port",
"assunto": "Interpretação",
"tipo": "pares",
"frente": "Qual a diferença entre inferência e pressuposto?",
"verso": "Pressuposto: informação implícita marcada por palavras do texto ('Ele parou de fumar' pressupõe que fumava). Inferência: conclusão do leitor a partir do texto.",
"explicacao": "Informações implícitas."
},
{
"id": 2000005778,
"trilha": "administrativa",
"materia": "port",
"assunto": "Redação oficial",
"tipo": "pergunta",
"frente": "Quais as partes do padrão ofício?",
"verso": "Cabeçalho, identificação do expediente, local e data, endereçamento, assunto, texto (introdução, desenvolvimento e conclusão), fecho, assinatura e identificação do signatário.",
"explicacao": "Manual de Redação da Presidência da República."
},
{
"id": 2000005779,
"trilha": "administrativa",
"materia": "port",
"assunto": "Redação oficial",
"tipo": "pergunta",
"frente": "Quais os fechos das comunicações oficiais?",
"verso": "'Respeitosamente', para autoridades superiores, e 'Atenciosamente', para autoridades da mesma hierarquia ou inferiores.",
"explicacao": "Manual de Redação da Presidência da República."
},
{
"id": 2000005780,
"trilha": "administrativa",
"materia": "port",
"assunto": "Redação oficial",
"tipo": "pergunta",
"frente": "Os pronomes de tratamento exigem verbo em qual pessoa?",
"verso": "3ª pessoa: 'Vossa Excelência sabe'.",
"explicacao": "Os possessivos também: 'Vossa Senhoria e seu assessor'."
},
{
"id": 2000005781,
"trilha": "administrativa",
"materia": "port",
"assunto": "Redação oficial",
"tipo": "pergunta",
"frente": "Quando se usa 'Vossa' e quando 'Sua' Excelência?",
"verso": "'Vossa': ao falar com a autoridade. 'Sua': ao falar sobre ela.",
"explicacao": "Regra dos pronomes de tratamento."
},
{
"id": 2000005782,
"trilha": "administrativa",
"materia": "inf",
"assunto": "Windows",
"tipo": "pergunta",
"frente": "Qual o atalho para bloquear o computador no Windows?",
"verso": "Win + L.",
"explicacao": "Atalho de segurança."
},
{
"id": 2000005783,
"trilha": "administrativa",
"materia": "inf",
"assunto": "Windows",
"tipo": "pergunta",
"frente": "O que faz Shift + Delete no Windows?",
"verso": "Exclui o arquivo permanentemente, sem enviar para a Lixeira.",
"explicacao": "Atalho do Explorador de Arquivos."
},
{
"id": 2000005784,
"trilha": "administrativa",
"materia": "inf",
"assunto": "Windows",
"tipo": "pergunta",
"frente": "Qual o atalho para abrir o Explorador de Arquivos?",
"verso": "Win + E.",
"explicacao": "Windows 10 e 11."
},
{
"id": 2000005785,
"trilha": "administrativa",
"materia": "inf",
"assunto": "Windows",
"tipo": "pergunta",
"frente": "Qual o atalho para mostrar a área de trabalho?",
"verso": "Win + D.",
"explicacao": "Atalho do Windows."
},
{
"id": 2000005786,
"trilha": "administrativa",
"materia": "inf",
"assunto": "Windows",
"tipo": "pergunta",
"frente": "O que acontece ao arrastar um arquivo para outra pasta no mesmo disco?",
"verso": "Ele é movido. Para outro disco (unidade), ele é copiado.",
"explicacao": "Com Ctrl, copia; com Shift, move."
},
{
"id": 2000005787,
"trilha": "administrativa",
"materia": "inf",
"assunto": "Word",
"tipo": "pergunta",
"frente": "Qual o atalho para negrito, itálico e sublinhado no Word em português?",
"verso": "Ctrl + N (negrito), Ctrl + I (itálico) e Ctrl + S (sublinhado).",
"explicacao": "Na versão em inglês: Ctrl + B, I e U."
},
{
"id": 2000005788,
"trilha": "administrativa",
"materia": "inf",
"assunto": "Word",
"tipo": "pergunta",
"frente": "Qual o atalho para salvar no Word em português?",
"verso": "Ctrl + B.",
"explicacao": "Na versão em inglês, Ctrl + S."
},
{
"id": 2000005789,
"trilha": "administrativa",
"materia": "inf",
"assunto": "Word",
"tipo": "pergunta",
"frente": "O que é a mala direta no Word?",
"verso": "Recurso que mescla um documento padrão com uma lista de dados para gerar documentos personalizados, como cartas e etiquetas.",
"explicacao": "Guia Correspondências."
},
{
"id": 2000005790,
"trilha": "administrativa",
"materia": "inf",
"assunto": "Word",
"tipo": "pergunta",
"frente": "Para que serve o controle de alterações no Word?",
"verso": "Para registrar as mudanças feitas no documento, permitindo aceitá-las ou rejeitá-las.",
"explicacao": "Guia Revisão."
},
{
"id": 2000005791,
"trilha": "administrativa",
"materia": "inf",
"assunto": "Excel",
"tipo": "pergunta",
"frente": "O que faz a função CONT.SE no Excel?",
"verso": "Conta as células de um intervalo que atendem a um critério.",
"explicacao": "Ex.: =CONT.SE(A1:A10;\">5\")."
},
{
"id": 2000005792,
"trilha": "administrativa",
"materia": "inf",
"assunto": "Excel",
"tipo": "pergunta",
"frente": "O que faz a função SOMASE no Excel?",
"verso": "Soma os valores de um intervalo que atendem a um critério.",
"explicacao": "Ex.: =SOMASE(A1:A10;\"Sim\";B1:B10)."
},
{
"id": 2000005793,
"trilha": "administrativa",
"materia": "inf",
"assunto": "Excel",
"tipo": "pergunta",
"frente": "O que faz a função CONCATENAR (ou o operador &) no Excel?",
"verso": "Junta textos de várias células em uma só.",
"explicacao": "Ex.: =A1&\" \"&B1."
},
{
"id": 2000005794,
"trilha": "administrativa",
"materia": "inf",
"assunto": "Excel",
"tipo": "pergunta",
"frente": "O que é a alça de preenchimento no Excel?",
"verso": "Pequeno quadrado no canto da célula que, ao ser arrastado, copia ou continua sequências.",
"explicacao": "Ex.: arrastar 'jan' gera 'fev', 'mar'."
},
{
"id": 2000005795,
"trilha": "administrativa",
"materia": "inf",
"assunto": "Excel",
"tipo": "pergunta",
"frente": "Qual a diferença entre as funções MÉDIA e MED no Excel?",
"verso": "MÉDIA: média aritmética. MED: mediana, o valor central.",
"explicacao": "Funções estatísticas."
},
{
"id": 2000005796,
"trilha": "administrativa",
"materia": "inf",
"assunto": "Internet",
"tipo": "pergunta",
"frente": "O que é um navegador (browser)?",
"verso": "Programa para acessar páginas da web, como Chrome, Edge e Firefox.",
"explicacao": "Diferente do buscador (Google, Bing)."
},
{
"id": 2000005797,
"trilha": "administrativa",
"materia": "inf",
"assunto": "Internet",
"tipo": "pergunta",
"frente": "O que é URL?",
"verso": "Endereço de um recurso na internet.",
"explicacao": "Ex.: https://www.gov.br."
},
{
"id": 2000005798,
"trilha": "administrativa",
"materia": "inf",
"assunto": "E-mail",
"tipo": "pares",
"frente": "Qual a diferença entre CC e CCO no e-mail?",
"verso": "CC: cópia visível a todos. CCO: cópia oculta, os outros destinatários não veem quem recebeu.",
"explicacao": "Campos do e-mail."
},
{
"id": 2000005799,
"trilha": "administrativa",
"materia": "inf",
"assunto": "E-mail",
"tipo": "pergunta",
"frente": "Quais os protocolos de envio e recebimento de e-mail?",
"verso": "Envio: SMTP. Recebimento: POP3 (baixa as mensagens) e IMAP (sincroniza com o servidor).",
"explicacao": "Protocolos de correio eletrônico."
},
{
"id": 2000005800,
"trilha": "administrativa",
"materia": "inf",
"assunto": "Segurança",
"tipo": "pergunta",
"frente": "O que é um worm?",
"verso": "Malware que se propaga sozinho pela rede, explorando vulnerabilidades, sem precisar de um arquivo hospedeiro.",
"explicacao": "Diferente do vírus, que precisa de um hospedeiro."
},
{
"id": 2000005801,
"trilha": "administrativa",
"materia": "inf",
"assunto": "Segurança",
"tipo": "pergunta",
"frente": "O que é criptografia assimétrica?",
"verso": "Usa um par de chaves: pública, para cifrar, e privada, para decifrar. Na assinatura digital, a lógica se inverte.",
"explicacao": "Também chamada de criptografia de chave pública."
},
{
"id": 2000005802,
"trilha": "administrativa",
"materia": "rl",
"assunto": "Lógica proposicional",
"tipo": "pergunta",
"frente": "Qual a negação de 'Algum servidor é estagiário'?",
"verso": "'Nenhum servidor é estagiário'.",
"explicacao": "Negação de 'algum' é 'nenhum'."
},
{
"id": 2000005803,
"trilha": "administrativa",
"materia": "rl",
"assunto": "Lógica proposicional",
"tipo": "pergunta",
"frente": "Qual a negação de 'Pedro é alto ou Paulo é baixo'?",
"verso": "'Pedro não é alto e Paulo não é baixo'.",
"explicacao": "Lei de De Morgan."
},
{
"id": 2000005804,
"trilha": "administrativa",
"materia": "rl",
"assunto": "Lógica proposicional",
"tipo": "pergunta",
"frente": "Qual a negação de 'Se estudo, então passo'?",
"verso": "'Estudo e não passo'.",
"explicacao": "~(p → q) ≡ p ∧ ~q."
},
{
"id": 2000005805,
"trilha": "administrativa",
"materia": "rl",
"assunto": "Lógica proposicional",
"tipo": "pergunta",
"frente": "Quando a conjunção 'p e q' é verdadeira?",
"verso": "Só quando p e q são verdadeiras.",
"explicacao": "Tabela-verdade da conjunção."
},
{
"id": 2000005806,
"trilha": "administrativa",
"materia": "rl",
"assunto": "Lógica proposicional",
"tipo": "pergunta",
"frente": "O que é uma contradição em lógica?",
"verso": "Proposição composta sempre falsa.",
"explicacao": "Ex.: p ∧ ~p."
},
{
"id": 2000005807,
"trilha": "administrativa",
"materia": "rl",
"assunto": "Lógica proposicional",
"tipo": "pergunta",
"frente": "O que é uma contingência?",
"verso": "Proposição que pode ser verdadeira ou falsa, dependendo dos valores das proposições simples.",
"explicacao": "Nem tautologia nem contradição."
},
{
"id": 2000005808,
"trilha": "administrativa",
"materia": "rl",
"assunto": "Lógica proposicional",
"tipo": "pergunta",
"frente": "'Todo A é B' equivale a qual condicional?",
"verso": "'Se é A, então é B'.",
"explicacao": "Equivalência entre categórica e condicional."
},
{
"id": 2000005809,
"trilha": "administrativa",
"materia": "rl",
"assunto": "Lógica proposicional",
"tipo": "pergunta",
"frente": "Qual a recíproca de 'Se p, então q'? Ela é equivalente?",
"verso": "'Se q, então p'. Não é equivalente à original.",
"explicacao": "A contrapositiva é equivalente; a recíproca e a inversa, não."
},
{
"id": 2000005810,
"trilha": "administrativa",
"materia": "rl",
"assunto": "Lógica proposicional",
"tipo": "pergunta",
"frente": "O que é o modus ponens?",
"verso": "Se p → q é verdadeira e p é verdadeira, então q é verdadeira.",
"explicacao": "Regra de inferência."
},
{
"id": 2000005811,
"trilha": "administrativa",
"materia": "rl",
"assunto": "Lógica proposicional",
"tipo": "pergunta",
"frente": "O que é o modus tollens?",
"verso": "Se p → q é verdadeira e q é falsa, então p é falsa.",
"explicacao": "Regra de inferência."
},
{
"id": 2000005812,
"trilha": "administrativa",
"materia": "rl",
"assunto": "Matemática",
"tipo": "pergunta",
"frente": "Quantos números de 3 algarismos distintos podem ser formados com 1, 2, 3, 4 e 5?",
"verso": "60 (5 × 4 × 3).",
"explicacao": "Arranjo: a ordem importa."
},
{
"id": 2000005813,
"trilha": "administrativa",
"materia": "rl",
"assunto": "Matemática",
"tipo": "pergunta",
"frente": "De quantas maneiras 5 pessoas podem sentar em 5 cadeiras em fila?",
"verso": "120 (5!).",
"explicacao": "Permutação simples."
},
{
"id": 2000005814,
"trilha": "administrativa",
"materia": "rl",
"assunto": "Matemática",
"tipo": "pergunta",
"frente": "Um servidor gasta 30% do salário com aluguel. Se o salário é R$ 4.000, quanto sobra?",
"verso": "R$ 2.800.",
"explicacao": "4.000 × 0,7 = 2.800."
},
{
"id": 2000005815,
"trilha": "administrativa",
"materia": "rl",
"assunto": "Matemática",
"tipo": "pergunta",
"frente": "Se 3 impressoras imprimem 600 páginas em 2 horas, quantas páginas 5 impressoras imprimem em 3 horas?",
"verso": "1.500 páginas.",
"explicacao": "Regra de três composta: 600 × (5/3) × (3/2) = 1.500."
},
{
"id": 2000005816,
"trilha": "administrativa",
"materia": "prev",
"assunto": "RPPS",
"tipo": "pergunta",
"frente": "O que é o regime próprio de previdência social (RPPS)?",
"verso": "Regime de previdência dos servidores titulares de cargo efetivo da União, estados, DF e municípios.",
"explicacao": "CF, art. 40."
},
{
"id": 2000005817,
"trilha": "administrativa",
"materia": "prev",
"assunto": "RPPS",
"tipo": "pergunta",
"frente": "Os servidores comissionados sem vínculo efetivo contribuem para qual regime?",
"verso": "Para o RGPS.",
"explicacao": "CF, art. 40, § 13."
},
{
"id": 2000005818,
"trilha": "administrativa",
"materia": "prev",
"assunto": "RPPS",
"tipo": "pergunta",
"frente": "Qual a alíquota mínima de contribuição dos servidores dos estados e municípios ao RPPS?",
"verso": "Não pode ser inferior à dos servidores da União (14%), salvo se o RPPS não tiver déficit atuarial.",
"explicacao": "CF, art. 149, § 1º, e EC 103/2019, art. 9º, § 4º."
},
{
"id": 2000005819,
"trilha": "administrativa",
"materia": "prev",
"assunto": "RPPS",
"tipo": "pergunta",
"frente": "Os aposentados e pensionistas do RPPS contribuem?",
"verso": "Sim, sobre a parcela dos proventos que supere o teto do RGPS (ou o salário mínimo, em caso de déficit atuarial).",
"explicacao": "CF, art. 40, § 18, e art. 149, § 1º-A."
},
{
"id": 2000005820,
"trilha": "administrativa",
"materia": "prev",
"assunto": "RPPS",
"tipo": "pergunta",
"frente": "O que é o abono de permanência?",
"verso": "Valor equivalente à contribuição previdenciária pago ao servidor que já cumpriu os requisitos para aposentadoria voluntária e opta por continuar trabalhando.",
"explicacao": "CF, art. 40, § 19."
},
{
"id": 2000005821,
"trilha": "administrativa",
"materia": "prev",
"assunto": "RPPS",
"tipo": "pergunta",
"frente": "O servidor pode acumular duas aposentadorias no RPPS?",
"verso": "Só as decorrentes de cargos acumuláveis na forma da Constituição.",
"explicacao": "CF, art. 40, § 6º."
},
{
"id": 2000005822,
"trilha": "administrativa",
"materia": "prev",
"assunto": "RPPS",
"tipo": "pergunta",
"frente": "Qual o regime do servidor que ingressou após a Funpresp quanto ao valor da aposentadoria?",
"verso": "O RPPS paga até o teto do RGPS; para receber mais, o servidor deve aderir à previdência complementar.",
"explicacao": "CF, art. 40, § 14."
},
{
"id": 2000005823,
"trilha": "administrativa",
"materia": "prev",
"assunto": "RPPS",
"tipo": "pergunta",
"frente": "Quais os requisitos da aposentadoria por incapacidade permanente do servidor federal?",
"verso": "Incapacidade para o trabalho insuscetível de readaptação, com avaliações periódicas.",
"explicacao": "CF, art. 40, § 1º, I."
},
{
"id": 2000005824,
"trilha": "administrativa",
"materia": "prev",
"assunto": "RPPS",
"tipo": "pergunta",
"frente": "É permitido contar tempo fictício para aposentadoria?",
"verso": "Não. A lei não pode estabelecer contagem de tempo de contribuição fictício.",
"explicacao": "CF, art. 40, § 10."
},
{
"id": 2000005825,
"trilha": "administrativa",
"materia": "prev",
"assunto": "Benefícios",
"tipo": "pergunta",
"frente": "O que é o abono anual (13º) dos benefícios previdenciários?",
"verso": "Pagamento anual a quem recebeu auxílio por incapacidade, auxílio-acidente, aposentadoria, pensão por morte ou auxílio-reclusão no ano.",
"explicacao": "Lei 8.213/1991, art. 40."
},
{
"id": 2000005826,
"trilha": "administrativa",
"materia": "prev",
"assunto": "Benefícios",
"tipo": "pergunta",
"frente": "O que é o salário de benefício após a EC 103/2019?",
"verso": "Média aritmética simples de todos os salários de contribuição desde julho de 1994.",
"explicacao": "EC 103/2019, art. 26."
},
{
"id": 2000005827,
"trilha": "administrativa",
"materia": "prev",
"assunto": "Benefícios",
"tipo": "pergunta",
"frente": "Qual o valor do auxílio por incapacidade temporária?",
"verso": "91% do salário de benefício, limitado à média dos 12 últimos salários de contribuição.",
"explicacao": "Lei 8.213/1991, arts. 61 e 29, § 10."
},
{
"id": 2000005828,
"trilha": "administrativa",
"materia": "pcd",
"assunto": "Pessoa com deficiência",
"tipo": "pergunta",
"frente": "A pessoa com deficiência tem atendimento prioritário?",
"verso": "Sim, inclusive em processos judiciais e administrativos e na restituição do imposto de renda.",
"explicacao": "Lei 13.146/2015, art. 9º."
},
{
"id": 2000005829,
"trilha": "administrativa",
"materia": "ia",
"assunto": "Inteligência artificial",
"tipo": "pergunta",
"frente": "Pode-se inserir dados pessoais sigilosos em ferramentas públicas de IA no trabalho?",
"verso": "Não sem avaliação e autorização. Isso pode violar a LGPD e as regras de sigilo do órgão.",
"explicacao": "Boa prática de governança e proteção de dados."
},
{
"id": 2000005830,
"trilha": "administrativa",
"materia": "ia",
"assunto": "Inteligência artificial",
"tipo": "pergunta",
"frente": "O que significa supervisão humana no uso de IA?",
"verso": "Decisões relevantes tomadas com apoio de IA devem ser revisadas e assumidas por uma pessoa responsável.",
"explicacao": "Princípio presente nas regras do CNJ e no debate sobre IA."
},
{
"id": 2000005831,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Receita",
"tipo": "pergunta",
"frente": "O que a LRF exige das previsões de receita?",
"verso": "Que observem normas técnicas e legais, considerem efeitos de mudanças na legislação, variação de preços e crescimento econômico, e venham acompanhadas de demonstrativo de 3 anos anteriores e projeção para os 2 seguintes.",
"explicacao": "LRF, art. 12."
},
{
"id": 2000005832,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Receita",
"tipo": "pergunta",
"frente": "As receitas de operações de crédito podem superar as despesas de capital no projeto de LOA?",
"verso": "Não.",
"explicacao": "LRF, art. 12, § 2º (regra de ouro)."
},
{
"id": 2000005833,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Receita",
"tipo": "pergunta",
"frente": "As transferências correntes recebidas são classificadas como?",
"verso": "Receitas correntes, mesmo que venham de outro ente.",
"explicacao": "Lei 4.320/1964, art. 11, § 1º."
},
{
"id": 2000005834,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Receita",
"tipo": "pergunta",
"frente": "A alienação de um imóvel público gera qual tipo de receita?",
"verso": "Receita de capital.",
"explicacao": "Lei 4.320/1964, art. 11, § 2º."
},
{
"id": 2000005835,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Receita",
"tipo": "pergunta",
"frente": "O superávit do orçamento corrente é receita de quê?",
"verso": "Receita de capital, embora não constitua item orçamentário.",
"explicacao": "Lei 4.320/1964, art. 11, § 3º."
},
{
"id": 2000005836,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Receita",
"tipo": "pergunta",
"frente": "Quais os níveis de codificação da natureza da receita?",
"verso": "Categoria econômica, origem, espécie, desdobramentos para identificação de peculiaridades e tipo.",
"explicacao": "Portaria Interministerial STN/SOF 163/2001 (atualizada)."
},
{
"id": 2000005837,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Receita",
"tipo": "pergunta",
"frente": "O que é a receita pública efetiva?",
"verso": "Receita que aumenta o patrimônio líquido, sem gerar obrigação correspondente, como os tributos.",
"explicacao": "As operações de crédito são receitas não efetivas."
},
{
"id": 2000005838,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Despesa",
"tipo": "pergunta",
"frente": "O que é despesa pública efetiva?",
"verso": "Despesa que diminui o patrimônio líquido, como pagamento de salários e juros.",
"explicacao": "A amortização da dívida é despesa não efetiva."
},
{
"id": 2000005839,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Despesa",
"tipo": "pergunta",
"frente": "O que é o elemento de despesa?",
"verso": "Identifica o objeto do gasto, como vencimentos, diárias, material de consumo e obras.",
"explicacao": "Último nível obrigatório da natureza da despesa."
},
{
"id": 2000005840,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Despesa",
"tipo": "pergunta",
"frente": "O empenho pode exceder o limite dos créditos concedidos?",
"verso": "Não.",
"explicacao": "Lei 4.320/1964, art. 59."
},
{
"id": 2000005841,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Despesa",
"tipo": "pergunta",
"frente": "O que é a anulação de empenho?",
"verso": "Cancelamento total ou parcial do empenho, que reverte o valor à dotação.",
"explicacao": "Ocorre quando o valor foi superestimado ou o serviço não será prestado."
},
{
"id": 2000005842,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Despesa",
"tipo": "pergunta",
"frente": "Quais as despesas consideradas de pessoal na LRF?",
"verso": "Ativos, inativos e pensionistas, mandatos eletivos, cargos, funções e empregos, com vencimentos, encargos e contribuições, além de contratos de terceirização para substituir servidores.",
"explicacao": "LRF, art. 18."
},
{
"id": 2000005843,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Despesa",
"tipo": "pergunta",
"frente": "Quais despesas não são computadas no limite de pessoal da LRF (exemplos)?",
"verso": "Indenização por demissão, incentivos à demissão voluntária, convocação extraordinária e despesas de exercícios anteriores fora do período de apuração.",
"explicacao": "LRF, art. 19, § 1º."
},
{
"id": 2000005844,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Despesa",
"tipo": "pergunta",
"frente": "Qual o período de apuração da despesa com pessoal?",
"verso": "O mês de referência somado aos 11 meses imediatamente anteriores (regime de competência).",
"explicacao": "LRF, art. 18, § 2º."
},
{
"id": 2000005845,
"trilha": "administrativa",
"materia": "afo",
"assunto": "LRF",
"tipo": "pergunta",
"frente": "O que é a dívida consolidada ou fundada?",
"verso": "Montante total das obrigações financeiras do ente com prazo de amortização superior a 12 meses.",
"explicacao": "LRF, art. 29, I. Inclui precatórios não pagos durante a execução do orçamento."
},
{
"id": 2000005846,
"trilha": "administrativa",
"materia": "afo",
"assunto": "LRF",
"tipo": "pergunta",
"frente": "O que é a dívida flutuante?",
"verso": "Dívida de curto prazo: restos a pagar, serviços da dívida a pagar, depósitos e débitos de tesouraria.",
"explicacao": "Lei 4.320/1964, art. 92."
},
{
"id": 2000005847,
"trilha": "administrativa",
"materia": "afo",
"assunto": "LRF",
"tipo": "pergunta",
"frente": "O que é a concessão de garantia na LRF?",
"verso": "Compromisso de adimplência de obrigação financeira assumido por um ente em favor de outro ente ou entidade.",
"explicacao": "LRF, art. 29, IV."
},
{
"id": 2000005848,
"trilha": "administrativa",
"materia": "afo",
"assunto": "LRF",
"tipo": "pergunta",
"frente": "Um ente da Federação pode fazer operação de crédito com outro ente?",
"verso": "Não, salvo por instituição financeira estatal, nas condições da lei e sem refinanciar dívida não contraída com a própria instituição.",
"explicacao": "LRF, art. 35."
},
{
"id": 2000005849,
"trilha": "administrativa",
"materia": "afo",
"assunto": "LRF",
"tipo": "pergunta",
"frente": "Qual a regra da LRF para o aumento de despesa com a seguridade social?",
"verso": "Nenhum benefício ou serviço pode ser criado, majorado ou estendido sem a indicação da fonte de custeio total.",
"explicacao": "LRF, art. 24."
},
{
"id": 2000005850,
"trilha": "administrativa",
"materia": "afo",
"assunto": "LRF",
"tipo": "pergunta",
"frente": "Em situação de calamidade pública reconhecida, o que a LRF suspende?",
"verso": "A contagem dos prazos para reconduzir pessoal e dívida aos limites e a obrigação de cumprir metas fiscais e limitar empenho.",
"explicacao": "LRF, art. 65."
},
{
"id": 2000005851,
"trilha": "administrativa",
"materia": "afo",
"assunto": "LRF",
"tipo": "pergunta",
"frente": "Os prazos de recondução aos limites da LRF são duplicados quando?",
"verso": "Em caso de crescimento real baixo ou negativo do PIB, inferior a 1%, por período igual ou superior a 4 trimestres.",
"explicacao": "LRF, art. 66."
},
{
"id": 2000005852,
"trilha": "administrativa",
"materia": "afo",
"assunto": "LRF",
"tipo": "pergunta",
"frente": "A LRF obriga a destinação de recursos ao setor privado por lei?",
"verso": "Sim. A destinação de recursos para cobrir necessidades de pessoas físicas ou déficits de pessoas jurídicas deve ser autorizada por lei específica, atender à LDO e estar prevista na LOA.",
"explicacao": "LRF, art. 26."
},
{
"id": 2000005853,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Tipos de orçamento",
"tipo": "pergunta",
"frente": "O que é o PPBS?",
"verso": "Sistema de Planejamento, Programação e Orçamento, criado nos EUA nos anos 1960, que integra planejamento e orçamento.",
"explicacao": "Planning, Programming and Budgeting System."
},
{
"id": 2000005854,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Tipos de orçamento",
"tipo": "pergunta",
"frente": "O que é o orçamento legislativo, executivo e misto?",
"verso": "Legislativo: elaborado e aprovado pelo Legislativo. Executivo: elaborado e aprovado pelo Executivo. Misto: elaborado pelo Executivo e aprovado pelo Legislativo, como no Brasil.",
"explicacao": "Classificação quanto à competência."
},
{
"id": 2000005855,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Ciclo orçamentário",
"tipo": "pergunta",
"frente": "O que acontece se a LOA não for aprovada até o início do exercício?",
"verso": "A LDO costuma prever a execução provisória de parte das despesas, como as obrigatórias, à razão de 1/12 por mês.",
"explicacao": "Não há regra constitucional expressa; a LDO disciplina."
},
{
"id": 2000005856,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Ciclo orçamentário",
"tipo": "pergunta",
"frente": "Quais recursos podem ser usados se, por veto, emenda ou rejeição, ficarem sem despesa correspondente?",
"verso": "Podem ser utilizados mediante créditos especiais ou suplementares, com prévia e específica autorização legislativa.",
"explicacao": "CF, art. 166, § 8º."
},
{
"id": 2000005857,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Ciclo orçamentário",
"tipo": "pergunta",
"frente": "O Presidente pode alterar o projeto de lei orçamentária depois de enviado?",
"verso": "Sim, por mensagem ao Congresso, enquanto não iniciada a votação na CMO da parte que se quer alterar.",
"explicacao": "CF, art. 166, § 5º."
},
{
"id": 2000005858,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Controle",
"tipo": "pergunta",
"frente": "Quais os aspectos da fiscalização contábil, financeira e orçamentária?",
"verso": "Legalidade, legitimidade, economicidade, aplicação das subvenções e renúncia de receitas.",
"explicacao": "CF, art. 70."
},
{
"id": 2000005859,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Controle",
"tipo": "pergunta",
"frente": "Quem deve prestar contas ao Tribunal de Contas?",
"verso": "Qualquer pessoa física ou jurídica, pública ou privada, que utilize, arrecade, guarde, gerencie ou administre dinheiros, bens e valores públicos.",
"explicacao": "CF, art. 70, parágrafo único."
},
{
"id": 2000005860,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Execução",
"tipo": "pares",
"frente": "Qual a diferença entre cota, repasse e sub-repasse?",
"verso": "Cota: do Tesouro para órgãos setoriais. Repasse: de um órgão para outro órgão. Sub-repasse: dentro do mesmo órgão, para suas unidades.",
"explicacao": "Descentralização de recursos financeiros."
},
{
"id": 2000005861,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Execução",
"tipo": "pergunta",
"frente": "O que é a fonte de recursos no orçamento?",
"verso": "Classificação que identifica a origem e a destinação dos recursos, ligando a receita à despesa.",
"explicacao": "Usada para controle das vinculações."
},
{
"id": 2000005862,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Administração geral",
"tipo": "pergunta",
"frente": "Quais as habilidades do administrador segundo Katz?",
"verso": "Técnicas, humanas e conceituais.",
"explicacao": "Nível operacional usa mais as técnicas; a alta direção, as conceituais."
},
{
"id": 2000005863,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Administração geral",
"tipo": "pergunta",
"frente": "Quais os papéis do administrador segundo Mintzberg?",
"verso": "Interpessoais, informacionais e decisórios.",
"explicacao": "10 papéis agrupados em 3 categorias."
},
{
"id": 2000005864,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Administração geral",
"tipo": "pergunta",
"frente": "O que é o princípio da unidade de comando de Fayol?",
"verso": "Cada empregado deve receber ordens de um só superior.",
"explicacao": "Um dos 14 princípios de Fayol."
},
{
"id": 2000005865,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Administração geral",
"tipo": "pergunta",
"frente": "O que é a cadeia escalar (hierarquia) de Fayol?",
"verso": "Linha de autoridade que vai do escalão mais alto ao mais baixo.",
"explicacao": "A 'ponte de Fayol' permite comunicação horizontal."
},
{
"id": 2000005866,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Organização",
"tipo": "pergunta",
"frente": "O que é a estrutura organizacional em rede?",
"verso": "Estrutura em que a organização terceiriza funções e coordena parceiros externos interligados.",
"explicacao": "Estrutura flexível e enxuta."
},
{
"id": 2000005867,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Organização",
"tipo": "pergunta",
"frente": "O que é a departamentalização funcional?",
"verso": "Agrupamento das atividades por função, como finanças, pessoal e produção.",
"explicacao": "Vantagem: especialização. Desvantagem: pouca cooperação entre áreas."
},
{
"id": 2000005868,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Organização",
"tipo": "pergunta",
"frente": "O que é a departamentalização por processos?",
"verso": "Agrupamento das atividades conforme as etapas de um processo produtivo ou de trabalho.",
"explicacao": "Comum em linhas de produção."
},
{
"id": 2000005869,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Organização",
"tipo": "pergunta",
"frente": "O que é a departamentalização geográfica (territorial)?",
"verso": "Agrupamento conforme a localização onde o trabalho é realizado ou o mercado atendido.",
"explicacao": "Ex.: superintendências regionais."
},
{
"id": 2000005870,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Organização",
"tipo": "pergunta",
"frente": "O que é o organograma?",
"verso": "Representação gráfica da estrutura formal da organização, com órgãos, níveis hierárquicos e relações.",
"explicacao": "Instrumento de organização."
},
{
"id": 2000005871,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Organização",
"tipo": "pergunta",
"frente": "O que é o fluxograma?",
"verso": "Representação gráfica da sequência das etapas de um processo de trabalho.",
"explicacao": "Instrumento de análise de processos."
},
{
"id": 2000005872,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Direção",
"tipo": "pergunta",
"frente": "O que é a teoria das necessidades adquiridas de McClelland?",
"verso": "As pessoas são motivadas por 3 necessidades: realização, poder e afiliação.",
"explicacao": "Teoria de conteúdo da motivação."
},
{
"id": 2000005873,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Direção",
"tipo": "pergunta",
"frente": "O que é a teoria ERG de Alderfer?",
"verso": "Reduz as necessidades de Maslow a 3: existência, relacionamento e crescimento, que podem atuar ao mesmo tempo.",
"explicacao": "Teoria de conteúdo da motivação."
},
{
"id": 2000005874,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Direção",
"tipo": "pergunta",
"frente": "O que é a teoria da equidade de Adams?",
"verso": "As pessoas comparam o que dão e recebem com os outros; percebendo injustiça, ficam desmotivadas.",
"explicacao": "Teoria de processo da motivação."
},
{
"id": 2000005875,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Direção",
"tipo": "pergunta",
"frente": "O que é a teoria do estabelecimento de metas de Locke?",
"verso": "Metas específicas e desafiadoras, com feedback, aumentam o desempenho.",
"explicacao": "Teoria de processo da motivação."
},
{
"id": 2000005876,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Direção",
"tipo": "pergunta",
"frente": "O que é o grid gerencial de Blake e Mouton?",
"verso": "Modelo que cruza preocupação com as pessoas e com a produção, sendo o estilo 9.9 (equipe) o ideal.",
"explicacao": "Teoria comportamental de liderança."
},
{
"id": 2000005877,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Direção",
"tipo": "pergunta",
"frente": "O que é a liderança servidora?",
"verso": "Estilo em que o líder prioriza servir e desenvolver os liderados.",
"explicacao": "Robert Greenleaf."
},
{
"id": 2000005878,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Controle",
"tipo": "pares",
"frente": "Qual a diferença entre controle estratégico, tático e operacional?",
"verso": "Estratégico: organização como um todo, longo prazo. Tático: cada departamento, médio prazo. Operacional: tarefas e operações, curto prazo.",
"explicacao": "Níveis de controle."
},
{
"id": 2000005879,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Controle",
"tipo": "pares",
"frente": "Qual a diferença entre controle preventivo, simultâneo e posterior?",
"verso": "Preventivo: antes da ação. Simultâneo (concorrente): durante. Posterior (feedback): após a ação.",
"explicacao": "Tipos de controle quanto ao momento."
},
{
"id": 2000005880,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Qualidade",
"tipo": "pergunta",
"frente": "O que é o kaizen?",
"verso": "Filosofia japonesa de melhoria contínua e gradual.",
"explicacao": "Pequenas melhorias constantes."
},
{
"id": 2000005881,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Qualidade",
"tipo": "pergunta",
"frente": "O que é o Seis Sigma?",
"verso": "Metodologia de melhoria que busca reduzir a variabilidade dos processos e os defeitos, usando o ciclo DMAIC.",
"explicacao": "Definir, Medir, Analisar, Melhorar e Controlar."
},
{
"id": 2000005882,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Qualidade",
"tipo": "pergunta",
"frente": "O que é o histograma como ferramenta da qualidade?",
"verso": "Gráfico de barras que mostra a distribuição de frequência de um conjunto de dados.",
"explicacao": "Uma das 7 ferramentas da qualidade."
},
{
"id": 2000005883,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Qualidade",
"tipo": "pergunta",
"frente": "O que é a folha de verificação?",
"verso": "Formulário para coletar e organizar dados de forma simples.",
"explicacao": "Uma das 7 ferramentas da qualidade."
},
{
"id": 2000005884,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Qualidade",
"tipo": "pergunta",
"frente": "Quais são os critérios do Modelo de Excelência em Gestão Pública (Gespública)?",
"verso": "Governança, estratégia e planos, público-alvo, interesse público e cidadania, informação e conhecimento, pessoas, processos e resultados.",
"explicacao": "Modelo de Excelência em Gestão Pública."
},
{
"id": 2000005885,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Processos",
"tipo": "pergunta",
"frente": "O que é a reengenharia?",
"verso": "Redesenho radical dos processos para obter melhorias drásticas em custo, qualidade e rapidez.",
"explicacao": "Hammer e Champy, anos 1990."
},
{
"id": 2000005886,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Processos",
"tipo": "pergunta",
"frente": "O que é o mapeamento de processos?",
"verso": "Identificação e representação das atividades, entradas, saídas e responsáveis de um processo.",
"explicacao": "Base para análise e melhoria."
},
{
"id": 2000005887,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Processos",
"tipo": "pergunta",
"frente": "O que é a cadeia de valor de Porter?",
"verso": "Modelo que divide a organização em atividades primárias e de apoio que geram valor.",
"explicacao": "Michael Porter."
},
{
"id": 2000005888,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Conceitos",
"tipo": "pergunta",
"frente": "O que é arquivologia segundo o objeto de estudo?",
"verso": "Ciência que estuda os arquivos e os documentos de arquivo, sua produção, organização e preservação.",
"explicacao": "Também chamada de arquivística."
},
{
"id": 2000005889,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Conceitos",
"tipo": "pergunta",
"frente": "Quais as características dos documentos de arquivo?",
"verso": "Organicidade, unicidade, autenticidade, imparcialidade e naturalidade.",
"explicacao": "Características segundo a teoria arquivística."
},
{
"id": 2000005890,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Conceitos",
"tipo": "pergunta",
"frente": "O que é a naturalidade do documento de arquivo?",
"verso": "O documento é produzido naturalmente, no curso das atividades, e não colecionado.",
"explicacao": "Característica do documento de arquivo."
},
{
"id": 2000005891,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Conceitos",
"tipo": "pergunta",
"frente": "O que é a imparcialidade do documento de arquivo?",
"verso": "O documento reflete fielmente as atividades que o geraram, sem intenção de registrar para a posteridade.",
"explicacao": "Característica do documento de arquivo."
},
{
"id": 2000005892,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Gestão documental",
"tipo": "pergunta",
"frente": "Qual a ordem das atividades de protocolo?",
"verso": "Recebimento, registro, classificação, autuação, distribuição, tramitação e expedição.",
"explicacao": "Rotina de protocolo."
},
{
"id": 2000005893,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Gestão documental",
"tipo": "pergunta",
"frente": "O que é o registro no protocolo?",
"verso": "Anotação dos dados do documento (número, data, procedência, assunto) em sistema ou livro de controle.",
"explicacao": "Atividade de protocolo."
},
{
"id": 2000005894,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Gestão documental",
"tipo": "pergunta",
"frente": "Como devem ser numeradas as folhas de um processo?",
"verso": "Em sequência, no canto superior direito, com carimbo e rubrica do servidor, sem numerar a capa.",
"explicacao": "Normas de protocolo do Executivo federal."
},
{
"id": 2000005895,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Gestão documental",
"tipo": "pergunta",
"frente": "Qual o limite aproximado de folhas por volume de um processo físico?",
"verso": "Cerca de 200 folhas, abrindo-se novo volume a partir daí.",
"explicacao": "Normas de protocolo do Executivo federal."
},
{
"id": 2000005896,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Gestão documental",
"tipo": "pergunta",
"frente": "O que é o NUP?",
"verso": "Número Único de Protocolo, que identifica cada processo e documento avulso na administração federal.",
"explicacao": "Portaria Interministerial 11/2019."
},
{
"id": 2000005897,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Gestão documental",
"tipo": "pergunta",
"frente": "O que é o SEI?",
"verso": "Sistema Eletrônico de Informações, plataforma de processo eletrônico usada por muitos órgãos públicos.",
"explicacao": "Desenvolvido pelo TRF4. Integra o Processo Eletrônico Nacional (PEN)."
},
{
"id": 2000005898,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Avaliação",
"tipo": "pergunta",
"frente": "Quem aprova a tabela de temporalidade dos órgãos do Executivo federal?",
"verso": "O Arquivo Nacional.",
"explicacao": "Decreto 10.148/2019."
},
{
"id": 2000005899,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Avaliação",
"tipo": "pergunta",
"frente": "Quais documentos nunca são eliminados?",
"verso": "Os de valor permanente, que devem ser recolhidos ao arquivo permanente.",
"explicacao": "Lei 8.159/1991, art. 10."
},
{
"id": 2000005900,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Arquivos permanentes",
"tipo": "pergunta",
"frente": "O que é o inventário como instrumento de pesquisa?",
"verso": "Instrumento que descreve as séries de um fundo, com detalhamento intermediário.",
"explicacao": "Mais específico que o guia, menos que o catálogo."
},
{
"id": 2000005901,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Arquivos permanentes",
"tipo": "pergunta",
"frente": "O que é o índice como instrumento de pesquisa?",
"verso": "Lista ordenada de termos (nomes, lugares, assuntos) com a indicação de sua localização no acervo.",
"explicacao": "Pode ser autônomo ou complementar outro instrumento."
},
{
"id": 2000005902,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Arquivos permanentes",
"tipo": "pergunta",
"frente": "O que é o repertório como instrumento de pesquisa?",
"verso": "Instrumento que descreve pormenorizadamente documentos selecionados de um ou mais fundos, segundo um critério temático.",
"explicacao": "Instrumento seletivo."
},
{
"id": 2000005903,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Reprodução",
"tipo": "pergunta",
"frente": "O que é a digitalização de documentos?",
"verso": "Conversão de documento em suporte físico para código digital, gerando representante digital.",
"explicacao": "Lei 12.682/2012 e Decreto 10.278/2020."
},
{
"id": 2000005904,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Reprodução",
"tipo": "pergunta",
"frente": "Qual a vantagem da microfilmagem em relação à digitalização para preservação?",
"verso": "Longa durabilidade (centenas de anos) e independência de tecnologia para leitura, bastando lente e luz.",
"explicacao": "Microfilme de sais de prata."
},
{
"id": 2000005905,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Ato administrativo",
"tipo": "pergunta",
"frente": "O que é o atributo da imperatividade?",
"verso": "O ato impõe obrigações a terceiros independentemente de sua concordância.",
"explicacao": "Nem todo ato tem imperatividade (ex.: atos enunciativos)."
},
{
"id": 2000005906,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Ato administrativo",
"tipo": "pergunta",
"frente": "O que é o atributo da tipicidade?",
"verso": "O ato deve corresponder a figuras definidas previamente em lei.",
"explicacao": "Atributo apontado por Maria Sylvia Di Pietro."
},
{
"id": 2000005907,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Ato administrativo",
"tipo": "pares",
"frente": "Qual a diferença entre motivo e motivação?",
"verso": "Motivo: situação de fato e de direito que justifica o ato. Motivação: exposição escrita dos motivos.",
"explicacao": "Conceitos do ato administrativo."
},
{
"id": 2000005908,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Ato administrativo",
"tipo": "pergunta",
"frente": "O que são atos normativos?",
"verso": "Atos gerais e abstratos que explicam ou regulamentam a lei, como decretos, regulamentos, instruções normativas e resoluções.",
"explicacao": "Classificação de Hely Lopes Meirelles."
},
{
"id": 2000005909,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Ato administrativo",
"tipo": "pergunta",
"frente": "O que são atos ordinatórios?",
"verso": "Atos que disciplinam o funcionamento da administração e a conduta dos agentes, como portarias, ordens de serviço e circulares.",
"explicacao": "Decorrem do poder hierárquico."
},
{
"id": 2000005910,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Ato administrativo",
"tipo": "pergunta",
"frente": "O que são atos negociais?",
"verso": "Atos que atendem a pedido do particular, como licença, autorização, permissão, aprovação e homologação.",
"explicacao": "Classificação de Hely Lopes Meirelles."
},
{
"id": 2000005911,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Ato administrativo",
"tipo": "pergunta",
"frente": "O que são atos enunciativos?",
"verso": "Atos que certificam ou atestam fatos ou emitem opinião, como certidões, atestados e pareceres.",
"explicacao": "Não têm imperatividade."
},
{
"id": 2000005912,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Ato administrativo",
"tipo": "pares",
"frente": "Qual a diferença entre licença e autorização?",
"verso": "Licença: ato vinculado e definitivo, quando o particular cumpre os requisitos (ex.: licença para construir). Autorização: ato discricionário e precário (ex.: porte de arma).",
"explicacao": "Atos negociais."
},
{
"id": 2000005913,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Ato administrativo",
"tipo": "pares",
"frente": "Qual a diferença entre aprovação e homologação?",
"verso": "Aprovação: controle de mérito (conveniência), prévio ou posterior. Homologação: controle de legalidade, sempre posterior e vinculado.",
"explicacao": "Atos de controle."
},
{
"id": 2000005914,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Poderes",
"tipo": "pergunta",
"frente": "O que é o poder hierárquico?",
"verso": "Poder de distribuir e escalonar funções, ordenar, fiscalizar, delegar, avocar e rever atos dos subordinados.",
"explicacao": "Existe dentro da mesma pessoa jurídica."
},
{
"id": 2000005915,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Poderes",
"tipo": "pergunta",
"frente": "O que é o poder disciplinar?",
"verso": "Poder de apurar infrações e aplicar penalidades aos servidores e às demais pessoas sujeitas à disciplina administrativa, como contratados.",
"explicacao": "Não se confunde com o poder punitivo penal."
},
{
"id": 2000005916,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Poderes",
"tipo": "pergunta",
"frente": "O que é a polícia administrativa e a judiciária?",
"verso": "Administrativa: preventiva, incide sobre bens, direitos e atividades. Judiciária: repressiva, incide sobre pessoas, apurando infrações penais.",
"explicacao": "Distinção doutrinária."
},
{
"id": 2000005917,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Princípios",
"tipo": "pergunta",
"frente": "O que é o princípio da indisponibilidade do interesse público?",
"verso": "O administrador não pode dispor livremente dos bens e interesses públicos, pois age em nome da coletividade.",
"explicacao": "Pilar do regime jurídico-administrativo."
},
{
"id": 2000005918,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Princípios",
"tipo": "pergunta",
"frente": "O que é o princípio da razoabilidade e proporcionalidade?",
"verso": "A atuação administrativa deve ser adequada, necessária e proporcional ao fim buscado, sem excessos.",
"explicacao": "Lei 9.784/1999, art. 2º."
},
{
"id": 2000005919,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Organização",
"tipo": "pergunta",
"frente": "O que é uma autarquia?",
"verso": "Pessoa jurídica de direito público, criada por lei, para executar atividades típicas da administração.",
"explicacao": "Decreto-Lei 200/1967, art. 5º, I. Ex.: INSS."
},
{
"id": 2000005920,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Organização",
"tipo": "pergunta",
"frente": "Como se criam as empresas públicas e sociedades de economia mista?",
"verso": "Lei específica autoriza a criação, que se completa com o registro dos atos constitutivos.",
"explicacao": "CF, art. 37, XIX."
},
{
"id": 2000005921,
"trilha": "administrativa",
"materia": "const",
"assunto": "Nacionalidade",
"tipo": "pergunta",
"frente": "Quem são os brasileiros natos?",
"verso": "Nascidos no Brasil (salvo filhos de estrangeiros a serviço de seu país), nascidos no exterior de pai ou mãe brasileiros a serviço do Brasil, e nascidos no exterior de pai ou mãe brasileiros registrados em repartição competente ou que venham residir no Brasil e optem pela nacionalidade.",
"explicacao": "CF, art. 12, I."
},
{
"id": 2000005922,
"trilha": "administrativa",
"materia": "const",
"assunto": "Direitos políticos",
"tipo": "pergunta",
"frente": "Quais as idades mínimas para os cargos eletivos?",
"verso": "35 anos (Presidente, Vice e Senador), 30 (Governador e Vice), 21 (Deputado, Prefeito, Vice e juiz de paz) e 18 (Vereador).",
"explicacao": "CF, art. 14, § 3º, VI."
},
{
"id": 2000005923,
"trilha": "administrativa",
"materia": "const",
"assunto": "Direitos políticos",
"tipo": "pergunta",
"frente": "Para quem o voto é facultativo?",
"verso": "Analfabetos, maiores de 70 anos e maiores de 16 e menores de 18 anos.",
"explicacao": "CF, art. 14, § 1º, II."
},
{
"id": 2000005924,
"trilha": "administrativa",
"materia": "const",
"assunto": "Organização do Estado",
"tipo": "pergunta",
"frente": "O que é a competência comum?",
"verso": "Competência administrativa compartilhada por União, estados, DF e municípios, como cuidar da saúde e proteger o meio ambiente.",
"explicacao": "CF, art. 23."
},
{
"id": 2000005925,
"trilha": "administrativa",
"materia": "const",
"assunto": "Organização do Estado",
"tipo": "pergunta",
"frente": "O que é a competência concorrente?",
"verso": "Competência legislativa em que a União fixa normas gerais e os estados suplementam, como direito tributário, financeiro e orçamento.",
"explicacao": "CF, art. 24."
},
{
"id": 2000005926,
"trilha": "administrativa",
"materia": "const",
"assunto": "Organização do Estado",
"tipo": "pergunta",
"frente": "Quem tem competência para legislar sobre direito financeiro e orçamento?",
"verso": "União, estados e DF, concorrentemente.",
"explicacao": "CF, art. 24, I e II."
},
{
"id": 2000005927,
"trilha": "administrativa",
"materia": "const",
"assunto": "Administração Pública",
"tipo": "pergunta",
"frente": "Quando a lei pode exigir requisitos diferenciados de admissão ao serviço público?",
"verso": "Quando a natureza do cargo o exigir.",
"explicacao": "CF, art. 39, § 3º."
},
{
"id": 2000005928,
"trilha": "administrativa",
"materia": "const",
"assunto": "Administração Pública",
"tipo": "pergunta",
"frente": "O que é o subsídio?",
"verso": "Parcela única de remuneração, vedado o acréscimo de gratificação, adicional ou outra espécie remuneratória.",
"explicacao": "CF, art. 39, § 4º."
},
{
"id": 2000005929,
"trilha": "administrativa",
"materia": "const",
"assunto": "Administração Pública",
"tipo": "pergunta",
"frente": "A estabilidade se aplica a empregados públicos celetistas?",
"verso": "Não. A estabilidade do art. 41 é dos servidores ocupantes de cargo efetivo.",
"explicacao": "CF, art. 41."
},
{
"id": 2000005930,
"trilha": "administrativa",
"materia": "port",
"assunto": "Sintaxe",
"tipo": "pergunta",
"frente": "O que é o objeto direto preposicionado?",
"verso": "Objeto direto que vem com preposição não exigida pelo verbo, por ênfase ou clareza.",
"explicacao": "Ex.: 'Amar a Deus'."
},
{
"id": 2000005931,
"trilha": "administrativa",
"materia": "port",
"assunto": "Sintaxe",
"tipo": "pares",
"frente": "Qual a diferença entre adjunto adnominal e complemento nominal?",
"verso": "Adjunto: caracteriza o nome, com sentido ativo ou de posse ('a decisão do juiz'). Complemento: completa nome de sentido incompleto, com sentido passivo ('a obediência às leis').",
"explicacao": "Diferença muito cobrada."
},
{
"id": 2000005932,
"trilha": "administrativa",
"materia": "port",
"assunto": "Sintaxe",
"tipo": "pergunta",
"frente": "O que é o agente da passiva?",
"verso": "Termo que pratica a ação na voz passiva, geralmente introduzido por 'por'.",
"explicacao": "Ex.: 'A lei foi aprovada pelo Congresso'."
},
{
"id": 2000005933,
"trilha": "administrativa",
"materia": "port",
"assunto": "Sintaxe",
"tipo": "pergunta",
"frente": "Como passar 'O juiz assinou a sentença' para a voz passiva analítica?",
"verso": "'A sentença foi assinada pelo juiz'.",
"explicacao": "Objeto direto vira sujeito; sujeito vira agente da passiva."
},
{
"id": 2000005934,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Ética no serviço público",
"tipo": "pergunta",
"frente": "Qual decreto aprova o Código de Ética Profissional do Servidor Público Civil do Poder Executivo Federal?",
"verso": "Decreto 1.171/1994.",
"explicacao": "Prevê regras deontológicas, deveres, vedações e comissões de ética."
},
{
"id": 2000005935,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Ética no serviço público",
"tipo": "pergunta",
"frente": "Qual a única pena que a Comissão de Ética pode aplicar pelo Decreto 1.171/1994?",
"verso": "Censura.",
"explicacao": "Decreto 1.171/1994, item XXII."
},
{
"id": 2000005936,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Ética no serviço público",
"tipo": "pergunta",
"frente": "Qual a posição do Decreto 1.171/1994 sobre o servidor deixar alguém esperando?",
"verso": "Deixar qualquer pessoa à espera de solução que compete ao seu setor causa dano moral aos usuários dos serviços públicos e caracteriza atitude contra a ética.",
"explicacao": "Decreto 1.171/1994, item XI."
},
{
"id": 2000005937,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Ética no serviço público",
"tipo": "pergunta",
"frente": "O que diz o Decreto 1.171/1994 sobre a vida privada do servidor?",
"verso": "Os fatos e atos verificados na conduta do dia a dia em sua vida privada poderão acrescer ou diminuir o seu bom conceito na vida funcional.",
"explicacao": "Decreto 1.171/1994, item VI."
},
{
"id": 2000005938,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Ética no serviço público",
"tipo": "pergunta",
"frente": "O que é a Comissão de Ética Pública (CEP)?",
"verso": "Órgão vinculado à Presidência da República que orienta a conduta ética da alta administração federal e coordena o sistema de gestão da ética.",
"explicacao": "Decreto 6.029/2007."
},
{
"id": 2000005939,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Ética no serviço público",
"tipo": "pergunta",
"frente": "O que regula a Lei 12.813/2013?",
"verso": "O conflito de interesses no exercício de cargo ou emprego do Executivo federal e os impedimentos posteriores ao exercício do cargo (quarentena).",
"explicacao": "Lei de Conflito de Interesses."
},
{
"id": 2000005940,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Ética no serviço público",
"tipo": "pergunta",
"frente": "Qual o prazo de quarentena para ocupantes de altos cargos após deixar o cargo?",
"verso": "6 meses.",
"explicacao": "Lei 12.813/2013, art. 6º, II."
},
{
"id": 2000005941,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Servidores",
"tipo": "pergunta",
"frente": "Quais são as indenizações previstas na Lei 8.112/1990?",
"verso": "Ajuda de custo, diárias, transporte e auxílio-moradia.",
"explicacao": "Lei 8.112/1990, art. 51. Não se incorporam ao vencimento."
},
{
"id": 2000005942,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Servidores",
"tipo": "pergunta",
"frente": "O que é a ajuda de custo na Lei 8.112/1990?",
"verso": "Indenização das despesas de instalação do servidor que muda de domicílio em caráter permanente, no interesse do serviço.",
"explicacao": "Lei 8.112/1990, art. 53. Limitada a 3 meses de remuneração."
},
{
"id": 2000005943,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Servidores",
"tipo": "pergunta",
"frente": "Quando o servidor recebe diárias?",
"verso": "Quando se afasta da sede em caráter eventual ou transitório, a serviço, para cobrir pousada, alimentação e locomoção urbana.",
"explicacao": "Lei 8.112/1990, art. 58."
},
{
"id": 2000005944,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Servidores",
"tipo": "pergunta",
"frente": "Qual o adicional do serviço extraordinário na Lei 8.112/1990?",
"verso": "50% em relação à hora normal, limitado a 2 horas por jornada.",
"explicacao": "Lei 8.112/1990, arts. 73 e 74."
},
{
"id": 2000005945,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Servidores",
"tipo": "pergunta",
"frente": "Qual o adicional noturno na Lei 8.112/1990?",
"verso": "25% sobre a hora normal, para trabalho entre 22h e 5h, com hora de 52 minutos e 30 segundos.",
"explicacao": "Lei 8.112/1990, art. 75."
},
{
"id": 2000005946,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Servidores",
"tipo": "pergunta",
"frente": "Qual o adicional de férias do servidor?",
"verso": "1/3 da remuneração do período de férias.",
"explicacao": "Lei 8.112/1990, art. 76, e CF, art. 7º, XVII."
},
{
"id": 2000005947,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Servidores",
"tipo": "pergunta",
"frente": "Qual a duração da licença à gestante na Lei 8.112/1990?",
"verso": "120 dias, prorrogáveis por mais 60 no Programa Empresa Cidadã aplicado ao serviço público federal.",
"explicacao": "Lei 8.112/1990, art. 207, e Decreto 6.690/2008."
},
{
"id": 2000005948,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Servidores",
"tipo": "pergunta",
"frente": "Qual a duração da licença-paternidade do servidor federal?",
"verso": "5 dias, prorrogáveis por mais 15.",
"explicacao": "Lei 8.112/1990, art. 208, e Decreto 8.737/2016."
},
{
"id": 2000005949,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Servidores",
"tipo": "pergunta",
"frente": "Por quanto tempo o servidor pode faltar para doar sangue?",
"verso": "1 dia.",
"explicacao": "Lei 8.112/1990, art. 97, I."
},
{
"id": 2000005950,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Servidores",
"tipo": "pergunta",
"frente": "O que é a vacância do cargo e suas hipóteses?",
"verso": "Desocupação do cargo por exoneração, demissão, promoção, readaptação, aposentadoria, posse em outro cargo inacumulável e falecimento.",
"explicacao": "Lei 8.112/1990, art. 33."
},
{
"id": 2000005951,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Servidores",
"tipo": "pares",
"frente": "Qual a diferença entre exoneração e demissão?",
"verso": "Exoneração: desligamento sem caráter punitivo (a pedido ou de ofício). Demissão: penalidade por infração grave.",
"explicacao": "Lei 8.112/1990, arts. 34 e 132."
},
{
"id": 2000005952,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Servidores",
"tipo": "pergunta",
"frente": "Qual a duração do estágio probatório segundo o STF e a CF?",
"verso": "3 anos, coincidindo com o prazo para adquirir estabilidade.",
"explicacao": "CF, art. 41, e entendimento do STF e STJ (a Lei 8.112 fala em 24 meses)."
},
{
"id": 2000005953,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Servidores",
"tipo": "pergunta",
"frente": "Quais fatores são avaliados no estágio probatório?",
"verso": "Assiduidade, disciplina, capacidade de iniciativa, produtividade e responsabilidade.",
"explicacao": "Lei 8.112/1990, art. 20."
},
{
"id": 2000005954,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Servidores",
"tipo": "pergunta",
"frente": "Quais condutas a Lei 8.112/1990 proíbe ao servidor (exemplos)?",
"verso": "Ausentar-se sem autorização, retirar documentos sem anuência, recusar fé a documentos públicos, valer-se do cargo para proveito pessoal, receber propina e participar de gerência de empresa privada.",
"explicacao": "Lei 8.112/1990, art. 117."
},
{
"id": 2000005955,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Servidores",
"tipo": "pergunta",
"frente": "Quais infrações geram demissão na Lei 8.112/1990 (exemplos)?",
"verso": "Crime contra a administração, abandono de cargo, inassiduidade habitual, improbidade, insubordinação grave, ofensa física em serviço, corrupção e aplicação irregular de dinheiro público.",
"explicacao": "Lei 8.112/1990, art. 132."
},
{
"id": 2000005956,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Processo disciplinar",
"tipo": "pergunta",
"frente": "Quantos servidores compõem a comissão do PAD e quais requisitos?",
"verso": "3 servidores estáveis, designados pela autoridade competente, e o presidente deve ocupar cargo de nível igual ou superior ou ter escolaridade igual ou superior à do indiciado.",
"explicacao": "Lei 8.112/1990, art. 149."
},
{
"id": 2000005957,
"trilha": "administrativa",
"materia": "adm",
"assunto": "Processo disciplinar",
"tipo": "pergunta",
"frente": "Quais as fases do PAD?",
"verso": "Instauração, inquérito administrativo (instrução, defesa e relatório) e julgamento.",
"explicacao": "Lei 8.112/1990, art. 151."
},
{
"id": 2000005958,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Contabilidade pública",
"tipo": "pergunta",
"frente": "O que é o MCASP?",
"verso": "Manual de Contabilidade Aplicada ao Setor Público, editado pela STN, que padroniza os procedimentos contábeis de todos os entes.",
"explicacao": "Alinhado às normas internacionais (IPSAS)."
},
{
"id": 2000005959,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Contabilidade pública",
"tipo": "pergunta",
"frente": "O que é o PCASP?",
"verso": "Plano de Contas Aplicado ao Setor Público, de uso obrigatório por todos os entes.",
"explicacao": "Organiza as contas em classes orçamentárias, patrimoniais e de controle."
},
{
"id": 2000005960,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Contabilidade pública",
"tipo": "pergunta",
"frente": "Qual o regime contábil da contabilidade patrimonial no setor público?",
"verso": "Regime de competência, tanto para receitas quanto para despesas (variações patrimoniais).",
"explicacao": "MCASP. O regime misto da Lei 4.320 vale para o orçamento."
},
{
"id": 2000005961,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Contabilidade pública",
"tipo": "pergunta",
"frente": "O que mostra o balanço orçamentário?",
"verso": "As receitas previstas e realizadas e as despesas fixadas e executadas, comparando previsão e execução.",
"explicacao": "Lei 4.320/1964, art. 102."
},
{
"id": 2000005962,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Contabilidade pública",
"tipo": "pergunta",
"frente": "O que mostra o balanço financeiro?",
"verso": "A receita e a despesa orçamentárias e os recebimentos e pagamentos extraorçamentários, com os saldos em espécie do exercício anterior e do seguinte.",
"explicacao": "Lei 4.320/1964, art. 103."
},
{
"id": 2000005963,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Contabilidade pública",
"tipo": "pergunta",
"frente": "O que mostra a demonstração das variações patrimoniais?",
"verso": "As alterações no patrimônio, resultantes ou independentes da execução orçamentária, e o resultado patrimonial do exercício.",
"explicacao": "Lei 4.320/1964, art. 104."
},
{
"id": 2000005964,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Contabilidade pública",
"tipo": "pergunta",
"frente": "O que é o ativo financeiro na Lei 4.320/1964?",
"verso": "Créditos e valores realizáveis independentemente de autorização orçamentária e os valores numerários.",
"explicacao": "Lei 4.320/1964, art. 105, § 1º."
},
{
"id": 2000005965,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Contabilidade pública",
"tipo": "pergunta",
"frente": "O que é o passivo permanente na Lei 4.320/1964?",
"verso": "Dívidas fundadas e outras que dependam de autorização legislativa para amortização ou resgate.",
"explicacao": "Lei 4.320/1964, art. 105, § 4º."
},
{
"id": 2000005966,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Despesa",
"tipo": "pergunta",
"frente": "O que é a despesa extraorçamentária?",
"verso": "Saída de recursos que não depende de autorização orçamentária, como devolução de cauções e pagamento de restos a pagar.",
"explicacao": "Não consta da LOA."
},
{
"id": 2000005967,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Despesa",
"tipo": "pergunta",
"frente": "O pagamento de restos a pagar é despesa orçamentária?",
"verso": "Não. É despesa extraorçamentária, pois a despesa orçamentária foi registrada no exercício do empenho.",
"explicacao": "Contabilidade pública."
},
{
"id": 2000005968,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Receita",
"tipo": "pergunta",
"frente": "A inscrição de restos a pagar gera qual efeito no balanço financeiro?",
"verso": "Aparece como receita extraorçamentária, compensando a despesa empenhada e não paga.",
"explicacao": "Lei 4.320/1964, art. 103, parágrafo único."
},
{
"id": 2000005969,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Orçamento na CF",
"tipo": "pergunta",
"frente": "Qual o prazo do repasse do Fundo de Participação dos Municípios (FPM)?",
"verso": "Decêndios (a cada 10 dias), pela União.",
"explicacao": "CF, art. 159, I, 'b', e LC 62/1989."
},
{
"id": 2000005970,
"trilha": "administrativa",
"materia": "afo",
"assunto": "Orçamento na CF",
"tipo": "pergunta",
"frente": "Quais percentuais do IR e do IPI a União entrega ao FPM e ao FPE?",
"verso": "FPM: 22,5% + 1% (dezembro) + 1% (julho) + 1% (setembro). FPE: 21,5%.",
"explicacao": "CF, art. 159, I, com as EC 55/2007, 84/2014 e 112/2021."
},
{
"id": 2000005971,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Administração pública",
"tipo": "pergunta",
"frente": "O que é o contrato de gestão na administração pública?",
"verso": "Acordo entre a administração e órgãos ou entidades que amplia sua autonomia em troca do cumprimento de metas de desempenho.",
"explicacao": "CF, art. 37, § 8º, e Lei 13.934/2019."
},
{
"id": 2000005972,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Administração pública",
"tipo": "pergunta",
"frente": "O que é a transparência pública?",
"verso": "Disponibilização de informações sobre a gestão pública aos cidadãos, de forma ativa e passiva.",
"explicacao": "LRF e Lei de Acesso à Informação."
},
{
"id": 2000005973,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Administração pública",
"tipo": "pergunta",
"frente": "O que é a responsividade (responsiveness)?",
"verso": "Capacidade de o governo responder às demandas e preferências dos cidadãos.",
"explicacao": "Conceito ligado à accountability."
},
{
"id": 2000005974,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Gestão de pessoas",
"tipo": "pergunta",
"frente": "O que é qualidade de vida no trabalho (QVT)?",
"verso": "Conjunto de ações para melhorar as condições físicas, psicológicas e sociais do trabalho.",
"explicacao": "Modelo de Walton tem 8 dimensões."
},
{
"id": 2000005975,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Gestão de pessoas",
"tipo": "pergunta",
"frente": "O que é o plano de cargos e salários?",
"verso": "Estrutura que define cargos, faixas salariais e critérios de progressão, buscando equilíbrio interno e externo.",
"explicacao": "Instrumento de remuneração."
},
{
"id": 2000005976,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Gestão de pessoas",
"tipo": "pergunta",
"frente": "O que é a avaliação por objetivos?",
"verso": "Avaliação baseada no alcance de metas previamente negociadas entre gestor e avaliado.",
"explicacao": "Relacionada à APO."
},
{
"id": 2000005977,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Comunicação",
"tipo": "pergunta",
"frente": "O que é a comunicação descendente, ascendente e horizontal?",
"verso": "Descendente: da chefia para os subordinados. Ascendente: dos subordinados para a chefia. Horizontal: entre pessoas do mesmo nível.",
"explicacao": "Fluxos de comunicação."
},
{
"id": 2000005978,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Comunicação",
"tipo": "pergunta",
"frente": "O que é o ruído na comunicação?",
"verso": "Qualquer interferência que distorce a mensagem entre emissor e receptor.",
"explicacao": "Pode ser físico, semântico ou psicológico."
},
{
"id": 2000005979,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Comunicação",
"tipo": "pergunta",
"frente": "O que é a escuta ativa?",
"verso": "Ouvir com atenção plena, demonstrando interesse e verificando o entendimento.",
"explicacao": "Habilidade de comunicação e atendimento."
},
{
"id": 2000005980,
"trilha": "administrativa",
"materia": "gest",
"assunto": "Atendimento",
"tipo": "pergunta",
"frente": "Quais os direitos básicos do usuário na Lei 13.460/2017 (exemplos)?",
"verso": "Participação no acompanhamento do serviço, liberdade de escolha entre os meios oferecidos, acesso e obtenção de informações, proteção de suas informações pessoais e atuação integrada dos órgãos.",
"explicacao": "Lei 13.460/2017, art. 6º."
},
{
"id": 2000005981,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Gestão documental",
"tipo": "pergunta",
"frente": "Qual o prazo de guarda do documento na fase corrente após o arquivamento?",
"verso": "O definido na tabela de temporalidade para cada tipo documental.",
"explicacao": "Não há prazo único: depende da tabela."
},
{
"id": 2000005982,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Gestão documental",
"tipo": "pergunta",
"frente": "O que é o arquivamento vertical?",
"verso": "Os documentos ou fichas ficam uns atrás dos outros, permitindo consulta rápida sem retirar os demais.",
"explicacao": "Forma de arquivamento mais comum em pastas suspensas."
},
{
"id": 2000005983,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Gestão documental",
"tipo": "pergunta",
"frente": "O que é o arquivamento horizontal?",
"verso": "Os documentos ficam uns sobre os outros, indicado para mapas, plantas e documentos de grandes dimensões.",
"explicacao": "Usado em mapotecas."
},
{
"id": 2000005984,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Gestão documental",
"tipo": "pergunta",
"frente": "O que é a mapoteca?",
"verso": "Móvel com gavetas largas e rasas para guardar mapas, plantas e documentos de grande formato na horizontal.",
"explicacao": "Mobiliário de arquivo."
},
{
"id": 2000005985,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Legislação",
"tipo": "pergunta",
"frente": "Qual decreto trata dos procedimentos de gestão de documentos e da CPAD no Executivo federal?",
"verso": "Decreto 10.148/2019.",
"explicacao": "Institui a Comissão de Coordenação do SIGA e trata das CPADs."
},
{
"id": 2000005986,
"trilha": "administrativa",
"materia": "arq",
"assunto": "Legislação",
"tipo": "pergunta",
"frente": "O que é o Arquivo Nacional?",
"verso": "Órgão central do SIGA, responsável pela gestão e recolhimento dos documentos do Executivo federal e pela preservação do patrimônio documental.",
"explicacao": "Vinculado ao Ministério da Gestão e da Inovação em Serviços Públicos."
},
{
"id": 2000005987,
"trilha": "administrativa",
"materia": "const",
"assunto": "Funções essenciais",
"tipo": "pergunta",
"frente": "Quem representa a União judicial e extrajudicialmente?",
"verso": "A Advocacia-Geral da União.",
"explicacao": "CF, art. 131. Na execução da dívida ativa tributária, a Procuradoria-Geral da Fazenda Nacional."
},
{
"id": 2000005988,
"trilha": "administrativa",
"materia": "const",
"assunto": "Funções essenciais",
"tipo": "pergunta",
"frente": "Quais as garantias dos membros do Ministério Público?",
"verso": "Vitaliciedade (após 2 anos), inamovibilidade e irredutibilidade de subsídio.",
"explicacao": "CF, art. 128, § 5º, I."
},
{
"id": 2000005989,
"trilha": "administrativa",
"materia": "const",
"assunto": "Defesa do Estado",
"tipo": "pergunta",
"frente": "Quem autoriza o estado de sítio?",
"verso": "O Congresso Nacional, por maioria absoluta, a pedido do Presidente da República.",
"explicacao": "CF, art. 137, parágrafo único. No estado de defesa, o Congresso aprecia depois do decreto."
},
{
"id": 2000005990,
"trilha": "administrativa",
"materia": "port",
"assunto": "Ortografia",
"tipo": "pergunta",
"frente": "Qual a diferença entre 'a par' e 'ao par'?",
"verso": "'A par': ciente, informado. 'Ao par': equivalência cambial.",
"explicacao": "Ex.: 'Estou a par do assunto'."
},
{
"id": 2000005991,
"trilha": "administrativa",
"materia": "port",
"assunto": "Ortografia",
"tipo": "pergunta",
"frente": "Qual a forma correta: 'excessão' ou 'exceção'?",
"verso": "'Exceção'.",
"explicacao": "Ortografia: exceção, excesso, exceto."
},
{
"id": 2000005992,
"trilha": "administrativa",
"materia": "port",
"assunto": "Pontuação",
"tipo": "pergunta",
"frente": "Usa-se vírgula para isolar adjunto adverbial deslocado?",
"verso": "Sim, especialmente se longo. Se curto, a vírgula é facultativa.",
"explicacao": "Ex.: 'No final do ano, os servidores entram em recesso'."
},
{
"id": 2000005993,
"trilha": "administrativa",
"materia": "port",
"assunto": "Pontuação",
"tipo": "pergunta",
"frente": "Usa-se vírgula antes de oração adjetiva explicativa?",
"verso": "Sim, a oração adjetiva explicativa vem entre vírgulas.",
"explicacao": "Ex.: 'O Brasil, que é um país grande, tem muitos estados'."
},
{
"id": 2000005994,
"trilha": "administrativa",
"materia": "inf",
"assunto": "Excel",
"tipo": "pergunta",
"frente": "O que faz a função MÁXIMO no Excel?",
"verso": "Retorna o maior valor de um intervalo.",
"explicacao": "MÍNIMO retorna o menor."
},
{
"id": 2000005995,
"trilha": "administrativa",
"materia": "inf",
"assunto": "Excel",
"tipo": "pergunta",
"frente": "O que faz a função HOJE no Excel?",
"verso": "Retorna a data atual.",
"explicacao": "AGORA retorna data e hora."
},
{
"id": 2000005996,
"trilha": "administrativa",
"materia": "inf",
"assunto": "Excel",
"tipo": "pergunta",
"frente": "O que é a formatação condicional no Excel?",
"verso": "Recurso que muda a aparência das células conforme regras definidas, como destacar valores negativos em vermelho.",
"explicacao": "Guia Página Inicial."
},
{
"id": 2000005997,
"trilha": "administrativa",
"materia": "inf",
"assunto": "Excel",
"tipo": "pergunta",
"frente": "O que é a tabela dinâmica no Excel?",
"verso": "Ferramenta que resume, agrupa e analisa grandes volumes de dados de forma interativa.",
"explicacao": "Guia Inserir."
},
{
"id": 2000005998,
"trilha": "administrativa",
"materia": "rl",
"assunto": "Matemática",
"tipo": "pergunta",
"frente": "Qual a média aritmética de 6, 8 e 10?",
"verso": "8.",
"explicacao": "(6 + 8 + 10) / 3 = 8."
},
{
"id": 2000005999,
"trilha": "administrativa",
"materia": "rl",
"assunto": "Matemática",
"tipo": "pergunta",
"frente": "Qual a mediana de 3, 7, 9, 12 e 15?",
"verso": "9.",
"explicacao": "Valor central do conjunto ordenado."
},
{
"id": 2000006000,
"trilha": "administrativa",
"materia": "rl",
"assunto": "Matemática",
"tipo": "pergunta",
"frente": "Qual a moda do conjunto 2, 3, 3, 5, 7, 3, 8?",
"verso": "3.",
"explicacao": "Valor que mais se repete."
}
]$c$::jsonb) as x(id integer, trilha text, materia text, assunto text, tipo text, frente text, verso text, explicacao text)
on conflict (id) do update set trilha = excluded.trilha, materia = excluded.materia, assunto = excluded.assunto, tipo = excluded.tipo,
  frente = excluded.frente, verso = excluded.verso, explicacao = excluded.explicacao, ativa = true, atualizado_em = now();

select trilha, count(*) as cartoes, public.cartoes_versao() as versao from public.cartoes where ativa group by trilha;
