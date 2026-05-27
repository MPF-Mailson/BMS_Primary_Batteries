%% =========================================================
% PARAMETROS CORRIDOS PARA USAR NOS MATLAB FUNCTION BLOCKS
%% =========================================================

%% PPTC / FUSIVEL REARMAVEL

R_inicial = 0.18;      % resistencia antes do trip [ohm]
R_trip    = 64.8;      % resistencia apos trip [ohm]

I_hold = [];           % corrente de hold [A]
I_trip = [];           % corrente de trip [A]
V_max  = [];           % tensao maxima [V]
I_max  = [];           % corrente maxima de falha [A]
Pd     = [];           % potencia dissipada [W]
R_min  = [];           % resistencia minima [ohm]
R_1max = [];           % resistencia maxima apos trip/soldagem [ohm]
T_ref  = [];           % temperatura de referencia [°C]

t_table = [ ...
93.22913720326267
76.76994539782535
62.18037806989684
50.73924610658234
40.551956310657374
32.47105757893063
26.394517987673122
21.585638860876912
17.363554643854652
13.998100573118215
11.503782619684877
9.6182874936426
7.983843646586587
6.543613910411737
5.5305799940213305
4.488841150019213
3.6811395220661125
3.0691035345829945
2.56588785048197
2.1334076155712065
1.786100804914066
1.4683937565737588
1.2222745996874582
1.0168559863924436
0.8443375099989755
0.7033060413781054
0.5859857233026248
0.48708820535544833
0.4065589224048396
0.3407490743059701
0.2843835543114932
0.23625622882498806
0.19856152744411365
0.16642029713466136
0.1394817800552231
0.11666242960936553
0.09757634636560927
0.08127608636241797
0.0680495323487456
0.057152335923816404
0.04766007172959659
0.039449150411942316
0.03286346213468454
0.027626437860520422
0.023101621650046852
0.01919204513775635
0.01601750355823144
0.013331270233922363
0.011136380504649084];

I_table = [ ...
1.6305773075253425
1.6641238044324276
1.7052918629865883
1.7417937517985849
1.7886258712321217
1.8290387302732178
1.8727604066578145
1.9190898383226047
1.9745913964198063
2.030043786451421
2.08074839923658
2.124792382454141
2.1773567271160714
2.223963196590481
2.2771252196593186
2.3429814370962196
2.4009434689695563
2.4603393991596647
2.5212047002736413
2.5941198845202935
2.680037217167277
2.7801002397411274
2.8956691093155515
3.0283513374238993
3.1800388991540705
3.3529529074977225
3.564184446636887
3.8041859339032715
4.060348401262711
4.333760080628025
4.64446053978823
4.997750113488696
5.356054040365019
5.716714650053633
6.1016610631341965
6.512528612744141
6.951062750448019
7.419126461281963
7.918708178105067
8.451930228879391
9.057874848343024
9.746879032228112
10.48829360744223
11.240231319501063
12.046077736252805
12.962385159202181
13.948393219299641
15.00940382581401
16.151122187654533];

I_min_tabela = min(I_table);
I_max_tabela = max(I_table);
t_min_tabela = min(t_table);
t_max_tabela = max(t_table);


%% MCP9502 / THERMAL SWITCH

VDD   = 3.3;       % tensao de alimentacao [V]
TSET  = 55;        % temperatura de atuacao [°C]
HYST  = 2;         % histerese [°C]
IDD   = 25e-6;     % corrente de consumo do CI [A]
Iload = 0;         % corrente da carga na saida [A]

OUT_normal = 3.3;  % saida em temperatura normal [V]
OUT_trip   = 0;    % saida com protecao ativa [V]

modelo_exato = 'MCP9502';
tipo_saida = 'push-pull';
tipo_acionamento = 'hot';

TSET_datasheet = [];
precisao_tipica = [];
precisao_maxima = [];
VDD_min = [];
VDD_max = [];
T_operacao_min = [];
T_operacao_max = [];


%% LDO / 
Ildo = -0.00007;
SOC_inicial = 1;

%% Coulomb counter / 
Icc = -0.000008;

%% Mosfet / 
Rds_on = 0.180;

%% Diode
V_direta = 0.37;
%% Paramêtros do teste da UN38.3

%Teste de curto circuito
Inicio_do_curto = 10; %segundos
R_curto = 0.5; %Resistência curto
tempo_simu_curto = 70;
%Teste de temperatura
Tempo_de_teste = [0 3600 7200 10800 14400 18000];
Valores_Temperatura = [25 60 60 -10 -10 25];
tempo_simu_temp = 50000;

%Teste de descarga
Inicio_da_descarga = 1000; %segundos
V_BATT_TOTAL = 12.15;
corrente_Max_bat = 3;
R_descarga = (V_BATT_TOTAL+12)/corrente_Max_bat;
tempo_simu_descarga = 20;
%% CONFIRMACAO

disp('Parametros corridos carregados no workspace.')