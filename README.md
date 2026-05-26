
# BMS_Primary_Batteries

Esse repositório terá como finalidade reunir arquivos de apoio, tais como modelos de simulação, códigos, tabelas de parâmetros, esquemáticos, resultados intermediários e demais documentos utilizados durante a elaboração do estudo.



## Dispositivos de referência.

## Proteção contra autocarregamento 
No projeto, foi utilizado o diodo Schottky RBS2MM40BTR, da ROHM, com a função de impedir a circulação de corrente entre células quando suas tensões estiverem desniveladas. Para isso, é necessário utilizar um diodo em cada ramo série do conjunto, evitando o autocarregamento ou a transferência indesejada de energia entre ramos com diferentes potenciais.

Como a validação foi realizada por simulação, o principal parâmetro considerado foi a tensão direta do diodo, utilizada para representar a queda de tensão durante a condução. Para o RBS2MM40B, o datasheet indica uma queda de tensão direta típica de 0,37 V para corrente de 2 A.
## Contador de coulomb
 No projeto, foi utilizado o Coulomb Counter LTC2959, selecionado por ser um medidor de carga de ultrabaixo consumo. Segundo o datasheet, o componente possui faixa de alimentação de 1,8 V a 60 V, mede carga, tensão, corrente e temperatura, e apresenta precisão de 1% para tensão, corrente e carga. Além disso, sua corrente de alimentação pode ficar abaixo de 1 µA com a medição de Coulomb ativa e o ADC desligado.
 
Na simulação, o consumo do circuito foi representado por uma fonte de corrente drenando 8 mA do conjunto de baterias, permitindo considerar seu impacto energético. Entretanto, os erros associados à medição foram desconsiderados, sendo utilizado o medidor de coulomb ideal do simulink, assim o componente acabou sendo modelado apenas pelo consumo elétrico no sistema.
## Proteção contra sobreaquecimento 
No projeto, foi utilizado o thermal switch MCP9502 como elemento de proteção térmica do conjunto de baterias. A escolha desse componente está associada ao seu baixo consumo e à simplicidade de implementação, pois ele possui limiar de temperatura definido de fábrica e por conta de ser do tipo push-pull, não exige tensões externas para o acionamento da saída. No circuito proposto, foi considerada a versão com atuação em temperatura elevada, configurada para TSET = 55 °C e histerese de 2 °C. Segundo o datasheet, o MCP9502 opera entre 2,7 V e 5,5 V e apresenta corrente típica de alimentação de 25 µA. 

Para alimentar o thermal switch, foi considerado o uso de um LDO, responsável por fornecer uma tensão de 3,3 V ao componente. Na simulação, o consumo associado ao LDO foi representado por uma fonte de corrente drenando corrente do conjunto de baterias, sem modelar internamente os detalhes elétricos do regulador.

Além disso, o thermal switch foi representado considerando dois estados de consumo: um consumo quando o dispositivo se encontra desativado e outro quando está ativado. Esses dois valores foram inseridos na simulação por meio de fontes de corrente, permitindo representar a variação do consumo do circuito de proteção térmica conforme sua condição de operação.

 
## Proteção contra sobrecarga
No projeto, foi utilizado um fusível rearmável do tipo PPTC da série 0ZCJ, aplicado como proteção contra corrente excessiva e condição de curto-circuito externo. A escolha desse tipo de componente está associada à sua capacidade de aumentar significativamente a resistência quando a corrente ultrapassa o limite de atuação, reduzindo a corrente no circuito sem exigir substituição após a remoção da falha.

Segundo o datasheet do 0ZCJ0110AF2C, esses dispositivos possuem faixa de corrente de retenção entre 50 mA e 2 A, faixa de temperatura de operação de -40 °C a 85 °C e são destinados a aplicações de proteção contra sobrecorrente. Na simulação, o PPTC foi representado por uma resistência variável, alternando entre uma resistência inicial baixa e uma resistência elevada após a atuação, permitindo demonstrar a limitação da corrente durante o curto-circuito. Os valores de resistência foram calculados a partir das fórmulas do datasheet.
## Documentation

[RBS2MM40B](https://fscdn.rohm.com/en/products/databook/datasheet/discrete/diode/schottky_barrier/rbs2mm40btr-e.pdf)

[LTC2959](https://www.analog.com/media/en/technical-documentation/data-sheets/ltc2959.pdf)

[MCP9501](https://br.mouser.com/datasheet/3/282/1/22268a.pdf)

[0ZCJ0110AF2C](https://br.mouser.com/datasheet/3/191/1/ds_cp_0zcj_series.pdf)
## Screenshots

![App Screenshot](https://dummyimage.com/468x300?text=App+Screenshot+Here)

