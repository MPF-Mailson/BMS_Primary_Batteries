
# BMS_Primary_Batteries

Esse repositório terá como finalidade reunir arquivos de apoio, tais como modelos de simulação, códigos, tabelas de parâmetros, esquemáticos, resultados intermediários e demais documentos utilizados durante a elaboração do estudo.

# Sumário

1. [Dispositivos de referência](#dispositivos-de-referência)
   1. [Proteção contra autocarregamento](#proteção-contra-autocarregamento)
   2. [Contador de coulomb](#contador-de-coulomb)
   3. [Proteção contra sobreaquecimento](#proteção-contra-sobreaquecimento)
   4. [Proteção contra sobrecarga](#proteção-contra-sobrecarga)
   5. [Datasheets](Datasheets/)

2. [Modelo de simulação da bateria](#modelo-de-simulação-da-bateria)
    1. [Funcionamento do modelo equivalente no Simulink](#funcionamento-do-modelo-equivalente-no-simulink)
    2. [Porta térmica e modelagem da temperatura](#porta-térmica-e-modelagem-da-temperatura)
    3. [Célula de referência](#célula-de-referência)
    4. [Configuração simulada](#configuração-simulada)
    5. [Referências](#arquivos-e-referências-relacionados)

3. [Modelos das proteções](#modelos-das-proteções)
   1. [Modelo da proteção contra autocarregamento](#modelo-da-proteção-contra-autocarregamento)
   2. [Modelo do Coulomb Counter](#modelo-do-coulomb-counter)
   3. [Modelo da proteção contra sobreaquecimento](#modelo-da-proteção-contra-sobreaquecimento)
   4. [Modelo da proteção contra sobrecarga](#modelo-da-proteção-contra-sobrecarga)

4. [Parâmetros da simulação](#parâmetros-da-simulação)

<br/>

# Dispositivos de referência.


## Proteção contra autocarregamento 
No projeto, foi utilizado o diodo Schottky [RBS2MM40B](Datasheets/RBS2MM40B.pdf), da ROHM, com a função de impedir a circulação de corrente entre células quando suas tensões estiverem desniveladas. Para isso, é necessário utilizar um diodo em cada ramo série do conjunto, evitando o autocarregamento ou a transferência indesejada de energia entre ramos com diferentes potenciais.

Como a validação foi realizada por simulação, o principal parâmetro considerado foi a tensão direta do diodo, utilizada para representar a queda de tensão durante a condução. Para o RBS2MM40B, o datasheet indica uma queda de tensão direta típica de 0,37 V para corrente de 2 A.
## Contador de coulomb
 No projeto, foi utilizado o Coulomb Counter [LTC2959](Datasheets/LTC2959.pdf), selecionado por ser um medidor de carga de ultrabaixo consumo. Segundo o datasheet, o componente possui faixa de alimentação de 1,8 V a 60 V, mede carga, tensão, corrente e temperatura, e apresenta precisão de 1% para tensão, corrente e carga. Além disso, sua corrente de alimentação pode ficar abaixo de 1 µA com a medição de Coulomb ativa e o ADC desligado.
 
Na simulação, o consumo do circuito foi representado por uma fonte de corrente drenando 8 mA do conjunto de baterias, permitindo considerar seu impacto energético. Entretanto, os erros associados à medição foram desconsiderados, sendo utilizado o medidor de coulomb ideal do simulink, assim o componente acabou sendo modelado apenas pelo consumo elétrico no sistema.
## Proteção contra sobreaquecimento 
No projeto, foi utilizado o thermal switch [MCP9502](Datasheets/MCP9501.pdf) como elemento de proteção térmica do conjunto de baterias. A escolha desse componente está associada ao seu baixo consumo e à simplicidade de implementação, pois ele possui limiar de temperatura definido de fábrica e por conta de ser do tipo push-pull, não exige tensões externas para o acionamento da saída. No circuito proposto, foi considerada a versão com atuação em temperatura elevada, configurada para TSET = 55 °C e histerese de 2 °C. Segundo o datasheet, o MCP9502 opera entre 2,7 V e 5,5 V e apresenta corrente típica de alimentação de 25 µA. 

Para alimentar o thermal switch, foi considerado o uso de um LDO, responsável por fornecer uma tensão de 3,3 V ao componente. Na simulação, o consumo associado ao LDO foi representado por uma fonte de corrente drenando corrente do conjunto de baterias, sem modelar internamente os detalhes elétricos do regulador.

Além disso, o thermal switch foi representado considerando dois estados de consumo: um consumo quando o dispositivo se encontra desativado e outro quando está ativado. Esses dois valores foram inseridos na simulação por meio de fontes de corrente, permitindo representar a variação do consumo do circuito de proteção térmica conforme sua condição de operação.

 
## Proteção contra sobrecarga
No projeto, foi utilizado um fusível rearmável do tipo PPTC da série 0ZCJ, aplicado como proteção contra corrente excessiva e condição de curto-circuito externo. A escolha desse tipo de componente está associada à sua capacidade de aumentar significativamente a resistência quando a corrente ultrapassa o limite de atuação, reduzindo a corrente no circuito sem exigir substituição após a remoção da falha.

Segundo o datasheet do [0ZCJ0110AF2C](Datasheets/0ZCJ0110AF2C.pdf), esses dispositivos possuem faixa de corrente de retenção entre 50 mA e 2 A, faixa de temperatura de operação de -40 °C a 85 °C e são destinados a aplicações de proteção contra sobrecorrente. Na simulação, o PPTC foi representado por uma resistência variável, alternando entre uma resistência inicial baixa e uma resistência elevada após a atuação, permitindo demonstrar a limitação da corrente durante o curto-circuito. Os valores de resistência foram calculados a partir das fórmulas do datasheet.

# Modelo de simulação da bateria

## Funcionamento do modelo equivalente no Simulink

O modelo da bateria foi desenvolvido no MATLAB/Simulink utilizando a biblioteca Simscape. A bateria foi representada por meio de um modelo elétrico equivalente, no qual o comportamento da célula é aproximado por uma fonte de tensão dependente do estado de carga, uma resistência interna e elementos dinâmicos associados à resposta transitória da bateria.

Esse tipo de modelo é útil para simulações em nível de sistema, pois permite representar o comportamento elétrico da bateria sem a necessidade de modelar diretamente todos os fenômenos eletroquímicos internos da célula. No Simscape, modelos equivalentes de bateria podem representar a tensão terminal a partir de parâmetros como estado de carga, resistência interna, temperatura e, dependendo da configuração utilizada, ramos RC associados à dinâmica de polarização da célula. A própria documentação da MathWorks descreve os modelos equivalentes como estruturas baseadas em resistores, capacitores e fontes de tensão para reproduzir o comportamento dinâmico de uma célula, sendo adequados para projeto de BMS e simulações em nível de sistema.

No modelo utilizado neste projeto, a bateria foi configurada para representar uma associação 3S4P. Assim, cada célula contribui para o comportamento elétrico do conjunto, enquanto a associação em série eleva a tensão total e a associação em paralelo aumenta a capacidade disponível. A tensão terminal do conjunto varia conforme a descarga, o estado de carga e a queda de tensão provocada pela resistência interna.

Como o objetivo do estudo é avaliar proteções para baterias primárias, o modelo foi utilizado apenas em condição de descarga. As partes associadas ao processo de carregamento não foram consideradas, mesmo a célula de referência sendo uma célula recarregável. Dessa forma, o modelo foi empregado como uma aproximação elétrica para permitir a validação das proteções propostas em condições de falha e operação.

## Porta térmica e modelagem da temperatura

Além do comportamento elétrico, o modelo também utiliza a interface térmica da bateria. No Simscape, alguns blocos de bateria permitem habilitar a porta térmica, normalmente identificada como porta `H`, para conectar a célula a uma rede térmica. Essa porta permite representar os efeitos térmicos associados à bateria e sua interação com o ambiente ou com outros elementos térmicos do sistema. A documentação da MathWorks indica que, ao habilitar a porta térmica, ela deve ser conectada à rede térmica do modelo, permitindo representar baterias com sensor de temperatura ou validar algoritmos de estimação térmica. 

Neste projeto, as interfaces térmicas das células foram conectadas entre si, formando uma rede térmica comum para o conjunto de baterias. Essa abordagem foi adotada para simplificar a representação térmica do pack, considerando que as células estão submetidas a uma condição térmica equivalente durante a simulação.

Para representar a massa térmica do conjunto, foram utilizados os dados físicos das células, como massa e propriedades térmicas adotadas no modelo. A partir desses valores, foram criadas as massas térmicas responsáveis por armazenar energia térmica durante o aquecimento. No Simscape, a massa térmica associada à porta térmica representa a energia necessária para elevar a temperatura do elemento em um grau, o que permite aproximar o comportamento térmico do conjunto durante os ensaios simulados.

Dessa forma, a variação de temperatura aplicada ao conjunto de baterias não atua apenas como um sinal isolado, mas como parte de uma rede térmica conectada às células. Essa configuração permite avaliar a atuação da proteção térmica, como o thermal switch MCP9502, a partir da temperatura representada no pack durante a simulação.


Para modelar as células/bateria primária, foi utilizado um modelo de circuito elétrico equivalente de bateria no ambiente MATLAB/Simulink com a biblioteca Simscape. Devido à dificuldade de encontrar modelos específicos de células primárias disponíveis para simulação, foi adotada como referência uma célula comercial de íon-lítio Panasonic NCA843436, utilizando seus dados elétricos principais para parametrizar o modelo.

A célula Panasonic NCA843436 é uma bateria prismática de íon-lítio com química NCA, tensão nominal de 3,6 V e capacidade típica de 1,3 Ah. Segundo o datasheet, sua capacidade mínima é de 1,275 Ah, com massa aproximada de 23 g. Essa célula foi utilizada como referência por possuir modelo de simulção dentro do Simulink com parte elétrica e de temperatura.

A configuração adotada no estudo foi de 3 células em série e 4 ramos em paralelo, formando um conjunto 3S4P. Dessa forma, a tensão nominal aproximada do conjunto é de 10,8 V, enquanto a capacidade equivalente considerada é de aproximadamente 5,2 Ah, obtida pela associação de quatro ramos em paralelo.

Embora a célula de referência seja recarregável, o estudo tem foco em baterias primárias. Por esse motivo, as partes do modelo relacionadas ao carregamento não foram utilizadas. A bateria foi analisada apenas em condições de descarga e falha, de forma compatível com a proposta de avaliar circuitos de proteção para baterias não recarregáveis.

### Célula de referência

| Parâmetro | Valor |
|---|---:|
| Modelo | Panasonic NCA843436 |
| Tipo | Célula prismática de íon-lítio |
| Química | NCA |
| Tensão nominal | 3,6 V |
| Capacidade mínima | 1,275 Ah |
| Capacidade típica | 1,3 Ah |
| Massa aproximada | 23 g |
| Aplicação no estudo | Referência para parametrização do modelo equivalente |


### Configuração simulada

| Parâmetro | Valor |
|---|---:|
| Configuração | 3S4P |
| Número total de células | 12 |
| Células em série | 3 |
| Ramos em paralelo | 4 |
| Tensão nominal aproximada do conjunto | 10,8 V |
| Capacidade equivalente aproximada | 5,2 Ah |

### Arquivos e referências relacionados

| Tipo de arquivo | Referência |
|---|---|
| Datasheet da célula | [NCA843436](Datasheets/nca843436.pdf) |
| Referência do modelo MATLAB/Simscape | [Battery (Table-Based) — MathWorks](https://www.mathworks.com/help/sps/ref/batterytablebased.html) |
| Referência sobre modelo equivalente de bateria | [Battery Equivalent Circuit — MathWorks](https://www.mathworks.com/help/simscape-battery/ref/batteryequivalentcircuit.html) |

### Imagem do modelo
![Modelo da bateria 3S4P](Matlab_Model/Imagens/Modelo_bateria.png)




