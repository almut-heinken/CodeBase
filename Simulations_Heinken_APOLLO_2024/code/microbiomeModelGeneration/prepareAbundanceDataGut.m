
mkdir([rootDir filesep 'data' filesep 'GutMicrobiomes'])
mkdir(modPath)

unzip([rootDir filesep 'input' filesep 'bwa_coverage.zip'])

% path to and name of the file with abundance information
abunFilePath=[rootDir filesep 'bwa_coverage.csv'];

% normalize abundance
[normalizedCoverage,normalizedCoveragePath] = normalizeCoverage(abunFilePath,0.001);

% translate GCF reference genomes to respective AGORA2
% reconstructions/new reconstruction IDs
translateGCF={'GCF_900095825','Acidaminococcus_massiliensis_Marseille_P2828';'GCF_000411395','Acidaminococcus_sp_HPA0509';'GCF_000162075','Acinetobacter_junii_SH205';'GCF_000162115','Acinetobacter_radioresistens_SH164';'GCF_001457875','Actinomyces_ihuae_DSM_100538';'GCF_000820725','Actinomyces_polynesiensis_DSM_27066';'GCF_000411415','Actinomyces_sp_HPA0247';'GCF_000308055','Actinomyces_sp_ph3';'GCF_000312105','Aeromicrobium_massiliense_JC14';'GCF_000321205','Alistipes_ihumii_AP11';'GCF_000231275','Alistipes_indistinctus_YIT_12060';'GCF_000311925','Alistipes_obesi_isolate_ph8';'GCF_900083545','Alistipes_provencensis_DSM_102308';'GCF_000154465','Alistipes_putredinis_DSM_17216';'GCF_000312145','Alistipes_senegalensis_JC50';'GCF_900107675','Alistipes_timonensis_JC136';'GCF_000752215','Amazonia_massiliensis_MS4';'GCF_000160455','Anaerobaculum_hydrogeniformans_OS1_ATCC_BAA_1850';'GCF_000173355','Anaerococcus_hydrogenalis_DSM_7454';'GCF_001182725','Anaerococcus_jeddahensis_DSM_100537';'GCF_001487145','Anaerococcus_rubeinfantis_DSM_101186';'GCF_000321005','Anaerococcus_senegalensis_JC48';'GCF_000154825','Anaerofustis_stercorihominis_DSM_17244';'GCF_000751555','Anaerosalibacter_massiliensis_ND1';'GCF_000466385','Aneurinibacillus_aneurinilyticus_ATCC_12856';'GCF_001244735','Bacillus_andreraoultii_KW_12';'GCF_000321185','Bacillus_massilioanorexius_AP8';'GCF_000311725','Bacillus_massiliosenegalensis_JC6';'GCF_000752035','Bacillus_rubiinfantis_mt2';'GCF_000238675','Bacillus_smithii_7_3_47FAA';'GCF_000238655','Bacillus_sp_7_6_55CFAA_CT2';'GCF_000821085','Bacillus_sp_B_jedd';'GCF_001243895','Bacillus_testis_DSM_101190';'GCF_000285535','Bacillus_timonensis_10403023';'GCF_000169015','Bacteroides_caccae_ATCC_43185';'GCF_000154845','Bacteroides_coprocola_M16_DSM_17136';'GCF_000157915','Bacteroides_coprophilus_DSM_18228';'GCF_000155815','Bacteroides_eggerthii_DSM_20697';'GCF_000195635','Bacteroides_fluxus_YIT_12057';'GCF_000157015','Bacteroides_fragilis_3_1_12';'GCF_000172175','Bacteroides_intestinalis_341_DSM_17393';'GCF_000499785','Bacteroides_neonati_MS4';'GCF_000315485','Bacteroides_oleiciplenus_YIT_12058';'GCF_000218325','Bacteroides_ovatus_3_8_47FAA';'GCF_000155855','Bacteroides_pectinophilus_ATCC_43243';'GCF_000187895','Bacteroides_pyogenes_DSM20611';'GCF_000381365','Bacteroides_salyersiae_WAL_10018';'GCF_000162155','Bacteroides_sp_2_1_22';'GCF_000157035','Bacteroides_sp_2_1_7';'GCF_000159855','Bacteroides_sp_3_2_5';'GCF_000162215','Bacteroides_sp_D20';'GCF_000382465','Bacteroides_sp_HPS0048';'GCF_000829905','Beduini_massiliensis_DSM_100188';'GCF_001025155','Bifidobacterium_angulatum_DSM_20098';'GCF_000273525','Bifidobacterium_bifidum_NCIMB_41171';'GCF_001025175','Bifidobacterium_breve_DSM_20213';'GCF_001025195','Bifidobacterium_catenulatum_DSM_16992';'GCF_000172135','Bifidobacterium_dentium_ATCC_27678';'GCF_000741205','Bifidobacterium_gallicum_DSM_20093';'GCF_000020425','Bifidobacterium_longum_infantis_ATCC_15697';'GCF_000185705','Bilophila_wadsworthia_3_1_6';'GCF_000582785','Blastococcus_massiliensis_AP3';'GCF_000285835','Brevibacterium_senegalense_JC43';'GCF_000144975','Burkholderiales_bacterium_1_1_47';'GCF_000398925','Butyricicoccus_pullicaecorum_1_2';'GCF_900091675','Butyricimonas_sp_Marseille_P2440';'GCF_000156015','Butyrivibrio_crossotus_DSM_2876';'GCF_900095875','Caecibacter_massiliensis_DSM_100188';'GCF_000146835','Campylobacter_coli_JV20';'GCF_000238755','Campylobacter_sp_10_1_50';'GCF_000185345','Campylobacter_upsaliensis_JV21';'GCF_000412335','Cedecea_davisae_DSM_4568';'GCF_000312005','Cellulomonas_massiliensis_JC225';'GCF_900046455','Cellulomonas_timonensis_DSM_100699';'GCF_000479045','Cetobacterium_somerae_ATCC_BAA_47401';'GCF_900087015','Christensenella_timonensis_DSM_102800';'GCF_000238735','Citrobacter_freundii_4_7_47CFAA';'GCF_000155975','Citrobacter_youngae_ATCC_29220';'GCF_001282665','Clostridiales_bacterium_mt11';'GCF_000155435','Clostridiales_sp_1_7_47FAA';'GCF_000753355','Clostridium_amazonitimonense_MGYG_HGUT_01477';'GCF_000158075','Clostridium_asparagiforme_DSM_15981';'GCF_001078425','Clostridium_bolteae_WAL_14578';'GCF_000320405','Clostridium_celatum_DSM_1785';'GCF_000233455','Clostridium_citroniae_WAL_17108';'GCF_000234155','Clostridium_clostridioforme_2_1_49FAA';'GCF_000751675','Clostridium_culturomicsense_CL_6';'GCF_000499525','Clostridium_dakarense_FF1';'GCF_000235505','Clostridium_hathewayi_WAL_18680';'GCF_000156055','Clostridium_hiranonis_TO_931_DSM_13275';'GCF_000156515','Clostridium_hylemonae_DSM_15053';'GCF_000577335','Clostridium_jeddahense_JCD';'GCF_001403635','Clostridium_massilioamazoniensis_ND2';'GCF_900091705','Clostridium_mediterraneense_Marseille_P2434';'GCF_000158655','Clostridium_methylpentosum_R2_DSM_5476';'GCF_001243045','Clostridium_niameyense_DSM_100441';'GCF_001244495','Clostridium_phoceensis_DSM_100334';'GCF_000820705','Clostridium_polynesiense_MS1';'GCF_000154505','Clostridium_scindens_ATCC_35704';'GCF_000285575','Clostridium_senegalense_JC122';'GCF_000158375','Clostridium_sp_7_2_43FAA';'GCF_001517625','Clostridium_sp_AT4';'GCF_000466605','Clostridium_sp_ATCC_29733';'GCF_000190355','Clostridium_sp_D5';'GCF_000159055','Clostridium_sp_M62_1';'GCF_900086625','Clostridium_sp_Marseille_P2538';'GCF_900078195','Clostridium_sp_Marseille_P299';'GCF_000154545','Clostridium_sp_SS2_1';'GCF_000154805','Clostridium_spiroforme_DSM_1552';'GCF_000155085','Clostridium_sporogenes_ATCC_15579';'GCF_000189615','Clostridium_symbiosum_WAL_14673';'GCF_900095855','Colibacter_massiliensis_DSM_103304';'GCF_000169035','Collinsella_aerofaciens_ATCC_25986';'GCF_900046475','Collinsella_ihuae_GD8';'GCF_000156175','Collinsella_intestinalis_DSM_13280';'GCF_000763055','Collinsella_sp_4_8_47FAA';'GCF_000156215','Collinsella_stercoris_DSM_13279';'GCF_000225705','Collinsella_tanakaei_YIT_12063';'GCF_000269565','Coprobacillus_cateniformis_D6';'GCF_000244855','Coprobacillus_sp_8_2_54BFAA';'GCF_000155875','Coprococcus_comes_ATCC_27758';'GCF_000411335','Coprococcus_sp_HPP0074';'GCF_001941425','Corynebacterium_ammoniagenes_DSM_20306';'GCF_900078305','Corynebacterium_bouchesdurhonense_DSM_100846';'GCF_000403725','Corynebacterium_ihumii_GD7';'GCF_900092335','Corynebacterium_phoceense_DSM_100570';'GCF_900049755','Corynebacterium_provencense_DSM_101074';'GCF_000411235','Corynebacterium_sp_HFH0082';'GCF_900091655','Culturomica_massiliensis_DSM_103121';'GCF_001182045','Dakarella_massiliensis_ND3';'GCF_000413375','Dermabacter_sp_HFH0086';'GCF_000238035','Desulfitobacterium_hafniense_DP7';'GCF_000156375','Desulfovibrio_piger_ATCC_29098';'GCF_000145315','Desulfovibrio_sp_3_1_syn3';'GCF_000242435','Dialister_succinatiphilus_YIT_11850';'GCF_000313565','Dielma_fastidiosa_JC13';'GCF_001185345','Dorea_sp_D27';'GCF_000213555','Dysgonomonas_gadei_ATCC_BAA_286';'GCF_000213575','Dysgonomonas_mossii_DSM_22836';'GCF_000163955','Edwardsiella_tarda_ATCC_23685';'GCF_000191845','Eggerthella_lenta_HGA1';'GCF_001486445','Eggerthellaceae_bacterium_AT8';'GCF_900086585','Emergencia_timonensis_DSM_101844';'GCF_000311845','Enorma_massiliensis_phI';'GCF_000321165','Enorma_timonensis_GD5';'GCF_000155995','Enterobacter_cancerogenus_ATCC_35316';'GCF_900021175','Enterobacter_timonensis_DSM_101775';'GCF_000159675','Enterococcus_faecium_TX1330';'GCF_001050095','Enterococcus_massiliensis_DSM_100308';'GCF_000242175','Erysipelotrichaceae_bacterium_6_1_45';'GCF_000165065','Erysipelotrichaceae_bacterium_sp_3_1_53';'GCF_000158415','Escherichia_sp_4_1_40B';'GCF_000156655','Eubacterium_biforme_DSM_3989';'GCF_000154285','Eubacterium_dolichum_DSM_3991';'GCF_000469345','Eubacterium_ramulus_ATCC_29099';'GCF_000154325','Eubacterium_siraeum_DSM_15702';'GCF_000242955','Eubacterium_sp_3_1_31';'GCF_001244405','Eubacterium_sp_SB2';'GCF_000153885','Eubacterium_ventriosum_ATCC_27560';'GCF_000166035','Faecalibacterium_cf_prausnitzii_KLE1255';'GCF_000154385','Faecalibacterium_prausnitzii_M21_2';'GCF_000469305','Faecalitalea_cylindroides_ATCC_27803';'GCF_001457835','Fenollaria_timonensis_GD5';'GCF_000010185','Finegoldia_magna_ATCC_29328';'GCF_001375495','Flaviflexus_massiliensis_SIT4';'GCF_001486665','Fournierella_massiliensis_DSM_100451';'GCF_000158235','Fusobacterium_gonidiaformans_3_1_5R';'GCF_900095705','Fusobacterium_massiliense_DSM_103085';'GCF_000158195','Fusobacterium_mortiferum_ATCC_9817';'GCF_000158295','Fusobacterium_necrophorum_D12';'GCF_000523555','Fusobacterium_nucleatum_13_3C';'GCF_000479265','Fusobacterium_nucleatum_CTI_2';'GCF_000158275','Fusobacterium_nucleatum_subsp_animalis_7_1';'GCF_000162235','Fusobacterium_nucleatum_subsp_vincentii_3_1_36A2';'GCF_000163935','Fusobacterium_periodonticum_1_1_41FAA';'GCF_000158215','Fusobacterium_periodonticum_2_1_31';'GCF_000158315','Fusobacterium_ulcerans_ATCC_49185';'GCF_000159915','Fusobacterium_varium_ATCC_27725';'GCF_001403595','Gabonia_massiliensis_DSM_100571';'GCF_001487125','Gabonibacter_massiliensis_DSM_101039';'GCF_001457415','Gorillibacterium_timonense_CSUR_P2011';'GCF_001458115','Gracilibacillus_massiliensis_DSM_29726';'GCF_900086715','Gracilibacillus_timonensis_CSUR_P2481';'GCF_000239255','Hafnia_alvei_ATCC_51873';'GCF_000158435','Helicobacter_bilis_ATCC_43879';'GCF_000162575','Helicobacter_canadensis_MIT_98_5491';'GCF_000507865','Helicobacter_canis_NCTC_12740';'GCF_000349975','Helicobacter_cinaedi_CCUG_18818';'GCF_000507845','Helicobacter_macacae_MIT_99_5501';'GCF_000155495','Helicobacter_pullorum_MIT_98_5489';'GCF_000178935','Helicobacter_pylori_35A';'GCF_000345485','Helicobacter_pylori_GAM264Ai';'GCF_000158455','Helicobacter_winghamensis_ATCC_BAA_430';'GCF_000157995','Holdemania_filiformis_VPI_J1_31B_1_DSM_12042';'GCF_000327285','Holdemania_massiliensis_AP2';'GCF_001244995','Intestinimonas_massiliensis_DSM_100417';'GCF_000752675','Jeddahella_massiliensis_OL_1';'GCF_001286805','Kallipyga_gabonensis_DSM_100575';'GCF_000163075','Klebsiella_sp_1_1_55';'GCF_000285555','Kurthia_massiliensis_JC30';'GCF_000218385','Lachnospiraceae_bacterium_1_4_56FAA';'GCF_000209385','Lachnospiraceae_bacterium_2_1_46FAA';'GCF_000218465','Lachnospiraceae_bacterium_2_1_58FAA';'GCF_000209405','Lachnospiraceae_bacterium_3_1_46FAA';'GCF_000218405','Lachnospiraceae_bacterium_3_1_57FAA_CT1';'GCF_000209425','Lachnospiraceae_bacterium_6_1_63FAA';'GCF_000159715','Lactobacillus_acidophilus_ATCC_4796';'GCF_001435665','Lactobacillus_amylolyticus_DSM_11664';'GCF_001435475','Lactobacillus_antri_DSM_16041';'GCF_001433855','Lactobacillus_brevis_DSM_20054';'GCF_000159175','Lactobacillus_brevis_subsp_gravesensis_ATCC_27305';'GCF_000192165','Lactobacillus_delbrueckii_subsp_lactis_DSM_20072';'GCF_000159215','Lactobacillus_fermentum_ATCC_14931';'GCF_000160855','Lactobacillus_helveticus_DSM_20075';'GCF_000227195','Lactobacillus_iners_7_1_47FAA';'GCF_000155515','Lactobacillus_paracasei_subsp_paracasei_8700_2';'GCF_000159455','Lactobacillus_reuteri_SD2112_ATCC_55730';'GCF_000026505','Lactobacillus_rhamnosus_GG_ATCC_53103';'GCF_000159375','Lactobacillus_ruminis_ATCC_25644';'GCF_000159415','Lactobacillus_ultunensis_DSM_16047';'GCF_001407835','Lagierella_massiliensis_CSUR_P2012';'GCF_001282625','Lascolabacillus_massiliensis_DSM_100190';'GCF_000160595','Leuconostoc_mesenteroides_subsp_cremoris_ATCC_19254';'GCF_000148995','Listeria_grayi_DSM_20601';'GCF_000241405','Listeria_innocua_ATCC_33091';'GCF_000173815','Marvinbryantia_formatexigens_I_52_DSM_14469';'GCF_001375675','Massilibacterium_senegalense_DSM_100455';'GCF_900095865','Massilioclostridium_coli_DSM_103344';'GCF_001487105','Mediterraneibacter_massiliensis_DSM_100837';'GCF_000245775','Megamonas_funiformis_YIT_11815';'GCF_000321045','Metakosakonia_massiliensis_JC163';'GCF_000155955','Mitsuokella_multacida_DSM_20544';'GCF_000826525','Mobilicoccus_massiliensis_DSM_29065';'GCF_900059565','Murdochiella_massiliensis_CSUR_P1987';'GCF_900119705','Murdochiella_vaginalis_DSM_102237';'GCF_900048895','Neglecta_timonensis_DSM_102082';'GCF_000220865','Neisseria_macacae_ATCC_33926';'GCF_000612625','Neobacillus_jeddahensis_DSM_28281';'GCF_001299475','Neofamilia_massiliensis_DSM_100639';'GCF_000455245','Nesterenkonia_massiliensis_NP1';'GCF_000826085','Nigerium_massiliense_SIT5';'GCF_000438455','Nosocomiicoccus_massiliensis_NP2';'GCF_000312045','Noviherbaspirillum_massiliense_JC206';'GCF_001375555','Numidum_massiliense_mt3';'GCF_000750635','Oceanobacillus_jeddahense_S5';'GCF_000285495','Oceanobacillus_massiliensis_str_N_diop';'GCF_000243215','Odoribacter_laneus_YIT_12061';'GCF_900078545','Olegusella_massiliensis_DSM_101849';'GCF_001457795','Olsenella_sp_SIT9';'GCF_000158475','Oxalobacter_formigenes_HOxBLS';'GCF_000158495','Oxalobacter_formigenes_OXCC13';'GCF_000455265','Paenibacillus_antibioticophila_GD11';'GCF_001368795','Paenibacillus_ihuae_GD6';'GCF_001403875','Paenibacillus_ihumii_DSM_100664';'GCF_900021165','Paenibacillus_phocaensis_DSM_101777';'GCF_001486505','Paenibacillus_rubinfantis_DSM_101191';'GCF_000285515','Paenibacillus_senegalensis_JC66';'GCF_001486585','Paenibacillus_senegalimassiliensis_CCUG_69869';'GCF_900069005','Paenibacillus_sp_GM2';'GCF_000204455','Paenibacillus_sp_HGF5';'GCF_000411255','Paenibacillus_sp_HGH0039';'GCF_900086655','Paenibacillus_tuaregi_DSM_102801';'GCF_000411295','Paenisporosarcina_sp_HGH0030';'GCF_000969835','Parabacteroides_goldsteinii_DSM_19448_WAL_12034';'GCF_000969845','Parabacteroides_sp_HGS0025';'GCF_000233955','Paraprevotella_clara_YIT_11840';'GCF_000205165','Paraprevotella_xylaniphila_YIT_11841';'GCF_000154405','Parvimonas_micra_ATCC_33270';'GCF_000146325','Pediococcus_acidilactici_DSM_20284';'GCF_000311865','Peptoniphilus_obesi_ph1';'GCF_001517665','Peptoniphilus_phoceensis_SIT15';'GCF_000321025','Peptoniphilus_senegalensis_JC140';'GCF_000188175','Phascolarctobacterium_succinatutens_YIT_12067';'GCF_000821325','Planococcus_massiliensis_DSM_28915';'GCF_000157935','Prevotella_copri_CB7_DSM_18205';'GCF_000413355','Prevotella_oralis_HGA0225';'GCF_000185845','Prevotella_salivae_DSM_15606';'GCF_000235885','Prevotella_stercorea_DSM_18206';'GCF_900095835','Prevotellaceae_bacterium_Marseille_P2826';'GCF_000413335','Propionibacterium_sp_HGH0353';'GCF_000297815','Proteus_mirabilis_WGLW6';'GCF_000527275','Providencia_alcalifaciens_PAL_1';'GCF_000527295','Providencia_alcalifaciens_RIMD_1656011';'GCF_000158055','Providencia_rettgeri_DSM_1131';'GCF_000156395','Providencia_rustigianii_DSM_4541';'GCF_000154865','Providencia_stuartii_ATCC_25827';'GCF_000233495','Pseudomonas_aeruginosa_2_1_26';'GCF_000826105','Pseudomonas_massiliensis_DSM_29075';'GCF_000478505','Pseudomonas_sp_HPB0071';'GCF_000227255','Ralstonia_sp_5_2_56FAA';'GCF_000942395','Risungbinella_massiliensis_GD1';'GCF_000174195','Roseburia_inulinivorans_DSM_16841';'GCF_001049895','Rubeoparvulum_massiliense_DSM_100479';'GCF_000177015','Ruminococcaceae_bacterium_D16';'GCF_000468015','Ruminococcus_callidus_ATCC_2776001';'GCF_000210095','Ruminococcus_champanellensis_18P13';'GCF_000155205','Ruminococcus_lactaris_ATCC_29176';'GCF_000159975','Ruminococcus_sp_5_1_39BFAA';'GCF_000236865','Senegalimassilia_anaerobia_JC110';'GCF_000296445','Slackia_piriformis_YIT_12062';'GCF_000411275','Staphylococcus_sp_HGB0015';'GCF_000455285','Stoquefichus_massiliensis_AP9';'GCF_000186545','Streptococcus_anginosus_1_2_62CV';'GCF_000187265','Streptococcus_equinus_ATCC_9812';'GCF_000154985','Streptococcus_infantarius_subsp_infantarius_ATCC_BAA_102';'GCF_000161955','Streptococcus_sp_2_1_36FAA';'GCF_000411475','Streptococcus_sp_HPH0090';'GCF_900095845','Streptococcus_timonensis_CSUR_P2915';'GCF_000411495','Streptomyces_sp_HPH0547';'GCF_000238635','Subdoligranulum_sp_4_3_54A2FAA';'GCF_000157955','Subdoligranulum_variabile_DSM_15176';'GCF_000188195','Succinatimonas_hippei_YIT_12066';'GCF_000250875','Sutterella_parvirubra_YIT_11816';'GCF_000297775','Sutterella_wadsworthensis_2_1_59BFAA';'GCF_000186505','Sutterella_wadsworthensis_3_1_45B';'GCF_000238615','Synergistes_sp_3_1_syn1';'GCF_000238695','Tannerella_sp_6_1_58FAA_CT1';'GCF_000826065','Tessaracoccus_massiliensis_SIT6';'GCF_001368835','Thalassobacillus_massiliensis_TM_1';'GCF_000312125','Timonella_senegalensis_JC301';'GCF_000163735','Veillonella_sp_6_1_27';'GCF_000411535','Veillonella_sp_HPA0037';'GCF_000723585','Virgibacillus_massiliensis_Vm_5';'GCF_001457815','Vitreoscilla_massiliensis_CSUR_P2036';'GCF_000160575','Weissella_paramesenteroides_ATCC_33313';'GCF_900018785','Xanthomonas_massiliensis_CSUR_P2129';'GCF_000239335','Yokenella_regensburgei_ATCC_43003'};

for i=1:size(translateGCF,1)
    normalizedCoverage(2:end,1)=strrep(normalizedCoverage(2:end,1),translateGCF{i,1},translateGCF{i,2});
end

cell2csv([rootDir filesep 'input' filesep 'normalized_gut_abundances.csv'],normalizedCoverage)

normalizedCoverage=readInputTableForPipeline([rootDir filesep 'input' filesep 'normalized_gut_abundances.csv']);
mkdir([rootDir filesep 'data' filesep  filesep 'split_coverages'])

% split into >10 runs for better performance
cnt=1;
for i=2:1000:size(normalizedCoverage,2)
    splitCoverage=normalizedCoverage;
    if i<130002
        splitCoverage(:,i+1000:end)=[];
    end
    if i>2
        splitCoverage(:,2:i-1)=[];
    end
    
    % remove what is no longer in any sample
    cntRM=1;
    delArray=[];
    for j=2:size(splitCoverage,1)
        if sum(str2double(splitCoverage(j,2:end))) < 0.0000001
            delArray(cntRM)=j;
            cntRM=cntRM+1;
        end
    end
    splitCoverage(delArray,:) = [];
    cell2csv([rootDir filesep 'data' filesep 'GutMicrobiomes' filesep 'split_coverages' filesep 'coverage_' num2str(cnt) '.csv'],splitCoverage);
    cnt=cnt+1;
end

cd ..