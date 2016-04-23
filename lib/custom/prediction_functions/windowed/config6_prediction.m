function [Y,Xf,Af] = myNeuralNetworkFunction(X,~,~)
%MYNEURALNETWORKFUNCTION neural network simulation function.
%
% Generated by Neural Network Toolbox function genFunction, 23-Apr-2016 16:13:43.
%
% [Y] = myNeuralNetworkFunction(X,~,~) takes these arguments:
%
%   X = 1xTS cell, 1 inputs over TS timesteps
%   Each X{1,ts} = 78xQ matrix, input #1 at timestep ts.
%
% and returns:
%   Y = 1xTS cell of 1 outputs over TS timesteps.
%   Each Y{1,ts} = 16xQ matrix, output #1 at timestep ts.
%
% where Q is number of samples (or series) and TS is the number of timesteps.

%#ok<*RPMT0>

% ===== NEURAL NETWORK CONSTANTS =====

% Input 1
x1_step1.xoffset = [-135.176487777073;-55.0493334251305;-50.4126585788092;-56.3837973809194;-67.1252471807653;-74.6819652521388;-61.1582023442947;-55.2595855075458;-56.1262315848604;-60.4303017839441;-53.5075787425292;-48.0405674903772;-57.9220460343185;-1176.41399524996;-515.447124583847;-551.638841056057;-532.907377570439;-581.822628738228;-537.960128684038;-500.213939272131;-555.050647162147;-462.757902779357;-507.331191868366;-510.967142804043;-595.075750399853;-586.553392139791;-1211.77299283159;-453.375095593034;-576.030651883212;-630.284663121713;-700.948354735559;-558.63159916871;-614.387533831307;-583.343240387782;-674.075429346835;-740.689088188396;-651.755002077447;-599.731929660688;-644.499937028958;2.54120048367046;-2.03504672408367;-1.87426365127368;-1.57720887523134;-1.92170944469349;-1.60597660957236;-1.43384647528452;-1.10435082286105;-0.972822750009611;-0.866597735103548;-0.808092022229876;-0.630061143021204;-0.588504404031653;-35.500607902939;-17.7388641285803;-17.3221025950415;-18.4961941761686;-15.7747290381753;-16.3031467750274;-12.5301887765836;-9.25213665947415;-10.5953004247194;-8.41147352616353;-8.36390936532343;-7.16408614228705;-6.32214773982597;-44.2529726093522;-15.3216276256731;-21.2472464625602;-18.1733433429458;-17.9321543160294;-17.0056712290096;-15.7806632700713;-16.1604064446794;-11.3068351129404;-12.8413863386564;-9.59143447161801;-10.5788481175678;-8.18776156262877];
x1_step1.gain = [0.00729892809695758;0.0209282587667374;0.0167701603670951;0.0181268817723119;0.0160885382039252;0.0169294005280584;0.0175069115223676;0.0198029028404169;0.0174874260004666;0.0166689139871039;0.0159651086917116;0.017160013732096;0.0175455894809691;0.000793031076221939;0.00196242477493039;0.00185125206637123;0.00198300558905037;0.00192224014471224;0.00201711798465831;0.00196550847578261;0.00192399603943744;0.00221576237843555;0.00198548448364608;0.00189947737956524;0.00167591178482144;0.00175157742349282;0.000759830517700488;0.00215087158111345;0.00173237842934559;0.00174259556649249;0.00138543557213057;0.00159639537268947;0.00153085018234227;0.00171666625919629;0.00160554111250249;0.001504014674575;0.00155682987201962;0.00160419531834449;0.00164048125103596;0.340238041000728;0.620299675612061;0.604269411554448;0.618638725053551;0.65521434501113;0.726344487889811;0.785310209556758;0.997940135035902;1.03137243750718;1.11346992487043;1.33251328129367;1.55857794406259;1.67798425347715;0.0240531104671832;0.0556675018999767;0.0566468855295643;0.0595632569638012;0.0692883350279294;0.0657993480736311;0.0814110348414213;0.106421492456055;0.100379830815835;0.11472153910073;0.117711141324675;0.141273425828946;0.165143260333301;0.0200088133175797;0.0622342190959826;0.0474809101812465;0.0547448528677565;0.0527977889340674;0.0561802724702075;0.0658277898214678;0.0694166810500238;0.0884170079610314;0.0828334969953197;0.107546237759589;0.0991480074736809;0.124398040032304];
x1_step1.ymin = -1;

% Layer 1
b1 = [-4.4137627774369452;1.8771460334390238;6.3950782787003568;0.71039791151934673;4.8431807730999434;-1.1788861903058498;-0.21175303759174793;-7.2150354743404597;5.6669364623299892;2.0532946348175418];
IW1_1 = [7.144260011737857 3.4843438459772664 1.3498688975301185 1.1411364530416579 0.46186282594694744 0.12002387414366951 -0.03041416987587283 -0.066694101586416588 -0.1688142854686201 -0.50792098442187095 -0.023242899997048493 -0.17216112031620739 -0.02897600379794113 -0.14360642532302206 -0.39167183245165649 -0.076635032399766767 -0.12614589831053327 0.054163637121266976 -0.14038846680967812 -0.097837085860226866 -0.12353378387254946 -0.19607147321619275 -0.12268418412656158 -0.13545419815435147 -0.066976602800738305 -0.0060877556965184994 1.9955142846961142 1.8613481871109527 0.62795791518766564 0.63974796507638088 0.33994192407560381 0.07586376683309011 0.081447044597537169 -0.093106511140619533 0.031931748865548691 -0.35423164708309279 0.038268781818653418 -0.098618974415854557 -0.019740018065274315 -3.1264742948285833 -2.7621987996697994 -0.83185977285989565 1.3291215312770852 0.077598351080603423 1.9002915225938417 0.76456478933390781 1.9116957900213654 0.26477840059753138 1.4028600020118329 0.17332776759543667 0.60361290288395086 0.078062497506145828 0.10368934399950819 0.23889770932578974 0.22234863241128694 -0.081016058661453449 0.10274568000899557 0.0284849476693603 0.084019084194233581 0.14062264173694172 0.14741650081238486 0.013898849862233156 0.053106105664987212 -0.0029863720396564775 -0.015262573585848292 -1.3698989038781897 -1.1603826371041657 -0.80489962919105773 0.83126427735992858 0.077444308741222753 1.1713972109429618 0.44141700829063507 1.4788023214246269 0.038901178160715769 1.0484029524763845 0.10863144797356625 0.41616656409269709 0.13859103647880344;-0.82184010539007235 1.9325338726661982 -2.2635746669995789 1.5260276553120928 2.4739029233840557 4.301692232672333 -0.74539151603115961 2.1658576061607806 0.22738370007072953 1.136124185003909 1.1483601357826692 0.70508479296494153 0.48929769432877268 1.060843816616996 0.41115532432326241 0.085929100190598934 0.025370878753372253 -0.063166543262436564 0.21588873649526727 0.0071664266666509472 0.054504123278220552 0.11041927514251798 0.1641412706245042 0.035188670073572265 -0.0056349528063302763 -0.024866487032074457 -0.7141360698434106 1.132202565738557 -1.4126568781957716 1.1306221270031314 1.1645912254321222 2.4356969774835253 -0.72275712435428419 1.1982411942510249 -0.052577425266248687 0.6079762925307064 0.54545695526897942 0.38134282101622774 0.25829766553238592 2.7400085294279117 -1.8909233319684238 -0.41191281546299802 -2.7636756773726954 3.271355021495157 -7.547807053609092 3.7070296474096538 -4.1277399112928812 1.5512072368457233 -1.8342468188944168 0.51975337782212949 -1.0074199376745485 1.1758996163744486 -0.70092668595907071 -0.34218679915655775 -0.19771978543504865 0.084218638424695264 -0.19172429915580699 -0.018753815159045045 -0.090622806299091141 -0.29471289812522572 -0.14494832795067905 -0.12454164905344783 -0.006491793494522979 -0.11169921709340473 -0.015554910096296009 2.6810310514002671 -1.2195668296571669 -0.079034072646356937 -1.6205688704427301 2.2300291345789174 -4.7838691792984465 2.7139113643265844 -3.1560327936167414 1.2017976045815759 -1.2575267024608769 0.32080156830142842 -0.81758481610561606 0.83252644130006703;-14.641729225625747 1.7555981688554434 -6.9022510202456511 -4.6142202555361269 -3.7577030398690412 -0.020953992145820281 -3.016379091724823 -2.562138341769864 -4.6421007968165737 -0.19712500890897752 -1.1306472121432618 0.13434318643837212 0.052828505145142056 0.66916412091140998 -0.43002383967351798 -0.49972531961131811 -0.63487232897642298 -0.29706852800064615 -0.22915762936973366 -0.24291176492912092 -0.14146907565339625 -0.21863002703040568 0.0060273225351671839 -0.22487606235713081 -0.15573520485042716 -0.053008838163771006 -5.0403476464451931 1.6861029346591232 -2.9719948419746389 -1.9009379672287277 -1.9227426952360944 0.15687472146351572 -1.772496642961737 -1.6714734554763413 -2.7275766999881741 -0.16968861956438652 -0.66174282999581502 0.098880924808684989 0.036776716200585514 4.5370795920131073 -2.0559217208455878 -0.12447688780038915 3.1306621770715113 3.2262025196113799 0.034197894911400212 -0.54710608545201544 1.669665850094334 -1.164286958113832 1.3608335550706758 -1.9272203175834763 0.022937332184253072 -1.9364176277040523 -0.54712265886218714 -0.14771207048462129 0.37551029957772736 0.38039457354440448 0.23351334048243708 -0.023839715877769362 0.090418686420822292 -0.043044250658618395 0.06130864298140274 -0.072278895189157186 0.045975203066700242 0.014419147748789055 -0.080072957848311782 2.5094684720791767 -1.9070806266675482 -0.46030995099103728 1.3526795868191615 1.892842421314411 0.097552275931203969 -0.15450324497230866 1.5100790484711641 -0.5660890269250104 1.0540422401570306 -1.2413016141356614 -0.0061763559404868461 -1.4411632155336769;-0.31397300045484122 -1.5741031191490762 -2.1947690212713229 -0.70385091909966968 -1.7971367790680601 0.62373997355837008 0.15848024163973537 -0.58963765522669009 -0.0053066766013970691 -0.018746832941511821 -0.0069088658028564351 -0.040902422819744592 -0.28166372237512954 0.2423306030294296 -0.012476785060437376 -0.14329649421685939 0.011148196914109449 -0.11255669790370158 -0.044476565586390959 -0.058639428581595876 0.0036293277368482915 0.0043665073629802409 0.039989704350903377 0.0093720093360782717 0.02360836031337487 0.0036224355716704729 0.47511965586137483 -1.0398543857372531 -1.0132078432443852 -0.36963126334705215 -1.0708839130598469 0.30780326911698758 0.035560603475850779 -0.40304940828489805 -0.042408811127658701 -0.048121275831091971 -0.023408949618942371 -0.038933924977775973 -0.15267285232706593 -0.90122498500912729 0.62679452700871874 -0.032796656142991529 0.36282508096802724 -1.6174962062925198 -0.67162654521120024 -1.6219724019165283 -1.1161228343331808 -0.91784363595385887 0.12731200202810891 -0.78876545881587268 -0.59363693618828006 -0.54658728928700906 -0.16082596348836595 -0.070774861113378731 0.070573214092017611 0.074607990505670976 -0.034462808824495025 0.048317624951375079 0.0078187959649971585 -0.011834888532900838 -0.067982983811439482 -0.040620811709980831 -0.041775859210756036 -0.0083044040554424905 -0.011968049762958441 -1.2662314597460551 0.51972136444963268 0.098524984842382007 0.15848938527526374 -1.0386278486651597 -0.33259783845553637 -0.99638261311471832 -0.72526067372700687 -0.52394199768163829 0.10479324679194163 -0.50874709426532361 -0.47909465744745977 -0.39096966008660239;-7.7784285800500257 -2.586369349895099 -4.2565486595729007 -3.3582778818781369 -0.87574487198193884 -2.721430041552912 -4.047763785256711 -1.57683881735647 -2.3554892562994687 0.45796825526638518 -0.74389009891972557 0.36563329234961117 -0.23958235839394232 -1.3117534058409883 0.55806907821362128 -0.25256141084110728 -0.044022225793768001 -0.084367589262712109 -0.077964646370497603 -0.02949637451187449 -0.081188193979178952 -0.042049488530700535 -0.10644747491570733 -0.007480373843156302 -0.023704260388394207 0.043755943875620505 -2.662438214464768 -0.55515979311775276 -1.7085941867882648 -1.7602498920845633 -0.39507567613671363 -1.8049434204496526 -2.4685072566052559 -1.1460052531581739 -1.438935944306531 0.049004637266895322 -0.54459741925272742 0.13505174941371245 -0.21212440793001969 2.4361879041763332 2.2900845538343875 4.1869185513185565 2.5778409993978082 2.2583148814214504 1.5514899618388929 1.9161735176619197 1.0035373936668521 1.5551678559288515 -2.2149986929659895 -0.25842622207018479 -0.98091706999359141 0.60695391829833423 0.87974322875256405 -0.14473099745113402 -0.23028361149456447 0.31369375404645589 0.095370033486695122 0.031263410044905418 0.18194629636932658 0.126553838168833 0.036348475576957771 0.022536743015267445 0.014550508077903928 -0.070319245631934757 0.0095713371809835242 1.5108534851580624 0.76377116154936342 2.5867606296031496 1.4737733008327978 1.7167613062676297 1.1704034039144873 1.4004645135426195 1.0237806621247292 1.0019143096961709 -1.4884432696948731 -0.046475485429654267 -0.76217095785537936 0.46029200716890151;6.9888372654321316 -13.505892612064907 -5.5875820794054425 -6.1283806885295657 -3.3110519052843559 -1.5609509238565309 2.115111855085158 -1.1992707455072245 -2.1276170004833972 0.08984548677038609 -0.75251499574893466 0.31557025524630411 -1.3023021178797674 -0.45689325941352382 -2.1721024155031206 0.10374789619424975 -0.41232487426975256 -0.62563942843862586 0.064623916600209219 0.56500193365977869 0.01330342580175487 -0.22467223163648584 0.11657968985876532 -0.38317544173676898 -0.072527009554935115 -0.045433970963153936 1.0079308121754191 -6.3857317945993239 -3.114482348212654 -3.9258577216926502 -2.3928298361086275 -1.1972221354553627 1.3831032459511716 -0.84926785326787135 -1.2594829633672862 -0.0011538912732034752 -0.47932752005525942 0.20382834163884805 -0.72776729970958987 0.46710962367908565 1.1189176054332255 12.01200459959334 -1.9901958553126262 1.0076848414345587 2.1070577474091543 -4.5419425622488303 0.97075180915857207 -1.9753590409862862 0.049425561188349031 1.7327832633894897 -1.0550007263326651 -0.66315246125757532 0.11147770127223768 -0.2366899241468266 1.1836351245117005 -0.4133748005674398 0.40712236934272195 0.037048040681140211 -0.013922822740120818 -0.4324128738599009 -0.13566216168117065 0.19696291751200831 0.40282214206236255 0.17271865669625766 -0.16529295332478899 1.6454573645919124 0.82149445504195184 7.3023302629607976 -0.6216147687815653 1.3089665703809397 1.3426545564717809 -2.699510672663171 0.67167325499703168 -1.1247869945023099 0.14845569175753914 1.2228772394665219 -0.92972223717858526 -0.58597162184652851;-1.6648122434775356 1.9108595332707945 3.6781319876454521 3.3395198905539427 3.5304741362558669 2.9644754745753286 3.2473845774577264 2.3397045819291842 1.2589649287157236 0.7051623597365092 0.75173491349245414 0.22174087939670381 1.2588897323279338 -0.79355366297244168 -0.67943126124095876 -0.23365887251845854 -0.17742987084664025 0.0022382778199726886 -0.22629332433708316 -0.2169625358051116 -0.21208938824091994 -0.21078999675804524 -0.12948658290598114 -0.083033038492480143 -0.067784783817196451 -0.019197170691204694 -2.3157602473404695 0.30878478489756944 1.6863750584604686 1.8551341652693145 2.0530685902651093 1.6075196598357444 1.7998391056607563 1.2871140337500455 0.77458259602177182 0.27647533767000376 0.4251394760719619 0.044238932262406917 0.64424083964959422 0.48716545129948907 0.64636291564631632 -4.9321582766939978 -0.28175122500708144 -3.3569856154666713 0.48977881841092741 -2.5956014699827263 -0.18522686115732073 -1.0464024320194159 1.055627958768516 -0.11751595009450534 0.80935190639804533 -0.33728078168519821 0.57613488787875888 0.73651081841343802 0.30400270299211135 -0.012925054957044388 0.099366394907374575 0.15888448350656084 0.041666315991365589 0.2290223686420384 0.055162543172735126 0.035712526969234507 -0.041574870053576872 -0.031160217128633736 -0.05251105771274333 2.0032725635755932 1.3885628022947505 -2.967696363375929 -0.047805584864002687 -2.2064559147942315 0.5481323714725399 -1.6417211482427974 0.052423527904940835 -0.76356293609026837 0.86569669036947394 -0.16595925220025598 0.55341058277782584 -0.066089228468117128;4.6474054876706807 -5.0682198179307711 2.1513979158915233 -2.2541997960734643 -1.2543935687142684 -1.1408913533051179 1.3425713090023048 -2.4998605718528535 1.562070314055267 -0.77418402515121632 0.96061543741712641 -0.18548477257720145 0.69936249420765684 -2.0725074602953031 1.3123574674504872 0.040805357475559988 0.47576017055570219 0.0080799209057393143 0.15830932544824591 -0.036273433580254942 0.1553801004079971 0.1189475673745102 -0.017984329425350418 0.039099250543734948 -0.119927950207239 -0.077285582361753966 0.86118948458149691 -0.17387071016367131 1.0458825217699472 -0.21132321899429188 -0.54400540769111849 0.1192762195511838 1.0317496101301957 -0.97908252182401112 0.71792558837771836 -0.12708133949350173 0.33968857122581497 -0.097181396066462422 0.35815362670157114 2.6674776307725803 9.8963615515313599 5.7426229300597678 0.25734141989994369 4.9715451547747564 1.6504720836713982 0.95675096008287663 1.0500101042547751 -0.18470763867807816 1.4491239508330851 -0.18148167444164895 -1.704455828440359 0.78015040737211661 0.75454847752148346 -0.90080857225821409 -1.0885236087586527 0.090586264361341789 -0.27070030939411682 -0.30429269444434076 0.18663987892241821 -0.19730611260634723 -0.10014884310610851 0.064315920607696378 -0.08798426778134763 0.094363927189920857 0.035370995620357656 -1.4529128548663783 -0.25843172594921154 -1.1188729480457968 -1.6727132484967833 1.0146101350259702 -0.3631043046654453 0.18304011861551753 -0.20903333851790049 -0.28417332987219546 0.76862127103400868 -0.13065819458235753 -1.0347298575714852 0.2591892521980268;-11.566389976039462 0.66712014470313674 -4.550969001866374 -1.4819643138363525 -1.0672164633973729 0.7800631203949917 -0.72017123793227744 -0.57650480710266194 -0.417510631129208 0.49530345694299083 -0.29643031983779705 0.051507632245843989 -0.51297149931699693 0.24554302182053031 0.33881027315698103 -0.11818649238365547 0.085210756048900396 -0.13247977585444212 0.023278235234844298 0.086935009326673265 0.10359388288560312 0.12836421032292167 0.09735126292832115 0.090704588070243633 0.048157752340616533 0.0012853465838173509 -4.1753979544797737 0.15184287499240681 -2.2135171426012996 -0.88185890597316396 -0.74316968676825279 0.3345967178953384 -0.54835090606068582 -0.37238927453227944 -0.39285804288951087 0.26963865217517863 -0.23176057514417603 0.012982607159239358 -0.27725035825268757 4.1611537365255264 0.044207598666086298 -0.75925463441327967 0.98072502335571665 -1.125970722154517 -2.4220432140210293 -0.7929289135023565 -0.74576029627807805 -0.84732348220463793 -0.41384619926591354 -1.1015956631051349 -1.404668090381554 -0.10844559328390907 -0.11674332616797044 -0.28417179483257449 -0.092942478931361663 0.097216703258804937 -0.095559817558897767 -0.0011618530052414503 -0.011934729345867333 -0.12089742948909755 -0.13767766871867981 -0.048867968781724842 -5.2722769826642755e-05 0.014978697851604647 0.010576206647321253 2.4246215405517075 -0.028326763434518499 -0.18505567362978792 0.52803624207524247 -0.67521885998537623 -1.4072055570619975 -0.4168685787376194 -0.46124574694536341 -0.43007680173166246 -0.2976399478559868 -0.67986398938252346 -1.0782035778489916 -0.14390652608291285;-0.21951402375429149 4.5485547964382542 2.832317568626141 2.9280336454365297 3.4872494280313875 -0.11014109998743798 3.6378317948669681 -0.25336485242923856 2.4618673589468982 0.14310178381897046 2.2543563519175867 -0.014771357614317249 -0.711204170104211 0.35304204315605475 -0.78402442941170569 0.17713849492543363 -0.13511179379446381 -0.37781896893048372 0.040488721708123239 0.12701209250453896 0.060920038447557986 0.063926304757994143 0.13229914174465324 0.031431889836779421 0.018879310739440991 -0.056093965711204612 0.13514719600903077 1.8418868444408285 1.2380930955395497 1.1704709678821108 1.7754517929146689 -0.25019430563315709 2.1039452958213403 -0.12542276609101072 1.2366253410721986 0.097355213793102705 1.1058354975397926 -0.019674520126890797 -0.37452679311282711 2.0965993083691212 -5.2798433759560872 -2.3243176361876574 -3.8075631576538034 -3.0628314405967969 -2.6007505963940782 -1.6978572902865356 -0.1646382866492988 -1.7859088637018927 -0.76057262652645119 0.52085816155149045 -1.4000760268326549 -0.087353888380678008 -0.24195447145534402 0.17460386691068663 0.32418725617320526 -0.087573658952507405 0.16414949038833335 0.1548165717927168 -0.15082863815350406 -0.36431052478043452 -0.12517393058463311 0.080716789467457584 0.016268474957852185 0.10081761713433694 -0.014216220761831114 1.1706980186009617 -2.3569613993498328 -1.1744266876906131 -1.9989490171991362 -1.7646201084795767 -1.5698597320166285 -1.0391950213857817 -0.11812550266766041 -1.0219445844259669 -0.50384808782430635 0.37621380372820357 -1.0537688514412462 -0.14286830344657844];

% Layer 2
b2 = [-2.4755932790864397;-4.5974235632360179;5.3264171293715314;5.8048605844543291;1.8232150155514195;-0.63075903569238723;2.548128785691782;-3.469697981180333;-1.6949577953747892;4.8076321720001811;6.2918665034999259;4.1586450506235115;7.2890933206289663;-7.4883902031961291;-5.6320894970886473;-13.915345860574135];
LW2_1 = [-1.5424914948124515 0.35676969588237767 -0.065228613282715439 -4.7078121807616462 -2.1820950885387234 0.38345146530813595 -0.91410017321932824 -4.596214406878488 -0.49166230980290532 -1.3652171438488241;-4.5630920379224786 1.3179815242638577 0.16700669307346494 3.070367205058901 -1.8881468640592121 1.6583664507158964 -0.11355858840293724 -0.66564417956632238 -3.5609579820232562 -1.8953225018355617;0.209722839871336 -0.76899566532808761 0.66368554289914572 -2.9813444704260257 -1.0306529165183322 -0.65864330037087171 0.09288429260633628 0.27563509747387815 0.65731664029633929 0.10231949241034093;0.59608841605918039 -0.18385490351632017 0.57234040824969612 -5.8035188855787299 -1.8274554863250301 0.62929692786849944 0.30435191142988033 -0.016287802107438125 1.5746707649224805 -1.0581340267779302;0.13747822141554258 -0.14593149156782528 -0.81188748503089014 -0.80523718764009444 1.8062770200968539 0.61850422364630508 0.33326490749204402 1.2330751451731825 0.082226982283031241 0.013737788454241784;1.1733602053629348 0.8155594930277108 -1.2912413789872208 0.93852637059107291 1.4369393913524195 0.18537880422667874 -0.48441206073900922 1.3855611628157189 0.49761322548299136 0.24079975021902558;-1.5914602070392412 -1.1527709546965583 -0.40373445960102244 -4.7375061364137832 0.094958717744459173 -0.54292092144288651 -0.17475432217185416 -0.20311583304458983 0.52807138495702532 -0.1364214322621739;4.4652057322483394 3.9108474942387823 2.8791706053213666 7.5731224247979787 6.7646938544766506 -1.505443310599377 3.5703384943246621 4.9054805708425029 -5.0913933833783886 5.4020836560121985;-1.3129631187077861 -0.69921603711309799 -0.031693566789402404 -4.8970994059302919 -0.63468296274392333 0.4097717827134294 -0.76082322995881924 -4.1090074311822997 1.3918971627025396 -0.85550131304761678;-0.40067254624470583 -0.98088565697928642 0.035051009099584945 -3.0230160929760359 -0.22313368134700079 0.087736953988869257 1.8839495981369028 0.78866423071312997 1.3932401445001967 -0.47080116939754457;2.2792562122556523 -0.45731101513058375 -1.1426585250466468 -4.3891573219777946 -1.1933066390196418 0.17378280919515909 0.75479802202388624 0.56466732374640893 1.92398313287649 -0.47015174265401022;-4.9166299410626113 -2.6060285095651912 1.4415402025161366 -5.3404378962381251 -0.86578211367964131 0.34443800975073963 1.4487737620853389 -1.7872777891396487 0.077845266786686337 -0.59099850329853643;0.8697913299015263 -0.96109110548834709 0.63615923687911224 -3.8507072246846099 -1.0572205457162376 -0.64315067031999851 -0.23372258555967873 1.0930067288801162 0.36393864499585982 0.10306434208121153;9.1295577583346876 1.0368387503903236 -1.7771492433264078 14.169699695568919 -1.7037816664227898 -1.1916808239623433 -4.091077511446036 0.4959434602318456 1.042353559915455 1.3757741780283133;0.91002373403314885 -0.52365304620884201 -0.84554840732211201 4.8238166331494812 0.50324380988549966 -0.1567080641781349 3.1063584492820575 1.0271359675085074 7.4185528688187121 -2.6542029501444335;-3.0838333175410111 2.1680791575189771 0.080170852482152485 8.5296519766013876 -0.6411900596250234 -1.632237869854317 -4.1386670611190217 -3.5230128816892252 -7.5819921941212653 1.1124449401245113];

% ===== SIMULATION ========

% Format Input Arguments
isCellX = iscell(X);
if ~isCellX, X = {X}; end;

% Dimensions
TS = size(X,2); % timesteps
if ~isempty(X)
    Q = size(X{1},2); % samples/series
else
    Q = 0;
end

% Allocate Outputs
Y = cell(1,TS);

% Time loop
for ts=1:TS
    
    % Input 1
    Xp1 = mapminmax_apply(X{1,ts},x1_step1);
    
    % Layer 1
    a1 = tansig_apply(repmat(b1,1,Q) + IW1_1*Xp1);
    
    % Layer 2
    a2 = softmax_apply(repmat(b2,1,Q) + LW2_1*a1);
    
    % Output 1
    Y{1,ts} = a2;
end

% Final Delay States
Xf = cell(1,0);
Af = cell(2,0);

% Format Output Arguments
if ~isCellX, Y = cell2mat(Y); end
end

% ===== MODULE FUNCTIONS ========

% Map Minimum and Maximum Input Processing Function
function y = mapminmax_apply(x,settings)
y = bsxfun(@minus,x,settings.xoffset);
y = bsxfun(@times,y,settings.gain);
y = bsxfun(@plus,y,settings.ymin);
end

% Competitive Soft Transfer Function
function a = softmax_apply(n,~)
if isa(n,'gpuArray')
    a = iSoftmaxApplyGPU(n);
else
    a = iSoftmaxApplyCPU(n);
end
end
function a = iSoftmaxApplyCPU(n)
nmax = max(n,[],1);
n = bsxfun(@minus,n,nmax);
numerator = exp(n);
denominator = sum(numerator,1);
denominator(denominator == 0) = 1;
a = bsxfun(@rdivide,numerator,denominator);
end
function a = iSoftmaxApplyGPU(n)
nmax = max(n,[],1);
numerator = arrayfun(@iSoftmaxApplyGPUHelper1,n,nmax);
denominator = sum(numerator,1);
a = arrayfun(@iSoftmaxApplyGPUHelper2,numerator,denominator);
end
function numerator = iSoftmaxApplyGPUHelper1(n,nmax)
numerator = exp(n - nmax);
end
function a = iSoftmaxApplyGPUHelper2(numerator,denominator)
if (denominator == 0)
    a = numerator;
else
    a = numerator ./ denominator;
end
end

% Sigmoid Symmetric Transfer Function
function a = tansig_apply(n,~)
a = 2 ./ (1 + exp(-2*n)) - 1;
end
